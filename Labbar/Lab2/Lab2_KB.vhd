library ieee;
use ieee.std_logic_1164.all;

entity Lab2_KB is
	port( rstn, clk, PS2_CLK, PS2_DAT : in std_logic;
			HEX0, HEX6, HEX7 : out std_logic_vector( 6 downto 0 );
			LEDR 				  : out std_logic_vector( 7 downto 0 ));
end entity;

architecture rtl of Lab2_KB is
	signal PS2_CLK2, PS2_CLK2_old, PS2_DAT2, detected_fall : std_logic;
	signal shiftreg : std_logic_vector( 9 downto 0 );
	
begin
	-- Process 1: Synchronizing the input
	p1 : process(clk) begin
		if rising_edge(clk) then
			PS2_DAT2 <= PS2_DAT;
			PS2_CLK2 <= PS2_CLK;
			PS2_CLK2_old <= PS2_CLK2;
		end if;
	end process;
	
	detected_fall <= NOT PS2_CLK2 AND PS2_CLK2_old;
	
	-- Process 2: Handling shiftreg
	p2 : process(clk, rstn) begin
		if rstn = '0' then
			shiftreg <= ( others => '1' );
		elsif rising_edge(clk) then
			if detected_fall = '1' then
				shiftreg <= PS2_DAT2 & shiftreg( 9 downto 1 );
			end if;
		end if;
	end process;
	
	LEDR <= shiftreg( 7 downto 0 );
	
	with shiftreg( 7 downto 0 ) select HEX0 <=
		"1111001" when "00010110", -- 1
		"0100100" when "00011110", -- 2
		"0110000" when "00100110", -- 3
		"0011001" when "00100101", -- 4
		"0010010" when "00101110", -- 5
		"0000010" when "00110110", -- 6
		"1111000" when "00111101", -- 7
		"0000000" when "00111110", -- 8
		"0010000" when "01000110", -- 9
		"1000000" when "01000101", -- 0
		"0000110" when others; -- Else 'E'
	
	HEX7 <= "0011001"; -- 4
	HEX6 <= "0100100"; -- 2

end architecture;