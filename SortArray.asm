.data
Elements:
	.string "Enter elements: "
Length: 
	.word 10 # length = 6
Array:
	.word 0,0,0,0,0,0,0,0,0,0	
Result: 
	.string "The sorted array is "
Space:
	.string "  "	
	
.text

main:

# First we get the elements of the array
la a0, Elements
li a7, 4
ecall

la a1, Array
addi t1, a1, 40
# Input elements of the array
Input:
li a7,5
ecall
sw a0, 0(a1)
addi a1, a1, 4
bne t1, a1, Input

addi a1, a1, -40 # First element of array

addi t0, zero, 10 # Length of array

jal ra, insertSort # go into Insertion Sort

la a0, Result # Ouput Result message
li a7, 4
ecall

la a1, Array
addi t1, a1, 40
Out:
lw a0, 0(a1)
li a7, 1
ecall
la a0, Space
li a7, 4
ecall

addi a1, a1, 4
bne t1, a1, Out


# Exit program
li a7, 10
ecall
	
insertSort:
# length in t0
# array in a1

mv t3, t0 # t3 is length
addi t0, x0, 1 # i = 1

Loop:
slli t6, t0, 2
add t6, t6, a1
lw t1, 0(t6) # get value =  a[i]

addi t4, t0, -1 # j = i-1
Inner:
blt t4, zero, Skip # leave loop if j < 0

slli a2, t4, 2 # j*4 to get memory address
add a2, a1, a2 # a[j]
lw t2, 0(a2) # get a[j]

bge t1, t2, Skip # leave loop if a[j] <= value

sw t2, 4(a2) # a[j+1] = a[j]

addi t4, t4, -1 # j--
beq zero, zero, Inner # unconditional jump

Skip:
sw t1, 4(a2) # a[j+1] = value

# addi t6, t6, 4
addi t0, t0, 1
blt t0, t3, Loop
jr ra
