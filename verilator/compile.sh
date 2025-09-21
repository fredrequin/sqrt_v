#Options for GCC compiler
COMPILE_OPT="-cc -O3 -CFLAGS -O3 -CFLAGS -Wno-attributes"

#Comment this line to disable VCD generation
TRACE_OPT="-trace"

#Clock signals
CLOCK_OPT=\
"-clk v.clk"
 
#Verilog top module
TOP_FILE=sqrt_16s

#C++ support files
CPP_FILES=\
"main.cpp\
 ./clock_gen/clock_gen.cpp\
 verilated_dpi.cpp"

verilator tb_top.v $COMPILE_OPT $TRACE_OPT $CLOCK_OPT -top-module $TOP_FILE -exe $CPP_FILES
cd ./obj_dir
make -j -f V$TOP_FILE.mk V$TOP_FILE
cd ..
