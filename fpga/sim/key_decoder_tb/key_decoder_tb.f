-L work
-reflib pmi_work
-reflib ovi_ice40up


"/home/jcarlin/e155/e155-lab3/fpga/src/key_decoder.sv" 
"/home/jcarlin/e155/e155-lab3/fpga/testbench/key_decoder_tb.sv" 
-sv
-optionset VOPTDEBUG
+noacc+pmi_work.*
+noacc+ovi_ice40up.*

-vopt.options
  -suppress vopt-7033
-end

-gui
-top key_decoder_tb
-vsim.options
  -suppress vsim-7033,vsim-8630,3009,3389
-end

-do "view wave"
-do "add wave /*"
-do "run 1000 ns"
