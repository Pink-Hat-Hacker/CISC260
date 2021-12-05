 # @ read integers from a file and insert them into a max-heap to get sorted
 # @ and print the sorted integers to the screen (stdout).

.align 4
.text
main:
	#@ open an input file to read integers
	ldr r0, =InFileName
	mov r1, #0
	swi 0x66		@ open file
	ldr r1, =InFileHandle
	str r0, [r1, #0]

	#@ Read the first integer from the file
	ldr r1, =InFileHandle
	ldr r0, [r1]
	swi 0x6c	#@ read an integer put in r0

	# @ To-Do: Here you should create a base node containing the just-read integer for your MaxHeap
	# @ and save the base node address to the label MyHeap (which is declared in .data) for later references	
################## MAKE BASE/ROOT NODE ######################
	mov r1, r0
	mov r0, #12
	swi 0x12
	ldr r1, =MyHeap #@ r1 <- address of MyHeap
	str r0, [r1] #@ r0 <- MyHeap

	mov r2, #0
	str r2, [r0, #4] #@left child
	str r2, [r0, #8] #@right child



Loop:
	#@ read integer from file
	ldr r1, =InFileHandle
	ldr r0, [r1]
	swi 0x6c	#@ read an integer put in r0
	BCS CloseF	#@ branch when the end of the file is reached

	#@print the integer that's just read 
	mov r1, r0	#@ copy r0 to r1 for printing
	MOV r0, #1	#@ Load 1 into register r0 (stdout handle) 
	SWI 0x6b	#@ Print integer in register r1 to stdout
	#@ print a space
	mov r0, #1
	ldr  r1,  =Space
	swi  0x69

	# @ TO-DO: You should comment out the above code for printing
	# @ Instead, you create a new node and save the integer into the first 4 bytes of the node
	# @ Put the base node address in r0, and the address of the to-be-inserted node in r1
	# @ call the subroutine Insert to insert the newly created node into the MaxHeap

    BL Insert
	
	B Loop			#@ go back to read next integer

CloseF:
	#@close infile
	ldr r0, =InFileHandle
	ldr r0, [r0]
	swi 0x68

	ldr r0, =MyHeap		#@ r0 is a pointer to the pointer to the heap
	BL PrintHeapSorted  
	
exit:	
	SWI 0x11		#@ Stop program execution 

# @ TO-DO: write the Insert function below
# @ The function takes two arguments: a pointer to the heap (in r0) and a pointer to a new node to be inserted to the heap (in r1) 
# @ The function returns (in r0) a pointer to the root node (potentially can be the new node) of the heap
Insert:
	#@ r3 = current nodde
	#@ r4 = insertion node
	ldr r3, [r0]

	#@new temp node
	ldr r4, [r1]

	#@compare if insertion node is > than current node
	cmp r4, r3
	bge ifroot #@ branch if r4 is greater than r3/ root node check

	bl else

	else:
		and r6, [r3, #4], [r3, #8]
		cmp r6, #1 #@ if both null (true) branch
		be nochild

		or r6, [r3, #4], [r3, #8]
		cmp r6, #1 #@ if one or the other is null (true) branch
		be onechild

		mov r5, [r3, #4]
		mov [r3, #4], r3
		mov [r4, #4], r5

	mov pc, r14


onechild:
	cmp [r3, #4], 0x00
	be leftC
	
	cmp [r3, #8], 0x00
	be rightC

		leftC:
			mov r4, [r3, #4]
		rightC:
			mov r4, [r3, #8]


nochild:
	mov r4, [r3, #4]


ifroot:
	mov r5, #0
	str r3, [r4, #4] #@left -- storing root at left child of insertion
	str r5, [r4, #8] #@right
	

# @ TO_DO: write deleteMax function below
# @ call-by-reference: the function takes a pointer-to-pointer as argument (in r0)
# @ when the heap contains only one node (i.e., the root node), 
# @ deleteMax should return root.data (to r0) and nullify the pointer to the root node
deleteMax:
	ldr r1, =MyHeap
	ldr r1, [r1]
	ldr r2, [r1, #0] 
	ldr r9, [r1, #0] 
	ldr r3, [r1, #4] 
	ldr r4, [r1, #8] 

	cmp r3, #0 
	bne deleteNode  
	cmp r4, #0
	bne deleteNode

	mov r0, r9 
	mov r2, #0 

	ldr r1, =MyHeap
	str r2, [r1]
	ldr r1, =MyHeap
	mov pc, lr

	deleteNode:
		ldr r2, [r1, #0]
		ldr r3, [r1, #4]
		ldr r4, [r1, #8]

		cmp r3, #0 #@ cmp 0 the r3
		beq deleteRight
		cmp r4, #0 #@ cmp 0 to r4
		beq deleteLeft

		ldr r5, [r3, #0]
		ldr r6, [r4, #0]
		cmp r5, r6 #@ cmp the value in r6 to r5
		bge deleteLeft
		blt deleteRight

	deleteLeft:
		ldr r5, [r3, #0]
		ldr r6, [r4, #0]
		str r5, [r1, #0] #@r5 is the current node

		ldr r8, [r3, #4] 
		cmp r8, #0 
		movgt r1, r3 
		bgt deleteNode 

		ldr r8, [r3, #8]
		cmp r8, #0
		movgt r1, r3
		bgt deleteNode

		mov r8, #0
		str r8, [r1, #4]

		mov r0, r9
		mov pc, lr

	deleteRight:
		ldr r5, [r3, #0]
		ldr r6, [r4, #0]
		str r6, [r1, #0]

		ldr r8, [r4, #4]
		cmp r8, #0
		movgt r1, r4
		bgt deleteRight

		ldr r8, [r4, #8]
		cmp r8, #0
		movgt r1, r4
		bgt deleteNode

		mov r8, #0
		str r8, [r1, #8]

		mov r0, r9
		mov pc, lr

	mov pc, r14

# @ This subroutine prints numbers from MaxHeap sorted (in descending order)
# @ it takes a pointer-to-pointer to the heap as argument (in r0)

PrintHeapSorted:
	sub sp, sp, #8
	str r14, [sp]
	str r0, [sp, #4]	#@ save the argument, which is a pointer to the pointer of the heap
L3:	
	bl deleteMax

	mov r1, r0		#@ copy r0 to r1 for printing
	MOV r0, #1		#@ Load 1 into register r0 (stdout handle) 
	SWI 0x6b		#@ Print integer in register r1 to stdout

	#@ print a space
	mov r0, #1
	ldr  r1,  =Space
	swi  0x69

	ldr r0, [sp, #4]	#@ retrieve the saved argument for next iteraction

	#@ check if the heap has become empty after the last call to deleteMax
	ldr r1, [r0]		
	cmp r1, #0
	beq L4			#@ terminate if empty
	
	b L3

L4:	ldr r14, [sp]
	add sp, sp, #8
	mov pc, r14		


.data
MyHeap: .word 0
InFileName: .ascii "list.txt"  
InFileHandle: .word 0
Space: .ascii " "
