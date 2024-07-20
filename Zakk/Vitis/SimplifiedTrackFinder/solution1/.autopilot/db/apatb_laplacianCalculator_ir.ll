; ModuleID = 'C:/Users/zakkh/Dark_Matter/PartitionAcceleratorHLS/Zakk/Vitis/SimplifiedTrackFinder/solution1/.autopilot/db/a.g.ld.5.gdce.bc'
source_filename = "llvm-link"
target datalayout = "e-m:e-i64:64-i128:128-i256:256-i512:512-i1024:1024-i2048:2048-i4096:4096-n8:16:32:64-S128-v16:16-v24:32-v32:32-v48:64-v96:128-v192:256-v256:256-v512:512-v1024:1024"
target triple = "fpga64-xilinx-none"

%struct.ap_int = type { %struct.ap_int_base }
%struct.ap_int_base = type { %struct.ssdm_int }
%struct.ssdm_int = type { i32 }
%struct.ap_int.3 = type { %struct.ap_int_base.4 }
%struct.ap_int_base.4 = type { %struct.ssdm_int.5 }
%struct.ssdm_int.5 = type { i16 }

; Function Attrs: noinline
define void @apatb_laplacianCalculator_ir([5 x [16 x %struct.ap_int]]* %coordinates, [3 x [16 x [16 x [16 x %struct.ap_int.3]]]]* %tripletMatrix) local_unnamed_addr #0 {
entry:
  %coordinates_copy = alloca [5 x [5 x [16 x %struct.ap_int]]], align 512
  %malloccall = tail call i8* @malloc(i64 24576)
  %tripletMatrix_copy = bitcast i8* %malloccall to [3 x [16 x [16 x [16 x %struct.ap_int.3]]]]*
  %0 = bitcast [5 x [16 x %struct.ap_int]]* %coordinates to [5 x [5 x [16 x %struct.ap_int]]]*
  call fastcc void @copy_in([5 x [5 x [16 x %struct.ap_int]]]* %0, [5 x [5 x [16 x %struct.ap_int]]]* nonnull align 512 %coordinates_copy, [3 x [16 x [16 x [16 x %struct.ap_int.3]]]]* %tripletMatrix, [3 x [16 x [16 x [16 x %struct.ap_int.3]]]]* %tripletMatrix_copy)
  %1 = getelementptr inbounds [5 x [5 x [16 x %struct.ap_int]]], [5 x [5 x [16 x %struct.ap_int]]]* %coordinates_copy, i32 0, i32 0
  call void @apatb_laplacianCalculator_hw([5 x [16 x %struct.ap_int]]* %1, [3 x [16 x [16 x [16 x %struct.ap_int.3]]]]* %tripletMatrix_copy)
  call fastcc void @copy_out([5 x [5 x [16 x %struct.ap_int]]]* %0, [5 x [5 x [16 x %struct.ap_int]]]* nonnull align 512 %coordinates_copy, [3 x [16 x [16 x [16 x %struct.ap_int.3]]]]* %tripletMatrix, [3 x [16 x [16 x [16 x %struct.ap_int.3]]]]* %tripletMatrix_copy)
  tail call void @free(i8* %malloccall)
  ret void
}

declare noalias i8* @malloc(i64) local_unnamed_addr

; Function Attrs: noinline
define internal fastcc void @copy_in([5 x [5 x [16 x %struct.ap_int]]]*, [5 x [5 x [16 x %struct.ap_int]]]* noalias align 512, [3 x [16 x [16 x [16 x %struct.ap_int.3]]]]*, [3 x [16 x [16 x [16 x %struct.ap_int.3]]]]* noalias) unnamed_addr #1 {
entry:
  call fastcc void @onebyonecpy_hls.p0a5a5a16struct.ap_int([5 x [5 x [16 x %struct.ap_int]]]* align 512 %1, [5 x [5 x [16 x %struct.ap_int]]]* %0)
  call fastcc void @onebyonecpy_hls.p0a3a16a16a16struct.ap_int.3([3 x [16 x [16 x [16 x %struct.ap_int.3]]]]* %3, [3 x [16 x [16 x [16 x %struct.ap_int.3]]]]* %2)
  ret void
}

