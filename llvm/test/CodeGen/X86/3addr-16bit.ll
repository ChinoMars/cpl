; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc < %s -mtriple=x86_64-apple-darwin | FileCheck %s -check-prefix=X64
; RUN: llc < %s -mtriple=i686-apple-darwin   | FileCheck %s -check-prefix=X32

; rdar://7329206

; In 32-bit the partial register stall would degrade performance.

define zeroext i16 @test1(i16 zeroext %c, i16 zeroext %k) nounwind ssp {
; X64-LABEL: test1:
; X64:       ## %bb.0: ## %entry
; X64-NEXT:    movl %esi, %eax
; X64-NEXT:    incl %eax
; X64-NEXT:    cmpw %di, %si
; X64-NEXT:    je LBB0_1
; X64-NEXT:  ## %bb.2: ## %bb1
; X64-NEXT:    movzwl %ax, %eax
; X64-NEXT:    retq
; X64-NEXT:  LBB0_1: ## %bb
; X64-NEXT:    pushq %rbx
; X64-NEXT:    movzwl %ax, %ebx
; X64-NEXT:    movl %ebx, %edi
; X64-NEXT:    callq _foo
; X64-NEXT:    movl %ebx, %eax
; X64-NEXT:    popq %rbx
; X64-NEXT:    retq
;
; X32-LABEL: test1:
; X32:       ## %bb.0: ## %entry
; X32-NEXT:    pushl %esi
; X32-NEXT:    subl $8, %esp
; X32-NEXT:    movl {{[0-9]+}}(%esp), %ecx
; X32-NEXT:    movl %ecx, %eax
; X32-NEXT:    incl %eax
; X32-NEXT:    cmpw {{[0-9]+}}(%esp), %cx
; X32-NEXT:    je LBB0_1
; X32-NEXT:  ## %bb.2: ## %bb1
; X32-NEXT:    movzwl %ax, %eax
; X32-NEXT:    jmp LBB0_3
; X32-NEXT:  LBB0_1: ## %bb
; X32-NEXT:    movzwl %ax, %esi
; X32-NEXT:    movl %esi, (%esp)
; X32-NEXT:    calll _foo
; X32-NEXT:    movl %esi, %eax
; X32-NEXT:  LBB0_3: ## %bb1
; X32-NEXT:    addl $8, %esp
; X32-NEXT:    popl %esi
; X32-NEXT:    retl
entry:
  %0 = icmp eq i16 %k, %c
  %1 = add i16 %k, 1
  br i1 %0, label %bb, label %bb1

bb:
  tail call void @foo(i16 zeroext %1) nounwind
  ret i16 %1

bb1:
  ret i16 %1
}

define zeroext i16 @test2(i16 zeroext %c, i16 zeroext %k) nounwind ssp {
; X64-LABEL: test2:
; X64:       ## %bb.0: ## %entry
; X64-NEXT:    movl %esi, %eax
; X64-NEXT:    decl %eax
; X64-NEXT:    cmpw %di, %si
; X64-NEXT:    je LBB1_1
; X64-NEXT:  ## %bb.2: ## %bb1
; X64-NEXT:    movzwl %ax, %eax
; X64-NEXT:    retq
; X64-NEXT:  LBB1_1: ## %bb
; X64-NEXT:    pushq %rbx
; X64-NEXT:    movzwl %ax, %ebx
; X64-NEXT:    movl %ebx, %edi
; X64-NEXT:    callq _foo
; X64-NEXT:    movl %ebx, %eax
; X64-NEXT:    popq %rbx
; X64-NEXT:    retq
;
; X32-LABEL: test2:
; X32:       ## %bb.0: ## %entry
; X32-NEXT:    pushl %esi
; X32-NEXT:    subl $8, %esp
; X32-NEXT:    movl {{[0-9]+}}(%esp), %ecx
; X32-NEXT:    movl %ecx, %eax
; X32-NEXT:    decl %eax
; X32-NEXT:    cmpw {{[0-9]+}}(%esp), %cx
; X32-NEXT:    je LBB1_1
; X32-NEXT:  ## %bb.2: ## %bb1
; X32-NEXT:    movzwl %ax, %eax
; X32-NEXT:    jmp LBB1_3
; X32-NEXT:  LBB1_1: ## %bb
; X32-NEXT:    movzwl %ax, %esi
; X32-NEXT:    movl %esi, (%esp)
; X32-NEXT:    calll _foo
; X32-NEXT:    movl %esi, %eax
; X32-NEXT:  LBB1_3: ## %bb1
; X32-NEXT:    addl $8, %esp
; X32-NEXT:    popl %esi
; X32-NEXT:    retl
entry:
  %0 = icmp eq i16 %k, %c
  %1 = add i16 %k, -1
  br i1 %0, label %bb, label %bb1

bb:
  tail call void @foo(i16 zeroext %1) nounwind
  ret i16 %1

bb1:
  ret i16 %1
}

