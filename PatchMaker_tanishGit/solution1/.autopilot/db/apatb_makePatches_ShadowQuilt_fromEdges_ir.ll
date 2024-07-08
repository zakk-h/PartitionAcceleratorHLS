; ModuleID = 'C:/Users/zakkh/Dark_Matter/PartitionAcceleratorHLS/PatchMaker_tanishGit/solution1/.autopilot/db/a.g.ld.5.gdce.bc'
source_filename = "llvm-link"
target datalayout = "e-m:e-i64:64-i128:128-i256:256-i512:512-i1024:1024-i2048:2048-i4096:4096-n8:16:32:64-S128-v16:16-v24:32-v32:32-v48:64-v96:128-v192:256-v256:256-v512:512-v1024:1024"
target triple = "fpga64-xilinx-none"

%"struct.std::array" = type { [5 x %"struct.std::array.0"] }
%"struct.std::array.0" = type { [256 x %"struct.std::array.1"] }
%"struct.std::array.1" = type { [3 x i64] }

; Function Attrs: noinline
define void @apatb_makePatches_ShadowQuilt_fromEdges_ir(i64 %apexZ0, i32 %stop, i32 %ppl, i1 %leftRight, i32* %n_patches, %"struct.std::array"* %GDarray, [5 x i32]* %GDn_points, [32 x [5 x [3 x [16 x [3 x i64]]]]]* %patches_superpoints, [32 x [5 x [4 x [6 x i64]]]]* %patches_parameters) local_unnamed_addr #0 {
entry:
  %n_patches_copy = alloca i32, align 512
  %malloccall = tail call i8* @malloc(i64 30720)
  %GDarray_copy = bitcast i8* %malloccall to %"struct.std::array"*
  %GDn_points_copy = alloca [5 x i32], align 512
  %malloccall1 = tail call i8* @malloc(i64 184320)
  %patches_superpoints_copy = bitcast i8* %malloccall1 to [32 x [5 x [3 x [16 x [3 x i64]]]]]*
  %malloccall2 = tail call i8* @malloc(i64 30720)
  %patches_parameters_copy = bitcast i8* %malloccall2 to [32 x [5 x [4 x [6 x i64]]]]*
  call fastcc void @copy_in(i32* %n_patches, i32* nonnull align 512 %n_patches_copy, %"struct.std::array"* %GDarray, %"struct.std::array"* %GDarray_copy, [5 x i32]* %GDn_points, [5 x i32]* nonnull align 512 %GDn_points_copy, [32 x [5 x [3 x [16 x [3 x i64]]]]]* %patches_superpoints, [32 x [5 x [3 x [16 x [3 x i64]]]]]* %patches_superpoints_copy, [32 x [5 x [4 x [6 x i64]]]]* %patches_parameters, [32 x [5 x [4 x [6 x i64]]]]* %patches_parameters_copy)
  call void @apatb_makePatches_ShadowQuilt_fromEdges_hw(i64 %apexZ0, i32 %stop, i32 %ppl, i1 %leftRight, i32* %n_patches_copy, %"struct.std::array"* %GDarray_copy, [5 x i32]* %GDn_points_copy, [32 x [5 x [3 x [16 x [3 x i64]]]]]* %patches_superpoints_copy, [32 x [5 x [4 x [6 x i64]]]]* %patches_parameters_copy)
  call fastcc void @copy_out(i32* %n_patches, i32* nonnull align 512 %n_patches_copy, %"struct.std::array"* %GDarray, %"struct.std::array"* %GDarray_copy, [5 x i32]* %GDn_points, [5 x i32]* nonnull align 512 %GDn_points_copy, [32 x [5 x [3 x [16 x [3 x i64]]]]]* %patches_superpoints, [32 x [5 x [3 x [16 x [3 x i64]]]]]* %patches_superpoints_copy, [32 x [5 x [4 x [6 x i64]]]]* %patches_parameters, [32 x [5 x [4 x [6 x i64]]]]* %patches_parameters_copy)
  tail call void @free(i8* %malloccall)
  tail call void @free(i8* %malloccall1)
  tail call void @free(i8* %malloccall2)
  ret void
}

declare noalias i8* @malloc(i64) local_unnamed_addr

