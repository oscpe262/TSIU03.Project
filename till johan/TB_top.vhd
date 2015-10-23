library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

library work;

entity TB_top is
end entity;

architecture sim of TB_top is
  -- stimuli signals:
  signal clk : std_logic := '1'; -- start with one. Give rising edge at even times.
  signal rstn : std_logic;
  -- SRAM signals:
  signal sram_addr : unsigned(17 downto 0);
  signal sram_data : unsigned(15 downto 0);
  signal sram_we, sram_oe, sram_ce, sram_lb, sram_ub : std_logic;
  -- VGA signals:
  signal vga_r, vga_g, vga_b : unsigned(9 downto 0);
  signal hsync, vsync, vga_clk, vga_blank, vga_sync : std_logic;
  
  -- Signals for simulating the VGA DAC:
  -- (*1=delayed DAC input, *2=next pipeline stage. See comment
  --  section "VGA_clk delta problem" in bottom of the file).
  signal blank1, blank2 : std_logic;
  signal pixcode1, pixcode2 : unsigned(6 downto 0); -- a kind of color code.
  
  -- Signals for horizontal timing:
  -- (nothing, it uses blank2 and hsync only)
  
  -- Signals for vertical timing:
  signal hsync_del : std_logic; -- hsync delayed 250 pixels
  signal line_cnt : integer := 0; -- count hcnt pulses.
  
  -- Other simulation signals:
  signal done_h, done_v, done_c : boolean := false; -- the three main sanity processes
  
  component VGA_contr is 
    port(fpga_clk,KEY0 : in  std_logic;
         sram_data : in  unsigned(15 DOWNTO 0);
         hsync, vsync : out std_logic;
         sram_ce, sram_oe, sram_lb, sram_ub, sram_we : out std_logic;
         vga_clk, vga_blank, vga_sync : out std_logic;
         HEX6, HEX7 : out std_logic_vector(0 TO 6);
         sram_addr : out unsigned(17 DOWNTO 0);
         vga_b, vga_g, vga_r : out  unsigned(9 DOWNTO 0));
  end component;
  component TB_SRAM is
    port(sram_addr : in unsigned(17 downto 0);
        sram_data : inout unsigned(15 downto 0);
        sram_we, sram_oe, sram_ce, sram_lb, sram_ub : in  std_logic);
  end component;