; Function Attrs: noinline
define internal fastcc void @onebyonecpy_hls.p0a5a5a16struct.ap_int([5 x [5 x [16 x %struct.ap_int]]]* noalias align 512, [5 x [5 x [16 x %struct.ap_int]]]* noalias) unnamed_addr #2 {
entry:
  %2 = icmp eq [5 x [5 x [16 x %struct.ap_int]]]* %0, null
  %3 = icmp eq [5 x [5 x [16 x %struct.ap_int]]]* %1, null
  %4 = or i1 %2, %3
  br i1 %4, label %ret, label %copy

copy:                                             ; preds = %entry
  br label %for.loop

for.loop:                                         ; preds = %for.loop.split, %copy
  %for.loop.idx27 = phi i64 [ 0, %copy ], [ %for.loop.idx.next, %for.loop.split ]
  br label %for.loop2

for.loop2:                                        ; preds = %for.loop2.split, %for.loop
  %for.loop.idx326 = phi i64 [ 0, %for.loop ], [ %for.loop.idx3.next, %for.loop2.split ]
  br label %for.loop8

for.loop8:                                        ; preds = %for.loop.head7, %for.loop2
  %for.loop.idx925 = phi i64 [ 0, %for.loop2 ], [ %for.loop.idx9.next, %for.loop.head7 ]
  %dst.addr1115 = getelementptr [5 x [5 x [16 x %struct.ap_int]]], [5 x [5 x [16 x %struct.ap_int]]]* %0, i64 0, i64 %for.loop.idx27, i64 %for.loop.idx326, i64 %for.loop.idx925
  %src.addr1216 = getelementptr [5 x [5 x [16 x %struct.ap_int]]], [5 x [5 x [16 x %struct.ap_int]]]* %1, i64 0, i64 %for.loop.idx27, i64 %for.loop.idx326, i64 %for.loop.idx925
  %5 = bitcast %struct.ap_int* %src.addr1216 to i8*
  %6 = call i1 @fpga_fifo_exist_4(i8* %5)
  br i1 %6, label %7, label %8

; <label>:7:                                      ; preds = %for.loop8
  call fastcc void @streamcpy_hls.p0struct.ap_int(%struct.ap_int* %dst.addr1115, %struct.ap_int* %src.addr1216)
  br label %for.loop.head7

; <label>:8:                                      ; preds = %for.loop8
  %src.addr12.017 = getelementptr [5 x [5 x [16 x %struct.ap_int]]], [5 x [5 x [16 x %struct.ap_int]]]* %1, i64 0, i64 %for.loop.idx27, i64 %for.loop.idx326, i64 %for.loop.idx925, i32 0
  %dst.addr11.018 = getelementptr [5 x [5 x [16 x %struct.ap_int]]], [5 x [5 x [16 x %struct.ap_int]]]* %0, i64 0, i64 %for.loop.idx27, i64 %for.loop.idx326, i64 %for.loop.idx925, i32 0
  %9 = bitcast %struct.ap_int_base* %src.addr12.017 to i8*
  %10 = call i1 @fpga_fifo_exist_4(i8* %9)
  br i1 %10, label %11, label %12

; <label>:11:                                     ; preds = %8
  call fastcc void @streamcpy_hls.p0struct.ap_int_base(%struct.ap_int_base* %dst.addr11.018, %struct.ap_int_base* %src.addr12.017)
  br label %for.loop.head7

