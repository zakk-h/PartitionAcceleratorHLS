#include <systemc>
#include <iostream>
#include <cstdlib>
#include <cstddef>
#include <stdint.h>
#include "SysCFileHandler.h"
#include "ap_int.h"
#include "ap_fixed.h"
#include <complex>
#include <stdbool.h>
#include "autopilot_cbe.h"
#include "hls_stream.h"
#include "hls_half.h"
#include "hls_signal_handler.h"

using namespace std;
using namespace sc_core;
using namespace sc_dt;

// wrapc file define:
#define AUTOTB_TVIN_apexZ0 "../tv/cdatafile/c.makePatches_ShadowQuilt_fromEdges.autotvin_apexZ0.dat"
#define AUTOTB_TVOUT_apexZ0 "../tv/cdatafile/c.makePatches_ShadowQuilt_fromEdges.autotvout_apexZ0.dat"
// wrapc file define:
#define AUTOTB_TVIN_stop "../tv/cdatafile/c.makePatches_ShadowQuilt_fromEdges.autotvin_stop.dat"
#define AUTOTB_TVOUT_stop "../tv/cdatafile/c.makePatches_ShadowQuilt_fromEdges.autotvout_stop.dat"
// wrapc file define:
#define AUTOTB_TVIN_ppl "../tv/cdatafile/c.makePatches_ShadowQuilt_fromEdges.autotvin_ppl.dat"
#define AUTOTB_TVOUT_ppl "../tv/cdatafile/c.makePatches_ShadowQuilt_fromEdges.autotvout_ppl.dat"
// wrapc file define:
#define AUTOTB_TVIN_leftRight "../tv/cdatafile/c.makePatches_ShadowQuilt_fromEdges.autotvin_leftRight.dat"
#define AUTOTB_TVOUT_leftRight "../tv/cdatafile/c.makePatches_ShadowQuilt_fromEdges.autotvout_leftRight.dat"
// wrapc file define:
#define AUTOTB_TVIN_n_patches "../tv/cdatafile/c.makePatches_ShadowQuilt_fromEdges.autotvin_n_patches.dat"
#define AUTOTB_TVOUT_n_patches "../tv/cdatafile/c.makePatches_ShadowQuilt_fromEdges.autotvout_n_patches.dat"
// wrapc file define:
#define AUTOTB_TVIN_GDarray "../tv/cdatafile/c.makePatches_ShadowQuilt_fromEdges.autotvin_GDarray.dat"
#define AUTOTB_TVOUT_GDarray "../tv/cdatafile/c.makePatches_ShadowQuilt_fromEdges.autotvout_GDarray.dat"
// wrapc file define:
#define AUTOTB_TVIN_GDn_points "../tv/cdatafile/c.makePatches_ShadowQuilt_fromEdges.autotvin_GDn_points.dat"
#define AUTOTB_TVOUT_GDn_points "../tv/cdatafile/c.makePatches_ShadowQuilt_fromEdges.autotvout_GDn_points.dat"
// wrapc file define:
#define AUTOTB_TVIN_patches_superpoints "../tv/cdatafile/c.makePatches_ShadowQuilt_fromEdges.autotvin_patches_superpoints.dat"
#define AUTOTB_TVOUT_patches_superpoints "../tv/cdatafile/c.makePatches_ShadowQuilt_fromEdges.autotvout_patches_superpoints.dat"
// wrapc file define:
#define AUTOTB_TVIN_patches_parameters "../tv/cdatafile/c.makePatches_ShadowQuilt_fromEdges.autotvin_patches_parameters.dat"
#define AUTOTB_TVOUT_patches_parameters "../tv/cdatafile/c.makePatches_ShadowQuilt_fromEdges.autotvout_patches_parameters.dat"

#define INTER_TCL "../tv/cdatafile/ref.tcl"

