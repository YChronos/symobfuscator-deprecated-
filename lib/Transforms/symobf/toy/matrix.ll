; ModuleID = 'matrix.c'
source_filename = "matrix.c"
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

@.str = private unnamed_addr constant [4 x i8] c"%d\0A\00", align 1
@main.initMat = private unnamed_addr constant [1 x [2 x i32]] [[2 x i32] [i32 1, i32 0]], align 4

; Function Attrs: nounwind uwtable
define i32** @MM(i32** %mat1, i32** %mat2, i32 %m1Height, i32 %m1Width, i32 %m2Height, i32 %m2Width) #0 {
entry:
  %retval = alloca i32**, align 8
  %mat1.addr = alloca i32**, align 8
  %mat2.addr = alloca i32**, align 8
  %m1Height.addr = alloca i32, align 4
  %m1Width.addr = alloca i32, align 4
  %m2Height.addr = alloca i32, align 4
  %m2Width.addr = alloca i32, align 4
  %saved_stack = alloca i8*, align 8
  %cleanup.dest.slot = alloca i32
  %i = alloca i32, align 4
  %j = alloca i32, align 4
  %ele = alloca i32, align 4
  %k = alloca i32, align 4
  store i32** %mat1, i32*** %mat1.addr, align 8
  store i32** %mat2, i32*** %mat2.addr, align 8
  store i32 %m1Height, i32* %m1Height.addr, align 4
  store i32 %m1Width, i32* %m1Width.addr, align 4
  store i32 %m2Height, i32* %m2Height.addr, align 4
  store i32 %m2Width, i32* %m2Width.addr, align 4
  %0 = load i32, i32* %m1Height.addr, align 4
  %1 = zext i32 %0 to i64
  %2 = load i32, i32* %m2Width.addr, align 4
  %3 = zext i32 %2 to i64
  %4 = call i8* @llvm.stacksave()
  store i8* %4, i8** %saved_stack, align 8
  %5 = mul nuw i64 %1, %3
  %vla = alloca i32, i64 %5, align 16
  %6 = load i32, i32* %m1Width.addr, align 4
  %7 = load i32, i32* %m2Height.addr, align 4
  %cmp = icmp ne i32 %6, %7
  br i1 %cmp, label %if.then, label %if.end

if.then:                                          ; preds = %entry
  %8 = bitcast i32* %vla to i32**
  store i32** %8, i32*** %retval, align 8
  store i32 1, i32* %cleanup.dest.slot, align 4
  br label %cleanup

if.end:                                           ; preds = %entry
  store i32 0, i32* %i, align 4
  br label %for.cond

for.cond:                                         ; preds = %for.inc21, %if.end
  %9 = load i32, i32* %i, align 4
  %10 = load i32, i32* %m1Height.addr, align 4
  %cmp1 = icmp slt i32 %9, %10
  br i1 %cmp1, label %for.body, label %for.end23

for.body:                                         ; preds = %for.cond
  store i32 0, i32* %j, align 4
  br label %for.cond2

for.cond2:                                        ; preds = %for.inc18, %for.body
  %11 = load i32, i32* %j, align 4
  %12 = load i32, i32* %m2Width.addr, align 4
  %cmp3 = icmp slt i32 %11, %12
  br i1 %cmp3, label %for.body4, label %for.end20

for.body4:                                        ; preds = %for.cond2
  store i32 0, i32* %ele, align 4
  store i32 0, i32* %k, align 4
  br label %for.cond5

for.cond5:                                        ; preds = %for.inc, %for.body4
  %13 = load i32, i32* %k, align 4
  %14 = load i32, i32* %m1Width.addr, align 4
  %cmp6 = icmp slt i32 %13, %14
  br i1 %cmp6, label %for.body7, label %for.end

