LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY tb_test_UART_TX IS
END tb_test_UART_TX;
 
ARCHITECTURE behavior OF tb_test_UART_TX IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT test_UART
    PORT(
         clk_in     : in std_logic;
			en_general : in std_logic;
			data_out_s   : out std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal clk_in     : std_logic := '0';
   signal en_general : std_logic := '0';

 	--Outputs
   signal data_out_s : std_logic;

   -- Clock period definitions
   constant clk_in_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: test_UART PORT MAP (
          clk_in     => clk_in,
          en_general => en_general,
          data_out_s   => data_out_s
        );

   -- Clock process definitions
   clk_in_process :process
   begin
		clk_in <= '0';
		wait for clk_in_period/2;
		clk_in <= '1';
		wait for clk_in_period/2;
   end process;
 

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
      wait for 100 ns;	

      wait for clk_in_period*10;

      -- insert stimulus here 
      en_general <= '1';
      wait;
   end process;

END;