// tvout file define:
#define AUTOTB_TVOUT_PC_apexZ0 "../tv/rtldatafile/rtl.makePatches_ShadowQuilt_fromEdges.autotvout_apexZ0.dat"
// tvout file define:
#define AUTOTB_TVOUT_PC_stop "../tv/rtldatafile/rtl.makePatches_ShadowQuilt_fromEdges.autotvout_stop.dat"
// tvout file define:
#define AUTOTB_TVOUT_PC_ppl "../tv/rtldatafile/rtl.makePatches_ShadowQuilt_fromEdges.autotvout_ppl.dat"
// tvout file define:
#define AUTOTB_TVOUT_PC_leftRight "../tv/rtldatafile/rtl.makePatches_ShadowQuilt_fromEdges.autotvout_leftRight.dat"
// tvout file define:
#define AUTOTB_TVOUT_PC_n_patches "../tv/rtldatafile/rtl.makePatches_ShadowQuilt_fromEdges.autotvout_n_patches.dat"
// tvout file define:
#define AUTOTB_TVOUT_PC_GDarray "../tv/rtldatafile/rtl.makePatches_ShadowQuilt_fromEdges.autotvout_GDarray.dat"
// tvout file define:
#define AUTOTB_TVOUT_PC_GDn_points "../tv/rtldatafile/rtl.makePatches_ShadowQuilt_fromEdges.autotvout_GDn_points.dat"
// tvout file define:
#define AUTOTB_TVOUT_PC_patches_superpoints "../tv/rtldatafile/rtl.makePatches_ShadowQuilt_fromEdges.autotvout_patches_superpoints.dat"
// tvout file define:
#define AUTOTB_TVOUT_PC_patches_parameters "../tv/rtldatafile/rtl.makePatches_ShadowQuilt_fromEdges.autotvout_patches_parameters.dat"

class INTER_TCL_FILE {
  public:
INTER_TCL_FILE(const char* name) {
  mName = name; 
  apexZ0_depth = 0;
  stop_depth = 0;
  ppl_depth = 0;
  leftRight_depth = 0;
  n_patches_depth = 0;
  GDarray_depth = 0;
  GDn_points_depth = 0;
  patches_superpoints_depth = 0;
  patches_parameters_depth = 0;
  trans_num =0;
}
~INTER_TCL_FILE() {
  mFile.open(mName);
  if (!mFile.good()) {
    cout << "Failed to open file ref.tcl" << endl;
    exit (1); 
  }
  string total_list = get_depth_list();
  mFile << "set depth_list {\n";
  mFile << total_list;
  mFile << "}\n";
  mFile << "set trans_num "<<trans_num<<endl;
  mFile.close();
}
string get_depth_list () {
  stringstream total_list;
  total_list << "{apexZ0 " << apexZ0_depth << "}\n";
  total_list << "{stop " << stop_depth << "}\n";
  total_list << "{ppl " << ppl_depth << "}\n";
  total_list << "{leftRight " << leftRight_depth << "}\n";
  total_list << "{n_patches " << n_patches_depth << "}\n";
  total_list << "{GDarray " << GDarray_depth << "}\n";
  total_list << "{GDn_points " << GDn_points_depth << "}\n";
  total_list << "{patches_superpoints " << patches_superpoints_depth << "}\n";
  total_list << "{patches_parameters " << patches_parameters_depth << "}\n";
  return total_list.str();
}
void set_num (int num , int* class_num) {
  (*class_num) = (*class_num) > num ? (*class_num) : num;
}
void set_string(std::string list, std::string* class_list) {
  (*class_list) = list;
}
  public:
    int apexZ0_depth;
    int stop_depth;
    int ppl_depth;
    int leftRight_depth;
    int n_patches_depth;
    int GDarray_depth;
    int GDn_points_depth;
    int patches_superpoints_depth;
    int patches_parameters_depth;
    int trans_num;
  private:
    ofstream mFile;
    const char* mName;
};

