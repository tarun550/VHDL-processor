entity decoder is
  port (a,b,c:in bit;
  d1,d2,d3,d4,d5,d6,d7,d8:out bit);
end decoder;

architecture dec_arch of decoder is
begin
  d1<= (not a) and (not b) and (not c);
  d2<= (not a) and (not b) and (c);
  d3<= (not a) and (b) and (not c);
  d4<= (not a) and (b) and (c);
  d5<= (a) and (not b) and (not c);
  d6<= (a) and (not b) and (c);
  d7<= (a) and (b) and (not c);
  d8<= (a) and (b) and (c);
end dec_arch;

entity tbd is
end entity;

architecture testb of tbd is
component decoder is
  port (a,b,c:in bit;
  d1,d2,d3,d4,d5,d6,d7,d8:out bit);
end component;

signal in1,in2,in3,out11,out2,out3,out4,out5,out6,out7,out8: bit;
begin
  inst1: decoder port map (in1,in2,in3,out11,out2,out3,out4,out5,out6,out7,out8);
process
begin
in1<='0';
in2<='0';
in3<='0';
wait for 50 ps;
in1<='0';
in2<='0';
in3<='1';
wait for 50 ps;
in1<='0';
in2<='1';
in3<='0';
wait for 50 ps;
in1<='0';
in2<='1';
in3<='1';
wait for 50 ps;
in1<='1';
in2<='0';
in3<='0';
wait for 50 ps;
in1<='1';
in2<='0';
in3<='1';
wait for 50 ps;
in1<='1';
in2<='1';
in3<='0';
wait for 50 ps;
in1<='1';
in2<='1';
in3<='1';
wait for 50 ps;
end process;
end testb;    