module sqrt_16s
#(
    parameter [15:0] OFFSET = 16'h0000
)
(
    input         clk,
    input  [15:0] data_i,
    input         vld_i,
    output [15:0] data_o,
    output        vld_o
);

wire [31:0] w_data_p0 = { data_i, OFFSET };

// ================ Stage #1 ================

wire [31:0] w_data_p1;
wire  [1:0] w_rem_p1;
wire  [1:0] w_res_p1;
wire        w_vld_p1;

sqrt_stage
#(
    .DATA_W (32),
    .STAGE  (1)
)
U_sqrt_p1
(
    .clk    (clk),
    .data_i (w_data_p0),
    .rem_i  (1'b0),
    .res_i  (1'b0),
    .vld_i  (vld_i),

    .data_o (w_data_p1),
    .rem_o  (w_rem_p1),
    .res_o  (w_res_p1),
    .vld_o  (w_vld_p1)
);

// ================ Stage #2 ================

wire [31:0] w_data_p2;
wire  [2:0] w_rem_p2;
wire  [2:0] w_res_p2;
wire        w_vld_p2;

sqrt_stage
#(
    .DATA_W (32),
    .STAGE  (2)
)
U_sqrt_p2
(
    .clk    (clk),
    .data_i (w_data_p1),
    .rem_i  (w_rem_p1),
    .res_i  (w_res_p1),
    .vld_i  (w_vld_p1),

    .data_o (w_data_p2),
    .rem_o  (w_rem_p2),
    .res_o  (w_res_p2),
    .vld_o  (w_vld_p2)
);

// ================ Stage #3 ================

wire [31:0] w_data_p3;
wire  [3:0] w_rem_p3;
wire  [3:0] w_res_p3;
wire        w_vld_p3;

sqrt_stage
#(
    .DATA_W (32),
    .STAGE  (3)
)
U_sqrt_p3
(
    .clk    (clk),
    .data_i (w_data_p2),
    .rem_i  (w_rem_p2),
    .res_i  (w_res_p2),
    .vld_i  (w_vld_p2),

    .data_o (w_data_p3),
    .rem_o  (w_rem_p3),
    .res_o  (w_res_p3),
    .vld_o  (w_vld_p3)
);

// ================ Stage #4 ================

wire [31:0] w_data_p4;
wire  [4:0] w_rem_p4;
wire  [4:0] w_res_p4;
wire        w_vld_p4;

sqrt_stage
#(
    .DATA_W (32),
    .STAGE  (4)
)
U_sqrt_p4
(
    .clk    (clk),
    .data_i (w_data_p3),
    .rem_i  (w_rem_p3),
    .res_i  (w_res_p3),
    .vld_i  (w_vld_p3),

    .data_o (w_data_p4),
    .rem_o  (w_rem_p4),
    .res_o  (w_res_p4),
    .vld_o  (w_vld_p4)
);

// ================ Stage #5 ================

wire [31:0] w_data_p5;
wire  [5:0] w_rem_p5;
wire  [5:0] w_res_p5;
wire        w_vld_p5;

sqrt_stage
#(
    .DATA_W (32),
    .STAGE  (5)
)
U_sqrt_p5
(
    .clk    (clk),
    .data_i (w_data_p4),
    .rem_i  (w_rem_p4),
    .res_i  (w_res_p4),
    .vld_i  (w_vld_p4),

    .data_o (w_data_p5),
    .rem_o  (w_rem_p5),
    .res_o  (w_res_p5),
    .vld_o  (w_vld_p5)
);

// ================ Stage #6 ================

wire [31:0] w_data_p6;
wire  [6:0] w_rem_p6;
wire  [6:0] w_res_p6;
wire        w_vld_p6;

sqrt_stage
#(
    .DATA_W (32),
    .STAGE  (6)
)
U_sqrt_p6
(
    .clk    (clk),
    .data_i (w_data_p5),
    .rem_i  (w_rem_p5),
    .res_i  (w_res_p5),
    .vld_i  (w_vld_p5),

    .data_o (w_data_p6),
    .rem_o  (w_rem_p6),
    .res_o  (w_res_p6),
    .vld_o  (w_vld_p6)
);

// ================ Stage #7 ================

wire [31:0] w_data_p7;
wire  [7:0] w_rem_p7;
wire  [7:0] w_res_p7;
wire        w_vld_p7;

sqrt_stage
#(
    .DATA_W (32),
    .STAGE  (7)
)
U_sqrt_p7
(
    .clk    (clk),
    .data_i (w_data_p6),
    .rem_i  (w_rem_p6),
    .res_i  (w_res_p6),
    .vld_i  (w_vld_p6),

    .data_o (w_data_p7),
    .rem_o  (w_rem_p7),
    .res_o  (w_res_p7),
    .vld_o  (w_vld_p7)
);

// ================ Stage #8 ================

wire [31:0] w_data_p8;
wire  [8:0] w_rem_p8;
wire  [8:0] w_res_p8;
wire        w_vld_p8;

sqrt_stage
#(
    .DATA_W (32),
    .STAGE  (8)
)
U_sqrt_p8
(
    .clk    (clk),
    .data_i (w_data_p7),
    .rem_i  (w_rem_p7),
    .res_i  (w_res_p7),
    .vld_i  (w_vld_p7),

    .data_o (w_data_p8),
    .rem_o  (w_rem_p8),
    .res_o  (w_res_p8),
    .vld_o  (w_vld_p8)
);

