	.section	__TEXT,__text,regular,pure_instructions
	.build_version macos, 11, 0	sdk_version 11, 3
	.globl	_tFib                           ## -- Begin function tFib
	.p2align	4, 0x90
_tFib:                                  ## @tFib
	.cfi_startproc
## %bb.0:
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register %rbp
	subq	$16, %rsp
	movl	%edi, -8(%rbp)
	cmpl	$0, -8(%rbp)
	je	LBB0_3
## %bb.1:
	cmpl	$1, -8(%rbp)
	je	LBB0_3
## %bb.2:
	cmpl	$2, -8(%rbp)
	jne	LBB0_4
LBB0_3:
	movl	-8(%rbp), %eax
	movl	%eax, -4(%rbp)
	jmp	LBB0_5
LBB0_4:
	movl	-8(%rbp), %eax
	subl	$1, %eax
	movl	%eax, %edi
	callq	_tFib
	movl	-8(%rbp), %ecx
	subl	$2, %ecx
	movl	%ecx, %edi
	movl	%eax, -12(%rbp)                 ## 4-byte Spill
	callq	_tFib
	movl	-12(%rbp), %ecx                 ## 4-byte Reload
	addl	%eax, %ecx
	movl	-8(%rbp), %eax
	subl	$3, %eax
	movl	%eax, %edi
	movl	%ecx, -16(%rbp)                 ## 4-byte Spill
	callq	_tFib
	movl	-16(%rbp), %ecx                 ## 4-byte Reload
	addl	%eax, %ecx
	movl	%ecx, -4(%rbp)
LBB0_5:
	movl	-4(%rbp), %eax
	addq	$16, %rsp
	popq	%rbp
	retq
	.cfi_endproc
                                        ## -- End function
	.globl	_main                           ## -- Begin function main
	.p2align	4, 0x90
_main:                                  ## @main
	.cfi_startproc
## %bb.0:
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register %rbp
	subq	$16, %rsp
	movl	$0, -4(%rbp)
	movl	$5, %edi
	callq	_tFib
	xorl	%ecx, %ecx
	movl	%eax, -8(%rbp)                  ## 4-byte Spill
	movl	%ecx, %eax
	addq	$16, %rsp
	popq	%rbp
	retq
	.cfi_endproc
                                        ## -- End function
.subsections_via_symbols
