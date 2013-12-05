entity dflip is 
 port(d,clk,clr: in bit;
 q: inout bit);
end dflip;

architecture dflip_arch of dflip is
begin 
  process(clk,clr)
    begin
      if(clr='1') then
         q<='0';
       elsif(clk='1' and clk'event ) then
           q<=d;
        end if;
 end process;
 end dflip_arch;
 
 entity register8 is
 port(a:in bit_vector(7 downto 0);
       clk, clr: in bit;
       s:inout bit_vector(7 downto 0));
end register8;

architecture arch of register8 is
component dflip is
port(d,clk,clr: in bit;
      q:inout bit);
end component;
begin
reg1 : dflip port map(a(0),clk,clr,s(0));                 
reg2 : dflip port map(a(1),clk,clr,s(1));
reg3 : dflip port map(a(2),clk,clr,s(2));
reg4 : dflip port map(a(3),clk,clr,s(3));
reg5 : dflip port map(a(4),clk,clr,s(4));
reg6 : dflip port map(a(5),clk,clr,s(5));
reg7 : dflip port map(a(6),clk,clr,s(6));
reg8 : dflip port map(a(7),clk,clr,s(7));
end architecture;        

entity testreg is
end entity;

architecture tbreg of testreg is
component register8 is
 port (a:in bit_vector(7 downto 0);
          clk,clr:in bit;
          s:inout bit_vector (7 downto 0));
 end component;
 
 signal b,r: bit_vector(7 downto 0);
 signal clk1,clr1: bit;
 
 begin
   inst1: register8 port map(b,clk1,clr1,r);
   process
     begin
       clk1<=not clk1;
       wait for 20 ns;
       clr1<= not clr1 after 40 ns;
       b<="00000111";
     end process;
   end architecture;