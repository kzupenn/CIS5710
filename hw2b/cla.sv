`timescale 1ns / 1ps
/*
Kevin Zhang, kz2025
Justina Lam, jklam 
*/

/**
 * @param a first 1-bit input
 * @param b second 1-bit input
 * @param g whether a and b generate a carry
 * @param p whether a and b would propagate an incoming carry
 */
module gp1(input wire a, b,
           output wire g, p);
   assign g = a & b;
   assign p = a | b;
endmodule

/**
 * Computes aggregate generate/propagate signals over a 4-bit window.
 * @param gin incoming generate signals
 * @param pin incoming propagate signals
 * @param cin the incoming carry
 * @param gout whether these 4 bits collectively generate a carry (takes cin into account)
 * @param pout whether these 4 bits collectively would propagate an incoming carry (ignoring cin)
 * @param cout the carry outs for the low-order 3 bits
 */
module gp4(input wire [3:0] gin, pin,
           input wire cin,
           output wire gout, pout,
           output wire [2:0] cout);

   // TODO: your code here
   assign gout = |gin;
   assign pout = &pin;
   assign cout[0]= gin[0] | (pin[0]&cin);
   assign cout[1]= gin[1] | (pin[1]&gin[0]) | pin[1]&pin[0]&cin;
   assign cout[2]= gin[2] | (pin[2]&gin[1]) | pin[2]&pin[1]&gin[0] | pin[2]&pin[1]&pin[0]&cin;

endmodule

/** Same as gp4 but for an 8-bit window instead */
module gp8(input wire [7:0] gin, pin,
           input wire cin,
           output wire gout, pout,
           output wire [6:0] cout);

   // TODO: your code here
   assign gout = |gin;
   assign pout = &pin;
   gp4 u1(.gin(gin[3:0]), .pin(pin[3:0]), .cin(1'b0), .gout(), .pout(), .cout(cout[2:0]));
   gp4 u2(.gin(gin[7:4]), .pin(pin[7:4]), .cin(cout[2]), .gout(), .pout(), .cout(cout[6:4]));

endmodule

module cla
  (input wire [31:0]  a, b,
   input wire         cin,
   output wire [31:0] sum);

   wire [31:0] p, g;
   p = a^b;
   g = a&b;
   // TODO: your code here
   gp8 u1(.gin(), .pin(), .cin(), .gout(), .pout(), .cout());
   gp8 u2(.gin(), .pin(), .cin(), .gout(), .pout(), .cout());
   gp8 u3(.gin(), .pin(), .cin(), .gout(), .pout(), .cout());
   gp8 u4(.gin(), .pin(), .cin(), .gout(), .pout(), .cout());


endmodule
