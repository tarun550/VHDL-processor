entity tff is
  port(t,clk,clr: in bit;
  q:inout bit);
end tff;

architecture tff_arch of tff is
begin
process(clk,clr)  
begin
if(clr='0') then
   q<='0';
 elsif (clk'event and clk='1') then
   if(t<='0') then 
     q<='0';
   elsif (t<='1') then
     q<='1';
  end if;
end if;
end process;
end tff_arch;

entity tbt is
end entity;

architecture testt of tbt is
component tff is
port(t,clk,clr: in bit;q:inout bit);
end component;

signal t1,clk1,clr1,q1: bit;
begin
  inst1: tff port map(t1,clk1,clr1,q1);
process
begin
  clk1<=not clk1;
  wait for 20 ps;
  t1<=not t1 after 40 ps;
  clr1<=not clr1 after 80 ps;
end process;
end testt; 
    