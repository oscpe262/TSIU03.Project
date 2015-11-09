library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity blank_video is
  Port ( vcnt : in unsigned(9 downto 0);
         hcnt : in unsigned(9 downto 0);
         blank : out std_logic);
end blank_video;

architecture rtl of blank_video is
  --signal blanki : std_logic := '1';
begin
	
blank <= '0' when (vcnt > 479) or (hcnt > 639) else '1';

--process(vcnt,hcnt) 
--	begin
--		if (vcnt = 797) then 
--			if (hcnt = 654) then
--			blanki <= '0';
--			end if;
--		else
--			blanki <= '1';
--		end if;
--	end process; 
--blank <=  blanki; 
end rtl;
