-- Author: 			Oscar Petersson
-- Last update: 	28 October 2015
-- Description:	Keyboard module in the Grupp41 system.
--						Reads PS2-keyboard signals and forwards legitimate break inputs
--						coded in "one-hot" kb_input signal.
--

library ieee;
use ieee.std_logic_1164.all;

entity Keyboard is
  port ( rstn, clk, PS2_CLK, PS2_DAT : in std_logic;
         kb_input : out std_logic_vector( 4 downto 0 ));
end entity;

architecture rtl of Keyboard is
  signal PS2_CLK2, PS2_CLK2_old, PS2_DAT2, detected_fall, BREAKSET : std_logic;
  signal shiftreg : std_logic_vector( 9 downto 0 );
  signal kb_reg : std_logic_vector( 4 downto 0 );

  begin
  kb_input <= kb_reg;
  
    -- Sync input
    p1 : process(clk)
      begin
        if rising_edge(clk) then
          PS2_DAT2 <= PS2_DAT;
          PS2_CLK2 <= PS2_CLK;
          PS2_CLK2_old <= PS2_CLK2;
        end if;
      end process;

      detected_fall <= not PS2_CLK2 and PS2_CLK2_old;

    p2 : process(clk, rstn) begin
		-- Handle shiftregz
		if rstn = '0' then
			shiftreg <= (others => '1' );
			kb_reg <= (others => '0' );
		  
		elsif rising_edge(clk) then
			if detected_fall = '1' then
				shiftreg <= PS2_DAT2 & shiftreg( 9 downto 1 );
            
				if shiftreg(0) = '0' then -- if startbit (byte rdy)
					shiftreg <= (others => '1' );
            
					if shiftreg(8 downto 1) = "11110000" then -- if break, set BREAKSET and prepare to identify key released
						BREAKSET <= '1';
					 
					else 
						if BREAKSET = '1' then --BREAKSET set prev. loop, data relevant
							BREAKSET <= '0';
							case shiftreg(8 downto 1) is
								when "01110101" => --75&break up
									kb_reg <= "00001";
								when "01101011" => --6b&break left
									kb_reg <= "00010";
								when "01110010" => --72&break down
									kb_reg <= "00100";
								when "01110100" => --74&break right
									kb_reg <= "01000";
								when "01101001" => --69&break end
									kb_reg <= "10000";
								when others =>
									kb_reg <= "00000";
							end case;
 						end if;
                end if;			  
            end if;
        end if;
		  
		  if kb_reg /= "00000" then
			  kb_reg <= "00000";
		  end if;
		  
		end if;
	end process;
	
end architecture;