for.body7:                                        ; preds = %for.cond5
  %15 = load i32, i32* %ele, align 4
  %16 = load i32**, i32*** %mat1.addr, align 8
  %17 = bitcast i32** %16 to i32*
  %18 = load i32, i32* %i, align 4
  %19 = load i32, i32* %m1Width.addr, align 4
  %mul = mul nsw i32 %18, %19
  %idx.ext = sext i32 %mul to i64
  %add.ptr = getelementptr inbounds i32, i32* %17, i64 %idx.ext
  %20 = load i32, i32* %k, align 4
  %idx.ext8 = sext i32 %20 to i64
  %add.ptr9 = getelementptr inbounds i32, i32* %add.ptr, i64 %idx.ext8
  %21 = load i32, i32* %add.ptr9, align 4
  %22 = load i32**, i32*** %mat2.addr, align 8
  %23 = bitcast i32** %22 to i32*
  %24 = load i32, i32* %k, align 4
  %25 = load i32, i32* %m2Width.addr, align 4
  %mul10 = mul nsw i32 %24, %25
  %idx.ext11 = sext i32 %mul10 to i64
  %add.ptr12 = getelementptr inbounds i32, i32* %23, i64 %idx.ext11
  %26 = load i32, i32* %j, align 4
  %idx.ext13 = sext i32 %26 to i64
  %add.ptr14 = getelementptr inbounds i32, i32* %add.ptr12, i64 %idx.ext13
  %27 = load i32, i32* %add.ptr14, align 4
  %mul15 = mul nsw i32 %21, %27
  %add = add nsw i32 %15, %mul15
  store i32 %add, i32* %ele, align 4
  br label %for.inc

for.inc:                                          ; preds = %for.body7
  %28 = load i32, i32* %k, align 4
  %inc = add nsw i32 %28, 1
  store i32 %inc, i32* %k, align 4
  br label %for.cond5

for.end:                                          ; preds = %for.cond5
  %29 = load i32, i32* %ele, align 4
  %30 = load i32, i32* %j, align 4
  %idxprom = sext i32 %30 to i64
  %31 = load i32, i32* %i, align 4
  %idxprom16 = sext i32 %31 to i64
  %32 = mul nsw i64 %idxprom16, %3
  %arrayidx = getelementptr inbounds i32, i32* %vla, i64 %32
  %arrayidx17 = getelementptr inbounds i32, i32* %arrayidx, i64 %idxprom
  store i32 %29, i32* %arrayidx17, align 4
  %33 = load i32, i32* %ele, align 4
  %call = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([4 x i8], [4 x i8]* @.str, i32 0, i32 0), i32 %33)
  br label %for.inc18

for.inc18:                                        ; preds = %for.end
  %34 = load i32, i32* %j, align 4
  %inc19 = add nsw i32 %34, 1
  store i32 %inc19, i32* %j, align 4
  br label %for.cond2

for.end20:                                        ; preds = %for.cond2
  br label %for.inc21

for.inc21:                                        ; preds = %for.end20
  %35 = load i32, i32* %i, align 4
  %inc22 = add nsw i32 %35, 1
  store i32 %inc22, i32* %i, align 4
  br label %for.cond

for.end23:                                        ; preds = %for.cond
  %36 = bitcast i32* %vla to i32**
  store i32** %36, i32*** %retval, align 8
  store i32 1, i32* %cleanup.dest.slot, align 4
  br label %cleanup

cleanup:                                          ; preds = %for.end23, %if.then
  %37 = load i8*, i8** %saved_stack, align 8
  call void @llvm.stackrestore(i8* %37)
  %38 = load i32**, i32*** %retval, align 8
  ret i32** %38
}

; Function Attrs: nounwind
declare i8* @llvm.stacksave() #1

declare i32 @printf(i8*, ...) #2

; Function Attrs: nounwind
declare void @llvm.stackrestore(i8*) #1

