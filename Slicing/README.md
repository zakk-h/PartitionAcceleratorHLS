# AI in ICs

## Project Purpose and Overview

The purpose of this project is to design an FPGA implementation of a particle fragment path reconstruction algorithm that improves upon current latency by orders of magnitude. This improvement will aid researchers in looking for Dark Matter.

This Git repository contains the implementation of the algorithm found in [A fast method for particle tracking and triggering using small-radius silicon detectors](http://webhome.phy.duke.edu/~kotwal/trackTrigger.pdf) for FPGAs.

## Version Control Scheme 
1. Each feature will have its own folder in the repo. This means all code associated with a particular feature will be placed in that folder. Feature level folders will be the situated directly in the repo (will have no enclosing folders). Only relevant code should be placed in the repo. Everything else can go in the Wiki.
2. When you are working on a feature on your own device, create a branch specifically for that feature instead of working in master. This means that if you are working on two or more features, each feature should have its own branch. All branches should be named after the feature being implemented. 
3. Push your branch to the remote when you complete important milestones in feature development. However, don't ask for a merge request until your feature is complete. 
4. When your feature is complete, create a merge request. For your merge request to be approved, it must meet the Code Standard specified below. When you are building features, only use code that is in master (i.e. don't start building on top of people's uncompleted branches). 
5. To find out who is working on a particular feature, navigate to Issues --> Doing. To find out what to work on next, look at the To-Do column under Issues. If you find an issue in the code, create an Issue; and if you have an idea for a feature, add a To-Do. When you start working on a feature in To-Do, claim it to move it to the Doing column. Be detailed with your descriptions.

## Code standard
1. Above each function:  
    a. Create a multi-line comment beginning with a sentence or two explaining the purpose of the function and the action it performs.

    b. Under the general statement, briefly explain the purpose of the function parameters and any relevant facts, features, or actions they perform. 

    c. Give a short explanation of the return values (facts, features, relevant actions) and any relevant errors or special values. 
2. Every variable name should be expressive (meaning it should properly describe what the variable is or the purpos it serves). E.g. if we have a variable to which we assign the name of a person, the variable name 'x' is worse than 'n' which is worse than 'name'. Properly naming variables makes code much easier to read.
3. There should be no numbers hard-coded (magic numbers). All numbers should be assigned to named constant (for ease of understanding).
4. All lines of code that are a) particularly important or b) not intuitively obvious should be rigorously inline commented with a brief explanation of their purpose, e.g. explain why you chose a particular bit width, what each for loop in a nested for loop does, etc.




