# AI in ICs

## Project Purpose and Overview

@Professor Kotwal: Here we could have a brief statement of the purpose of the project and an overview of the algorithm found in [trackTrigger.pdf](http://webhome.phy.duke.edu/~kotwal/trackTrigger.pdf) I'm assuming you would want to write this part. (maybe include explanation of why we are using Vivado/Vitis, purpose on using FPGAs, etc.)

You can find an analytic and geometric representation of the algorithm on the [Wiki](https://gitlab.oit.duke.edu/test-group1/test-project/-/wikis/Global-Design/Communication-Ideas).

### Progress As of June 18th, 2021

### TODO

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

## Onboarding

### Downloading and Installation
The hardware development kit (HDK) we are using to implement the FPGA can be downloaded [here](https://www.xilinx.com/support/download/index.html/content/xilinx/en/downloadNav/vivado-design-tools/2020-2.html). Make sure to download Xilinx Unified Installer 2020.2: Windows Self Extracting Web Installer. You will have to make an account with Xilinx in order to perform this download. Use your university credentials. For each question in the installation genie, choose the options that provide access to the highest genus of content.

### License
To obtain a Xilinx license: 
1. Open Vivado and click on Help
2. Click on Obtain a License
3. Check all the boxes for services whose Subscription End Date is Never
4. Generate the license and save it to a folder you can easily access
5. Go to Help --> Manage License in Vivado
6. Copy the License that you just downloaded
7. Complete!

### Getting Started in Vitis
1. First, clone the GitLab using 
```shell
$ git clone https://gitlab.oit.duke.edu/test-group1/test-project.git
```
2. In Vitis, click File --> Open Project --> test-group1
3. Notice in the Explorer (on the left) there is a Source tab and Test Bench tab. The Source tab is where you will implement your code and Test is where you will test it.
4. Notice the Green play button in the top left. This is where you will Synthesize (or run) your code. You have to set which file to synthesize (the Top Function) by clicking on Project --> Project Settings --> Synthesis --> Browse.
5. After you Synthesize your code, you will be taken to a Synthesis Summary. Take particular notice of the Timing Estimates and Performance & Resolution Estimates.
    
    a. The number under Target is how long we would like each clock cycle to last (the default is 5 ns). Under Estimated is the time each cycle is actually taking.  
    
    b. Under Performance & Resolution, notice FF (flip flops) and LUT (look up tables). These are the two important resources we use for FPGAs. For each FPGA, there is a set amount of LUTs and FFs, and we can't use more than that amount. Latency indicates the number of cycles it took to run the Top Function (if it finishes within one cycle, Latency will be 0). Intervals is the number of iterations in the function. 
    
    c. Notice the Analysis tab in the top Right: Click on this and you're taken to the Schedule Viewer. You'll see several numbered columns starting with 0. These columns correspond to cycles. The white rectangles indicate processes executed during synthesis, and their width indicates how long they took. If two rectangles overlap vertically, this means they were executed at the same time. If you right click on a process under Operation\Control Step, you can see which part of the code the process corresponds to.

6. Note that the Test Bench tab exists for you to test your code prior to Synthesis. This is necessary because for longer scripts, Synthesis can take a while, and you don't want to synthesize a bad piece of code. When you want to run tests, click on the arrow next to Synthesis and run C Simulation.
7. IT IS IMPERATIVE to make sure you are using the correct FPGA: go to Solution --> Solution Settings --> Part Selection --> Part and choose the xcvu35p-fsvh2892-3-e. You can also change the clock cycle here under Clock --> Period. 