; Function Attrs: nounwind uwtable
define i32 @main(i32 %argc, i8** %argv) #0 {
entry:
  %retval = alloca i32, align 4
  %argc.addr = alloca i32, align 4
  %argv.addr = alloca i8**, align 8
  %inp = alloca [2 x i32], align 4
  %len = alloca i32, align 4
  %mat = alloca [2 x [2 x [2 x [2 x i32]]]], align 16
  %selMat1 = alloca i32**, align 8
  %selMat2 = alloca i32**, align 8
  %initMat = alloca [1 x [2 x i32]], align 4
  %interMat = alloca i32**, align 8
  %i = alloca i32, align 4
  store i32 0, i32* %retval, align 4
  store i32 %argc, i32* %argc.addr, align 4
  store i8** %argv, i8*** %argv.addr, align 8
  %0 = load i8**, i8*** %argv.addr, align 8
  %arrayidx = getelementptr inbounds i8*, i8** %0, i64 1
  %1 = load i8*, i8** %arrayidx, align 8
  %arrayidx1 = getelementptr inbounds i8, i8* %1, i64 0
  %2 = load i8, i8* %arrayidx1, align 1
  %conv = sext i8 %2 to i32
  %rem = srem i32 %conv, 2
  %arrayidx2 = getelementptr inbounds [2 x i32], [2 x i32]* %inp, i64 0, i64 0
  store i32 %rem, i32* %arrayidx2, align 4
  %3 = load i8**, i8*** %argv.addr, align 8
  %arrayidx3 = getelementptr inbounds i8*, i8** %3, i64 1
  %4 = load i8*, i8** %arrayidx3, align 8
  %arrayidx4 = getelementptr inbounds i8, i8* %4, i64 1
  %5 = load i8, i8* %arrayidx4, align 1
  %conv5 = sext i8 %5 to i32
  %rem6 = srem i32 %conv5, 2
  %arrayidx7 = getelementptr inbounds [2 x i32], [2 x i32]* %inp, i64 0, i64 1
  store i32 %rem6, i32* %arrayidx7, align 4
  store i32 2, i32* %len, align 4
  %arrayidx8 = getelementptr inbounds [2 x [2 x [2 x [2 x i32]]]], [2 x [2 x [2 x [2 x i32]]]]* %mat, i64 0, i64 0
  %arrayidx9 = getelementptr inbounds [2 x [2 x [2 x i32]]], [2 x [2 x [2 x i32]]]* %arrayidx8, i64 0, i64 1
  %arrayidx10 = getelementptr inbounds [2 x [2 x i32]], [2 x [2 x i32]]* %arrayidx9, i64 0, i64 0
  %arrayidx11 = getelementptr inbounds [2 x i32], [2 x i32]* %arrayidx10, i64 0, i64 0
  store i32 0, i32* %arrayidx11, align 16
  %arrayidx12 = getelementptr inbounds [2 x [2 x [2 x [2 x i32]]]], [2 x [2 x [2 x [2 x i32]]]]* %mat, i64 0, i64 0
  %arrayidx13 = getelementptr inbounds [2 x [2 x [2 x i32]]], [2 x [2 x [2 x i32]]]* %arrayidx12, i64 0, i64 1
  %arrayidx14 = getelementptr inbounds [2 x [2 x i32]], [2 x [2 x i32]]* %arrayidx13, i64 0, i64 0
  %arrayidx15 = getelementptr inbounds [2 x i32], [2 x i32]* %arrayidx14, i64 0, i64 1
  store i32 1, i32* %arrayidx15, align 4
  %arrayidx16 = getelementptr inbounds [2 x [2 x [2 x [2 x i32]]]], [2 x [2 x [2 x [2 x i32]]]]* %mat, i64 0, i64 0
  %arrayidx17 = getelementptr inbounds [2 x [2 x [2 x i32]]], [2 x [2 x [2 x i32]]]* %arrayidx16, i64 0, i64 1
  %arrayidx18 = getelementptr inbounds [2 x [2 x i32]], [2 x [2 x i32]]* %arrayidx17, i64 0, i64 1
  %arrayidx19 = getelementptr inbounds [2 x i32], [2 x i32]* %arrayidx18, i64 0, i64 1
  store i32 1, i32* %arrayidx19, align 4
  %arrayidx20 = getelementptr inbounds [2 x [2 x [2 x [2 x i32]]]], [2 x [2 x [2 x [2 x i32]]]]* %mat, i64 0, i64 0
  %arrayidx21 = getelementptr inbounds [2 x [2 x [2 x i32]]], [2 x [2 x [2 x i32]]]* %arrayidx20, i64 0, i64 1
  %arrayidx22 = getelementptr inbounds [2 x [2 x i32]], [2 x [2 x i32]]* %arrayidx21, i64 0, i64 1
  %arrayidx23 = getelementptr inbounds [2 x i32], [2 x i32]* %arrayidx22, i64 0, i64 0
  store i32 0, i32* %arrayidx23, align 8
  %arrayidx24 = getelementptr inbounds [2 x [2 x [2 x [2 x i32]]]], [2 x [2 x [2 x [2 x i32]]]]* %mat, i64 0, i64 0
  %arrayidx25 = getelementptr inbounds [2 x [2 x [2 x i32]]], [2 x [2 x [2 x i32]]]* %arrayidx24, i64 0, i64 0
  %arrayidx26 = getelementptr inbounds [2 x [2 x i32]], [2 x [2 x i32]]* %arrayidx25, i64 0, i64 0
  %arrayidx27 = getelementptr inbounds [2 x i32], [2 x i32]* %arrayidx26, i64 0, i64 0
  store i32 0, i32* %arrayidx27, align 16
  %arrayidx28 = getelementptr inbounds [2 x [2 x [2 x [2 x i32]]]], [2 x [2 x [2 x [2 x i32]]]]* %mat, i64 0, i64 0
  %arrayidx29 = getelementptr inbounds [2 x [2 x [2 x i32]]], [2 x [2 x [2 x i32]]]* %arrayidx28, i64 0, i64 0
  %arrayidx30 = getelementptr inbounds [2 x [2 x i32]], [2 x [2 x i32]]* %arrayidx29, i64 0, i64 0
  %arrayidx31 = getelementptr inbounds [2 x i32], [2 x i32]* %arrayidx30, i64 0, i64 1
  store i32 1, i32* %arrayidx31, align 4
  %arrayidx32 = getelementptr inbounds [2 x [2 x [2 x [2 x i32]]]], [2 x [2 x [2 x [2 x i32]]]]* %mat, i64 0, i64 0
  %arrayidx33 = getelementptr inbounds [2 x [2 x [2 x i32]]], [2 x [2 x [2 x i32]]]* %arrayidx32, i64 0, i64 0
  %arrayidx34 = getelementptr inbounds [2 x [2 x i32]], [2 x [2 x i32]]* %arrayidx33, i64 0, i64 1
  %arrayidx35 = getelementptr inbounds [2 x i32], [2 x i32]* %arrayidx34, i64 0, i64 1
  store i32 0, i32* %arrayidx35, align 4
  %arrayidx36 = getelementptr inbounds [2 x [2 x [2 x [2 x i32]]]], [2 x [2 x [2 x [2 x i32]]]]* %mat, i64 0, i64 0
  %arrayidx37 = getelementptr inbounds [2 x [2 x [2 x i32]]], [2 x [2 x [2 x i32]]]* %arrayidx36, i64 0, i64 0
  %arrayidx38 = getelementptr inbounds [2 x [2 x i32]], [2 x [2 x i32]]* %arrayidx37, i64 0, i64 1
  %arrayidx39 = getelementptr inbounds [2 x i32], [2 x i32]* %arrayidx38, i64 0, i64 0
  store i32 0, i32* %arrayidx39, align 8
  %arrayidx40 = getelementptr inbounds [2 x [2 x [2 x [2 x i32]]]], [2 x [2 x [2 x [2 x i32]]]]* %mat, i64 0, i64 1
  %arrayidx41 = getelementptr inbounds [2 x [2 x [2 x i32]]], [2 x [2 x [2 x i32]]]* %arrayidx40, i64 0, i64 1
  %arrayidx42 = getelementptr inbounds [2 x [2 x i32]], [2 x [2 x i32]]* %arrayidx41, i64 0, i64 0
  %arrayidx43 = getelementptr inbounds [2 x i32], [2 x i32]* %arrayidx42, i64 0, i64 0
  store i32 0, i32* %arrayidx43, align 16
  %arrayidx44 = getelementptr inbounds [2 x [2 x [2 x [2 x i32]]]], [2 x [2 x [2 x [2 x i32]]]]* %mat, i64 0, i64 1
  %arrayidx45 = getelementptr inbounds [2 x [2 x [2 x i32]]], [2 x [2 x [2 x i32]]]* %arrayidx44, i64 0, i64 1
  %arrayidx46 = getelementptr inbounds [2 x [2 x i32]], [2 x [2 x i32]]* %arrayidx45, i64 0, i64 0
  %arrayidx47 = getelementptr inbounds [2 x i32], [2 x i32]* %arrayidx46, i64 0, i64 1
  store i32 1, i32* %arrayidx47, align 4
  %arrayidx48 = getelementptr inbounds [2 x [2 x [2 x [2 x i32]]]], [2 x [2 x [2 x [2 x i32]]]]* %mat, i64 0, i64 1
  %arrayidx49 = getelementptr inbounds [2 x [2 x [2 x i32]]], [2 x [2 x [2 x i32]]]* %arrayidx48, i64 0, i64 1
  %arrayidx50 = getelementptr inbounds [2 x [2 x i32]], [2 x [2 x i32]]* %arrayidx49, i64 0, i64 1
  %arrayidx51 = getelementptr inbounds [2 x i32], [2 x i32]* %arrayidx50, i64 0, i64 1
  store i32 1, i32* %arrayidx51, align 4
  %arrayidx52 = getelementptr inbounds [2 x [2 x [2 x [2 x i32]]]], [2 x [2 x [2 x [2 x i32]]]]* %mat, i64 0, i64 1
  %arrayidx53 = getelementptr inbounds [2 x [2 x [2 x i32]]], [2 x [2 x [2 x i32]]]* %arrayidx52, i64 0, i64 1
  %arrayidx54 = getelementptr inbounds [2 x [2 x i32]], [2 x [2 x i32]]* %arrayidx53, i64 0, i64 1
  %arrayidx55 = getelementptr inbounds [2 x i32], [2 x i32]* %arrayidx54, i64 0, i64 0
  store i32 0, i32* %arrayidx55, align 8
  %arrayidx56 = getelementptr inbounds [2 x [2 x [2 x [2 x i32]]]], [2 x [2 x [2 x [2 x i32]]]]* %mat, i64 0, i64 1
  %arrayidx57 = getelementptr inbounds [2 x [2 x [2 x i32]]], [2 x [2 x [2 x i32]]]* %arrayidx56, i64 0, i64 0
  %arrayidx58 = getelementptr inbounds [2 x [2 x i32]], [2 x [2 x i32]]* %arrayidx57, i64 0, i64 0
  %arrayidx59 = getelementptr inbounds [2 x i32], [2 x i32]* %arrayidx58, i64 0, i64 0
  store i32 0, i32* %arrayidx59, align 16
  %arrayidx60 = getelementptr inbounds [2 x [2 x [2 x [2 x i32]]]], [2 x [2 x [2 x [2 x i32]]]]* %mat, i64 0, i64 1
  %arrayidx61 = getelementptr inbounds [2 x [2 x [2 x i32]]], [2 x [2 x [2 x i32]]]* %arrayidx60, i64 0, i64 0
  %arrayidx62 = getelementptr inbounds [2 x [2 x i32]], [2 x [2 x i32]]* %arrayidx61, i64 0, i64 0
  %arrayidx63 = getelementptr inbounds [2 x i32], [2 x i32]* %arrayidx62, i64 0, i64 1
  store i32 1, i32* %arrayidx63, align 4
  %arrayidx64 = getelementptr inbounds [2 x [2 x [2 x [2 x i32]]]], [2 x [2 x [2 x [2 x i32]]]]* %mat, i64 0, i64 1
  %arrayidx65 = getelementptr inbounds [2 x [2 x [2 x i32]]], [2 x [2 x [2 x i32]]]* %arrayidx64, i64 0, i64 0
  %arrayidx66 = getelementptr inbounds [2 x [2 x i32]], [2 x [2 x i32]]* %arrayidx65, i64 0, i64 1
  %arrayidx67 = getelementptr inbounds [2 x i32], [2 x i32]* %arrayidx66, i64 0, i64 0
  store i32 0, i32* %arrayidx67, align 8
  %arrayidx68 = getelementptr inbounds [2 x [2 x [2 x [2 x i32]]]], [2 x [2 x [2 x [2 x i32]]]]* %mat, i64 0, i64 1
  %arrayidx69 = getelementptr inbounds [2 x [2 x [2 x i32]]], [2 x [2 x [2 x i32]]]* %arrayidx68, i64 0, i64 0
  %arrayidx70 = getelementptr inbounds [2 x [2 x i32]], [2 x [2 x i32]]* %arrayidx69, i64 0, i64 1
  %arrayidx71 = getelementptr inbounds [2 x i32], [2 x i32]* %arrayidx70, i64 0, i64 1
  store i32 0, i32* %arrayidx71, align 4
  %6 = bitcast [1 x [2 x i32]]* %initMat to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* %6, i8* bitcast ([1 x [2 x i32]]* @main.initMat to i8*), i64 8, i32 4, i1 false)
  %arraydecay = getelementptr inbounds [1 x [2 x i32]], [1 x [2 x i32]]* %initMat, i32 0, i32 0
  %7 = bitcast [2 x i32]* %arraydecay to i32**
  %arrayidx72 = getelementptr inbounds [2 x i32], [2 x i32]* %inp, i64 0, i64 0
  %8 = load i32, i32* %arrayidx72, align 4
  %idxprom = sext i32 %8 to i64
  %arrayidx73 = getelementptr inbounds [2 x [2 x [2 x [2 x i32]]]], [2 x [2 x [2 x [2 x i32]]]]* %mat, i64 0, i64 0
  %arrayidx74 = getelementptr inbounds [2 x [2 x [2 x i32]]], [2 x [2 x [2 x i32]]]* %arrayidx73, i64 0, i64 %idxprom
  %arraydecay75 = getelementptr inbounds [2 x [2 x i32]], [2 x [2 x i32]]* %arrayidx74, i32 0, i32 0
  %9 = bitcast [2 x i32]* %arraydecay75 to i32**
  %call = call i32** @MM(i32** %7, i32** %9, i32 1, i32 2, i32 2, i32 2)
  store i32** %call, i32*** %interMat, align 8
  store i32 1, i32* %i, align 4
  br label %for.cond

