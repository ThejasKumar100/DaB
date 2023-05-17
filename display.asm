#Akshay Nagarajan
#Thejaswin Kumaran
#Vaishnavi Pasumarthi
#Rohan Sanyal

#CS 2340-501
#Nhut Nguyen
#Dots and Boxes Project
.data

		
rowLabel:	.byte 'A', 'B', 'C', 'D', 'E', 'F', 'G'	# row
colLabel: 	.byte 1, 2, 3, 4, 5, 6, 7, 8, 9		# column
rowSize:	.word 13
colSize:	.word 17
newLine:	.byte '\n'
space:		.byte ' '
dash:		.byte '-'
pipe:		.byte '|'
dots:		.byte '+'
player: 	.asciiz "P"				
AI:		.asciiz	"C"				
connection:	.space 4

	.globl generate
	.text
generate:
	move $t9, $ra		
	move $s4, $a1		
	move $s5, $a2		
	sb $a3, connection	
	jal printColLabel	
	
	lw $t0, rowSize		# Load max size of the rows of the board
	lw $t1, colSize 	# Load max size of the cols of the board
	
	li $t2, 0		# Outer loop counter
	li $t3, 0		
	li $t5, 0		# Board index pointer
	li $t6, 2		
	li $t7, 1		
	outer:	
	
	#-------------------------------------------------------------------Looping structure--------------------------------------
	
		li $t4, 0	# Inner loop counter
		validateEmptyRows:
			div $t2, $t6			
			mfhi $t8			
			bne $t7, $t8, printLabel	
			addi $t3, $t3, -1		
			jal insertSpace
			jal insertSpace
			j inner				# Continue
		
		printLabel:
			lb $a0, rowLabel($t3)		# Load the current row label in insertr
			li $v0, 11
			syscall
		
			jal insertSpace
		inner:
			beq $a3, $0, printNormal
			bne $s4, $t2, printNormal	# Else consider the index that matches
			bne $s5, $t4, printNormal
			lb $a0, connection		# And print out the connection
			sb $a0, board($t5)		# And store the character in the board
			li $v0, 11
			syscall
			j increment
			printNormal:			# Print out the current board index
			lb $a0, board($t5)
			li $v0, 11
			syscall
			increment:
			addi $t4, $t4, 1		# Increment inner loop counter
			addi $t5, $t5, 1		# Increment board ptr
			
			blt  $t4, $t1, inner		
		endInner:
			addi $t2, $t2, 1		
			addi $t3, $t3, 1		
			jal insertNewLine
			blt $t2, $t0, outer		
	endOuter:
		jal insertNewLine			
		move $ra, $t9				
		jr $ra
		


insertSpace:						
	lb $a0, space($0)
	li $v0, 11
	syscall
	jr $ra

insertNewLine:						
	lb $a0, newLine($0)
	li $v0, 11
	syscall
	jr $ra
	
printColLabel:						
	sw $ra, ($sp)					
	jal insertSpace
	jal insertSpace
	lw $s0, colSize					
	li $t0, 0					
	li $t1, 1					
	loop:
		lb $a0, colLabel($t0)			
		li $v0, 1
		syscall
		
		jal insertSpace
		
		addi $t0, $t0, 1			
		addi $t1, $t1, 2			
		ble $t1, $s0, loop			
		jal insertNewLine
		lw $ra, ($sp)				
		jr $ra
