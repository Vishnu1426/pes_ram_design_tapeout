# DUAL PORT RAM - TAPEOUT

### Using caravel_user_project template to start your project
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

<details>
+ Type out your module name and instance name. Change from user_proj_example to your module name.
![image](https://github.com/Vishnu1426/pes_ram_design_tapeout/assets/79538653/6f899f50-d24a-4782-b0f9-4fbbbc6aeb85)

+ It will look like this after changing module name

![image](https://github.com/Vishnu1426/pes_ram_design_tapeout/assets/79538653/5eedb6ee-9d3e-47d5-bd8d-bbf14589e3aa)

+ After this add the digital domain power-in and ground pins to your module. This is not compulsory but it will help prevent errors in the later stages.
```
`ifdef USE_POWER_PINS
  inout vccd1,	// User area 1 1.8V supply
  inout vssd1, // User area 1 digital ground
`endif
```
+ After adding your module should look like this

![image](https://github.com/Vishnu1426/pes_ram_design_tapeout/assets/79538653/690ba081-d2f1-4acb-9361-31d9c90d325d)

+ Continue with the instantiation process. Now remove the wishbone slave port pins if you are not using them or comment them. Do the same with the logic analyzer.
+ Also change the names of clock and reset signals.
+ Do these things only under your project in the wrapper not the ones above it.
+ Change the output names to your output reg names and also add the oeb into your module. Make sure the bits are correct.
+ My files looks like this after updating

![image](https://github.com/Vishnu1426/pes_ram_design_tapeout/assets/79538653/1b9a2911-8013-45ec-9c74-339e6f4bede2)

![image](https://github.com/Vishnu1426/pes_ram_design_tapeout/assets/79538653/ad3ee48d-eab6-4705-beb4-33c23c36a63b)

+ Open this in the includes sub-folder in verilog folder
```
gedit includes.rtl.caravel_user_project 
```
+ The above file should look like this after updating. Upadate the name of the design module.

![image](https://github.com/Vishnu1426/pes_ram_design_tapeout/assets/79538653/bdd93de8-8364-4777-8278-71297cc32510)

### Adding a testbench

+ Go to the 'dv' directory.
+ Type the follwing'
```
cp -r io_ports/ <your_design_name>
rename s/io_ports/<your_design_name>/ *
```
+ Now the names of the files in io_ports folder will be adjusted to your module name. You can check it by going into your design folder which was freshly created by the above commands and check the files in it.
+ Open the .c file.
+ Change the port number to start from 8. Add or delete ports based on the number of ports you have. My file looks like this after adding.

![image](https://github.com/Vishnu1426/pes_ram_design_tapeout/assets/79538653/65cf2169-aa3d-42fe-8ee8-b7b1899cdf41)

+ Next open the testbench file.
+ Update the design names in the following places

![image](https://github.com/Vishnu1426/pes_ram_design_tapeout/assets/79538653/0db6b767-9216-42e9-997c-1ee27c4b547f)

![image](https://github.com/Vishnu1426/pes_ram_design_tapeout/assets/79538653/7008a684-f309-4b03-b55f-ec07a8da323d)

+ Comment out the following 'if' section

![image](https://github.com/Vishnu1426/pes_ram_design_tapeout/assets/79538653/c53853fa-eacd-4f18-aefb-fe967f83865d)

+ Also change the following according to what you have given in the wrapper file. The bits have to be changed for the convenience pins.

![image](https://github.com/Vishnu1426/pes_ram_design_tapeout/assets/79538653/6b2587b6-16e8-4814-a77c-93b9808cb598)

+ Type the following to check the design
```
make verify-<your_design_name>-rtl
```
+ This will not work since we have not adjusted the test but this is just to verify if things have been done right. Missing files will be downloaded automatically.

![image](https://github.com/Vishnu1426/pes_ram_design_tapeout_old/assets/79538653/968cd62f-05d6-43d2-aba4-74bb5fa3f136)

+ The gtkwave view will have some signals set to Z and X since we have ran the flow with some things missing.

![image](https://github.com/Vishnu1426/pes_ram_design_tapeout_old/assets/79538653/cd6bef0d-29be-4ddc-9313-1ec7c823451e)

+ The above gtkwave vcd can be found in the dv directory in the verilog directory.

+ Let us update the tests.
+ Change the required variables in the testbench file so that the code waits till the correct output comes and then declares the test passed.
+ Since we have already tested the design previously we can move on to the next step.

### Final GDS

+ After the final run and completion of flow, this is what the output looks like

![image](https://github.com/Vishnu1426/pes_ram_design_tapeout/assets/79538653/fa65c286-3e7a-4a76-a854-7c0b5371246a)

+ This is what the final gds file looks like

![image](https://github.com/Vishnu1426/pes_ram_design_tapeout/assets/79538653/005d60ce-597f-404f-a8b6-c17c403d95f6)


