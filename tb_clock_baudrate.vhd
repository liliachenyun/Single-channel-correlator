LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY tb_clock_baudrate IS
END tb_clock_baudrate;
 
ARCHITECTURE behavior OF tb_clock_baudrate IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT clock_baudrate
    PORT(
         clk_100M : IN  std_logic;
         clk_baudrate : OUT  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal clk_100M : std_logic := '0';

 	--Outputs
   signal clk_baudrate : std_logic;

   -- Clock period definitions
   constant clk_100M_period : time := 10 ns;
   constant clk_baudrate_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: clock_baudrate PORT MAP (
          clk_100M => clk_100M,
          clk_baudrate => clk_baudrate
        );

   -- Clock process definitions
   clk_100M_process :process
   begin
		clk_100M <= '0';
		wait for clk_100M_period/2;
		clk_100M <= '1';
		wait for clk_100M_period/2;
   end process;

 

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
      wait for 100 ns;	

      wait for clk_100M_period*10;

      -- insert stimulus here 
      
      wait;
   end process;

END;
