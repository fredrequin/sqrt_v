#include "verilated.h"
#include "clock_gen.h"
#include <stdlib.h>
#include <stdio.h>
#include <time.h>

// Constructor : set the number of clocks
ClockGen::ClockGen(int num_clk)
{
    // Initialize time variables
    max_step_ps    = (vluint64_t)0;
    next_stamp_ps  = (vluint64_t)0;
    
    // Allocate the clocks
    num_clock      = num_clk;
    p_clk          = new vlclk_t[num_clk];
    
    // Clear the clocks
    vlclk_t *p = p_clk;
    for (int i = 0; i < num_clk; i++)
    {
        p->clk_stamp_ps = (vluint64_t)0;
        p->clk_sig      = NULL;
        p->clk_hper_ps  = (vluint32_t)0;
        p->clk_state    = (vluint8_t)0;
        p->clk_enable   = false;
        p++;
    }
}

// Destructor
ClockGen::~ClockGen()
{
    delete [] p_clk;
}

// Create a new clock
void ClockGen::NewClock(int clk_idx, vluint64_t period_ps)
{
    // Boundary check
    if (clk_idx >= num_clock) return;
    // Store the clock's half period
    p_clk[clk_idx].clk_hper_ps = (vluint32_t)(period_ps >> 1);
    // Adjust the maximum simulation step
    if (max_step_ps < (period_ps >> 1))
    {
        max_step_ps = (period_ps >> 1) + 1;
    }
}

// Connect the undivided clock to a signal
void ClockGen::ConnectClock(int clk_idx, vluint8_t *sig)
{
    // Boundary check
    if (clk_idx >= num_clock) return;
    // Store the signal's memory address
    p_clk[clk_idx].clk_sig = sig;
}

// Start a clock with a null phase
void ClockGen::StartClock(int clk_idx, vluint64_t stamp_ps)
{
    StartClock(clk_idx, 0, stamp_ps);
}

// Start a clock with a phase
void ClockGen::StartClock(int clk_idx, vluint64_t phase_ps, vluint64_t stamp_ps)
{
    // Boundary check
    if (clk_idx < num_clock)
    {
        // Clock pointer
        vlclk_t *p = p_clk + clk_idx;
        // Start with a 0
        p->clk_state = (vluint8_t)0;
        if (p->clk_sig) *p->clk_sig = (vluint8_t)0;
        // Check if the half period is not null
        if (p->clk_hper_ps)
        {
            // Compute where we are in the clock's period
            vluint64_t rem = stamp_ps % (p->clk_hper_ps << 1);
            // Next rising edge : phase shift + one half period later
            p->clk_stamp_ps = stamp_ps - rem + phase_ps + p->clk_hper_ps;
            // To prevent going back in time !!!
            if (rem >= (phase_ps + p->clk_hper_ps))
            {
                p->clk_stamp_ps += (p->clk_hper_ps << 1);
            }
            // Enable the clock
            p->clk_enable = true;
            // Debug message
            printf("StartClock(%d) : time = %lld, phase = %lld, stamp = %lld\n",
                   clk_idx, stamp_ps, phase_ps, p->clk_stamp_ps);
        }
    }
}

// Stop a clock
void ClockGen::StopClock(int clk_idx)
{
    // Boundary check
    if (clk_idx >= num_clock) return;
    // Disable the clock
    p_clk[clk_idx].clk_enable = false;
}

// Undivided clock, phase can be 0 (0 deg) or 1 (180 deg)
vluint8_t ClockGen::GetClockStateDiv1(int clk_idx, vluint8_t phase)
{
    // Boundary check
    if (clk_idx >= num_clock) return (vluint8_t)0;
    // Return clock's state
    return (p_clk[clk_idx].clk_state - phase) & 1;
}

// Clock divided by 2, phase can be 0 (0 deg), 1 (90 deg), 2 (180 deg) or 3 (270 deg)
vluint8_t ClockGen::GetClockStateDiv2(int clk_idx, vluint8_t phase)
{
    // Boundary check
    if (clk_idx >= num_clock) return (vluint8_t)0;
    // Return clock's state
    return ((p_clk[clk_idx].clk_state - phase) >> 1) & 1;
}

// Clock divided by 4, phase can be 0 (0 deg) - 7 (315 deg)
vluint8_t ClockGen::GetClockStateDiv4(int clk_idx, vluint8_t phase)
{
    // Boundary check
    if (clk_idx >= num_clock) return (vluint8_t)0;
    // Return clock's state
    return ((p_clk[clk_idx].clk_state - phase) >> 2) & 1;
}

// Clock divided by 8, phase can be 0 (0 deg) - 15 (337.5 deg)
vluint8_t ClockGen::GetClockStateDiv8(int clk_idx, vluint8_t phase)
{
    // Boundary check
    if (clk_idx >= num_clock) return (vluint8_t)0;
    // Return clock's state
    return ((p_clk[clk_idx].clk_state - phase) >> 3) & 1;
}

// Clock divided by 16, phase can be 0 (0 deg) - 31 (348.75 deg)
vluint8_t ClockGen::GetClockStateDiv16(int clk_idx, vluint8_t phase)
{
    // Boundary check
    if (clk_idx >= num_clock) return (vluint8_t)0;
    // Return clock's state
    return ((p_clk[clk_idx].clk_state - phase) >> 4) & 1;
}

// Clock divided by 32, phase can be 0 (0 deg) - 63 (354.375 deg)
vluint8_t ClockGen::GetClockStateDiv32(int clk_idx, vluint8_t phase)
{
    // Boundary check
    if (clk_idx >= num_clock) return (vluint8_t)0;
    // Return clock's state
    return ((p_clk[clk_idx].clk_state - phase) >> 5) & 1;
}

// Update clock states, compute next time stamp
void ClockGen::AdvanceClocks(vluint64_t &stamp_ps)
{
    stamp_ps       = next_stamp_ps;
    next_stamp_ps += max_step_ps;
    
    vlclk_t *p = p_clk;
    for (int i = 0; i < num_clock; i++)
    {
        if (p->clk_enable)
        {
            // Update clock state
            if (p->clk_stamp_ps == stamp_ps)
            {
                p->clk_stamp_ps += p->clk_hper_ps;
                p->clk_state++;
                // Update connected signal
                if (p->clk_sig) *p->clk_sig = p->clk_state & 1;
            }
            // Find next time stamp
            if (p->clk_stamp_ps < next_stamp_ps)
            {
                next_stamp_ps = p->clk_stamp_ps;
            }
        }
        p++;
    }
    
    // Show progress, in microseconds
    if (!(vluint16_t)stamp_ps)
    {
        printf("\r%lld us", stamp_ps / 1000000 );
        fflush(stdout);
    }
}
