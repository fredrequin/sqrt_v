module sqrt_stage
#(
    parameter integer DATA_W = 16,
    parameter integer STAGE  = 1
)
(
    input               clk,
    input  [DATA_W-1:0] data_i,
    input   [STAGE-1:0] rem_i,
    input   [STAGE-1:0] res_i,
    input               vld_i,

    output [DATA_W-1:0] data_o,
    output    [STAGE:0] rem_o,
    output    [STAGE:0] res_o,
    output              vld_o
);
    // A = 4 * remainder + top 2 data bits
    wire [STAGE+1:0] w_A = { rem_i, data_i[DATA_W-1:DATA_W-2] };
    // B = 4 * result + 1
    wire [STAGE+1:0] w_B = { res_i, 2'b01 };
    // Difference : A - B
    wire [STAGE+1:0] w_diff = w_A - w_B;

    reg [DATA_W-1:0] r_data; // Forwarded data
    reg    [STAGE:0] r_rem;  // Remainder
    reg    [STAGE:0] r_res;  // Partial result
    reg              r_vld;  // Data valid

    always@(posedge clk) begin
    
        if (vld_i) begin
            r_data <= { data_i[DATA_W-3:0], 2'b00 };
            if (w_diff[STAGE+1]) begin
                r_rem <=  w_A[STAGE:0];
                r_res <= { res_i, 1'b0 };
            end
            else begin
                r_rem <= w_diff[STAGE:0];
                r_res <= { res_i, 1'b1 };
            end
        end
        r_vld <= vld_i;
    end
    
    assign data_o = r_data;
    assign rem_o  = r_rem;
    assign res_o  = r_res;
    assign vld_o  = r_vld;

endmodule
