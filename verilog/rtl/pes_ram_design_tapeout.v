// Dual Port RAM module design

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
  
  reg [7:0] ram [63:0]; //8*64 bit ram

/*  `ifdef COCOTB_SIM
  	initial begin
  		$dumpfile ("pes_ram_design_tapeout.vcd");
  		$dumpvars (0, pes_ram_design_tapeout);
  		#1;
  	end
  	localparam MAX_COUNT = 100;
  `else
  	localparam MAX_COUNT = 100;
  `endif
  	*/
  	
 assign io_oeb = 16'b0000000000000000;
  always @ (posedge clk)
    begin
      if(we_a)
        ram[addr_a] <= data_a;
      else
        q_a <= ram[addr_a]; 
    end
  
  always @ (posedge clk)
    begin
      if(we_b)
        ram[addr_b] <= data_b;
      else
        q_b <= ram[addr_b]; 
    end
  
endmodule
