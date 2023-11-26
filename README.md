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

### Getting ready for running the tool flow

<details>
  <summary>Setting up directories in openlane</summary>

+ As mentioned, we made this repository using a template from efables.
+ Therefore there is a template available for us for the openlane flow directory.
+ Go to the openlane directory using `cd`.
+ Type the following in it
```
cp -r user_proj_example/ <your_design_name> 
```
+ This will copy all the files from `user_proj_example` to another folder named `<your_design_name`.   
</details>

<details>
  <summary>Changing the config flie</summary>

+ You have to edit the `config.json` file to make sure it is good for your design.
+ Open the `config.json` file.
+ Under the `DESGIN_NAME`, change from `user_proj_example` to your design name.
+ Do the same under `VERILOG_FILES`.
+ My `config.json` looks like this after changing.

![image](https://github.com/Vishnu1426/pes_ram_design_tapeout/assets/79538653/ef7e6e01-2460-45d3-bc01-62b03c106a93)

+ Change the name `CLOCK_PORT` to whatever variable the clock signal has in your design module.
+ Reduce or increase the `DIE_AREA` based on the size of your design.

![image](https://github.com/Vishnu1426/pes_ram_design_tapeout/assets/79538653/16fd6c08-1fda-426f-8914-66bd3a27d3a2)

+ Change the `MAX_FANOUT_CONSTRAINT` also if you want. I have mine set at 20. 
</details>

<details>
  <summary>Setiing the pins</summary>

+ You need to add the pins to the `pin_order_cfg` file.
+ It should be based on your design file. All the input and output ports that you are using should be mentioned here **except the power pins**.
+ My design file has the following inputs and outputs.
```verilog
module pes_ram_design_tapeout(
`ifdef USE_POWER_PINS
  inout vccd1,	// User area 1 1.8V supply
  inout vssd1, // User area 1 digital ground
`endif 

  input [7:0] data_a, data_b, //input data
  input [5:0] addr_a, addr_b, //Port A and Port B address
  input we_a, we_b, //write enable for Port A and Port B
  input clk, //clk
  output reg [7:0] q_a, q_b, //output data at Port A and Port B
  output wire [15:0] io_oeb
);
```
+ This is what my `pin_order.cfg` looks like. Since I am using 16 bit `oeb`, I have added more `io_oeb` variables.
```verilog
#BUS_SORT

#S
wb_.*
wbs_.*
la_.*
irq.*

#E
clk
we_a
we_b
addr_a\[0\]
addr_b\[0\]
data_a\[0\]
data_b\[0\]
q_a\[0\]
q_b\[0\]
addr_a\[1\]
addr_b\[1\]
data_a\[1\]
data_b\[1\]
q_a\[1\]
q_b\[1\]
addr_a\[2\]
addr_b\[2\]
data_a\[2\]
data_b\[2\]
q_a\[2\]
q_b\[2\]
addr_a\[3\]
addr_b\[3\]
data_a\[3\]
data_b\[3\]
q_a\[3\]
q_b\[3\]
addr_a\[4\]
addr_b\[4\]
data_a\[4\]
data_b\[4\]
q_a\[4\]
q_b\[4\]
addr_a\[5\]
addr_b\[5\]
data_a\[5\]
data_b\[5\]
q_a\[5\]
q_b\[5\]
data_a\[6\]
data_b\[6\]
q_a\[6\]
q_b\[6\]
data_a\[7\]
data_b\[7\]
q_a\[7\]
q_b\[7\]

io_oeb\[0\]
io_oeb\[1\]
io_oeb\[2\]
io_oeb\[3\]
io_oeb\[4\]
io_oeb\[5\]
io_oeb\[6\]
io_oeb\[7\]

#WR
io_oeb\[8\]
io_oeb\[9\]
io_oeb\[10\]
io_oeb\[11\]
io_oeb\[12\]
io_oeb\[13\]
io_oeb\[14\]
io_oeb\[15\]
io_oeb\[16\]
io_oeb\[17\]
io_oeb\[18\]
io_oeb\[19\]
io_oeb\[20\]
io_oeb\[21\]
io_oeb\[22\]
io_oeb\[23\]
```
+ Add all the `\` in the right places as shown above.
+ For single bit variables, don't add any `\`. My `clk` signal is single bit.
</details>

<details>
  <summary>Running to toolflow</summary>

+ Now to run the entire toolflow, come out of openlane and be in your repo's directory.
+ Make sure you are in the terminal where you did your `export` commands initially in your `dependencies` folder. If you are in a different terminal, do those steps again.
+ Once you are ready in your repo's folder, type the following and replace `<your_design_name>` with your design name what you have given everywhere.
```
time make <your_design_name>
```
+ The openlane tool will start and synthesis to gds will be done here.
</details>

<details>
  <summary>Possible Errors</summary>
  
+ You might get some erros in between. Correct them and try again.
+ Some errors could be placement errors saying `unmatched_pins`. This means that there is some issue with the names in your `pin_order.cfg` file.
+ Another placement error could occur, which is actually a python error. This again could be an issue with the `\` in your `pin_order.cfg` file.
+ Larger die area will increase the complexity of power distribution network. Therefore keep it exactly how much is required.
+ Smaller die area might give your a `die area too small` error or something similar due to high density of power distribution network lines.
+ During `detailed_routing`, your system might start using up a lot of ram and end up hanging. To prevent this make sure you have system monitor opened on the side and monitor the ram.
+ If your ram usage goes beyond 90% usage, stop the flow. Reduce the `DIE_AREA` a little and try again.
+ My design is an 8x64 bit ram. I had to change the die area by first making it 8x4 bit and checking how my computer's RAM usage in `detailed_routing` was affected.
+ I started with a large die area for 8x4 bit ram, and subsequently modified the die area so that it was just enough.
+ Then I increased it  to 8x8, then 8x16, then 8x32 and then finally 8x64. I had to run all of them to get a good and optimal die area for my design.
+ Larger die area consumes more memory.
+ If you run out of memory while trying different parameters, delete the old runs and that will give you some space.
+ The runs will be in the `runs` directory in `openlane/<your_design_name>`.
+ Use `rm -r <run_name>` to recorsively delete everything in that particular run.
</details>

<details>
  <summary>Cheking the tool flow completion</summary>

+ After the final run and completion of flow, you will get a `[SUCESS]: Flow complete` message in the termninal just like how you got for the `user_proj_example`
+ This is what the output looks like after finishing.
+ Fanout violations can be corrected by changing the fanout parameters in the `config.json` file. I am not doing that for the time being since it is just a rule of thumb and not compulsory.

![image](https://github.com/Vishnu1426/pes_ram_design_tapeout/assets/79538653/fa65c286-3e7a-4a76-a854-7c0b5371246a)
</details>

<details>
  <summary>Viewing the GDS file</summary>
  
+ To view the GDS file in your runs, go the runs directory of your most recent run.
+ The runs will be in the `runs` directory in `openlane/<your_design_name>`.
+ Your gds file will be in the following path. Change `<your_design_name>` with your design name accordingly.
```
/home/vishnu/<your_design_name>/openlane/<your_design_name>/runs/23_11_26_01_03/results/final/gds
```
+ Go to the above directory and type
```
klayout <your_design_name>
```
+ This is what my final GDS layout looks like

![image](https://github.com/Vishnu1426/pes_ram_design_tapeout/assets/79538653/005d60ce-597f-404f-a8b6-c17c403d95f6)

![image](https://github.com/Vishnu1426/pes_ram_design_tapeout/assets/79538653/401951dd-765a-4543-be03-b4086e29f076)

![image](https://github.com/Vishnu1426/pes_ram_design_tapeout/assets/79538653/5e51e11a-242f-48f5-8ee3-8cbcc2fef9d5)

+ Output pins

![image](https://github.com/Vishnu1426/pes_ram_design_tapeout/assets/79538653/5ede0a5f-3674-4b19-a48e-6f6cd5c7b3a1)

+ One of the input pin

![image](https://github.com/Vishnu1426/pes_ram_design_tapeout/assets/79538653/6ad6c454-58b4-484f-96f8-d7381d8d4bee)

+ This area has a relatively very high density of cells.

![image](https://github.com/Vishnu1426/pes_ram_design_tapeout/assets/79538653/edd462c0-38ca-4a08-b9f5-0ee0d74f25e1)

![image](https://github.com/Vishnu1426/pes_ram_design_tapeout/assets/79538653/bac4235f-9da6-442e-ad24-c5a96af4c0cb)

</details>

<details>
  <summary>Commiting your files to Github</summary>

+ Go to your repo's directory.
+ This will update your local repo with whatever changes have been made remotely,
+ Next type `git status` to get the status of all the changed files.
+ Using `git add` add all the files that are visible from the previous command to have been modified.
+ Then type `git commit -m '<commit desc>`
+ Now pull from the remote repo for any changes.
```
git pull
```
+ Now type `git push` to push the files to Github repo. Reload the page and all your files will be updated in the remore repository,
</details>
