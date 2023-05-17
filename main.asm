#MAKE SURE TO COMPILE THIS FILE AND HAVE ASSEMBLE ALL FILE IN DIRECTORY ENABLED

#Akshay Nagarajan
#Thejaswin Kumaran
#Vaishnavi Pasumarthi
#Rohan Sanyal

#CS 2340-501
#Nhut Nguyen
#Dots and Boxes Project
.data
IntroMessage: .asciiz	"Welcome to Dots and Boxes!\n\nHow to play: \nDraw lines between dots by giving the coordinates of both the dots.\nPlease make sure the line is not diagonal or illegal, an error message will be prompted.\nWhomever creates the most boxes, wins.\n\n Good Luck Beating the AI!\n\nMode: Player vs Computer\n"


.text

.globl exit
main:
   
   # OP music
    li $v0, 31
    li $a0, 55
    li $a1, 1750
    li $a2, 75
    li $a3, 100
    syscall    

    li $v0, 32
    li $a0, 1000
    syscall
            
    li $v0, 31
    li $a0, 60
    li $a1, 1500
    li $a2, 75
    li $a3, 75
    syscall
        
    li $v0, 32
    li $a0, 750
    syscall
            
    li $v0, 31
    li $a0, 65
    li $a1, 1000
    li $a2, 75
    li $a3, 75
    syscall
    
   # Print Intro Message 
   li $v0, 4
   la $a0, IntroMessage
   syscall
   li $s3, 100
   
   # initialized the board
   jal generate   
   jal validateBox
   
   # game loop
   loop:
   	jal player_input
   	beq $v0, $0, exit
	jal AIstuff
      	sub $s3,$s3,1
     
     	beqz $s3, exit
      	j loop
  	jal generate
      
exit:
   li $v0, 10
   syscall
