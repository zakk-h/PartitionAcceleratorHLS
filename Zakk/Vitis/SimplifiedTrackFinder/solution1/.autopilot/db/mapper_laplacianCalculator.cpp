#include <systemc>
#include <vector>
#include <iostream>
#include "hls_stream.h"
#include "ap_int.h"
#include "ap_fixed.h"
using namespace std;
using namespace sc_dt;
class AESL_RUNTIME_BC {
  public:
    AESL_RUNTIME_BC(const char* name) {
      file_token.open( name);
      if (!file_token.good()) {
        cout << "Failed to open tv file " << name << endl;
        exit (1);
      }
      file_token >> mName;//[[[runtime]]]
    }
    ~AESL_RUNTIME_BC() {
      file_token.close();
    }
    int read_size () {
      int size = 0;
      file_token >> mName;//[[transaction]]
      file_token >> mName;//transaction number
      file_token >> mName;//pop_size
      size = atoi(mName.c_str());
      file_token >> mName;//[[/transaction]]
      return size;
    }
  public:
    fstream file_token;
    string mName;
};
extern "C" void laplacianCalculator(int*, short*);
extern "C" void apatb_laplacianCalculator_hw(volatile void * __xlx_apatb_param_coordinates, volatile void * __xlx_apatb_param_tripletMatrix) {
  // Collect __xlx_coordinates__tmp_vec
  vector<sc_bv<32> >__xlx_coordinates__tmp_vec;
  for (int j = 0, e = 400; j != e; ++j) {
    __xlx_coordinates__tmp_vec.push_back(((int*)__xlx_apatb_param_coordinates)[j]);
  }
  int __xlx_size_param_coordinates = 400;
  int __xlx_offset_param_coordinates = 0;
  int __xlx_offset_byte_param_coordinates = 0*4;
  int* __xlx_coordinates__input_buffer= new int[__xlx_coordinates__tmp_vec.size()];
  for (int i = 0; i < __xlx_coordinates__tmp_vec.size(); ++i) {
    __xlx_coordinates__input_buffer[i] = __xlx_coordinates__tmp_vec[i].range(31, 0).to_uint64();
  }
  // Collect __xlx_tripletMatrix__tmp_vec
  vector<sc_bv<16> >__xlx_tripletMatrix__tmp_vec;
  for (int j = 0, e = 12288; j != e; ++j) {
    __xlx_tripletMatrix__tmp_vec.push_back(((short*)__xlx_apatb_param_tripletMatrix)[j]);
  }
  int __xlx_size_param_tripletMatrix = 12288;
  int __xlx_offset_param_tripletMatrix = 0;
  int __xlx_offset_byte_param_tripletMatrix = 0*2;
  short* __xlx_tripletMatrix__input_buffer= new short[__xlx_tripletMatrix__tmp_vec.size()];
  for (int i = 0; i < __xlx_tripletMatrix__tmp_vec.size(); ++i) {
    __xlx_tripletMatrix__input_buffer[i] = __xlx_tripletMatrix__tmp_vec[i].range(15, 0).to_uint64();
  }
  // DUT call
  laplacianCalculator(__xlx_coordinates__input_buffer, __xlx_tripletMatrix__input_buffer);
// print __xlx_apatb_param_coordinates
  sc_bv<32>*__xlx_coordinates_output_buffer = new sc_bv<32>[__xlx_size_param_coordinates];
  for (int i = 0; i < __xlx_size_param_coordinates; ++i) {
    __xlx_coordinates_output_buffer[i] = __xlx_coordinates__input_buffer[i+__xlx_offset_param_coordinates];
  }
  for (int i = 0; i < __xlx_size_param_coordinates; ++i) {
    ((int*)__xlx_apatb_param_coordinates)[i] = __xlx_coordinates_output_buffer[i].to_uint64();
  }
// print __xlx_apatb_param_tripletMatrix
  sc_bv<16>*__xlx_tripletMatrix_output_buffer = new sc_bv<16>[__xlx_size_param_tripletMatrix];
  for (int i = 0; i < __xlx_size_param_tripletMatrix; ++i) {
    __xlx_tripletMatrix_output_buffer[i] = __xlx_tripletMatrix__input_buffer[i+__xlx_offset_param_tripletMatrix];
  }
  for (int i = 0; i < __xlx_size_param_tripletMatrix; ++i) {
    ((short*)__xlx_apatb_param_tripletMatrix)[i] = __xlx_tripletMatrix_output_buffer[i].to_uint64();
  }
}
