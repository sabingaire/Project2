
.data
#Updating the .data part where it includes the various output statements
  Input_isLong: .asciiz "Invalid input"
  emptyInput: .asciiz "Input is empty."
  Input_isInvalid: .asciiz "Invalid input."
  input_message: .asciiz "Choose a string: "

#Creating the space for user to input 1000 characters
  Maximum_store: .space 1000
# Storing the first four non-space characters.
#If the input has less than 4 characters, then the value would not be Invalid
  Valid_store: .space 4

.text

main:

    li $v0, 4 						    #Make it ready to print the instruction to console
    la $a0, input_message     #This will allow the "Choose a string method to print"
    syscall

#User will input their string
    li $v0, 8
    la $a0, Maximum_store
    li $a1, 2000
    syscall

    la $a1, Maximum_store
        li $t0, 0     #Here t0 acts to check the validity of the input. It remains zero until its invalid and
                      #It changes to 1 when the input is valid
four_characters:
    lb $a0,($a1)                    # load the first byte the first time the loop executes and subsequent bytes after that
    addi $a1, $a1, 1                # add 1 to the memory to loop again

    beq $a0, 0, loop1_exit_check     #As ascii value of Null is 0, so checking if the input is valid or not

    beq $a0, 10, loop1_exit_check      #checking if the input character is newline. the ascii value of the newline is 10

    beq $a0, 32, four_characters
#checking if the input character is a spacebar, i.e ' '. the ascii value of the space is 32

    beq $t0, 1, Input_isLonglabel
# if the input charcter is not space,newline or null, then it is either a valid charcter or invalid character. Regardless, this is the first character we analyse.
#Then we take that and the next three characters after it in a row and also set the value of t0  to 1.
# If we find another non-space character after that then the input is too long.

    li $t0, 1
# Setting the  value to 1 as before

# Storing the characters as we had mentioned above
    la $t9, Valid_store
    lb $a0, -1($a1)
    sb $a0, 0($t9)

    lb $a0, 0($a1)
    sb $a0, 1($t9)
    addi $a1, $a1, 1    #adding 1 to the address as we take additional characters


    lb $a0, 0($a1)
     sb $a0, 2($t9)
     addi $a1, $a1, 1    #adding 1 to the address as we take additional characters

     lb $a0, 0($a1)
 #After this four characters are stored

 sb $a0, 3($t9)

 addi $a1, $a1, 1     #adding 1 to the address as we take additional characters
 j four_characters

 loop1_exit_check:
 beq $t0, 0, emptyInputlabel         #If null characters then it is empty

 # Initialysing registers that holds the register
     li $t8, 0
     li $t1, 1
     li $t2, 0

 la $t9, Valid_store +4

 loop_findvalue:
     beq $t2, 4, check_if_loop_continues        #this checks if we have gone through all the values. It ends the loop
     addi $t2, $t2, 1                    # incresing value of the loop count as we loop through the string from behind

     addi $t9, $t9, -1                   #increasing the value of the address by 1.In the next loop we look at the 2nd last, then 2nd and 1st chracter
     lb $t3, ($t9)                # loading the value of the byte to $t3
     beq $t3, 10, loop_findvalue      # check if the character is a new line. We will ignore it if it is

     beq $t3, 32, check_forspace        # check if the character is a space. We will ignore it if it is

     beq $t3, 0, loop_findvalue        # check if the character is a null. We will ignore it if it is

     li $a3, 1                # initializing the value as we reach the last valid character


 #For numbers
     slti $t4, $t3, 58                     #anything below 58 is either a number or invalid
     li $t5, 47

     slt $t5, $t5, $t3
     and $t5, $t5, $t4
     addi $t0, $t3, -48            # t0 stores the actual value of the number
     beq $t5, 1, findvalue

#For Capital letters
   slti $t4, $t3, 85             #anything below 95 are capital letters or invalid
   li $t5, 64
   slt $t5, $t5, $t3
   and $t5, $t5, $t4
   addi $t0, $t3, -55

   beq $t5, 1, findvalue

#For small letters
   slti $t4, $t3, 117         #anything below 95 are capital letters or invalid
   li $t5, 96
   slt $t5, $t5, $t3
   and $t5, $t5, $t4

   addi $t0, $t3, -87
   bne $t5, 1, Input_isInvalidlabel
   j findvalue

#Handles long string printing invalid string
Input_isLonglabel:
       li $v0, 4
       la $a0, Input_isLong
       syscall
       j exit

#handles empty  string

emptyInputlabel:
    li $v0, 4
    la $a0, emptyInput
    syscall
    j exit

#Handles invalid: string
Input_isInvalidlabel:
    li $v0, 4
    la $a0, Input_isInvalid
    syscall
    j exit

#Space is not valid between characters
check_forspace:
    beq $a3, 1, Input_isInvalidlabel
    j loop_findvalue            #