; <label>:12:                                     ; preds = %8
  %src.addr12.0.019 = getelementptr [5 x [5 x [16 x %struct.ap_int]]], [5 x [5 x [16 x %struct.ap_int]]]* %1, i64 0, i64 %for.loop.idx27, i64 %for.loop.idx326, i64 %for.loop.idx925, i32 0, i32 0
  %dst.addr11.0.020 = getelementptr [5 x [5 x [16 x %struct.ap_int]]], [5 x [5 x [16 x %struct.ap_int]]]* %0, i64 0, i64 %for.loop.idx27, i64 %for.loop.idx326, i64 %for.loop.idx925, i32 0, i32 0
  %13 = bitcast %struct.ssdm_int* %src.addr12.0.019 to i8*
  %14 = call i1 @fpga_fifo_exist_4(i8* %13)
  br i1 %14, label %15, label %16

; <label>:15:                                     ; preds = %12
  call fastcc void @streamcpy_hls.p0struct.ssdm_int(%struct.ssdm_int* %dst.addr11.0.020, %struct.ssdm_int* %src.addr12.0.019)
  br label %for.loop.head7

; <label>:16:                                     ; preds = %12
  %dst.addr11.0.0.022.gep23 = getelementptr [5 x [5 x [16 x %struct.ap_int]]], [5 x [5 x [16 x %struct.ap_int]]]* %0, i64 0, i64 %for.loop.idx27, i64 %for.loop.idx326, i64 %for.loop.idx925, i32 0, i32 0, i32 0
  %17 = bitcast i32* %dst.addr11.0.0.022.gep23 to i8*
  %src.addr12.0.0.021.gep24 = getelementptr [5 x [5 x [16 x %struct.ap_int]]], [5 x [5 x [16 x %struct.ap_int]]]* %1, i64 0, i64 %for.loop.idx27, i64 %for.loop.idx326, i64 %for.loop.idx925, i32 0, i32 0, i32 0
  %18 = bitcast i32* %src.addr12.0.0.021.gep24 to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* align 1 %17, i8* align 1 %18, i64 4, i1 false)
  br label %for.loop.head7

for.loop.head7:                                   ; preds = %16, %15, %11, %7
  %for.loop.idx9.next = add nuw nsw i64 %for.loop.idx925, 1
  %exitcond = icmp ne i64 %for.loop.idx9.next, 16
  br i1 %exitcond, label %for.loop8, label %for.loop2.split

for.loop2.split:                                  ; preds = %for.loop.head7
  %for.loop.idx3.next = add nuw nsw i64 %for.loop.idx326, 1
  %exitcond28 = icmp ne i64 %for.loop.idx3.next, 5
  br i1 %exitcond28, label %for.loop2, label %for.loop.split

for.loop.split:                                   ; preds = %for.loop2.split
  %for.loop.idx.next = add nuw nsw i64 %for.loop.idx27, 1
  %exitcond29 = icmp ne i64 %for.loop.idx.next, 5
  br i1 %exitcond29, label %for.loop, label %ret

ret:                                              ; preds = %for.loop.split, %entry
  ret void
}

declare i1 @fpga_fifo_exist_4(i8*) local_unnamed_addr

; Function Attrs: argmemonly noinline
define internal fastcc void @streamcpy_hls.p0struct.ap_int(%struct.ap_int* noalias nocapture, %struct.ap_int* noalias nocapture) unnamed_addr #3 {
entry:
  %2 = alloca %struct.ap_int
  br label %empty

empty:                                            ; preds = %push, %entry
  %3 = bitcast %struct.ap_int* %1 to i8*
  %4 = call i1 @fpga_fifo_not_empty_4(i8* %3)
  br i1 %4, label %push, label %ret

push:                                             ; preds = %empty
  %5 = bitcast %struct.ap_int* %2 to i8*
  %6 = bitcast %struct.ap_int* %1 to i8*
  call void @fpga_fifo_pop_4(i8* %5, i8* %6)
  %7 = load volatile %struct.ap_int, %struct.ap_int* %2
  %8 = bitcast %struct.ap_int* %2 to i8*
  %9 = bitcast %struct.ap_int* %0 to i8*
  call void @fpga_fifo_push_4(i8* %8, i8* %9)
  br label %empty, !llvm.loop !5

