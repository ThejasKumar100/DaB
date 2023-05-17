#Akshay Nagarajan
#Thejaswin Kumaran
#Vaishnavi Pasumarthi
#Rohan Sanyal

#CS 2340-501
#Nhut Nguyen
#Dots and Boxes Project
.data
   brd: .asciiz ".", " ", "."
   	  .asciiz "|" , " " , " "
   	  .asciiz "." , "-", "."	  
   rows: .word 13
   colm: .word  17
   .eqv DATA_SIZE 8
   pipe:     .asciiz "|"
   dash:    .asciiz "-"
   emptySpace: .byte ' '

.text
.globl AIstuff


AIstuff:	
	li $t9,1 #indicate current turn is AI
   	move $s7, $ra
	la $s1, board
	lw $s5, rows
	lw $s6, colm
	li $t3, 0
	
	li $t0, 0 # current row index
	li $t1, 0 # current colm index
	
	
	readLoop:

        jal validInput
        beq $a3, $zero,move1 
	
	j incrm
	
	
     	move1:
     		
             li $t9, 1  #let other files know it is AI turn
             li $t5, 2

             div $t0,$t5       #validate if odd number to see which line is needed
             mfhi $s1
	    
	   
	     jal validateBox
	     move $t3, $a3
	     
            move $a1, $t0
           
            move $a2, $t1
            
            beqz $s1, horz #if even horz line, if odd keep going.

             vert:
 
             lb $a3, pipe
            jal generate
            j next

             horz:
             lb $a3, dash
            jal generate

            next:
          
            
            # beq $t3, 1, AIstuff
      
       
        j finish
        
	#condition increm
    	incrm:
    
    	addi $t1, $t1, 1
   	slt $t5, $t1, $s6
    	beq $t5, 0, proper
    	j readLoop
    	
    	proper:

    	addi $t0,$t0,1
    	
        slt $t5, $t0, $s5
    
        li $t1, 0 
    	beq $t5, 1, readLoop
    	
    
    	
     	finish:
	move $ra, $s7

	jr $ra

	
