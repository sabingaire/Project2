
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
