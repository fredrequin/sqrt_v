// Trace configuration
// -------------------
`verilator_config

tracing_on -file "../rtl/sqrt_stage.v"
tracing_on -file "../rtl/sqrt_16s.v"

`verilog

`include "../rtl/sqrt_stage.v"
`include "../rtl/sqrt_16s.v"
