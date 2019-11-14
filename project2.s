
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
