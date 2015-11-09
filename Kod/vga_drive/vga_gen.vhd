library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity vga_gen is
  Port ( clk,rstn : in std_logic;
         pixrg :  in unsigned(7 downto 0);
         blank2 : in std_logic;
         vga_r :  out unsigned(9 downto 0);
         vga_g :  out unsigned(9 downto 0);
         vga_b :  out unsigned(9 downto 0);
         vga_blank : out std_logic;
         vga_sync  : out std_logic);
end vga_gen;

architecture behave of vga_gen is
	--signal gray : unsigned(9 downto 0);
	signal vga_ri, vga_gi, vga_bi : unsigned(9 downto 0);
	--signal vga_blanki std_logic;
begin
	process(clk,rstn) begin
		if (rstn ='0') then
			vga_ri <= (others => '0');
			vga_bi <= (others => '0');
			vga_gi <= (others => '0');
		elsif (falling_edge(clk)) then
		
			if (pixrg(7) = '1') then
				vga_bi <= (pixrg(1 downto 0) & pixrg(1 downto 0) & pixrg(1 downto 0) & pixrg(1 downto 0) & pixrg(1 downto 0));
				vga_ri <= (pixrg(6 downto 5) & pixrg(6 downto 5) & pixrg(6 downto 5) & pixrg(6 downto 5) & pixrg(6 downto 5));
				vga_gi <= (pixrg(4 downto 2) & pixrg(4 downto 2) & pixrg(4 downto 2) & pixrg(4));
			else
				vga_bi <= pixrg(6 downto 0) & pixrg(6 downto 4);
				vga_ri <= pixrg(6 downto 0) & pixrg(6 downto 4);
				vga_gi <= pixrg(6 downto 0) & pixrg(6 downto 4);
			end if; 
			vga_blank <= blank2;
		end if; 
	--vga_blank <= blank2;
	end process;
	
	vga_b <= vga_bi;
	vga_r <= vga_ri;
	vga_g <= vga_gi; 
	vga_sync <= '0'; 
end behave;