// ================ Stage #9 ================

wire [31:0] w_data_p9;
wire  [9:0] w_rem_p9;
wire  [9:0] w_res_p9;
wire        w_vld_p9;

sqrt_stage
#(
    .DATA_W (32),
    .STAGE  (9)
)
U_sqrt_p9
(
    .clk    (clk),
    .data_i (w_data_p8),
    .rem_i  (w_rem_p8),
    .res_i  (w_res_p8),
    .vld_i  (w_vld_p8),

    .data_o (w_data_p9),
    .rem_o  (w_rem_p9),
    .res_o  (w_res_p9),
    .vld_o  (w_vld_p9)
);

// ================ Stage #10 ================

wire [31:0] w_data_p10;
wire [10:0] w_rem_p10;
wire [10:0] w_res_p10;
wire        w_vld_p10;

sqrt_stage
#(
    .DATA_W (32),
    .STAGE  (10)
)
U_sqrt_p10
(
    .clk    (clk),
    .data_i (w_data_p9),
    .rem_i  (w_rem_p9),
    .res_i  (w_res_p9),
    .vld_i  (w_vld_p9),

    .data_o (w_data_p10),
    .rem_o  (w_rem_p10),
    .res_o  (w_res_p10),
    .vld_o  (w_vld_p10)
);

// ================ Stage #11 ================

wire [31:0] w_data_p11;
wire [11:0] w_rem_p11;
wire [11:0] w_res_p11;
wire        w_vld_p11;

sqrt_stage
#(
    .DATA_W (32),
    .STAGE  (11)
)
U_sqrt_p11
(
    .clk    (clk),
    .data_i (w_data_p10),
    .rem_i  (w_rem_p10),
    .res_i  (w_res_p10),
    .vld_i  (w_vld_p10),

    .data_o (w_data_p11),
    .rem_o  (w_rem_p11),
    .res_o  (w_res_p11),
    .vld_o  (w_vld_p11)
);

// ================ Stage #12 ================

wire [31:0] w_data_p12;
wire [12:0] w_rem_p12;
wire [12:0] w_res_p12;
wire        w_vld_p12;

sqrt_stage
#(
    .DATA_W (32),
    .STAGE  (12)
)
U_sqrt_p12
(
    .clk    (clk),
    .data_i (w_data_p11),
    .rem_i  (w_rem_p11),
    .res_i  (w_res_p11),
    .vld_i  (w_vld_p11),

    .data_o (w_data_p12),
    .rem_o  (w_rem_p12),
    .res_o  (w_res_p12),
    .vld_o  (w_vld_p12)
);

// ================ Stage #13 ================

wire [31:0] w_data_p13;
wire [13:0] w_rem_p13;
wire [13:0] w_res_p13;
wire        w_vld_p13;

sqrt_stage
#(
    .DATA_W (32),
    .STAGE  (13)
)
U_sqrt_p13
(
    .clk    (clk),
    .data_i (w_data_p12),
    .rem_i  (w_rem_p12),
    .res_i  (w_res_p12),
    .vld_i  (w_vld_p12),

    .data_o (w_data_p13),
    .rem_o  (w_rem_p13),
    .res_o  (w_res_p13),
    .vld_o  (w_vld_p13)
);

// ================ Stage #14 ================

wire [31:0] w_data_p14;
wire [14:0] w_rem_p14;
wire [14:0] w_res_p14;
wire        w_vld_p14;

sqrt_stage
#(
    .DATA_W (32),
    .STAGE  (14)
)
U_sqrt_p14
(
    .clk    (clk),
    .data_i (w_data_p13),
    .rem_i  (w_rem_p13),
    .res_i  (w_res_p13),
    .vld_i  (w_vld_p13),

    .data_o (w_data_p14),
    .rem_o  (w_rem_p14),
    .res_o  (w_res_p14),
    .vld_o  (w_vld_p14)
);

// ================ Stage #15 ================

wire [31:0] w_data_p15;
wire [15:0] w_rem_p15;
wire [15:0] w_res_p15;
wire        w_vld_p15;

sqrt_stage
#(
    .DATA_W (32),
    .STAGE  (15)
)
U_sqrt_p15
(
    .clk    (clk),
    .data_i (w_data_p14),
    .rem_i  (w_rem_p14),
    .res_i  (w_res_p14),
    .vld_i  (w_vld_p14),

    .data_o (w_data_p15),
    .rem_o  (w_rem_p15),
    .res_o  (w_res_p15),
    .vld_o  (w_vld_p15)
);

// ================ Stage #16 ================

/* verilator lint_off UNUSED */
wire [31:0] w_data_p16;
wire [16:0] w_rem_p16;
wire [16:0] w_res_p16;
wire        w_vld_p16;
/* verilator lint_on UNUSED */

sqrt_stage
#(
    .DATA_W (32),
    .STAGE  (16)
)
U_sqrt_p16
(
    .clk    (clk),
    .data_i (w_data_p15),
    .rem_i  (w_rem_p15),
    .res_i  (w_res_p15),
    .vld_i  (w_vld_p15),

    .data_o (w_data_p16),
    .rem_o  (w_rem_p16),
    .res_o  (w_res_p16),
    .vld_o  (w_vld_p16)
);

assign data_o = w_res_p16[15:0];
assign vld_o  = w_vld_p16;

endmodule