begin
  -- Clock and reset stimuli:
  clk <= not clk after 10 ns when not (done_h and done_v and done_c); -- period = 20 ns <=> freq = 50 MHz
  rstn <= '0', '1' after 101 ns;
  
  -- Instantiations:
  DUT : VGA_contr port map(
        fpga_clk => clk, KEY0 => rstn,
        sram_data => sram_data,
        hsync => hsync, vsync => vsync,
        sram_ce => sram_ce, sram_oe => sram_oe, sram_lb => sram_lb,
        sram_ub => sram_ub, sram_we => sram_we,
        vga_clk => vga_clk, vga_blank => vga_blank, vga_sync => vga_sync,
        sram_addr => sram_addr,
        vga_b => vga_b, vga_g => vga_g, vga_r => vga_r);
  iSRAM : TB_SRAM port map(
        sram_addr => sram_addr, sram_data => sram_data,
        sram_we => sram_we, sram_oe => sram_oe, sram_ce => sram_ce,
        sram_lb => sram_lb, sram_ub => sram_ub);
  
  -- Simulate the VGA DAC (ADC7123) chip:
  -- Delay the input, see comment section "VGA_clk delta problem" at bottom.
  blank1 <= vga_blank after 1 ns;
  pixcode1 <= vga_r(9 downto 3) after 1 ns; -- decode the color
  process(vga_clk) begin
    if rising_edge(vga_clk) then
      blank2 <= blank1;
      pixcode2 <= pixcode1;
    end if;
  end process;
  
  -- Sanity check: Constants.
  process begin
    wait for 1 us; -- let it stabalize
    assert vga_sync = '0' report "vga_sync error" severity error;
    wait; -- wait forever
  end process;
  
  -- Sanity check: Pixel clock
  clk_timing_p : process
    variable t0,t1 : time;
  begin
    -- make sure things stabalizes.
    wait for 1 us;
    -- collect timing ("NOW" = current simulation time):
    wait until rising_edge(vga_clk); t0 := NOW;
    wait until rising_edge(vga_clk); t1 := NOW;
    -- present result to user:
    if t1-t0 = 40 ns then
      report "VGA_clk timing: OK" severity note;
    else
      report "VGA_clk timing: NOK" severity error;
    end if;
    wait; -- wait forever
  end process;
  
  -- Sanity check: Horizontal timing
  h_timing_p : process
    variable t0,t1,t2,t3,t4 : time;
    variable tmp, ta,tb,tc,td : time;
  begin
    -- make sure things stabalizes.
    wait for 1 us;
    wait until hsync='0';
    
    -- collect timing ("NOW" = current simulation time):
    -- "so"/"eo" = "start of"/"end of"
    wait until blank2='1'; t0 := NOW; -- so pic
    wait until blank2='0'; t1 := NOW; -- eo pic
    wait until hsync='0';  t2 := NOW; -- so hsync
    wait until hsync='1';  t3 := NOW; -- eo hsync
    wait until blank2='1'; t4 := NOW; -- so pic.
    
    -- present result to user:
    -- each pixel is 40 ns long. Time = #pixels*40ns
    -- visible area = t1-t0 long, should be 640*40ns.
    --if tc = 640*40 ns and td = 15*40 (600ns )ns and ta = 95*40 ns and tb = 48*40 ns then
    if t1-t0 = 640*40 ns and t2-t1 = 15*40 ns and t3-t2 = 95*40 ns and t4-t3 = 48*40 ns then
      report "Horizontal timing: OK" severity note;
    else
      -- You can change this message to include the timings.
      -- Use e.g. time'image(t1-t0) to convert to a string
      report "Horizontal timing: NOK" & " t1-t0  " & time'image(t1-t0) & " t2-t1  " & time'image(t2-t1) & " t3-t2  " & time'image(t3-t2) & " t4-t3  " & time'image(t4-t3) severity error;
    end if;
    done_h <= true;
    wait;
  end process;
  
  -- Sanity check: Vertical timing (check during rising_edge(hsync)
  hsync_del <= transport hsync after 250 * 40 ns;
  line_cnt <= line_cnt + 1 when rising_edge(hsync); -- line starts with hsync. Increase then.
  
  process
    variable t0,t1,t2,t3,t4 : integer;
  begin
    wait for 1 us; -- make sure things stabalizes.
    wait until rising_edge(hsync_del) and vsync = '0'; -- wait for vsync;
    wait until rising_edge(hsync_del) and blank2 = '1'; t0 := line_cnt; -- so pic
    wait until rising_edge(hsync_del) and blank2 = '0'; t1 := line_cnt; -- eo pic
    wait until rising_edge(hsync_del) and vsync = '0';  t2 := line_cnt; -- so vsync
    wait until rising_edge(hsync_del) and vsync = '1';  t3 := line_cnt; -- eo vsync
    wait until rising_edge(hsync_del) and blank2 = '1'; t4 := line_cnt; -- so pic
    
    -- verify timing:
    --if tc = 480 and td = 10 and ta = 2 and tb = 33 then
    if t1-t0 = 480 and t2-t1 = 10 and t3-t2 = 2 and t4-t3 = 33 then
      report "Vertical timing: OK" severity note;
    else
      -- You can change this message to include the timings.
      -- Use e.g. integer'image(t1-t0) to convert to a string
      report "Vertical timing: NOK   t2-t1   " & integer'image(t2-t1) & "  t3-t2: " & integer'image(t3-t2) & " t4-t3  " & integer'image(t4-t3)  severity error;
    end if;
    done_v <= true;
    wait;
  end process;
  
  -- Sanity check: Colors (Five pixels in screen)
  process
    variable err_code : integer := 0;
  begin
    wait for 1 us; -- make sure things stabalizes.
    wait until falling_edge(vsync); -- wait for a new frame.
    -- first line:
    wait until rising_edge(blank2); -- wait for the picture to start.
    wait until falling_edge(vga_clk); -- wait until middle of pixel
    if pixcode2 /= 4 then err_code := 14; end if ;-- row 1, col 1: value=4
    wait until falling_edge(vga_clk); -- middle of next pixel
    if pixcode2 /= 5 then err_code := 15; end if ;-- row 1, col 2: value=5
    wait until falling_edge(vga_clk); -- middle of next pixel
    if pixcode2 /= 2 then err_code := 12; end if ;-- row 1, col 3: value=2
    -- second line:
    wait until rising_edge(blank2);   -- wait for next line
    wait until falling_edge(vga_clk); -- wait until middle of pixel
    if pixcode2 /= 6 then err_code := 26; end if ;-- row 2, col 1: value=6
    wait until falling_edge(vga_clk); -- middle of next pixel
    if pixcode2 /= 7 then err_code := 27; end if ;-- row 2, col 2: value=7
    wait until falling_edge(vga_clk); -- middle of next pixel
    if pixcode2 /= 2 then err_code := 22; end if ;-- row 2, col 3: value=2
    
    -- present result:
    if err_code = 0 then
      report "Color check: OK" severity note;
    else
      report "Color check: NOK " & integer'image(err_code) severity error;
    end if;
    -- Suggested debug method, if you have an error you can't see in the waveform:
    -- * Change the "all_ok" variable into err_code : integer := 0.
    -- * Instead of all_ok := false, set err_code := <unique code number>.
    -- * If err_code = 0 then "OK", else "NOK: " & integer'image(err_code).
    done_c <= true;
    wait;
  end process;
  
  -- Three extra sanity checks (never the wrong colors):
  -- 1. SRAM is padded with pixel value 3. This should never be sent to the screen.
  process begin
    wait for 1 us; -- make sure things stabalize.
    -- hope that this will wait forever:
    wait until falling_edge(vga_clk) and pixcode2=3 and blank2='1';
    report "Pixel Error: out-of-screen values." severity error;
    wait;
  end process;
  -- 2. SRAM can only reply values 2..7. Anything else is something wrong.
  process begin
    wait for 1 us;
    wait until falling_edge(vga_clk) and (pixcode2 < 2 or 7 < pixcode2) and blank2 = '1';
    report "Pixel Error: invalid pixel value." severity error;
    wait;
  end process;
  -- 3. Always grayscale image:
  process begin
    wait for 1 us;
    wait until falling_edge(vga_clk) and (vga_r /= vga_g or vga_r /= vga_b) and blank2 = '1';
    report "Pixel Error: It's colored." severity error;
    wait;
  end process;
end architecture;

-- ###### VGA_clk delta problem #########
-- The VGA_clk is used to clock all signals in the VGA_cntrl, as well as the signals
-- simulated video DAC input signals. However, the VGA_clk output signal from VGA_cntrl
-- is one delta cycle later than the one used to clock the internal signals, since:
-- | vga_clk_internal <= fpga_clk/2; -- well, you know what I mean.
-- | internal_sigs <= yada @ rising_edge(vga_clk_internal);
-- | vga_clk <= vga_clk_internal;
-- The result is that the output signals and vga_clk is changed in the same delta cycle.
-- Hence the output must be delayed a little bit before being clocked in into the
-- VGA DAC input registers.

