entity dff is
  port( d,clk,clr:in bit;
  q: inout bit);
end dff;

architecture dff_arch of dff is
begin 
process(clk,clr)
begin
if(clr='1') then
   q<='0';
 elsif (clk'event and clk='1') then
   if (d='0') then
     q<=q;
    elsif (d='1') then
     q<= not q;
    end if;
end if;
end process;
end dff_arch;

entity tbs is
end entity;

architecture testbench of tbs is
 component dff is
   port( d,clk,clr:in b
  q: inout bit);
end component;

signal d1,clk1,clr1,q1: bit;
begin
  d12: dff port map(d1,clk1,clr1,q1);
process 
begin
 clk1<=not clk1;
 wait for 20 ps;
 d1<=not d1 after 40 ps;
 clr1<=not clr1 after 80 ps;
 end process;
 end testbench;   