; Function Attrs: noinline
define internal fastcc void @copy_in(i32* readonly, i32* noalias align 512, %"struct.std::array"*, %"struct.std::array"* noalias, [5 x i32]* readonly, [5 x i32]* noalias align 512, [32 x [5 x [3 x [16 x [3 x i64]]]]]* readonly, [32 x [5 x [3 x [16 x [3 x i64]]]]]* noalias, [32 x [5 x [4 x [6 x i64]]]]* readonly, [32 x [5 x [4 x [6 x i64]]]]* noalias) unnamed_addr #1 {
entry:
  call fastcc void @onebyonecpy_hls.p0i32(i32* align 512 %1, i32* %0)
  call fastcc void @"onebyonecpy_hls.p0struct.std::array"(%"struct.std::array"* %3, %"struct.std::array"* %2)
  call fastcc void @onebyonecpy_hls.p0a5i32([5 x i32]* align 512 %5, [5 x i32]* %4)
  call fastcc void @onebyonecpy_hls.p0a32a5a3a16a3i64([32 x [5 x [3 x [16 x [3 x i64]]]]]* %7, [32 x [5 x [3 x [16 x [3 x i64]]]]]* %6)
  call fastcc void @onebyonecpy_hls.p0a32a5a4a6i64([32 x [5 x [4 x [6 x i64]]]]* %9, [32 x [5 x [4 x [6 x i64]]]]* %8)
  ret void
}

; Function Attrs: argmemonly noinline
define internal fastcc void @onebyonecpy_hls.p0i32(i32* noalias align 512, i32* noalias readonly) unnamed_addr #2 {
entry:
  %2 = icmp eq i32* %0, null
  %3 = icmp eq i32* %1, null
  %4 = or i1 %2, %3
  br i1 %4, label %ret, label %copy

copy:                                             ; preds = %entry
  %5 = bitcast i32* %0 to i8*
  %6 = bitcast i32* %1 to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* align 1 %5, i8* align 1 %6, i64 4, i1 false)
  br label %ret

ret:                                              ; preds = %copy, %entry
  ret void
}

; Function Attrs: argmemonly nounwind
declare void @llvm.memcpy.p0i8.p0i8.i64(i8* nocapture writeonly, i8* nocapture readonly, i64, i1) #3

; Function Attrs: noinline
define internal fastcc void @"onebyonecpy_hls.p0struct.std::array"(%"struct.std::array"* noalias, %"struct.std::array"* noalias) unnamed_addr #4 {
entry:
  %2 = icmp eq %"struct.std::array"* %0, null
  %3 = icmp eq %"struct.std::array"* %1, null
  %4 = or i1 %2, %3
  br i1 %4, label %ret, label %copy

copy:                                             ; preds = %entry
  %5 = bitcast %"struct.std::array"* %1 to i8*
  %6 = call i1 @fpga_fifo_exist_30720(i8* %5)
  br i1 %6, label %7, label %8

; <label>:7:                                      ; preds = %copy
  call fastcc void @"streamcpy_hls.p0struct.std::array"(%"struct.std::array"* nonnull %0, %"struct.std::array"* nonnull %1)
  br label %ret

; <label>:8:                                      ; preds = %copy
  br label %for.loop

for.loop:                                         ; preds = %for.loop.head, %8
  %for.loop.idx33 = phi i64 [ 0, %8 ], [ %for.loop.idx.next, %for.loop.head ]
  %dst.addr18 = getelementptr %"struct.std::array", %"struct.std::array"* %0, i32 0, i32 0, i64 %for.loop.idx33
  %src.addr19 = getelementptr %"struct.std::array", %"struct.std::array"* %1, i32 0, i32 0, i64 %for.loop.idx33
  %9 = bitcast %"struct.std::array.0"* %src.addr19 to i8*
  %10 = call i1 @fpga_fifo_exist_6144(i8* %9)
  br i1 %10, label %11, label %12

; <label>:11:                                     ; preds = %for.loop
  call fastcc void @"streamcpy_hls.p0struct.std::array.0"(%"struct.std::array.0"* %dst.addr18, %"struct.std::array.0"* %src.addr19)
  br label %for.loop.head

; <label>:12:                                     ; preds = %for.loop
  br label %for.loop4

