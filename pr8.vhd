entity dff is
  port(d,clk: in bit;
       q: buffer bit);
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
  port(clk:in bit;
       inp:in bit_vector(3 downto 0);
       outp:buffer bit_vector(3 downto 0));
end entity;

architecture arch of ringcounter is 
component dff is 
  port(d,clk: in bit;
         q: buffer bit);
      end component;
begin 
inst1: dff port map(inp(0),clk,outp(3)); 
inst2: dff port map(inp(1),clk,outp(2));
inst3: dff port map(inp(2),clk,outp(1));
inst4: dff port map(inp(3),clk,outp(0));
end arch;

entity test is 
end entity;

architecture testbench of test is
component ringcounter is
  port ( clk:in bit;
       inp:in bit_vector(3 downto 0);
       outp:buffer bit_vector(3 downto 0));
end component;

signal clk,init:bit;
signal inp1,outp1:bit_vector(3 downto 0);
begin
  inst: ringcounter port map(clk,inp1,outp1);
  clk<=not clk after 10 ns;
  
process
begin
  init<='1';
  wait for 20 ns;
  init<='0'; wait for 400 ns;
end process;

process(clk,init)
  begin
      if(clk='1' and clk'event)  then
          if(init='1') then
             inp1<="0001";
           elsif(init='0') then
              inp1<=outp1;
          end if;
      end if;
end process;
end testbench;
           
  