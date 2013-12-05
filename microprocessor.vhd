library	ieee;
use ieee.std_logic_1164.all;  
use ieee.std_logic_arith.all;			   
use ieee.std_logic_unsigned.all;

entity microprocessor is
port( 	cpu_clk:	in std_logic;
		cpu_rst:	in std_logic;
		cpu_output:	out std_logic_vector(15 downto 0)
);
end microprocessor;

architecture structure of microprocessor is

component datapath is
port(	clock_dp:	in std_logic;
		rst_dp:		in std_logic;
		imm_data:	in std_logic_vector(15 downto 0);
		mem_data: 	in std_logic_vector(15 downto 0);
		RFs_dp:		in std_logic_vector(1 downto 0);
		RFwa_dp:	in std_logic_vector(3 downto 0);
		RFr1a_dp:	in std_logic_vector(3 downto 0);
		RFr2a_dp:	in std_logic_vector(3 downto 0);
		RFwe_dp:	in std_logic;
		RFr1e_dp:	in std_logic;
		RFr2e_dp:	in std_logic;
		jp_en:		in std_logic;
		ALUs_dp:	in std_logic_vector(1 downto 0);
		oe_dp:		in std_logic;
		ALUz_dp:	out	std_logic;
		RF1out_dp:	out std_logic_vector(15 downto 0);
		ALUout_dp:	out std_logic_vector(15 downto 0);
		bufout_dp:	out	std_logic_vector(15 downto 0)
);
end component;

component ctrl_unit is		
port(	clock_cu:	in std_logic;
		rst_cu:		in std_logic;
		PCld_cu:	in std_logic;
		mdata_out: 	in std_logic_vector(15 downto 0);
		dpdata_out:	in std_logic_vector(15 downto 0);
		maddr_in:	out std_logic_vector(15 downto 0);		  
		immdata:	out std_logic_vector(15 downto 0);
		RFs_cu:		out	std_logic_vector(1 downto 0);
		RFwa_cu:	out	std_logic_vector(3 downto 0);
		RFr1a_cu:	out	std_logic_vector(3 downto 0);
		RFr2a_cu:	out	std_logic_vector(3 downto 0);
		RFwe_cu:	out	std_logic;
		RFr1e_cu:	out	std_logic;
		RFr2e_cu:	out	std_logic;
		jpen_cu:	out std_logic;
		ALUs_cu:	out	std_logic_vector(1 downto 0);	
		Mre_cu:		out std_logic;
		Mwe_cu:		out std_logic;
		oe_cu:		out std_logic
);
end component;

component memory is
port ( 	clock	: 	in std_logic;
		rst		: 	in std_logic;
		Mre		:	in std_logic;
		Mwe		:	in std_logic;
		address	:	in std_logic_vector(7 downto 0);
		data_in	:	in std_logic_vector(15 downto 0);
		data_out:	out std_logic_vector(15 downto 0)
);
end component;

signal addr_bus,mdin_bus,mdout_bus,immd_bus,rfout_bus: std_logic_vector(15 downto 0);  
signal mem_addr: std_logic_vector(7 downto 0);
signal RFwa_s, RFr1a_s, RFr2a_s: std_logic_vector(3 downto 0);
signal RFwe_s, RFr1e_s, RFr2e_s: std_logic;
signal ALUs_s, RFs_s: std_logic_vector(1 downto 0);
signal IRld_s, PCld_s, PCinc_s, PCclr_s: std_logic;
signal Mre_s, Mwe_s, jpz_s, oe_s: std_logic;

begin
	
	mem_addr <= addr_bus(7 downto 0); 
	
	Unit0: ctrl_unit port map(	cpu_clk,cpu_rst,PCld_s,mdout_bus,rfout_bus,addr_bus,
								immd_bus, RFs_s,RFwa_s,RFr1a_s,RFr2a_s,RFwe_s,
								RFr1e_s,RFr2e_s,jpz_s,ALUs_s,Mre_s,Mwe_s,oe_s);
	Unit1: datapath port map(	cpu_clk,cpu_rst,immd_bus,mdout_bus,
								RFs_s,RFwa_s,RFr1a_s,RFr2a_s,RFwe_s,RFr1e_s,
								RFr2e_s,jpz_s,ALUs_s,oe_s,PCld_s,rfout_bus,
								mdin_bus,cpu_output);
	Unit2: memory port map(	cpu_clk,cpu_rst,Mre_s,Mwe_s,mem_addr,mdin_bus,mdout_bus);

end structure;