for.loop4:                                        ; preds = %for.loop.head3, %12
  %for.loop.idx631 = phi i64 [ 0, %12 ], [ %for.loop.idx6.next, %for.loop.head3 ]
  %dst.addr822 = getelementptr %"struct.std::array", %"struct.std::array"* %0, i32 0, i32 0, i64 %for.loop.idx33, i32 0, i64 %for.loop.idx631
  %src.addr923 = getelementptr %"struct.std::array", %"struct.std::array"* %1, i32 0, i32 0, i64 %for.loop.idx33, i32 0, i64 %for.loop.idx631
  %13 = bitcast %"struct.std::array.1"* %src.addr923 to i8*
  %14 = call i1 @fpga_fifo_exist_24(i8* %13)
  br i1 %14, label %15, label %16

; <label>:15:                                     ; preds = %for.loop4
  call fastcc void @"streamcpy_hls.p0struct.std::array.1"(%"struct.std::array.1"* %dst.addr822, %"struct.std::array.1"* %src.addr923)
  br label %for.loop.head3

; <label>:16:                                     ; preds = %for.loop4
  br label %for.loop12

for.loop12:                                       ; preds = %for.loop12, %16
  %for.loop.idx1430 = phi i64 [ 0, %16 ], [ %for.loop.idx14.next, %for.loop12 ]
  %dst.addr1626.gep28 = getelementptr %"struct.std::array", %"struct.std::array"* %0, i32 0, i32 0, i64 %for.loop.idx33, i32 0, i64 %for.loop.idx631, i32 0, i64 %for.loop.idx1430
  %17 = bitcast i64* %dst.addr1626.gep28 to i8*
  %src.addr1727.gep29 = getelementptr %"struct.std::array", %"struct.std::array"* %1, i32 0, i32 0, i64 %for.loop.idx33, i32 0, i64 %for.loop.idx631, i32 0, i64 %for.loop.idx1430
  %18 = bitcast i64* %src.addr1727.gep29 to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* align 1 %17, i8* align 1 %18, i64 8, i1 false)
  %for.loop.idx14.next = add nuw nsw i64 %for.loop.idx1430, 1
  %exitcond = icmp ne i64 %for.loop.idx14.next, 3
  br i1 %exitcond, label %for.loop12, label %for.loop.head3

for.loop.head3:                                   ; preds = %for.loop12, %15
  %for.loop.idx6.next = add nuw nsw i64 %for.loop.idx631, 1
  %exitcond35 = icmp ne i64 %for.loop.idx6.next, 256
  br i1 %exitcond35, label %for.loop4, label %for.loop.head

for.loop.head:                                    ; preds = %for.loop.head3, %11
  %for.loop.idx.next = add nuw nsw i64 %for.loop.idx33, 1
  %exitcond36 = icmp ne i64 %for.loop.idx.next, 5
  br i1 %exitcond36, label %for.loop, label %ret

ret:                                              ; preds = %for.loop.head, %7, %entry
  ret void
}

declare i1 @fpga_fifo_exist_30720(i8*) local_unnamed_addr

; Function Attrs: argmemonly noinline
define internal fastcc void @"streamcpy_hls.p0struct.std::array"(%"struct.std::array"* noalias nocapture, %"struct.std::array"* noalias nocapture) unnamed_addr #5 {
entry:
  %2 = alloca %"struct.std::array"
  br label %empty

empty:                                            ; preds = %push, %entry
  %3 = bitcast %"struct.std::array"* %1 to i8*
  %4 = call i1 @fpga_fifo_not_empty_30720(i8* %3)
  br i1 %4, label %push, label %ret

push:                                             ; preds = %empty
  %5 = bitcast %"struct.std::array"* %2 to i8*
  %6 = bitcast %"struct.std::array"* %1 to i8*
  call void @fpga_fifo_pop_30720(i8* %5, i8* %6)
  %7 = load volatile %"struct.std::array", %"struct.std::array"* %2
  %8 = bitcast %"struct.std::array"* %2 to i8*
  %9 = bitcast %"struct.std::array"* %0 to i8*
  call void @fpga_fifo_push_30720(i8* %8, i8* %9)
  br label %empty, !llvm.loop !5

ret:                                              ; preds = %empty
  %10 = bitcast %"struct.std::array"* %1 to i8*
  %11 = bitcast %"struct.std::array"* %0 to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* align 1 %11, i8* align 1 %10, i64 30720, i1 false)
  ret void
}

declare i1 @fpga_fifo_exist_6144(i8*) local_unnamed_addr

