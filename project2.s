
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
