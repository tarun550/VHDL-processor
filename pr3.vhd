entity comp is
  port(a,b:in bit_vector(3 downto 0);
        e,g,l: out bit);
end comp;

architecture comp_arch of comp is
begin 
  e <= ( (a(3) xnor b(3)) and (a(2) xnor b(2)) and (a(1) xnor b(1)) and (a(0) xnor b(0)));
  l <= ( (not (a(3)) and b(3)) or ( (a(3)xnor b(3)) and (not a(2)and b(2)) ) OR ( (a(3) xnor b(3)) and (a(2) xnor b(2)) and (not a(1) and b(1)) ) or ( (a(3)xnor b(3)) and (a(2)xnor b(2)) and (a(1)xnor b(1)) and (not a(0) and b(0)) ));
  g <=  (( not b(3) and a(3)) or ((b(3)xnor a(3))and (not b(2) and a(2))) or ((b(3)xnor a(3)) and (b(2)xnor a(2)) and(not b(1) and a(1))) or ((b(3)xnor a(3)) and (b(2)xnor a(2)) and (b(1)xnor a(1)) and(not b(0) and a(0))));
end comp_arch;

entity tbc is
end entity;

architecture testc of tbc is
component comp is
  port(a,b:in bit_vector(3 downto 0);
        e,g,l: out bit);
end component;
  
signal in1,in2:bit_vector(3 downto 0);
signal gr,eq,le: bit;

begin 
  inst: comp port map(in1,in2,eq,gr,le);
 process
 begin
 in1<="0000";
 in2<="0101";
 wait for 100 ps;
 in1<="1001";
 in2<="0111";
 wait for 100 ps;
 in1<="0111";
 in2<="1101";
 wait for 100 ps;
 in1<="1111";
 in2<="1111";
 wait for 100 ps;
 end process;
 end testc; 