; Function Attrs: argmemonly noinline
define internal fastcc void @"streamcpy_hls.p0struct.std::array.0"(%"struct.std::array.0"* noalias nocapture, %"struct.std::array.0"* noalias nocapture) unnamed_addr #5 {
entry:
  %2 = alloca %"struct.std::array.0"
  br label %empty

empty:                                            ; preds = %push, %entry
  %3 = bitcast %"struct.std::array.0"* %1 to i8*
  %4 = call i1 @fpga_fifo_not_empty_6144(i8* %3)
  br i1 %4, label %push, label %ret

push:                                             ; preds = %empty
  %5 = bitcast %"struct.std::array.0"* %2 to i8*
  %6 = bitcast %"struct.std::array.0"* %1 to i8*
  call void @fpga_fifo_pop_6144(i8* %5, i8* %6)
  %7 = load volatile %"struct.std::array.0", %"struct.std::array.0"* %2
  %8 = bitcast %"struct.std::array.0"* %2 to i8*
  %9 = bitcast %"struct.std::array.0"* %0 to i8*
  call void @fpga_fifo_push_6144(i8* %8, i8* %9)
  br label %empty, !llvm.loop !7

ret:                                              ; preds = %empty
  %10 = bitcast %"struct.std::array.0"* %1 to i8*
  %11 = bitcast %"struct.std::array.0"* %0 to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* align 1 %11, i8* align 1 %10, i64 6144, i1 false)
  ret void
}

declare i1 @fpga_fifo_exist_24(i8*) local_unnamed_addr

; Function Attrs: argmemonly noinline
define internal fastcc void @"streamcpy_hls.p0struct.std::array.1"(%"struct.std::array.1"* noalias nocapture, %"struct.std::array.1"* noalias nocapture) unnamed_addr #5 {
entry:
  %2 = alloca %"struct.std::array.1"
  br label %empty

empty:                                            ; preds = %push, %entry
  %3 = bitcast %"struct.std::array.1"* %1 to i8*
  %4 = call i1 @fpga_fifo_not_empty_24(i8* %3)
  br i1 %4, label %push, label %ret

push:                                             ; preds = %empty
  %5 = bitcast %"struct.std::array.1"* %2 to i8*
  %6 = bitcast %"struct.std::array.1"* %1 to i8*
  call void @fpga_fifo_pop_24(i8* %5, i8* %6)
  %7 = load volatile %"struct.std::array.1", %"struct.std::array.1"* %2
  %8 = bitcast %"struct.std::array.1"* %2 to i8*
  %9 = bitcast %"struct.std::array.1"* %0 to i8*
  call void @fpga_fifo_push_24(i8* %8, i8* %9)
  br label %empty, !llvm.loop !8

ret:                                              ; preds = %empty
  %10 = bitcast %"struct.std::array.1"* %1 to i8*
  %11 = bitcast %"struct.std::array.1"* %0 to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* align 1 %11, i8* align 1 %10, i64 24, i1 false)
  ret void
}

; Function Attrs: argmemonly noinline
define internal fastcc void @onebyonecpy_hls.p0a5i32([5 x i32]* noalias align 512, [5 x i32]* noalias readonly) unnamed_addr #2 {
entry:
  %2 = icmp eq [5 x i32]* %0, null
  %3 = icmp eq [5 x i32]* %1, null
  %4 = or i1 %2, %3
  br i1 %4, label %ret, label %copy

copy:                                             ; preds = %entry
  br label %for.loop

for.loop:                                         ; preds = %for.loop, %copy
  %for.loop.idx3 = phi i64 [ 0, %copy ], [ %for.loop.idx.next, %for.loop ]
  %dst.addr.gep1 = getelementptr [5 x i32], [5 x i32]* %0, i64 0, i64 %for.loop.idx3
  %5 = bitcast i32* %dst.addr.gep1 to i8*
  %src.addr.gep2 = getelementptr [5 x i32], [5 x i32]* %1, i64 0, i64 %for.loop.idx3
  %6 = bitcast i32* %src.addr.gep2 to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* align 1 %5, i8* align 1 %6, i64 4, i1 false)
  %for.loop.idx.next = add nuw nsw i64 %for.loop.idx3, 1
  %exitcond = icmp ne i64 %for.loop.idx.next, 5
  br i1 %exitcond, label %for.loop, label %ret