static void RTLOutputCheckAndReplacement(std::string &AESL_token, std::string PortName) {
  bool no_x = false;
  bool err = false;

  no_x = false;
  // search and replace 'X' with '0' from the 3rd char of token
  while (!no_x) {
    size_t x_found = AESL_token.find('X', 0);
    if (x_found != string::npos) {
      if (!err) { 
        cerr << "WARNING: [SIM 212-201] RTL produces unknown value 'X' on port" 
             << PortName << ", possible cause: There are uninitialized variables in the C design."
             << endl; 
        err = true;
      }
      AESL_token.replace(x_found, 1, "0");
    } else
      no_x = true;
  }
  no_x = false;
  // search and replace 'x' with '0' from the 3rd char of token
  while (!no_x) {
    size_t x_found = AESL_token.find('x', 2);
    if (x_found != string::npos) {
      if (!err) { 
        cerr << "WARNING: [SIM 212-201] RTL produces unknown value 'x' on port" 
             << PortName << ", possible cause: There are uninitialized variables in the C design."
             << endl; 
        err = true;
      }
      AESL_token.replace(x_found, 1, "0");
    } else
      no_x = true;
  }
}
struct __cosim_s18__ { char data[24]; };
extern "C" void makePatches_ShadowQuilt_fromEdges_hw_stub_wrapper(long long, int, int, char, volatile void *, volatile void *, volatile void *, volatile void *, volatile void *);

