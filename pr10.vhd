entity full1 is
  port (x,y,cinp: in bit;
         s,coutp: out bit);
end entity;

architecture f1arch of full1 is
begin
 s <= ((x xor y) xor cinp); 
 coutp <= ((x and y) or ((x xor y) and cinp));
 end architecture;
 
 entity full4 is
 port (a,b: in bit_vector(3 downto 0);
       cin: in bit;
       s: out bit_vector(3 downto 0);
       cout: out bit);
end entity;

architecture f4arch of full4 is
component full1 is
port (x,y,cinp: in bit;
         s,coutp: out bit);
end component;

signal c1,c2,c3:bit;
begin
fa1: full1 port map(a(0),b(0),cin,s(0),c1);
fa2: full1 port map(a(1),b(1),c1,s(1),c2);
fa3: full1 port map(a(2),b(2),c2,s(2),c3);
fa4: full1 port map(a(3),b(3),c3,s(3),cout);  
end architecture;

entity tstb is
end entity;

architecture testbenchaddr of tstb is
component full4 is 
port (a,b: in bit_vector(3 downto 0);
       cin: in bit;
       s: out bit_vector(3 downto 0);
       cout: out bit);
end component;
       
signal in1,in2,out1: bit_vector(3 downto 0);
signal cari,caro:bit;
begin  
inst1: full4 port map(in1,in2,cari,out1,caro);
process
begin
cari<='0';
in1<="0010";
in2<="1010";
wait for 50 ns;
in1<="1000";
in2<="1011";
wait for 50 ns; 
end process;
end architecture;    