ret:                                              ; preds = %for.loop, %entry
  ret void
}

; Function Attrs: argmemonly noinline
define internal fastcc void @onebyonecpy_hls.p0a32a5a3a16a3i64([32 x [5 x [3 x [16 x [3 x i64]]]]]* noalias, [32 x [5 x [3 x [16 x [3 x i64]]]]]* noalias readonly) unnamed_addr #2 {
entry:
  %2 = icmp eq [32 x [5 x [3 x [16 x [3 x i64]]]]]* %0, null
  %3 = icmp eq [32 x [5 x [3 x [16 x [3 x i64]]]]]* %1, null
  %4 = or i1 %2, %3
  br i1 %4, label %ret, label %copy

copy:                                             ; preds = %entry
  br label %for.loop

for.loop:                                         ; preds = %for.loop.split, %copy
  %for.loop.idx39 = phi i64 [ 0, %copy ], [ %for.loop.idx.next, %for.loop.split ]
  br label %for.loop2

for.loop2:                                        ; preds = %for.loop2.split, %for.loop
  %for.loop.idx338 = phi i64 [ 0, %for.loop ], [ %for.loop.idx3.next, %for.loop2.split ]
  br label %for.loop8

for.loop8:                                        ; preds = %for.loop8.split, %for.loop2
  %for.loop.idx937 = phi i64 [ 0, %for.loop2 ], [ %for.loop.idx9.next, %for.loop8.split ]
  br label %for.loop14

for.loop14:                                       ; preds = %for.loop14.split, %for.loop8
  %for.loop.idx1536 = phi i64 [ 0, %for.loop8 ], [ %for.loop.idx15.next, %for.loop14.split ]
  br label %for.loop20

for.loop20:                                       ; preds = %for.loop20, %for.loop14
  %for.loop.idx2135 = phi i64 [ 0, %for.loop14 ], [ %for.loop.idx21.next, %for.loop20 ]
  %dst.addr2331.gep33 = getelementptr [32 x [5 x [3 x [16 x [3 x i64]]]]], [32 x [5 x [3 x [16 x [3 x i64]]]]]* %0, i64 0, i64 %for.loop.idx39, i64 %for.loop.idx338, i64 %for.loop.idx937, i64 %for.loop.idx1536, i64 %for.loop.idx2135
  %5 = bitcast i64* %dst.addr2331.gep33 to i8*
  %src.addr2432.gep34 = getelementptr [32 x [5 x [3 x [16 x [3 x i64]]]]], [32 x [5 x [3 x [16 x [3 x i64]]]]]* %1, i64 0, i64 %for.loop.idx39, i64 %for.loop.idx338, i64 %for.loop.idx937, i64 %for.loop.idx1536, i64 %for.loop.idx2135
  %6 = bitcast i64* %src.addr2432.gep34 to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* align 1 %5, i8* align 1 %6, i64 8, i1 false)
  %for.loop.idx21.next = add nuw nsw i64 %for.loop.idx2135, 1
  %exitcond = icmp ne i64 %for.loop.idx21.next, 3
  br i1 %exitcond, label %for.loop20, label %for.loop14.split

for.loop14.split:                                 ; preds = %for.loop20
  %for.loop.idx15.next = add nuw nsw i64 %for.loop.idx1536, 1
  %exitcond40 = icmp ne i64 %for.loop.idx15.next, 16
  br i1 %exitcond40, label %for.loop14, label %for.loop8.split

for.loop8.split:                                  ; preds = %for.loop14.split
  %for.loop.idx9.next = add nuw nsw i64 %for.loop.idx937, 1
  %exitcond41 = icmp ne i64 %for.loop.idx9.next, 3
  br i1 %exitcond41, label %for.loop8, label %for.loop2.split

for.loop2.split:                                  ; preds = %for.loop8.split
  %for.loop.idx3.next = add nuw nsw i64 %for.loop.idx338, 1
  %exitcond42 = icmp ne i64 %for.loop.idx3.next, 5
  br i1 %exitcond42, label %for.loop2, label %for.loop.split

for.loop.split:                                   ; preds = %for.loop2.split
  %for.loop.idx.next = add nuw nsw i64 %for.loop.idx39, 1
  %exitcond43 = icmp ne i64 %for.loop.idx.next, 32
  br i1 %exitcond43, label %for.loop, label %ret

