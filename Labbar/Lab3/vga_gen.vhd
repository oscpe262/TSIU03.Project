library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity vga_gen is
	Port ( clk : in std_logic;
			rstn : in std_logic;
			pixrg :  in unsigned(7 downto 0);
         blank2 : in std_logic;
         vga_r :  out unsigned(9 downto 0);
         vga_g :  out unsigned(9 downto 0);
         vga_b :  out unsigned(9 downto 0);
         vga_blank : out std_logic;
         vga_sync  : out std_logic);
end vga_gen;

architecture behave of vga_gen is
	signal r, b : unsigned (1 downto 0);
	signal g		: unsigned (2 downto 0);
	signal gray	: unsigned (9 downto 0);
begin
	r <= pixrg(6 downto 5);
	g <= pixrg(4 downto 2);
	b <= pixrg(1 downto 0);
	gray <= pixrg(6 downto 0) & pixrg(6 downto 4); -- 7-bit gray value "resized" to 10-bit
	
	process (clk, rstn)
	begin
		if (rstn = '0') then
			vga_r <= "0000000000";
			vga_g <= "0000000000";
			vga_b <= "0000000000";
			vga_blank <= '0';
		elsif falling_edge(clk) then
			if pixrg(7) = '1' then -- Colour!
				vga_r <= (r & r & r & r & r); -- 2-bit red value "resized" to 10-bit
				vga_g <= (g & g & g & g(2)); -- 3-bit green value - " -
				vga_b <= (b & b & b & b & b); -- 2-bit blue value - " -
			else							-- Grayscale
				vga_r <= gray;
				vga_g <= gray;
				vga_b <= gray;
			end if;
			vga_blank <= blank2; -- Pipelining and forwarding of the 'blank' signal
		end if;
	end process;
	
	vga_sync <= '0'; -- Constant.
end behave;