ret:                                              ; preds = %empty
  %10 = bitcast %struct.ap_int* %1 to i8*
  %11 = bitcast %struct.ap_int* %0 to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* align 1 %11, i8* align 1 %10, i64 4, i1 false)
  ret void
}

; Function Attrs: argmemonly nounwind
declare void @llvm.memcpy.p0i8.p0i8.i64(i8* nocapture writeonly, i8* nocapture readonly, i64, i1) #4

; Function Attrs: argmemonly noinline
define internal fastcc void @streamcpy_hls.p0struct.ap_int_base(%struct.ap_int_base* noalias nocapture, %struct.ap_int_base* noalias nocapture) unnamed_addr #3 {
entry:
  %2 = alloca %struct.ap_int_base
  br label %empty

empty:                                            ; preds = %push, %entry
  %3 = bitcast %struct.ap_int_base* %1 to i8*
  %4 = call i1 @fpga_fifo_not_empty_4(i8* %3)
  br i1 %4, label %push, label %ret

push:                                             ; preds = %empty
  %5 = bitcast %struct.ap_int_base* %2 to i8*
  %6 = bitcast %struct.ap_int_base* %1 to i8*
  call void @fpga_fifo_pop_4(i8* %5, i8* %6)
  %7 = load volatile %struct.ap_int_base, %struct.ap_int_base* %2
  %8 = bitcast %struct.ap_int_base* %2 to i8*
  %9 = bitcast %struct.ap_int_base* %0 to i8*
  call void @fpga_fifo_push_4(i8* %8, i8* %9)
  br label %empty, !llvm.loop !7

ret:                                              ; preds = %empty
  %10 = bitcast %struct.ap_int_base* %1 to i8*
  %11 = bitcast %struct.ap_int_base* %0 to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* align 1 %11, i8* align 1 %10, i64 4, i1 false)
  ret void
}

; Function Attrs: argmemonly noinline
define internal fastcc void @streamcpy_hls.p0struct.ssdm_int(%struct.ssdm_int* noalias nocapture, %struct.ssdm_int* noalias nocapture) unnamed_addr #3 {
entry:
  %2 = alloca %struct.ssdm_int
  br label %empty

empty:                                            ; preds = %push, %entry
  %3 = bitcast %struct.ssdm_int* %1 to i8*
  %4 = call i1 @fpga_fifo_not_empty_4(i8* %3)
  br i1 %4, label %push, label %ret

push:                                             ; preds = %empty
  %5 = bitcast %struct.ssdm_int* %2 to i8*
  %6 = bitcast %struct.ssdm_int* %1 to i8*
  call void @fpga_fifo_pop_4(i8* %5, i8* %6)
  %7 = load volatile %struct.ssdm_int, %struct.ssdm_int* %2
  %8 = bitcast %struct.ssdm_int* %2 to i8*
  %9 = bitcast %struct.ssdm_int* %0 to i8*
  call void @fpga_fifo_push_4(i8* %8, i8* %9)
  br label %empty, !llvm.loop !8

ret:                                              ; preds = %empty
  %10 = bitcast %struct.ssdm_int* %1 to i8*
  %11 = bitcast %struct.ssdm_int* %0 to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* align 1 %11, i8* align 1 %10, i64 4, i1 false)
  ret void
}

; Function Attrs: noinline
define internal fastcc void @onebyonecpy_hls.p0a3a16a16a16struct.ap_int.3([3 x [16 x [16 x [16 x %struct.ap_int.3]]]]* noalias, [3 x [16 x [16 x [16 x %struct.ap_int.3]]]]* noalias) unnamed_addr #2 {
entry:
  %2 = icmp eq [3 x [16 x [16 x [16 x %struct.ap_int.3]]]]* %0, null
  %3 = icmp eq [3 x [16 x [16 x [16 x %struct.ap_int.3]]]]* %1, null
  %4 = or i1 %2, %3
  br i1 %4, label %ret, label %copy

copy:                                             ; preds = %entry
  br label %for.loop

