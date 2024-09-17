-L work
-reflib pmi_work
-reflib ovi_ice40up


"C:/Users/jcarlin/Documents/GitHub/e155-lab3/fpga/src/key_decoder.sv" 
"C:/Users/jcarlin/Documents/GitHub/e155-lab3/fpga/src/key_scan.sv" 
"C:/Users/jcarlin/Documents/GitHub/e155-lab3/fpga/src/pulse.sv" 
"C:/Users/jcarlin/Documents/GitHub/e155-lab3/fpga/src/seg_decoder.sv" 
"C:/Users/jcarlin/Documents/GitHub/e155-lab3/fpga/src/sync.sv" 
"C:/Users/jcarlin/Documents/GitHub/e155-lab3/fpga/src/top.sv" 
"C:/Users/jcarlin/Documents/GitHub/e155-lab3/fpga/testbench/lab3_tb.sv" 
-sv
-optionset VOPTDEBUG
+noacc+pmi_work.*
+noacc+ovi_ice40up.*

-vopt.options
  -suppress vopt-7033
-end

-gui
-top lab3_tb
-vsim.options
  -suppress vsim-7033,vsim-8630,3009,3389
-end

-do "view wave"
-do "add wave /*"
-do "run 1000 ns"
