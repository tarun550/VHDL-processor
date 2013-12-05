entity dff is
  port( d,clk:in bit;
  q: inout bit);
end dff;

architecture dff_arch of dff is
begin 
process(clk)
begin
 if (clk'event and clk='1') then
   q<=d;
end if;
end process;
end dff_arch;

entity ringcounter is
  port(clk1: in bit;
       inp : in bit_vector(3 downto 0);
       outp: inout bit_vector(3 downto 0));
 end entity;
   
architecture arch of ringcounter is
component dff is
port (d,clk: in bit;
       q: inout bit);
end component;
begin
inst3: dff port map(inp(0),clk1,outp(3));            
inst2: dff port map(inp(3),clk1,outp(2));
inst1: dff port map(inp(2),clk1,outp(1));
inst0: dff port map(inp(1),clk1,outp(0));
end architecture;

entity tbrc is
end entity;

architecture testbench of tbrc is
 component ringcounter is
   port( clk1:in bit;
   inp: in bit_vector(3 downto 0);
  outp: inout bit_vector(3 downto 0));
end component;

signal clk2,init: bit;
signal inp1,outp1: bit_vector(3 downto 0);
begin
inst: ringcounter port map(clk2,inp1,outp1);
clk2<=not clk2 after 10 ns;

process 
begin
init<='1';
wait for 20 ns;
init<='0';
wait for 400 ns;
end process;

process(clk2,init)
begin
  if(clk2='1' and clk2'event) then
      if(init='1') then
         inp1<="0001";
        elsif (init ='0') then
           inp1<=outp1;
         end if;
     end if; 
 end process;
 end testbench;   