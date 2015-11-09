library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

library work;

entity TB_analysis is
end entity;


architecture sim of TB_analysis is

	--in/out
	signal	clk,rstn		: std_logic := '1'; 						--System signals
	signal	lrsel 			: std_logic := '1'; 							--Sound signal, left/right select
	--signal	LC,RC			: signed(15 downto 0);					--Sound signal
	signal	LC				: signed(15 downto 0) := ( (12) => '1', others => '0' );
	signal	RC				: signed(15 downto 0) := ( (15) => '1', others => '0' );
	signal	vsync	 		: std_logic := '0';							--Timing signal
	signal	lbar 			: unsigned(7 downto 0);					--Outgoing signal to indicate how to draw the bar
	signal	rbar			: unsigned(7 downto 0);				--

	--internal signals
	
	--signal lrsel_old, lrsel_change 			: std_logic := '0';			--Detect new sample
	--signal ildac, irdac 					: signed(15 downto 0) ;--:= "1001110001001110";		--Internal signals for left/right dac
	--signal lafter, rafter, temp				: unsigned(41 downto 0); 	--
	--signal counter							: unsigned(5 downto 0) := "101010";
	--constant sound1	: signed(15 downto 0) := "0000000000000000";
	--constant sound2 : signed(15 downto 0) := "1000000000000000";
	--signal noob	: unsigned(7 downto 0);
  -- signals for clock generation:
  signal done : boolean := false;

 function s2str(x : signed) return string is begin
    return integer'image(to_integer(x));
  end function;

function s2str(x : unsigned) return string is begin
    return integer'image(to_integer(x));
  end function;

component Analysis is
	port(clk,rstn			: in std_logic; 					--System signals
			lrsel 			: in std_logic; 					--Sound signal, left/right select
			LC,RC			: in signed(15 downto 0);			--Sound signal
			vsync 			: in std_logic;						--Timing signal
			lbar 			: out unsigned(7 downto 0);			--Outgoing signal to indicate how to draw the bar
			rbar			: out unsigned(7 downto 0));	--
end component;




begin
	-- ### Clock generation part ###
  clk <= not clk after 10 ns when not done;
  lrsel <= not lrsel after 10240 ns when not done;
  vsync <= not vsync after 5120 ns when not done; -- 10240
  rstn <= '0', '1' after 50 ns;
  done <= false;--, true after 100 ms;
  --LC <= sound1;
  --RC <= sound2;
  
  
  LC <= LC - 1 after 12800 ns when not done;
  RC <= RC - 1 after 12800 ns when not done;
	
		
  
  process 
	begin
   -- wait for signals to stabilize, 1 us.
    wait for 1 us;


	wait for 2000 ns;
	--report "sound1=" & s2str(sound1) & " | lbar=" & s2str(noob) severity error;
	
	wait;
end process;

	DUT : Analysis port map(clk, rstn, lrsel, LC, RC, vsync, lbar, rbar);
end;

	
	