for.loop:                                         ; preds = %for.loop.split, %copy
  %for.loop.idx36 = phi i64 [ 0, %copy ], [ %for.loop.idx.next, %for.loop.split ]
  br label %for.loop2

for.loop2:                                        ; preds = %for.loop2.split, %for.loop
  %for.loop.idx335 = phi i64 [ 0, %for.loop ], [ %for.loop.idx3.next, %for.loop2.split ]
  br label %for.loop8

for.loop8:                                        ; preds = %for.loop8.split, %for.loop2
  %for.loop.idx934 = phi i64 [ 0, %for.loop2 ], [ %for.loop.idx9.next, %for.loop8.split ]
  br label %for.loop14

for.loop14:                                       ; preds = %for.loop.head13, %for.loop8
  %for.loop.idx1533 = phi i64 [ 0, %for.loop8 ], [ %for.loop.idx15.next, %for.loop.head13 ]
  %dst.addr1723 = getelementptr [3 x [16 x [16 x [16 x %struct.ap_int.3]]]], [3 x [16 x [16 x [16 x %struct.ap_int.3]]]]* %0, i64 0, i64 %for.loop.idx36, i64 %for.loop.idx335, i64 %for.loop.idx934, i64 %for.loop.idx1533
  %src.addr1824 = getelementptr [3 x [16 x [16 x [16 x %struct.ap_int.3]]]], [3 x [16 x [16 x [16 x %struct.ap_int.3]]]]* %1, i64 0, i64 %for.loop.idx36, i64 %for.loop.idx335, i64 %for.loop.idx934, i64 %for.loop.idx1533
  %5 = bitcast %struct.ap_int.3* %src.addr1824 to i8*
  %6 = call i1 @fpga_fifo_exist_2(i8* %5)
  br i1 %6, label %7, label %8

; <label>:7:                                      ; preds = %for.loop14
  call fastcc void @streamcpy_hls.p0struct.ap_int.3(%struct.ap_int.3* %dst.addr1723, %struct.ap_int.3* %src.addr1824)
  br label %for.loop.head13

; <label>:8:                                      ; preds = %for.loop14
  %src.addr18.025 = getelementptr [3 x [16 x [16 x [16 x %struct.ap_int.3]]]], [3 x [16 x [16 x [16 x %struct.ap_int.3]]]]* %1, i64 0, i64 %for.loop.idx36, i64 %for.loop.idx335, i64 %for.loop.idx934, i64 %for.loop.idx1533, i32 0
  %dst.addr17.026 = getelementptr [3 x [16 x [16 x [16 x %struct.ap_int.3]]]], [3 x [16 x [16 x [16 x %struct.ap_int.3]]]]* %0, i64 0, i64 %for.loop.idx36, i64 %for.loop.idx335, i64 %for.loop.idx934, i64 %for.loop.idx1533, i32 0
  %9 = bitcast %struct.ap_int_base.4* %src.addr18.025 to i8*
  %10 = call i1 @fpga_fifo_exist_2(i8* %9)
  br i1 %10, label %11, label %12

; <label>:11:                                     ; preds = %8
  call fastcc void @streamcpy_hls.p0struct.ap_int_base.4(%struct.ap_int_base.4* %dst.addr17.026, %struct.ap_int_base.4* %src.addr18.025)
  br label %for.loop.head13

; <label>:12:                                     ; preds = %8
  %src.addr18.0.027 = getelementptr [3 x [16 x [16 x [16 x %struct.ap_int.3]]]], [3 x [16 x [16 x [16 x %struct.ap_int.3]]]]* %1, i64 0, i64 %for.loop.idx36, i64 %for.loop.idx335, i64 %for.loop.idx934, i64 %for.loop.idx1533, i32 0, i32 0
  %dst.addr17.0.028 = getelementptr [3 x [16 x [16 x [16 x %struct.ap_int.3]]]], [3 x [16 x [16 x [16 x %struct.ap_int.3]]]]* %0, i64 0, i64 %for.loop.idx36, i64 %for.loop.idx335, i64 %for.loop.idx934, i64 %for.loop.idx1533, i32 0, i32 0
  %13 = bitcast %struct.ssdm_int.5* %src.addr18.0.027 to i8*
  %14 = call i1 @fpga_fifo_exist_2(i8* %13)
  br i1 %14, label %15, label %16