for.cond:                                         ; preds = %for.inc, %entry
  %10 = load i32, i32* %i, align 4
  %11 = load i32, i32* %len, align 4
  %cmp = icmp slt i32 %10, %11
  br i1 %cmp, label %for.body, label %for.end

for.body:                                         ; preds = %for.cond
  %12 = load i32**, i32*** %interMat, align 8
  %13 = load i32, i32* %i, align 4
  %idxprom77 = sext i32 %13 to i64
  %arrayidx78 = getelementptr inbounds [2 x i32], [2 x i32]* %inp, i64 0, i64 %idxprom77
  %14 = load i32, i32* %arrayidx78, align 4
  %idxprom79 = sext i32 %14 to i64
  %15 = load i32, i32* %i, align 4
  %idxprom80 = sext i32 %15 to i64
  %arrayidx81 = getelementptr inbounds [2 x [2 x [2 x [2 x i32]]]], [2 x [2 x [2 x [2 x i32]]]]* %mat, i64 0, i64 %idxprom80
  %arrayidx82 = getelementptr inbounds [2 x [2 x [2 x i32]]], [2 x [2 x [2 x i32]]]* %arrayidx81, i64 0, i64 %idxprom79
  %arraydecay83 = getelementptr inbounds [2 x [2 x i32]], [2 x [2 x i32]]* %arrayidx82, i32 0, i32 0
  %16 = bitcast [2 x i32]* %arraydecay83 to i32**
  %call84 = call i32** @MM(i32** %12, i32** %16, i32 1, i32 2, i32 2, i32 2)
  store i32** %call84, i32*** %interMat, align 8
  br label %for.inc

for.inc:                                          ; preds = %for.body
  %17 = load i32, i32* %i, align 4
  %inc = add nsw i32 %17, 1
  store i32 %inc, i32* %i, align 4
  br label %for.cond

for.end:                                          ; preds = %for.cond
  %18 = load i32, i32* %retval, align 4
  ret i32 %18
}

; Function Attrs: argmemonly nounwind
declare void @llvm.memcpy.p0i8.p0i8.i64(i8* nocapture writeonly, i8* nocapture readonly, i64, i32, i1) #3

attributes #0 = { nounwind uwtable "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind }
attributes #2 = { "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #3 = { argmemonly nounwind }

!llvm.ident = !{!0}

!0 = !{!"clang version 3.9.0 (tags/RELEASE_390/final)"}
