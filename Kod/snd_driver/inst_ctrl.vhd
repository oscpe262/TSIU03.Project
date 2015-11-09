library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity Ctrl is 
	port(	clk, rstn 					: in std_logic;
			mclk, bclk, men			: out std_logic;
			SCCnt 						: out unsigned(1 downto 0);
			BitCnt						: out unsigned(4 downto 0);
			adclrc, daclrc, lrsel  	: out std_logic);
end entity;

architecture Ctrl_Arch of Ctrl is
	signal cntr : unsigned(9 downto 0) := "0000000000";
begin
		process(clk, rstn) begin
			if rstn = '0' then
				cntr <= (others => '0');
			elsif rising_edge(clk) then
				cntr <= cntr + 1;					
			end if;
		end process;

		mclk 		<= not cntr(1);						-- OK
		bclk 		<=	cntr(3); 							-- OK
		men  		<= cntr(1) and cntr(0);				-- OK
		adclrc 	<= not cntr(9);						-- OK
		daclrc 	<= not cntr(9);						-- OK
		lrsel 	<= cntr(9);								-- OK
		BitCnt 	<= cntr(8 downto 4);					-- OK (phijo078 garanterad)
		SCCnt 	<= cntr(3 downto 2);
end architecture;
