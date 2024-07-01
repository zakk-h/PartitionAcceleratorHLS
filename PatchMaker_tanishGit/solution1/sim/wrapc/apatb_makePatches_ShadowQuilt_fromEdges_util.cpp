#include <iostream>
#include "hls_stream.h"

using namespace std;

struct __cosim_T_24__ {char data[24];};
extern "C" void fpga_fifo_push_24(__cosim_T_24__* val, hls::stream<__cosim_T_24__>* fifo) {
  fifo->write(*val);
}
extern "C" void fpga_fifo_pop_24(__cosim_T_24__* val, hls::stream<__cosim_T_24__>* fifo) {
  *val = fifo->read();
}
extern "C" bool fpga_fifo_not_empty_24(hls::stream<__cosim_T_24__>* fifo) {
  return !fifo->empty();
}
extern "C" bool fpga_fifo_exist_24(hls::stream<__cosim_T_24__>* fifo) {
  return fifo->exist();
}
struct __cosim_T_6144__ {char data[6144];};
extern "C" void fpga_fifo_push_6144(__cosim_T_6144__* val, hls::stream<__cosim_T_6144__>* fifo) {
  fifo->write(*val);
}
extern "C" void fpga_fifo_pop_6144(__cosim_T_6144__* val, hls::stream<__cosim_T_6144__>* fifo) {
  *val = fifo->read();
}
extern "C" bool fpga_fifo_not_empty_6144(hls::stream<__cosim_T_6144__>* fifo) {
  return !fifo->empty();
}
extern "C" bool fpga_fifo_exist_6144(hls::stream<__cosim_T_6144__>* fifo) {
  return fifo->exist();
}
struct __cosim_T_30720__ {char data[30720];};
extern "C" void fpga_fifo_push_30720(__cosim_T_30720__* val, hls::stream<__cosim_T_30720__>* fifo) {
  fifo->write(*val);
}
extern "C" void fpga_fifo_pop_30720(__cosim_T_30720__* val, hls::stream<__cosim_T_30720__>* fifo) {
  *val = fifo->read();
}
extern "C" bool fpga_fifo_not_empty_30720(hls::stream<__cosim_T_30720__>* fifo) {
  return !fifo->empty();
}
extern "C" bool fpga_fifo_exist_30720(hls::stream<__cosim_T_30720__>* fifo) {
  return fifo->exist();
}
