/* Kevin Zhang, kz2025 */

`timescale 1ns / 1ns

// quotient = dividend / divisor

module divider_unsigned (
    input  wire [31:0] i_dividend,
    input  wire [31:0] i_divisor,
    output wire [31:0] o_remainder,
    output wire [31:0] o_quotient
);
    wire [31:0] b_dividend [33];
    wire [31:0] b_remainder [33];
    wire [31:0] b_quotient [33];
    
    assign b_dividend[0] = i_dividend;
    assign b_remainder[0] = 32'b0;
    assign b_quotient[0] = 32'b0;

    genvar i;
    for(i = 0; i < 32; i+=1) begin
        divu_1iter iter(.i_dividend(b_dividend[i]), .i_divisor(i_divisor), .i_remainder(b_remainder[i]), .i_quotient(b_quotient[i]),
        .o_dividend(b_dividend[i+1]), .o_quotient(b_quotient[i+1]), .o_remainder(b_remainder[i+1]));
    end

    assign o_remainder = b_remainder[32];
    assign o_quotient = b_quotient[32];

endmodule


module divu_1iter (
    input  wire [31:0] i_dividend,
    input  wire [31:0] i_divisor,
    input  wire [31:0] i_remainder,
    input  wire [31:0] i_quotient,
    output wire [31:0] o_dividend,
    output wire [31:0] o_remainder,
    output wire [31:0] o_quotient
);
    logic [31:0] temp_remainder_1, temp_remainder_2, temp_quotient;
    assign temp_remainder_1 = ((i_remainder << 1) | ((i_dividend >> 31) & 32'b1));

    always_comb begin
        if (temp_remainder_1 < i_divisor) begin
            assign temp_quotient = (i_quotient << 1);
            assign temp_remainder_2 = temp_remainder_1;
        end else begin
            assign temp_quotient = ((i_quotient << 1) | 32'b1);
            assign temp_remainder_2 = temp_remainder_1 - i_divisor;
        end
    end

    assign o_remainder = temp_remainder_2;
    assign o_quotient = temp_quotient;
    assign o_dividend = i_dividend << 1;

endmodule
