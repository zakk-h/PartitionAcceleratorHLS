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
struct __cosim_s18__ { char data[24]; };
extern "C" void makePatches_ShadowQuilt_fromEdges(long long, int, int, char, volatile void *, __cosim_s18__*, int*, long long*, long long*);
extern "C" void apatb_makePatches_ShadowQuilt_fromEdges_hw(long long __xlx_apatb_param_apexZ0, int __xlx_apatb_param_stop, int __xlx_apatb_param_ppl, char __xlx_apatb_param_leftRight, volatile void * __xlx_apatb_param_n_patches, volatile void * __xlx_apatb_param_GDarray, volatile void * __xlx_apatb_param_GDn_points, volatile void * __xlx_apatb_param_patches_superpoints, volatile void * __xlx_apatb_param_patches_parameters) {
  // Collect __xlx_GDarray__tmp_vec
  vector<sc_bv<192> >__xlx_GDarray__tmp_vec;
  for (int j = 0, e = 1280; j != e; ++j) {
    sc_bv<192> _xlx_tmp_sc;
    _xlx_tmp_sc.range(63, 0) = ((long long*)__xlx_apatb_param_GDarray)[j*3+0];
    _xlx_tmp_sc.range(127, 64) = ((long long*)__xlx_apatb_param_GDarray)[j*3+1];
    _xlx_tmp_sc.range(191, 128) = ((long long*)__xlx_apatb_param_GDarray)[j*3+2];
    __xlx_GDarray__tmp_vec.push_back(_xlx_tmp_sc);
  }
  int __xlx_size_param_GDarray = 1280;
  int __xlx_offset_param_GDarray = 0;
  int __xlx_offset_byte_param_GDarray = 0*24;
  __cosim_s18__* __xlx_GDarray__input_buffer= new __cosim_s18__[__xlx_GDarray__tmp_vec.size()];
  for (int i = 0; i < __xlx_GDarray__tmp_vec.size(); ++i) {
    ((long long*)__xlx_GDarray__input_buffer)[i*3+0] = __xlx_GDarray__tmp_vec[i].range(63, 0).to_uint64();
    ((long long*)__xlx_GDarray__input_buffer)[i*3+1] = __xlx_GDarray__tmp_vec[i].range(127, 64).to_uint64();
    ((long long*)__xlx_GDarray__input_buffer)[i*3+2] = __xlx_GDarray__tmp_vec[i].range(191, 128).to_uint64();
  }
  // Collect __xlx_GDn_points__tmp_vec
  vector<sc_bv<32> >__xlx_GDn_points__tmp_vec;
  for (int j = 0, e = 5; j != e; ++j) {
    __xlx_GDn_points__tmp_vec.push_back(((int*)__xlx_apatb_param_GDn_points)[j]);
  }
  int __xlx_size_param_GDn_points = 5;
  int __xlx_offset_param_GDn_points = 0;
  int __xlx_offset_byte_param_GDn_points = 0*4;
  int* __xlx_GDn_points__input_buffer= new int[__xlx_GDn_points__tmp_vec.size()];
  for (int i = 0; i < __xlx_GDn_points__tmp_vec.size(); ++i) {
    __xlx_GDn_points__input_buffer[i] = __xlx_GDn_points__tmp_vec[i].range(31, 0).to_uint64();
  }
  // Collect __xlx_patches_superpoints__tmp_vec
  vector<sc_bv<64> >__xlx_patches_superpoints__tmp_vec;
  for (int j = 0, e = 23040; j != e; ++j) {
    __xlx_patches_superpoints__tmp_vec.push_back(((long long*)__xlx_apatb_param_patches_superpoints)[j]);
  }
  int __xlx_size_param_patches_superpoints = 23040;
  int __xlx_offset_param_patches_superpoints = 0;
  int __xlx_offset_byte_param_patches_superpoints = 0*8;
  long long* __xlx_patches_superpoints__input_buffer= new long long[__xlx_patches_superpoints__tmp_vec.size()];
  for (int i = 0; i < __xlx_patches_superpoints__tmp_vec.size(); ++i) {
    __xlx_patches_superpoints__input_buffer[i] = __xlx_patches_superpoints__tmp_vec[i].range(63, 0).to_uint64();
  }
  // Collect __xlx_patches_parameters__tmp_vec
  vector<sc_bv<64> >__xlx_patches_parameters__tmp_vec;
  for (int j = 0, e = 3840; j != e; ++j) {
    __xlx_patches_parameters__tmp_vec.push_back(((long long*)__xlx_apatb_param_patches_parameters)[j]);
  }
  int __xlx_size_param_patches_parameters = 3840;
  int __xlx_offset_param_patches_parameters = 0;
  int __xlx_offset_byte_param_patches_parameters = 0*8;
  long long* __xlx_patches_parameters__input_buffer= new long long[__xlx_patches_parameters__tmp_vec.size()];
  for (int i = 0; i < __xlx_patches_parameters__tmp_vec.size(); ++i) {
    __xlx_patches_parameters__input_buffer[i] = __xlx_patches_parameters__tmp_vec[i].range(63, 0).to_uint64();
  }
  // DUT call
  makePatches_ShadowQuilt_fromEdges(__xlx_apatb_param_apexZ0, __xlx_apatb_param_stop, __xlx_apatb_param_ppl, __xlx_apatb_param_leftRight, __xlx_apatb_param_n_patches, __xlx_GDarray__input_buffer, __xlx_GDn_points__input_buffer, __xlx_patches_superpoints__input_buffer, __xlx_patches_parameters__input_buffer);
// print __xlx_apatb_param_GDarray
  sc_bv<192>*__xlx_GDarray_output_buffer = new sc_bv<192>[__xlx_size_param_GDarray];
  for (int i = 0; i < __xlx_size_param_GDarray; ++i) {
    char* start = (char*)(&(__xlx_GDarray__input_buffer[__xlx_offset_param_GDarray]));
    __xlx_GDarray_output_buffer[i].range(63, 0) = ((long long*)start)[i*3+0];
    __xlx_GDarray_output_buffer[i].range(127, 64) = ((long long*)start)[i*3+1];
    __xlx_GDarray_output_buffer[i].range(191, 128) = ((long long*)start)[i*3+2];
  }
  for (int i = 0; i < __xlx_size_param_GDarray; ++i) {
    ((long long*)__xlx_apatb_param_GDarray)[i*3+0] = __xlx_GDarray_output_buffer[i].range(63, 0).to_uint64();
    ((long long*)__xlx_apatb_param_GDarray)[i*3+1] = __xlx_GDarray_output_buffer[i].range(127, 64).to_uint64();
    ((long long*)__xlx_apatb_param_GDarray)[i*3+2] = __xlx_GDarray_output_buffer[i].range(191, 128).to_uint64();
  }
// print __xlx_apatb_param_GDn_points
  sc_bv<32>*__xlx_GDn_points_output_buffer = new sc_bv<32>[__xlx_size_param_GDn_points];
  for (int i = 0; i < __xlx_size_param_GDn_points; ++i) {
    __xlx_GDn_points_output_buffer[i] = __xlx_GDn_points__input_buffer[i+__xlx_offset_param_GDn_points];
  }
  for (int i = 0; i < __xlx_size_param_GDn_points; ++i) {
    ((int*)__xlx_apatb_param_GDn_points)[i] = __xlx_GDn_points_output_buffer[i].to_uint64();
  }
// print __xlx_apatb_param_patches_superpoints
  sc_bv<64>*__xlx_patches_superpoints_output_buffer = new sc_bv<64>[__xlx_size_param_patches_superpoints];
  for (int i = 0; i < __xlx_size_param_patches_superpoints; ++i) {
    __xlx_patches_superpoints_output_buffer[i] = __xlx_patches_superpoints__input_buffer[i+__xlx_offset_param_patches_superpoints];
  }
  for (int i = 0; i < __xlx_size_param_patches_superpoints; ++i) {
    ((long long*)__xlx_apatb_param_patches_superpoints)[i] = __xlx_patches_superpoints_output_buffer[i].to_uint64();
  }
// print __xlx_apatb_param_patches_parameters
  sc_bv<64>*__xlx_patches_parameters_output_buffer = new sc_bv<64>[__xlx_size_param_patches_parameters];
  for (int i = 0; i < __xlx_size_param_patches_parameters; ++i) {
    __xlx_patches_parameters_output_buffer[i] = __xlx_patches_parameters__input_buffer[i+__xlx_offset_param_patches_parameters];
  }
  for (int i = 0; i < __xlx_size_param_patches_parameters; ++i) {
    ((long long*)__xlx_apatb_param_patches_parameters)[i] = __xlx_patches_parameters_output_buffer[i].to_uint64();
  }
}