ret:                                              ; preds = %for.loop.split, %entry
  ret void
}

; Function Attrs: argmemonly noinline
define internal fastcc void @onebyonecpy_hls.p0a32a5a4a6i64([32 x [5 x [4 x [6 x i64]]]]* noalias, [32 x [5 x [4 x [6 x i64]]]]* noalias readonly) unnamed_addr #2 {
entry:
  %2 = icmp eq [32 x [5 x [4 x [6 x i64]]]]* %0, null
  %3 = icmp eq [32 x [5 x [4 x [6 x i64]]]]* %1, null
  %4 = or i1 %2, %3
  br i1 %4, label %ret, label %copy

copy:                                             ; preds = %entry
  br label %for.loop

for.loop:                                         ; preds = %for.loop.split, %copy
  %for.loop.idx30 = phi i64 [ 0, %copy ], [ %for.loop.idx.next, %for.loop.split ]
  br label %for.loop2

for.loop2:                                        ; preds = %for.loop2.split, %for.loop
  %for.loop.idx329 = phi i64 [ 0, %for.loop ], [ %for.loop.idx3.next, %for.loop2.split ]
  br label %for.loop8

for.loop8:                                        ; preds = %for.loop8.split, %for.loop2
  %for.loop.idx928 = phi i64 [ 0, %for.loop2 ], [ %for.loop.idx9.next, %for.loop8.split ]
  br label %for.loop14

for.loop14:                                       ; preds = %for.loop14, %for.loop8
  %for.loop.idx1527 = phi i64 [ 0, %for.loop8 ], [ %for.loop.idx15.next, %for.loop14 ]
  %dst.addr1723.gep25 = getelementptr [32 x [5 x [4 x [6 x i64]]]], [32 x [5 x [4 x [6 x i64]]]]* %0, i64 0, i64 %for.loop.idx30, i64 %for.loop.idx329, i64 %for.loop.idx928, i64 %for.loop.idx1527
  %5 = bitcast i64* %dst.addr1723.gep25 to i8*
  %src.addr1824.gep26 = getelementptr [32 x [5 x [4 x [6 x i64]]]], [32 x [5 x [4 x [6 x i64]]]]* %1, i64 0, i64 %for.loop.idx30, i64 %for.loop.idx329, i64 %for.loop.idx928, i64 %for.loop.idx1527
  %6 = bitcast i64* %src.addr1824.gep26 to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* align 1 %5, i8* align 1 %6, i64 8, i1 false)
  %for.loop.idx15.next = add nuw nsw i64 %for.loop.idx1527, 1
  %exitcond = icmp ne i64 %for.loop.idx15.next, 6
  br i1 %exitcond, label %for.loop14, label %for.loop8.split

for.loop8.split:                                  ; preds = %for.loop14
  %for.loop.idx9.next = add nuw nsw i64 %for.loop.idx928, 1
  %exitcond31 = icmp ne i64 %for.loop.idx9.next, 4
  br i1 %exitcond31, label %for.loop8, label %for.loop2.split

for.loop2.split:                                  ; preds = %for.loop8.split
  %for.loop.idx3.next = add nuw nsw i64 %for.loop.idx329, 1
  %exitcond32 = icmp ne i64 %for.loop.idx3.next, 5
  br i1 %exitcond32, label %for.loop2, label %for.loop.split

for.loop.split:                                   ; preds = %for.loop2.split
  %for.loop.idx.next = add nuw nsw i64 %for.loop.idx30, 1
  %exitcond33 = icmp ne i64 %for.loop.idx.next, 32
  br i1 %exitcond33, label %for.loop, label %ret

ret:                                              ; preds = %for.loop.split, %entry
  ret void
}

