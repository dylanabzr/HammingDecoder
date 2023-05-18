module FourParity(input logic[4:1] d, output logic p);
  assign p = ((d[1] ^ d[2]) ^ d[3]) ^ d[4];
endmodule
module FiveParity(input logic[5:1] d, output logic p);
  assign p = (((d[1] ^ d[2]) ^ d[3]) ^ d[4]) ^ d[5];
endmodule
module TestHammingParity(input logic [8:1] d, output logic[4:1] p);
  logic[5:1] dw;
  assign dw = {d[7],d[5:4],d[2:1]};
  FiveParity p01(dw, p[1]);
  logic[5:1] dx;
  assign dx = {d[7:6], d[4:3], d[1]};
  FiveParity p02(dx, p[2]);
  logic[4:1] dy;
  assign dy = {d[8],d[4:2]};
  FourParity p03(dy, p[3]);
  logic[4:1] dz;
  assign dz = {d[8:5]};
  FourParity p04(dz, p[4]);
endmodule
module DecodeHamming(input logic[12:1] bits, output logic[8:1]dados);
  logic[4:1] s;
  logic[4:1] p;
  logic[8:1] d;
  logic[4:1] dp;
  assign d = {bits[12:9], bits[7:5], bits[3]};
  assign dp = {bits[8], bits[4], bits[2:1]};
  TestHammingParity hp01(d, p);
  assign s = dp ^ p;
  always_comb
    begin
      if (s == 4'b0011)
        dados[1] = ~bits[3];
      else
        dados[1] = bits[3];
      if ( s == 4'b0101)
        dados[2] = ~bits[5];
      else
        dados[2] = bits[5];
      if (s == 4'b0110)
        dados[3] = ~bits[6];
      else
        dados[3] = bits[6];
      if (s == 4'b0111)
        dados[4] = ~bits[7];
      else
        dados[4] = bits[7];
      if (s == 4'b1001)
        dados[5] = ~bits[9];
      else
        dados[5] = bits[9];
      if (s == 4'b1010)
        dados[6] = ~bits[10];
      else
        dados[6] = bits[10];
      if (s == 4'b1011)
        dados[7] = ~bits[11];
      else
        dados[7] = bits[11];
      if (s == 4'b1100)
        dados[8] = ~bits[12];
      else
        dados[8] = bits[12];
    end    
endmodule