; <label>:15:                                     ; preds = %12
  call fastcc void @streamcpy_hls.p0struct.ssdm_int.5(%struct.ssdm_int.5* %dst.addr17.0.028, %struct.ssdm_int.5* %src.addr18.0.027)
  br label %for.loop.head13

; <label>:16:                                     ; preds = %12
  %dst.addr17.0.0.030.gep31 = getelementptr [3 x [16 x [16 x [16 x %struct.ap_int.3]]]], [3 x [16 x [16 x [16 x %struct.ap_int.3]]]]* %0, i64 0, i64 %for.loop.idx36, i64 %for.loop.idx335, i64 %for.loop.idx934, i64 %for.loop.idx1533, i32 0, i32 0, i32 0
  %17 = bitcast i16* %dst.addr17.0.0.030.gep31 to i8*
  %src.addr18.0.0.029.gep32 = getelementptr [3 x [16 x [16 x [16 x %struct.ap_int.3]]]], [3 x [16 x [16 x [16 x %struct.ap_int.3]]]]* %1, i64 0, i64 %for.loop.idx36, i64 %for.loop.idx335, i64 %for.loop.idx934, i64 %for.loop.idx1533, i32 0, i32 0, i32 0
  %18 = bitcast i16* %src.addr18.0.0.029.gep32 to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* align 1 %17, i8* align 1 %18, i64 2, i1 false)
  br label %for.loop.head13

for.loop.head13:                                  ; preds = %16, %15, %11, %7
  %for.loop.idx15.next = add nuw nsw i64 %for.loop.idx1533, 1
  %exitcond = icmp ne i64 %for.loop.idx15.next, 16
  br i1 %exitcond, label %for.loop14, label %for.loop8.split

for.loop8.split:                                  ; preds = %for.loop.head13
  %for.loop.idx9.next = add nuw nsw i64 %for.loop.idx934, 1
  %exitcond37 = icmp ne i64 %for.loop.idx9.next, 16
  br i1 %exitcond37, label %for.loop8, label %for.loop2.split

for.loop2.split:                                  ; preds = %for.loop8.split
  %for.loop.idx3.next = add nuw nsw i64 %for.loop.idx335, 1
  %exitcond38 = icmp ne i64 %for.loop.idx3.next, 16
  br i1 %exitcond38, label %for.loop2, label %for.loop.split

for.loop.split:                                   ; preds = %for.loop2.split
  %for.loop.idx.next = add nuw nsw i64 %for.loop.idx36, 1
  %exitcond39 = icmp ne i64 %for.loop.idx.next, 3
  br i1 %exitcond39, label %for.loop, label %ret

ret:                                              ; preds = %for.loop.split, %entry
  ret void
}

declare i1 @fpga_fifo_exist_2(i8*) local_unnamed_addr

; Function Attrs: argmemonly noinline
define internal fastcc void @streamcpy_hls.p0struct.ap_int.3(%struct.ap_int.3* noalias nocapture, %struct.ap_int.3* noalias nocapture) unnamed_addr #3 {
entry:
  %2 = alloca %struct.ap_int.3
  br label %empty

empty:                                            ; preds = %push, %entry
  %3 = bitcast %struct.ap_int.3* %1 to i8*
  %4 = call i1 @fpga_fifo_not_empty_2(i8* %3)
  br i1 %4, label %push, label %ret

