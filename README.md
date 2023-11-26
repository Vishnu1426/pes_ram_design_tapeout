# DUAL PORT RAM - TAPEOUT

## Using caravel_user_project template to start your project
<details>
  <summary>Creating a Repo and cloning it to your local system</summary>
  
+ First go to this link to [`caravel_user_project`](https://github.com/efabless/caravel_user_project) and create a repository using the template.
+ Copy your newly created github repository link from the `<> Code` menu in github.

![image](https://github.com/Vishnu1426/pes_ram_design_tapeout/assets/79538653/0e9494c8-6c6f-4271-80ef-ec02c010415e)

+ Then go to your terminal and open root user by typing `sudo su`. Type your password and your will be in root.
+ Type the following code and change the `<your repo link>` with your repository link that you copied and press `Enter`.
```
git clone <your repo link>
```

![image](https://github.com/Vishnu1426/pes_ram_design_tapeout/assets/79538653/7eb5fb81-1d01-427f-b8da-ab4f3d549a51)

+ Now, create a directory named `dependencies` where all your dependencies will be present. You will have to manually export the variables to point to this `dependencies` directory.
+ Replace `<your_repo_name>` with the name of your repository that you cloned.
```Mint
mkdir dependencies
export OPENLANE_ROOT=$(pwd)/dependencies/openlane_src
export PDK_ROOT=$(pwd)/dependencies/pdks
cd <your_repo_name>
make setup
```
+ Now your repository cloning is complete.
</details>

<details>
  <summary>Running a sample project</summary>

+ To check if everything is working fine we can run an example project which comes with the template.
+ To do this type the following after going into the directory of your cloned repository.
```
make user_proj_example
```
+ It takes some time and starts like this:

![image](https://github.com/Vishnu1426/pes_ram_design_tapeout/assets/79538653/cb8ef924-7126-4c3f-830d-e67c09c4cbdd)

+ Once it is completed, you get a `[sucess]: Flow complete` message in the terminal. This means that the flow has been completed.

+ You can check your gds output if you want to using klayout.
+ If you don't have klayout already installed, in a new terminal, type
```
sudo apt install klayout
```
</details>

## Working with your own custom design
<details>
<summary>Adding your design module</summary>

+ First step is to make sure your design file is in the required directory.
+ To do this, type the following when you are in your repo's directory in terminal
```
cd verilog/rtl
```
+ Now we need to place your design file in this directory. Use the `cp` command to do that. Make sure you add the period `.` after typing the design file path
```
cp <your design file path> .
```
</details>

<details>
  <summary>Updating user_project_wrapper</summary>

+ Open the `user_project_wrapper.v` file and change the names of design files in the required places from `user_proj_example` to whatever your design file name is.
+ Type out your module name and instance name.
+ Before changing it will look like this
![image](https://github.com/Vishnu1426/pes_ram_design_tapeout/assets/79538653/6f899f50-d24a-4782-b0f9-4fbbbc6aeb85)

+ It will look like this after changing module name and the instance name

![image](https://github.com/Vishnu1426/pes_ram_design_tapeout/assets/79538653/5eedb6ee-9d3e-47d5-bd8d-bbf14589e3aa)

+ After this add the digital domain power-in and ground pins to your design module. This is not compulsory but it will help prevent errors in the later stages.
```
`ifdef USE_POWER_PINS
  inout vccd1,	// User area 1 1.8V supply
  inout vssd1, // User area 1 digital ground
`endif
```
+ After adding the above lines my design module looks like this.

![image](https://github.com/Vishnu1426/pes_ram_design_tapeout/assets/79538653/690ba081-d2f1-4acb-9361-31d9c90d325d)

+ Continue with the instantiation process. Remove or comment out the wishbone slave ports, logic analyser and IRQ.
+ Change the names of clock and reset signals.
+ Do these things only under your project in the wrapper not the ones above it.
+ Change the output names to your output reg names. Make sure the bits are correct.
+ If you can afford it, make sure you start using output ports from port 8, like I have done.
+ My `user_project_wrapper.v` looks like this after updating

![image](https://github.com/Vishnu1426/pes_ram_design_tapeout/assets/79538653/4c3e8b84-5bb5-4396-92f2-f277cd5d3220)

+ `oeb` stands for output enable bit. Add this to your design module and have the same number of bits of oeb as you have outputs bits.
+ I have 8x2 bits output so I have 16 bit oeb.

![image](https://github.com/Vishnu1426/pes_ram_design_tapeout/assets/79538653/0f1a3528-ae4e-4d04-bad0-d783e1bb5fa9)

+ Open this in the includes sub-folder in verilog folder
```
gedit includes.rtl.caravel_user_project 
```
+ The above file should look like this after updating. Upadate the name of the design module.

![image](https://github.com/Vishnu1426/pes_ram_design_tapeout/assets/79538653/bdd93de8-8364-4777-8278-71297cc32510)

</details>


## Adding a testbench 
#### This can be skipped. This is not required for tapeout if you have already tested your design.

<details>
  <summary>Creating a testbench directory with the right names</summary>
+ Go to the 'dv' directory.
+ Type the follwing'
```
cp -r io_ports/ <your_design_name>
rename s/io_ports/<your_design_name>/ *
```
+ Now the names of the files in io_ports folder will be adjusted to your module name. 
+ You can check it by going into your design folder which was freshly created by the above commands and check the files in it.
</details>

<details>
  <summary>Editing the files</summary>
  
+ Open the .c file.
+ Change the port number to start from 8, if you have started from port 8.
+ Add or delete ports based on the number of ports you are actually using.
+ My file looks like this after adding.

![image](https://github.com/Vishnu1426/pes_ram_design_tapeout/assets/79538653/65cf2169-aa3d-42fe-8ee8-b7b1899cdf41)

</details>

<details>
  <summary>Editing the testbench</summary>
  
+ Open the testbench file, i.e., `<your_design_tb.v>`
+ Update the design names in the following places

![image](https://github.com/Vishnu1426/pes_ram_design_tapeout/assets/79538653/0db6b767-9216-42e9-997c-1ee27c4b547f)

![image](https://github.com/Vishnu1426/pes_ram_design_tapeout/assets/79538653/7008a684-f309-4b03-b55f-ec07a8da323d)

+ Comment out the following 'if' section

![image](https://github.com/Vishnu1426/pes_ram_design_tapeout/assets/79538653/c53853fa-eacd-4f18-aefb-fe967f83865d)

+ Also change the following according to what you have given in the wrapper file.
+ The bits have to be changed for the convenience pins. These should be same as the oeb pins that you are using.

![image](https://github.com/Vishnu1426/pes_ram_design_tapeout/assets/79538653/6b2587b6-16e8-4814-a77c-93b9808cb598)

</details>

<details>
  <summary>Running an RTL check</summary>
  
+ Type the following to check the design
```
make verify-<your_design_name>-rtl
```
+ This will not work since we have not adjusted the test for our project. Missing files will be downloaded automatically.

![image](https://github.com/Vishnu1426/pes_ram_design_tapeout_old/assets/79538653/968cd62f-05d6-43d2-aba4-74bb5fa3f136)

+ To actually pass the test, in the section of the testbench where wait is being used, you have to put in your actual outputs that you are expecting out of output pins.
+ The tool will check of the output match and will give whether test has been passed or not.
+ The gtkwave view will have some signals set to Z and X since we have ran the flow with some things missing.

![image](https://github.com/Vishnu1426/pes_ram_design_tapeout_old/assets/79538653/cd6bef0d-29be-4ddc-9313-1ec7c823451e)

+ The above gtkwave vcd can be found in the dv directory in the verilog directory.
+ If you want to use the test change the required variables in the testbench file as mentioned above so that the code waits till the correct output comes and then declares the test passed.
+ Since we have already tested the design previously we can move on to the next step.

</details>

### Final GDS

+ After the final run and completion of flow, this is what the output looks like

![image](https://github.com/Vishnu1426/pes_ram_design_tapeout/assets/79538653/fa65c286-3e7a-4a76-a854-7c0b5371246a)

+ This is what the final gds file looks like

![image](https://github.com/Vishnu1426/pes_ram_design_tapeout/assets/79538653/005d60ce-597f-404f-a8b6-c17c403d95f6)


