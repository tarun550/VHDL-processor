entity gates is
  port(x,y:in bit;
  s1,s2,s3,s4,s5,s6:out bit);
end gates;

architecture gate_arch of gates is
begin
  s1<= x and y;
  s2<= x or y;
  s3<= x nand y;
  s4<= x nor y;
  s5<= x xor y;
  s6<= x xnor y;
end gate_arch;

entity tb is
end entity;

architecture test of tb is
component gates is 
port(x,y:in bit;
  s1,s2,s3,s4,s5,s6:out bit);
end component;

signal in1,in2,ao,oo,no,nao,xo,xno : bit;
begin
inst1:gates port map 
(in1,in2,ao,oo,no,nao,xo,xno);
process
begin
  in1<='0';
  in2<='0';
  wait for 20 ps;
  in1<='0';
  in2<='1';
  wait for 20 ps;
  in1<='1';
  in2<='0';
  wait for 20 ps;
  in1<='1';
  in2<='1';
  wait for 20 ps;
end process;
end test;