push:                                             ; preds = %empty
  %5 = bitcast %struct.ap_int.3* %2 to i8*
  %6 = bitcast %struct.ap_int.3* %1 to i8*
  call void @fpga_fifo_pop_2(i8* %5, i8* %6)
  %7 = load volatile %struct.ap_int.3, %struct.ap_int.3* %2
  %8 = bitcast %struct.ap_int.3* %2 to i8*
  %9 = bitcast %struct.ap_int.3* %0 to i8*
  call void @fpga_fifo_push_2(i8* %8, i8* %9)
  br label %empty, !llvm.loop !9

ret:                                              ; preds = %empty
  %10 = bitcast %struct.ap_int.3* %1 to i8*
  %11 = bitcast %struct.ap_int.3* %0 to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* align 1 %11, i8* align 1 %10, i64 2, i1 false)
  ret void
}

; Function Attrs: argmemonly noinline
define internal fastcc void @streamcpy_hls.p0struct.ap_int_base.4(%struct.ap_int_base.4* noalias nocapture, %struct.ap_int_base.4* noalias nocapture) unnamed_addr #3 {
entry:
  %2 = alloca %struct.ap_int_base.4
  br label %empty

empty:                                            ; preds = %push, %entry
  %3 = bitcast %struct.ap_int_base.4* %1 to i8*
  %4 = call i1 @fpga_fifo_not_empty_2(i8* %3)
  br i1 %4, label %push, label %ret

push:                                             ; preds = %empty
  %5 = bitcast %struct.ap_int_base.4* %2 to i8*
  %6 = bitcast %struct.ap_int_base.4* %1 to i8*
  call void @fpga_fifo_pop_2(i8* %5, i8* %6)
  %7 = load volatile %struct.ap_int_base.4, %struct.ap_int_base.4* %2
  %8 = bitcast %struct.ap_int_base.4* %2 to i8*
  %9 = bitcast %struct.ap_int_base.4* %0 to i8*
  call void @fpga_fifo_push_2(i8* %8, i8* %9)
  br label %empty, !llvm.loop !10

ret:                                              ; preds = %empty
  %10 = bitcast %struct.ap_int_base.4* %1 to i8*
  %11 = bitcast %struct.ap_int_base.4* %0 to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* align 1 %11, i8* align 1 %10, i64 2, i1 false)
  ret void
}

; Function Attrs: argmemonly noinline
define internal fastcc void @streamcpy_hls.p0struct.ssdm_int.5(%struct.ssdm_int.5* noalias nocapture, %struct.ssdm_int.5* noalias nocapture) unnamed_addr #3 {
entry:
  %2 = alloca %struct.ssdm_int.5
  br label %empty

empty:                                            ; preds = %push, %entry
  %3 = bitcast %struct.ssdm_int.5* %1 to i8*
  %4 = call i1 @fpga_fifo_not_empty_2(i8* %3)
  br i1 %4, label %push, label %ret

push:                                             ; preds = %empty
  %5 = bitcast %struct.ssdm_int.5* %2 to i8*
  %6 = bitcast %struct.ssdm_int.5* %1 to i8*
  call void @fpga_fifo_pop_2(i8* %5, i8* %6)
  %7 = load volatile %struct.ssdm_int.5, %struct.ssdm_int.5* %2
  %8 = bitcast %struct.ssdm_int.5* %2 to i8*
  %9 = bitcast %struct.ssdm_int.5* %0 to i8*
  call void @fpga_fifo_push_2(i8* %8, i8* %9)
  br label %empty, !llvm.loop !11

ret:                                              ; preds = %empty
  %10 = bitcast %struct.ssdm_int.5* %1 to i8*
  %11 = bitcast %struct.ssdm_int.5* %0 to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* align 1 %11, i8* align 1 %10, i64 2, i1 false)
  ret void
}