declare void @foo(i16 zeroext)

define zeroext i16 @test3(i16 zeroext %c, i16 zeroext %k) nounwind ssp {
; X64-LABEL: test3:
; X64:       ## %bb.0: ## %entry
; X64-NEXT:    movl %esi, %eax
; X64-NEXT:    addl $2, %eax
; X64-NEXT:    cmpw %di, %si
; X64-NEXT:    je LBB2_1
; X64-NEXT:  ## %bb.2: ## %bb1
; X64-NEXT:    movzwl %ax, %eax
; X64-NEXT:    retq
; X64-NEXT:  LBB2_1: ## %bb
; X64-NEXT:    pushq %rbx
; X64-NEXT:    movzwl %ax, %ebx
; X64-NEXT:    movl %ebx, %edi
; X64-NEXT:    callq _foo
; X64-NEXT:    movl %ebx, %eax
; X64-NEXT:    popq %rbx
; X64-NEXT:    retq
;
; X32-LABEL: test3:
; X32:       ## %bb.0: ## %entry
; X32-NEXT:    pushl %esi
; X32-NEXT:    subl $8, %esp
; X32-NEXT:    movl {{[0-9]+}}(%esp), %ecx
; X32-NEXT:    movl %ecx, %eax
; X32-NEXT:    addl $2, %eax
; X32-NEXT:    cmpw {{[0-9]+}}(%esp), %cx
; X32-NEXT:    je LBB2_1
; X32-NEXT:  ## %bb.2: ## %bb1
; X32-NEXT:    movzwl %ax, %eax
; X32-NEXT:    jmp LBB2_3
; X32-NEXT:  LBB2_1: ## %bb
; X32-NEXT:    movzwl %ax, %esi
; X32-NEXT:    movl %esi, (%esp)
; X32-NEXT:    calll _foo
; X32-NEXT:    movl %esi, %eax
; X32-NEXT:  LBB2_3: ## %bb1
; X32-NEXT:    addl $8, %esp
; X32-NEXT:    popl %esi
; X32-NEXT:    retl
entry:
  %0 = add i16 %k, 2
  %1 = icmp eq i16 %k, %c
  br i1 %1, label %bb, label %bb1

bb:
  tail call void @foo(i16 zeroext %0) nounwind
  ret i16 %0

bb1:
  ret i16 %0
}

define zeroext i16 @test4(i16 zeroext %c, i16 zeroext %k) nounwind ssp {
; X64-LABEL: test4:
; X64:       ## %bb.0: ## %entry
; X64-NEXT:    movl %esi, %eax
; X64-NEXT:    addl %edi, %eax
; X64-NEXT:    cmpw %di, %si
; X64-NEXT:    je LBB3_1
; X64-NEXT:  ## %bb.2: ## %bb1
; X64-NEXT:    movzwl %ax, %eax
; X64-NEXT:    retq
; X64-NEXT:  LBB3_1: ## %bb
; X64-NEXT:    pushq %rbx
; X64-NEXT:    movzwl %ax, %ebx
; X64-NEXT:    movl %ebx, %edi
; X64-NEXT:    callq _foo
; X64-NEXT:    movl %ebx, %eax
; X64-NEXT:    popq %rbx
; X64-NEXT:    retq
;
; X32-LABEL: test4:
; X32:       ## %bb.0: ## %entry
; X32-NEXT:    pushl %esi
; X32-NEXT:    subl $8, %esp
; X32-NEXT:    movl {{[0-9]+}}(%esp), %ecx
; X32-NEXT:    movl {{[0-9]+}}(%esp), %edx
; X32-NEXT:    movl %edx, %eax
; X32-NEXT:    addl %ecx, %eax
; X32-NEXT:    cmpw %cx, %dx
; X32-NEXT:    je LBB3_1
; X32-NEXT:  ## %bb.2: ## %bb1
; X32-NEXT:    movzwl %ax, %eax
; X32-NEXT:    jmp LBB3_3
; X32-NEXT:  LBB3_1: ## %bb
; X32-NEXT:    movzwl %ax, %esi
; X32-NEXT:    movl %esi, (%esp)
; X32-NEXT:    calll _foo
; X32-NEXT:    movl %esi, %eax
; X32-NEXT:  LBB3_3: ## %bb1
; X32-NEXT:    addl $8, %esp
; X32-NEXT:    popl %esi
; X32-NEXT:    retl
entry:
  %0 = add i16 %k, %c
  %1 = icmp eq i16 %k, %c
  br i1 %1, label %bb, label %bb1

bb:
  tail call void @foo(i16 zeroext %0) nounwind
  ret i16 %0

bb1:
  ret i16 %0
}

