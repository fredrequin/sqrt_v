
#ifndef _CLOCK_GEN_H_
#define _CLOCK_GEN_H_

#include "verilated.h"

class ClockGen
{
    public:
        // Constructor and destructor
        ClockGen(int num_clk);
        ~ClockGen();
        // Methods
        void        NewClock(int clk_idx, vluint64_t period_ps);
        void        ConnectClock(int clk_idx, vluint8_t *sig);
        void        StartClock(int clk_idx, vluint64_t stamp_ps);
        void        StartClock(int clk_idx, vluint64_t phase_ps, vluint64_t stamp_ps);
        void        StopClock(int clk_idx);
        vluint8_t   GetClockStateDiv1(int clk_idx, vluint8_t phase); // phase : 0 - 1
        vluint8_t   GetClockStateDiv2(int clk_idx, vluint8_t phase); // phase : 0 - 3
        vluint8_t   GetClockStateDiv4(int clk_idx, vluint8_t phase); // phase : 0 - 7
        vluint8_t   GetClockStateDiv8(int clk_idx, vluint8_t phase); // phase : 0 - 15
        vluint8_t   GetClockStateDiv16(int clk_idx, vluint8_t phase); // phase : 0 - 31
        vluint8_t   GetClockStateDiv32(int clk_idx, vluint8_t phase); // phase : 0 - 63
        void        AdvanceClocks(vluint64_t &stamp_ps);
    private:
        typedef struct
        {
            vluint64_t clk_stamp_ps; // Clock's time stamps (in ps)
            vluint8_t *clk_sig;      // Clock signal
            vluint32_t clk_hper_ps;  // Clock's half period (in ps)
            vluint8_t  clk_state;    // Clock's state (0 - 255)
            bool       clk_enable;   // Clock enabled
        } vlclk_t;
        int         num_clock;       // Number of clocks
        vluint64_t  max_step_ps;     // Maximum simulation step (in ps)
        vluint64_t  next_stamp_ps;   // Next time stamp (in ps)
        vlclk_t    *p_clk;           // Created clocks
};

#endif /* _CLOCK_GEN_H_ */
