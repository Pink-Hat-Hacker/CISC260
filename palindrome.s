	.section	__TEXT,__text,regular,pure_instructions
	.build_version macos, 11, 0	sdk_version 11, 3
	.globl	_isPalindrome                   ## -- Begin function isPalindrome
	.p2align	4, 0x90
_isPalindrome:                          ## @isPalindrome
	.cfi_startproc
## %bb.0:
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register %rbp
	subq	$16, %rsp
	movq	%rdi, -8(%rbp)
	movl	$0, -12(%rbp)
	movq	-8(%rbp), %rdi
	callq	_strlen
	subq	$1, %rax
                                        ## kill: def $eax killed $eax killed $rax
	movl	%eax, -16(%rbp)
LBB0_1:                                 ## =>This Inner Loop Header: Depth=1
	cmpl	$1, -16(%rbp)
	jle	LBB0_5
## %bb.2:                               ##   in Loop: Header=BB0_1 Depth=1
	movq	-8(%rbp), %rax
	movl	-12(%rbp), %ecx
	movl	%ecx, %edx
	addl	$1, %edx
	movl	%edx, -12(%rbp)
	movslq	%ecx, %rsi
	movsbl	(%rax,%rsi), %ecx
	movq	-8(%rbp), %rax
	movl	-16(%rbp), %edx
	movl	%edx, %edi
	addl	$-1, %edi
	movl	%edi, -16(%rbp)
	movslq	%edx, %rsi
	movsbl	(%rax,%rsi), %edx
	cmpl	%edx, %ecx
	je	LBB0_4
## %bb.3:
	leaq	L_.str(%rip), %rdi
	movb	$0, %al
	callq	_printf
	jmp	LBB0_6
LBB0_4:                                 ##   in Loop: Header=BB0_1 Depth=1
	jmp	LBB0_1
LBB0_5:
	leaq	L_.str.1(%rip), %rdi
	movb	$0, %al
	callq	_printf
LBB0_6:
	addq	$16, %rsp
	popq	%rbp
	retq
	.cfi_endproc
                                        ## -- End function
	.section	__TEXT,__cstring,cstring_literals
L_.str:                                 ## @.str
	.asciz	"Not  palindrome"

L_.str.1:                               ## @.str.1
	.asciz	"Palindrome"

.subsections_via_symbols
