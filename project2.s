
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