; Function Attrs: noinline
define internal fastcc void @copy_out(i32*, i32* noalias readonly align 512, %"struct.std::array"*, %"struct.std::array"* noalias, [5 x i32]*, [5 x i32]* noalias readonly align 512, [32 x [5 x [3 x [16 x [3 x i64]]]]]*, [32 x [5 x [3 x [16 x [3 x i64]]]]]* noalias readonly, [32 x [5 x [4 x [6 x i64]]]]*, [32 x [5 x [4 x [6 x i64]]]]* noalias readonly) unnamed_addr #6 {
entry:
  call fastcc void @onebyonecpy_hls.p0i32(i32* %0, i32* align 512 %1)
  call fastcc void @"onebyonecpy_hls.p0struct.std::array"(%"struct.std::array"* %2, %"struct.std::array"* %3)
  call fastcc void @onebyonecpy_hls.p0a5i32([5 x i32]* %4, [5 x i32]* align 512 %5)
  call fastcc void @onebyonecpy_hls.p0a32a5a3a16a3i64([32 x [5 x [3 x [16 x [3 x i64]]]]]* %6, [32 x [5 x [3 x [16 x [3 x i64]]]]]* %7)
  call fastcc void @onebyonecpy_hls.p0a32a5a4a6i64([32 x [5 x [4 x [6 x i64]]]]* %8, [32 x [5 x [4 x [6 x i64]]]]* %9)
  ret void
}

declare void @free(i8*) local_unnamed_addr

declare void @apatb_makePatches_ShadowQuilt_fromEdges_hw(i64, i32, i32, i1, i32*, %"struct.std::array"*, [5 x i32]*, [32 x [5 x [3 x [16 x [3 x i64]]]]]*, [32 x [5 x [4 x [6 x i64]]]]*)

define void @makePatches_ShadowQuilt_fromEdges_hw_stub_wrapper(i64, i32, i32, i1, i32*, %"struct.std::array"*, [5 x i32]*, [32 x [5 x [3 x [16 x [3 x i64]]]]]*, [32 x [5 x [4 x [6 x i64]]]]*) #7 {
entry:
  call void @copy_out(i32* null, i32* %4, %"struct.std::array"* null, %"struct.std::array"* %5, [5 x i32]* null, [5 x i32]* %6, [32 x [5 x [3 x [16 x [3 x i64]]]]]* null, [32 x [5 x [3 x [16 x [3 x i64]]]]]* %7, [32 x [5 x [4 x [6 x i64]]]]* null, [32 x [5 x [4 x [6 x i64]]]]* %8)
  call void @makePatches_ShadowQuilt_fromEdges_hw_stub(i64 %0, i32 %1, i32 %2, i1 %3, i32* %4, %"struct.std::array"* %5, [5 x i32]* %6, [32 x [5 x [3 x [16 x [3 x i64]]]]]* %7, [32 x [5 x [4 x [6 x i64]]]]* %8)
  call void @copy_in(i32* null, i32* %4, %"struct.std::array"* null, %"struct.std::array"* %5, [5 x i32]* null, [5 x i32]* %6, [32 x [5 x [3 x [16 x [3 x i64]]]]]* null, [32 x [5 x [3 x [16 x [3 x i64]]]]]* %7, [32 x [5 x [4 x [6 x i64]]]]* null, [32 x [5 x [4 x [6 x i64]]]]* %8)
  ret void
}

declare void @makePatches_ShadowQuilt_fromEdges_hw_stub(i64, i32, i32, i1, i32*, %"struct.std::array"*, [5 x i32]*, [32 x [5 x [3 x [16 x [3 x i64]]]]]*, [32 x [5 x [4 x [6 x i64]]]]*)

declare i1 @fpga_fifo_not_empty_30720(i8*)

declare i1 @fpga_fifo_not_empty_6144(i8*)

declare i1 @fpga_fifo_not_empty_24(i8*)

declare void @fpga_fifo_pop_30720(i8*, i8*)

declare void @fpga_fifo_pop_6144(i8*, i8*)

declare void @fpga_fifo_pop_24(i8*, i8*)

declare void @fpga_fifo_push_30720(i8*, i8*)

declare void @fpga_fifo_push_6144(i8*, i8*)

declare void @fpga_fifo_push_24(i8*, i8*)

attributes #0 = { noinline "fpga.wrapper.func"="wrapper" }
attributes #1 = { noinline "fpga.wrapper.func"="copyin" }
attributes #2 = { argmemonly noinline "fpga.wrapper.func"="onebyonecpy_hls" }
attributes #3 = { argmemonly nounwind }
attributes #4 = { noinline "fpga.wrapper.func"="onebyonecpy_hls" }
attributes #5 = { argmemonly noinline "fpga.wrapper.func"="streamcpy_hls" }
attributes #6 = { noinline "fpga.wrapper.func"="copyout" }
attributes #7 = { "fpga.wrapper.func"="stub" }

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
