#include "Vsqrt_12s.h"
#include "verilated.h"
#include "clock_gen/clock_gen.h"

#if VM_TRACE
#include "verilated_vcd_c.h"
#endif

// Period for a 100 MHz clock
#define PERIOD_100MHz_ps    ((vluint64_t)10000)

// Clocks generation (global)
ClockGen *clk;

int main(int argc, char **argv, char **env)
{
    // Simulation duration
    clock_t beg, end;
    double secs;
    // Trace index
    int trc_idx = 0;
    int min_idx = 0;
    // File name generation
    char file_name[256];
    // Simulation time
    vluint64_t tb_time;
    vluint64_t max_time;
    // Testbench configuration
    const char *arg;
    vluint8_t prev_clk;

    beg = clock();

    // Parse parameters
    Verilated::commandArgs(argc, argv);

    // Default : 1 msec
    max_time = (vluint64_t)1000000000;

    // Simulation duration : +usec=<num>
    arg = Verilated::commandArgsPlusMatch("usec=");
    if ((arg) && (arg[0]))
    {
        arg += 6;
        max_time = (vluint64_t)atoi(arg) * (vluint64_t)1000000;
    }

    // Simulation duration : +msec=<num>
    arg = Verilated::commandArgsPlusMatch("msec=");
    if ((arg) && (arg[0]))
    {
        arg += 6;
        max_time = (vluint64_t)atoi(arg) * (vluint64_t)1000000000;
    }

    // Init top verilog instance
    Vsqrt_12s* top = new Vsqrt_12s;


    // Initialize clock generator
    clk = new ClockGen(1);
    tb_time = (vluint64_t)0;
    // 100 MHz clock
    clk->NewClock(0, PERIOD_100MHz_ps);
    clk->ConnectClock(0, &top->clk);
    clk->StartClock(0, tb_time);
    prev_clk = 0;

#if VM_TRACE
    // Init VCD trace dump
    Verilated::traceEverOn(true);
    VerilatedVcdC* tfp = new VerilatedVcdC;
    top->trace (tfp, 99);
    tfp->spTrace()->set_time_resolution ("1 ps");
    sprintf(file_name, "sqrt_%04d.vcd", 0);
    tfp->open (file_name);
#endif /* VM_TRACE */

    // Initialize simulation inputs
    top->data_i = 0x0000;
    top->vld_i  = 0;

    // Simulation loop
    while (tb_time < max_time)
    {
        // Toggle clocks
        clk->AdvanceClocks(tb_time);
        // Evaluate verilated model
        top->eval ();
        
        if (prev_clk && !top->clk) // falling edge
        {
            top->vld_i = 1;
            top->data_i++;
        }

        prev_clk = top->clk;

#if VM_TRACE
        // Dump signals into VCD file
        if (tfp) tfp->dump (tb_time);
#endif /* VM_TRACE */

        if (Verilated::gotFinish()) break;
    }

#if VM_TRACE
    if (tfp) tfp->close();
#endif /* VM_TRACE */

    top->final();

    delete top;

    delete clk;

    // Calculate running time
    end = clock();
    printf("\nSeconds elapsed : %5.3f\n", (float)(end - beg) / CLOCKS_PER_SEC);

    exit(0);
}
