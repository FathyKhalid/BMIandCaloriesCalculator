.data
  Welcome_msg: .asciiz "=================================\n    Welcome To BMI Calculator \n================================="
  End_loop: .asciiz     "\n\n================================="
  End_Program: .asciiz     "\n Stay Healthy and Happy Goodbye! :)\n"
  menu: .asciiz "\n\n 1.New BMI Calculation \n 2.Calculate Calories\n 3.End The Program\n"
  prompt_Choice: .asciiz " Enter your Choice (1 - 3): "
  prompt_height: .asciiz "\n Enter your height (in cm): "
  prompt_weight: .asciiz " Enter your weight (in kg): "
  result_msg: .asciiz " -> Your BMI is: "
  message_one: .asciiz " -> You're Underweight"
  message_two: .asciiz " -> You're in Shape (Normal Weight)"
  message_three: .asciiz "-> You're OverWeight"
  message_four: .asciiz " -> You're Obese"
  error: .asciiz "\n Invalid Choice! :( "
  
  #calculate Calories Constants and data
  prompt_age: .asciiz " Enter your age: "
  calories_word: .asciiz "\n -> Your Maintain Calories is "
  weight_loss: .asciiz "\n -> Your Weight Loss Calories is "
  weight_gain: .asciiz "\n -> Your Weight Gain Calories is "
  bmr_constant_1: .float 10            
  bmr_constant_2: .float 7.45        
  bmr_constant_3: .float 5           
  float_450: .float 450.0 
  newline: .asciiz "\n"
  hundred: .float 100.0
  exit_value: .word 3

.text
  main:
    #Print the Welcone Message
    li $v0, 4
    la $a0, Welcome_msg
    syscall
    
    loop:
    #Print The menu
    li $v0, 4
    la $a0, menu
    syscall
    
    # Prompt user for Choice
    li $v0, 4
    la $a0, prompt_Choice
    syscall
    
    # Read in Choice
    li $v0, 5
    syscall
    move $t0, $v0
    
    # Switch Choice
    li $t1, 1
    li $t2, 2
    lw $t3, exit_value
    beq $t0, $t1, calc_bmi
    beq $t0, $t2, calc_calories
    beq $t0, $t3, exitP
    li $v0, 4
    la $a0, error
    syscall
    la $a0, End_loop
    li $v0, 4
    syscall
    j loop
    
    calc_bmi:
    # Prompt user for height
    li $v0, 4
    la $a0, prompt_height
    syscall

    # Read in height
    li $v0, 6     
    syscall
    mov.s $f1, $f0

    # Prompt user for weight
    li $v0, 4
    la $a0, prompt_weight
    syscall

    # Read in weight
    li $v0, 6      
    syscall
    mov.s $f2, $f0 
    
    # Print newline
    li $v0, 4
    la $a0, newline
    syscall

    # Calculate BMI
    l.s $f12, hundred
    div.s $f0, $f1, $f12
    mul.s $f0, $f0, $f0
    div.s $f0, $f2, $f0

    # Display result
    li $v0, 4       
    la $a0, result_msg 
    syscall
    li $v0, 2      
    mov.s $f12, $f0
    syscall
    
    #print new line
    li $v0, 4
    la $a0, newline
    syscall
    
    # Chech BMI status
    cvt.w.s $f0, $f12
    mfc1 $t0, $f0
    
    # Compare $t0 to 18
    li $t1, 18        
    blt $t0, $t1, less_than_18  

    # Compare $t0 to 25
    li $t1, 25        
    blt $t0, $t1, between_18_and_25  

    # Compare $t0 to 30
    li $t1, 30        
    blt $t0, $t1, between_25_and_30  
    bge $t0, $t1, greater_than_30    

    less_than_18:
    # print message_one
    la $a0, message_one
    li $v0, 4
    syscall
    la $a0, End_loop
    li $v0, 4
    syscall
    j skip

    between_18_and_25:
    # print message_two
    la $a0, message_two
    li $v0, 4
    syscall
    la $a0, End_loop
    li $v0, 4
    syscall
    j skip

    between_25_and_30:
    # print message_three
    la $a0, message_three
    li $v0, 4
    syscall
    la $a0, End_loop
    li $v0, 4
    syscall
    j skip

    greater_than_30:
    # print message_four
    la $a0, message_four
    li $v0, 4
    syscall
    la $a0, End_loop
    li $v0, 4
    syscall
    j skip
    
    # Print newline
    li $v0, 4
    la $a0, End_loop
    syscall
    skip:
    j loop
    
    
    calc_calories:
    # calculate the number of calories needed per day
    # Prompt user for height
    li $v0, 4
    la $a0, prompt_height
    syscall

    # Read in height
    li $v0, 6      
    syscall
    mov.s $f17, $f0

    # Prompt user for weight
    li $v0, 4
    la $a0, prompt_weight
    syscall

    # Read in weight
    li $v0, 6     
    syscall
    mov.s $f2, $f0  
    
    # prompt user for age
    li $v0, 4
    la $a0, prompt_age
    syscall
    
    # Read age
    li $v0, 6      
    syscall
    mov.s $f16, $f0  
    
    # Calculate Calories
    l.s $f6, bmr_constant_1
    mul.s $f1, $f2, $f6
    l.s $f6, bmr_constant_2
    mul.s $f3, $f17, $f6
    add.s $f1,$f1,$f3
    l.s $f6, bmr_constant_3
    mul.s $f3,$f16,$f6
    add.s $f1,$f1,$f3
    add.s $f1,$f1,$f6
    
    # print the number of calories needed pre day ( Maintain )
    la $a0, calories_word
    li $v0, 4
    syscall
    cvt.w.s $f0, $f1
    mfc1 $t0, $f0
    li $v0, 1         
    move $a0, $t0   
    syscall
    
    # Adding and Substracting 450 Calories                  
    addi $t1, $t0, -450  
    addi $t2, $t0, 450 
    
    # print the number of calories needed pre day ( Lose Weight )
    la $a0, weight_loss
    li $v0, 4
    syscall
    li $v0, 1          
    move $a0, $t1     
    syscall             
    
    # print the number of calories needed pre day ( Gain Weight )
     la $a0, weight_gain
    li $v0, 4
    syscall
    li $v0, 1            
    move $a0, $t2 
    syscall  
    la $a0, End_loop
    li $v0, 4
    syscall          
    
    j loop
    exitP:
    # Exit program
    la $a0, End_Program
    li $v0, 4
    syscall
    li $v0, 10
    syscall
