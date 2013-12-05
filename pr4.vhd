entity jk is 
port (j,k,clk,clr: in bit;
        q:inout bit);
end jk;

architecture arch_jk of jk is 
begin
  process(clk,clr)
    begin
   if(clr='1') then 
    q<='0';
  elsif(clk'event and clk ='1') then 
    if (j='0' and k='0') then 
     q<=q;
     elsif (j='0' and k='1') then 
       q<='0';
       elsif (j='1' and k='0') then 
       q<='1';
       elsif (j='1' and k='1') then 
       q<=not q; 
  end if;
end if;

end process;
end architecture;

entity tb is
end entity;

architecture testbench of tb is
component jk is
port (j,k,clk,clr: in bit;
        q:inout bit);
end component;
signal j1,k1,clk1,clr1,q1: bit;
begin
  jk1: jk port map(j1,k1,clk1,clr1,q1);
process
begin
clk1<=not clk1; wait for 20 ps;
j1<=not j1 after 40 ps;
k1<=not k1 after 80 ps;
clr1<=not clr1 after 160 ps;
end process;
end testbench;     