; Function Attrs: noinline
define internal fastcc void @copy_out([5 x [5 x [16 x %struct.ap_int]]]*, [5 x [5 x [16 x %struct.ap_int]]]* noalias align 512, [3 x [16 x [16 x [16 x %struct.ap_int.3]]]]*, [3 x [16 x [16 x [16 x %struct.ap_int.3]]]]* noalias) unnamed_addr #5 {
entry:
  call fastcc void @onebyonecpy_hls.p0a5a5a16struct.ap_int([5 x [5 x [16 x %struct.ap_int]]]* %0, [5 x [5 x [16 x %struct.ap_int]]]* align 512 %1)
  call fastcc void @onebyonecpy_hls.p0a3a16a16a16struct.ap_int.3([3 x [16 x [16 x [16 x %struct.ap_int.3]]]]* %2, [3 x [16 x [16 x [16 x %struct.ap_int.3]]]]* %3)
  ret void
}

declare void @free(i8*) local_unnamed_addr

declare void @apatb_laplacianCalculator_hw([5 x [16 x %struct.ap_int]]*, [3 x [16 x [16 x [16 x %struct.ap_int.3]]]]*)

define void @laplacianCalculator_hw_stub_wrapper([5 x [16 x %struct.ap_int]]*, [3 x [16 x [16 x [16 x %struct.ap_int.3]]]]*) #6 {
entry:
  %2 = bitcast [5 x [16 x %struct.ap_int]]* %0 to [5 x [5 x [16 x %struct.ap_int]]]*
  call void @copy_out([5 x [5 x [16 x %struct.ap_int]]]* null, [5 x [5 x [16 x %struct.ap_int]]]* %2, [3 x [16 x [16 x [16 x %struct.ap_int.3]]]]* null, [3 x [16 x [16 x [16 x %struct.ap_int.3]]]]* %1)
  %3 = bitcast [5 x [5 x [16 x %struct.ap_int]]]* %2 to [5 x [16 x %struct.ap_int]]*
  call void @laplacianCalculator_hw_stub([5 x [16 x %struct.ap_int]]* %3, [3 x [16 x [16 x [16 x %struct.ap_int.3]]]]* %1)
  call void @copy_in([5 x [5 x [16 x %struct.ap_int]]]* null, [5 x [5 x [16 x %struct.ap_int]]]* %2, [3 x [16 x [16 x [16 x %struct.ap_int.3]]]]* null, [3 x [16 x [16 x [16 x %struct.ap_int.3]]]]* %1)
  ret void
}

declare void @laplacianCalculator_hw_stub([5 x [16 x %struct.ap_int]]*, [3 x [16 x [16 x [16 x %struct.ap_int.3]]]]*)

declare i1 @fpga_fifo_not_empty_4(i8*)

declare i1 @fpga_fifo_not_empty_2(i8*)

declare void @fpga_fifo_pop_4(i8*, i8*)

declare void @fpga_fifo_pop_2(i8*, i8*)

declare void @fpga_fifo_push_4(i8*, i8*)

declare void @fpga_fifo_push_2(i8*, i8*)

attributes #0 = { noinline "fpga.wrapper.func"="wrapper" }
attributes #1 = { noinline "fpga.wrapper.func"="copyin" }
attributes #2 = { noinline "fpga.wrapper.func"="onebyonecpy_hls" }
attributes #3 = { argmemonly noinline "fpga.wrapper.func"="streamcpy_hls" }
attributes #4 = { argmemonly nounwind }
attributes #5 = { noinline "fpga.wrapper.func"="copyout" }
attributes #6 = { "fpga.wrapper.func"="stub" }

!llvm.dbg.cu = !{}
!llvm.ident = !{!0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0}
!llvm.module.flags = !{!1, !2, !3}
!blackbox_cfg = !{!4}

!0 = !{!"clang version 7.0.0 "}
!1 = !{i32 2, !"Dwarf Version", i32 4}
!2 = !{i32 2, !"Debug Info Version", i32 3}
!3 = !{i32 1, !"wchar_size", i32 4}
!4 = !{}
!5 = distinct !{!5, !6}
!6 = !{!"llvm.loop.rotate.disable"}
!7 = distinct !{!7, !6}
!8 = distinct !{!8, !6}
!9 = distinct !{!9, !6}
!10 = distinct !{!10, !6}
!11 = distinct !{!11, !6}