extern "C" void apatb_makePatches_ShadowQuilt_fromEdges_hw(long long __xlx_apatb_param_apexZ0, int __xlx_apatb_param_stop, int __xlx_apatb_param_ppl, char __xlx_apatb_param_leftRight, volatile void * __xlx_apatb_param_n_patches, volatile void * __xlx_apatb_param_GDarray, volatile void * __xlx_apatb_param_GDn_points, volatile void * __xlx_apatb_param_patches_superpoints, volatile void * __xlx_apatb_param_patches_parameters) {
  refine_signal_handler();
  fstream wrapc_switch_file_token;
  wrapc_switch_file_token.open(".hls_cosim_wrapc_switch.log");
  int AESL_i;
  if (wrapc_switch_file_token.good())
  {

    CodeState = ENTER_WRAPC_PC;
    static unsigned AESL_transaction_pc = 0;
    string AESL_token;
    string AESL_num;{
      static ifstream rtl_tv_out_file;
      if (!rtl_tv_out_file.is_open()) {
        rtl_tv_out_file.open(AUTOTB_TVOUT_PC_n_patches);
        if (rtl_tv_out_file.good()) {
          rtl_tv_out_file >> AESL_token;
          if (AESL_token != "[[[runtime]]]")
            exit(1);
        }
      }
  
      if (rtl_tv_out_file.good()) {
        rtl_tv_out_file >> AESL_token; 
        rtl_tv_out_file >> AESL_num;  // transaction number
        if (AESL_token != "[[transaction]]") {
          cerr << "Unexpected token: " << AESL_token << endl;
          exit(1);
        }
        if (atoi(AESL_num.c_str()) == AESL_transaction_pc) {
          std::vector<sc_bv<32> > n_patches_pc_buffer(1);
          int i = 0;

          rtl_tv_out_file >> AESL_token; //data
          while (AESL_token != "[[/transaction]]"){

            RTLOutputCheckAndReplacement(AESL_token, "n_patches");
  
            // push token into output port buffer
            if (AESL_token != "") {
              n_patches_pc_buffer[i] = AESL_token.c_str();;
              i++;
            }
  
            rtl_tv_out_file >> AESL_token; //data or [[/transaction]]
            if (AESL_token == "[[[/runtime]]]" || rtl_tv_out_file.eof())
              exit(1);
          }
          if (i > 0) {
            ((int*)__xlx_apatb_param_n_patches)[0] = n_patches_pc_buffer[0].to_int64();
          }
        } // end transaction
      } // end file is good
    } // end post check logic bolck
  {
      static ifstream rtl_tv_out_file;
      if (!rtl_tv_out_file.is_open()) {
        rtl_tv_out_file.open(AUTOTB_TVOUT_PC_patches_superpoints);
        if (rtl_tv_out_file.good()) {
          rtl_tv_out_file >> AESL_token;
          if (AESL_token != "[[[runtime]]]")
            exit(1);
        }
      }
  
      if (rtl_tv_out_file.good()) {
        rtl_tv_out_file >> AESL_token; 
        rtl_tv_out_file >> AESL_num;  // transaction number
        if (AESL_token != "[[transaction]]") {
          cerr << "Unexpected token: " << AESL_token << endl;
          exit(1);
        }
        if (atoi(AESL_num.c_str()) == AESL_transaction_pc) {
          std::vector<sc_bv<64> > patches_superpoints_pc_buffer(23040);
          int i = 0;

          rtl_tv_out_file >> AESL_token; //data
          while (AESL_token != "[[/transaction]]"){

            RTLOutputCheckAndReplacement(AESL_token, "patches_superpoints");
  
            // push token into output port buffer
            if (AESL_token != "") {
              patches_superpoints_pc_buffer[i] = AESL_token.c_str();;
              i++;
            }
  
            rtl_tv_out_file >> AESL_token; //data or [[/transaction]]
            if (AESL_token == "[[[/runtime]]]" || rtl_tv_out_file.eof())
              exit(1);
          }
          if (i > 0) {{
            int i = 0;
            for (int j = 0, e = 23040; j < e; j += 1, ++i) {
            ((long long*)__xlx_apatb_param_patches_superpoints)[j] = patches_superpoints_pc_buffer[i].to_int64();
          }}}
        } // end transaction
      } // end file is good
    } // end post check logic bolck
  {
      static ifstream rtl_tv_out_file;
      if (!rtl_tv_out_file.is_open()) {
        rtl_tv_out_file.open(AUTOTB_TVOUT_PC_patches_parameters);
        if (rtl_tv_out_file.good()) {
          rtl_tv_out_file >> AESL_token;
          if (AESL_token != "[[[runtime]]]")
            exit(1);
        }
      }
  
      if (rtl_tv_out_file.good()) {
        rtl_tv_out_file >> AESL_token; 
        rtl_tv_out_file >> AESL_num;  // transaction number
        if (AESL_token != "[[transaction]]") {
          cerr << "Unexpected token: " << AESL_token << endl;
          exit(1);
        }
        if (atoi(AESL_num.c_str()) == AESL_transaction_pc) {
          std::vector<sc_bv<64> > patches_parameters_pc_buffer(3840);
          int i = 0;

          rtl_tv_out_file >> AESL_token; //data
          while (AESL_token != "[[/transaction]]"){

            RTLOutputCheckAndReplacement(AESL_token, "patches_parameters");
  
            // push token into output port buffer
            if (AESL_token != "") {
              patches_parameters_pc_buffer[i] = AESL_token.c_str();;
              i++;
            }
  
            rtl_tv_out_file >> AESL_token; //data or [[/transaction]]
            if (AESL_token == "[[[/runtime]]]" || rtl_tv_out_file.eof())
              exit(1);
          }
          if (i > 0) {{
            int i = 0;
            for (int j = 0, e = 3840; j < e; j += 1, ++i) {
            ((long long*)__xlx_apatb_param_patches_parameters)[j] = patches_parameters_pc_buffer[i].to_int64();
          }}}
        } // end transaction
      } // end file is good
    } // end post check logic bolck
  
    AESL_transaction_pc++;
    return ;
  }
static unsigned AESL_transaction;
static AESL_FILE_HANDLER aesl_fh;
static INTER_TCL_FILE tcl_file(INTER_TCL);
std::vector<char> __xlx_sprintf_buffer(1024);
CodeState = ENTER_WRAPC;
//apexZ0
aesl_fh.touch(AUTOTB_TVIN_apexZ0);
aesl_fh.touch(AUTOTB_TVOUT_apexZ0);
//stop
aesl_fh.touch(AUTOTB_TVIN_stop);
aesl_fh.touch(AUTOTB_TVOUT_stop);
//ppl
aesl_fh.touch(AUTOTB_TVIN_ppl);
aesl_fh.touch(AUTOTB_TVOUT_ppl);
//leftRight
aesl_fh.touch(AUTOTB_TVIN_leftRight);
aesl_fh.touch(AUTOTB_TVOUT_leftRight);
//n_patches
aesl_fh.touch(AUTOTB_TVIN_n_patches);
aesl_fh.touch(AUTOTB_TVOUT_n_patches);
//GDarray
aesl_fh.touch(AUTOTB_TVIN_GDarray);
aesl_fh.touch(AUTOTB_TVOUT_GDarray);
//GDn_points
aesl_fh.touch(AUTOTB_TVIN_GDn_points);
aesl_fh.touch(AUTOTB_TVOUT_GDn_points);
//patches_superpoints
aesl_fh.touch(AUTOTB_TVIN_patches_superpoints);
aesl_fh.touch(AUTOTB_TVOUT_patches_superpoints);
//patches_parameters
aesl_fh.touch(AUTOTB_TVIN_patches_parameters);
aesl_fh.touch(AUTOTB_TVOUT_patches_parameters);
CodeState = DUMP_INPUTS;
// print apexZ0 Transactions
{
  sprintf(__xlx_sprintf_buffer.data(), "[[transaction]] %d\n", AESL_transaction);
  aesl_fh.write(AUTOTB_TVIN_apexZ0, __xlx_sprintf_buffer.data());
  {
    sc_bv<64> __xlx_tmp_lv = *((long long*)&__xlx_apatb_param_apexZ0);

    sprintf(__xlx_sprintf_buffer.data(), "%s\n", __xlx_tmp_lv.to_string(SC_HEX).c_str());
    aesl_fh.write(AUTOTB_TVIN_apexZ0, __xlx_sprintf_buffer.data()); 
  }
  tcl_file.set_num(1, &tcl_file.apexZ0_depth);
  sprintf(__xlx_sprintf_buffer.data(), "[[/transaction]] \n");
  aesl_fh.write(AUTOTB_TVIN_apexZ0, __xlx_sprintf_buffer.data());
}
// print stop Transactions
{
  sprintf(__xlx_sprintf_buffer.data(), "[[transaction]] %d\n", AESL_transaction);
  aesl_fh.write(AUTOTB_TVIN_stop, __xlx_sprintf_buffer.data());
  {
    sc_bv<32> __xlx_tmp_lv = *((int*)&__xlx_apatb_param_stop);

    sprintf(__xlx_sprintf_buffer.data(), "%s\n", __xlx_tmp_lv.to_string(SC_HEX).c_str());
    aesl_fh.write(AUTOTB_TVIN_stop, __xlx_sprintf_buffer.data()); 
  }
  tcl_file.set_num(1, &tcl_file.stop_depth);
  sprintf(__xlx_sprintf_buffer.data(), "[[/transaction]] \n");
  aesl_fh.write(AUTOTB_TVIN_stop, __xlx_sprintf_buffer.data());
}
// print ppl Transactions
{
  sprintf(__xlx_sprintf_buffer.data(), "[[transaction]] %d\n", AESL_transaction);
  aesl_fh.write(AUTOTB_TVIN_ppl, __xlx_sprintf_buffer.data());
  {
    sc_bv<32> __xlx_tmp_lv = *((int*)&__xlx_apatb_param_ppl);

    sprintf(__xlx_sprintf_buffer.data(), "%s\n", __xlx_tmp_lv.to_string(SC_HEX).c_str());
    aesl_fh.write(AUTOTB_TVIN_ppl, __xlx_sprintf_buffer.data()); 
  }
  tcl_file.set_num(1, &tcl_file.ppl_depth);
  sprintf(__xlx_sprintf_buffer.data(), "[[/transaction]] \n");
  aesl_fh.write(AUTOTB_TVIN_ppl, __xlx_sprintf_buffer.data());
}
// print leftRight Transactions
{
  sprintf(__xlx_sprintf_buffer.data(), "[[transaction]] %d\n", AESL_transaction);
  aesl_fh.write(AUTOTB_TVIN_leftRight, __xlx_sprintf_buffer.data());
  {
    sc_bv<1> __xlx_tmp_lv = *((char*)&__xlx_apatb_param_leftRight);

    sprintf(__xlx_sprintf_buffer.data(), "%s\n", __xlx_tmp_lv.to_string(SC_HEX).c_str());
    aesl_fh.write(AUTOTB_TVIN_leftRight, __xlx_sprintf_buffer.data()); 
  }
  tcl_file.set_num(1, &tcl_file.leftRight_depth);
  sprintf(__xlx_sprintf_buffer.data(), "[[/transaction]] \n");
  aesl_fh.write(AUTOTB_TVIN_leftRight, __xlx_sprintf_buffer.data());
}
// print n_patches Transactions
{
  sprintf(__xlx_sprintf_buffer.data(), "[[transaction]] %d\n", AESL_transaction);
  aesl_fh.write(AUTOTB_TVIN_n_patches, __xlx_sprintf_buffer.data());
  {
    sc_bv<32> __xlx_tmp_lv = *((int*)__xlx_apatb_param_n_patches);

    sprintf(__xlx_sprintf_buffer.data(), "%s\n", __xlx_tmp_lv.to_string(SC_HEX).c_str());
    aesl_fh.write(AUTOTB_TVIN_n_patches, __xlx_sprintf_buffer.data()); 
  }
  tcl_file.set_num(1, &tcl_file.n_patches_depth);
  sprintf(__xlx_sprintf_buffer.data(), "[[/transaction]] \n");
  aesl_fh.write(AUTOTB_TVIN_n_patches, __xlx_sprintf_buffer.data());
}
unsigned __xlx_offset_byte_param_GDarray = 0;
// print GDarray Transactions
{
  sprintf(__xlx_sprintf_buffer.data(), "[[transaction]] %d\n", AESL_transaction);
  aesl_fh.write(AUTOTB_TVIN_GDarray, __xlx_sprintf_buffer.data());
  {  __xlx_offset_byte_param_GDarray = 0*24;
  if (__xlx_apatb_param_GDarray) {
    for (int j = 0  - 0, e = 1280 - 0; j != e; ++j) {
sc_bv<192> __xlx_tmp_lv;
__xlx_tmp_lv.range(63,0) = ((long long*)__xlx_apatb_param_GDarray)[j*3+0];
__xlx_tmp_lv.range(127,64) = ((long long*)__xlx_apatb_param_GDarray)[j*3+1];
__xlx_tmp_lv.range(191,128) = ((long long*)__xlx_apatb_param_GDarray)[j*3+2];

    sprintf(__xlx_sprintf_buffer.data(), "%s\n", __xlx_tmp_lv.to_string(SC_HEX).c_str());
    aesl_fh.write(AUTOTB_TVIN_GDarray, __xlx_sprintf_buffer.data()); 
      }
  }
}
  tcl_file.set_num(1280, &tcl_file.GDarray_depth);
  sprintf(__xlx_sprintf_buffer.data(), "[[/transaction]] \n");
  aesl_fh.write(AUTOTB_TVIN_GDarray, __xlx_sprintf_buffer.data());
}
unsigned __xlx_offset_byte_param_GDn_points = 0;
// print GDn_points Transactions
{
  sprintf(__xlx_sprintf_buffer.data(), "[[transaction]] %d\n", AESL_transaction);
  aesl_fh.write(AUTOTB_TVIN_GDn_points, __xlx_sprintf_buffer.data());
  {  __xlx_offset_byte_param_GDn_points = 0*4;
  if (__xlx_apatb_param_GDn_points) {
    for (int j = 0  - 0, e = 5 - 0; j != e; ++j) {
sc_bv<32> __xlx_tmp_lv = ((int*)__xlx_apatb_param_GDn_points)[j];

    sprintf(__xlx_sprintf_buffer.data(), "%s\n", __xlx_tmp_lv.to_string(SC_HEX).c_str());
    aesl_fh.write(AUTOTB_TVIN_GDn_points, __xlx_sprintf_buffer.data()); 
      }
  }
}
  tcl_file.set_num(5, &tcl_file.GDn_points_depth);
  sprintf(__xlx_sprintf_buffer.data(), "[[/transaction]] \n");
  aesl_fh.write(AUTOTB_TVIN_GDn_points, __xlx_sprintf_buffer.data());
}
unsigned __xlx_offset_byte_param_patches_superpoints = 0;
// print patches_superpoints Transactions
{
  sprintf(__xlx_sprintf_buffer.data(), "[[transaction]] %d\n", AESL_transaction);
  aesl_fh.write(AUTOTB_TVIN_patches_superpoints, __xlx_sprintf_buffer.data());
  {  __xlx_offset_byte_param_patches_superpoints = 0*8;
  if (__xlx_apatb_param_patches_superpoints) {
    for (int j = 0  - 0, e = 23040 - 0; j != e; ++j) {
sc_bv<64> __xlx_tmp_lv = ((long long*)__xlx_apatb_param_patches_superpoints)[j];

    sprintf(__xlx_sprintf_buffer.data(), "%s\n", __xlx_tmp_lv.to_string(SC_HEX).c_str());
    aesl_fh.write(AUTOTB_TVIN_patches_superpoints, __xlx_sprintf_buffer.data()); 
      }
  }
}
  tcl_file.set_num(23040, &tcl_file.patches_superpoints_depth);
  sprintf(__xlx_sprintf_buffer.data(), "[[/transaction]] \n");
  aesl_fh.write(AUTOTB_TVIN_patches_superpoints, __xlx_sprintf_buffer.data());
}
unsigned __xlx_offset_byte_param_patches_parameters = 0;
// print patches_parameters Transactions
{
  sprintf(__xlx_sprintf_buffer.data(), "[[transaction]] %d\n", AESL_transaction);
  aesl_fh.write(AUTOTB_TVIN_patches_parameters, __xlx_sprintf_buffer.data());
  {  __xlx_offset_byte_param_patches_parameters = 0*8;
  if (__xlx_apatb_param_patches_parameters) {
    for (int j = 0  - 0, e = 3840 - 0; j != e; ++j) {
sc_bv<64> __xlx_tmp_lv = ((long long*)__xlx_apatb_param_patches_parameters)[j];

    sprintf(__xlx_sprintf_buffer.data(), "%s\n", __xlx_tmp_lv.to_string(SC_HEX).c_str());
    aesl_fh.write(AUTOTB_TVIN_patches_parameters, __xlx_sprintf_buffer.data()); 
      }
  }
}
  tcl_file.set_num(3840, &tcl_file.patches_parameters_depth);
  sprintf(__xlx_sprintf_buffer.data(), "[[/transaction]] \n");
  aesl_fh.write(AUTOTB_TVIN_patches_parameters, __xlx_sprintf_buffer.data());
}
CodeState = CALL_C_DUT;
makePatches_ShadowQuilt_fromEdges_hw_stub_wrapper(__xlx_apatb_param_apexZ0, __xlx_apatb_param_stop, __xlx_apatb_param_ppl, __xlx_apatb_param_leftRight, __xlx_apatb_param_n_patches, __xlx_apatb_param_GDarray, __xlx_apatb_param_GDn_points, __xlx_apatb_param_patches_superpoints, __xlx_apatb_param_patches_parameters);
CodeState = DUMP_OUTPUTS;
// print n_patches Transactions
{
  sprintf(__xlx_sprintf_buffer.data(), "[[transaction]] %d\n", AESL_transaction);
  aesl_fh.write(AUTOTB_TVOUT_n_patches, __xlx_sprintf_buffer.data());
  {
    sc_bv<32> __xlx_tmp_lv = *((int*)__xlx_apatb_param_n_patches);

    sprintf(__xlx_sprintf_buffer.data(), "%s\n", __xlx_tmp_lv.to_string(SC_HEX).c_str());
    aesl_fh.write(AUTOTB_TVOUT_n_patches, __xlx_sprintf_buffer.data()); 
  }
  tcl_file.set_num(1, &tcl_file.n_patches_depth);
  sprintf(__xlx_sprintf_buffer.data(), "[[/transaction]] \n");
  aesl_fh.write(AUTOTB_TVOUT_n_patches, __xlx_sprintf_buffer.data());
}
// print patches_superpoints Transactions
{
  sprintf(__xlx_sprintf_buffer.data(), "[[transaction]] %d\n", AESL_transaction);
  aesl_fh.write(AUTOTB_TVOUT_patches_superpoints, __xlx_sprintf_buffer.data());
  {  __xlx_offset_byte_param_patches_superpoints = 0*8;
  if (__xlx_apatb_param_patches_superpoints) {
    for (int j = 0  - 0, e = 23040 - 0; j != e; ++j) {
sc_bv<64> __xlx_tmp_lv = ((long long*)__xlx_apatb_param_patches_superpoints)[j];

    sprintf(__xlx_sprintf_buffer.data(), "%s\n", __xlx_tmp_lv.to_string(SC_HEX).c_str());
    aesl_fh.write(AUTOTB_TVOUT_patches_superpoints, __xlx_sprintf_buffer.data()); 
      }
  }
}
  tcl_file.set_num(23040, &tcl_file.patches_superpoints_depth);
  sprintf(__xlx_sprintf_buffer.data(), "[[/transaction]] \n");
  aesl_fh.write(AUTOTB_TVOUT_patches_superpoints, __xlx_sprintf_buffer.data());
}
// print patches_parameters Transactions
{
  sprintf(__xlx_sprintf_buffer.data(), "[[transaction]] %d\n", AESL_transaction);
  aesl_fh.write(AUTOTB_TVOUT_patches_parameters, __xlx_sprintf_buffer.data());
  {  __xlx_offset_byte_param_patches_parameters = 0*8;
  if (__xlx_apatb_param_patches_parameters) {
    for (int j = 0  - 0, e = 3840 - 0; j != e; ++j) {
sc_bv<64> __xlx_tmp_lv = ((long long*)__xlx_apatb_param_patches_parameters)[j];

    sprintf(__xlx_sprintf_buffer.data(), "%s\n", __xlx_tmp_lv.to_string(SC_HEX).c_str());
    aesl_fh.write(AUTOTB_TVOUT_patches_parameters, __xlx_sprintf_buffer.data()); 
      }
  }
}
  tcl_file.set_num(3840, &tcl_file.patches_parameters_depth);
  sprintf(__xlx_sprintf_buffer.data(), "[[/transaction]] \n");
  aesl_fh.write(AUTOTB_TVOUT_patches_parameters, __xlx_sprintf_buffer.data());
}
CodeState = DELETE_CHAR_BUFFERS;
AESL_transaction++;
tcl_file.set_num(AESL_transaction , &tcl_file.trans_num);
}
