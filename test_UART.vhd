----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    19:21:35 06/05/2018 
-- Design Name: 
-- Module Name:    test_UART_TX - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: 
--
-- Dependencies: 
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

library UNISIM;
use UNISIM.VComponents.all;
Library UNIMACRO;
use UNIMACRO.VComponents.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity test_UART is
    port(
	      clk_in     : in std_logic;
			en_general : in std_logic;
			data_out_s   : out std_logic
			);	      
end test_UART;

architecture Behavioral of test_UART is

-------clocks--------
signal clk_in_s     : std_logic;
signal clk_100M     : std_logic;
signal clk_baudrate : std_logic;
signal clk_reset    : std_logic;
signal clk_locked   : std_logic;

---control signals---
signal en_general_s : std_logic;
signal en_write     : std_logic;
signal en_TX        : std_logic;
signal act_TX       : std_logic;

signal fifo_pulse : std_logic_vector(7 downto 0);
signal data_out : std_logic;
type state is (ready, load, idle);
signal fifo_state : state := ready;

component clockman
    port(
         clk_in1  : in std_logic;
	      clk_out1 : out std_logic;
	      reset    : in std_logic;
	      locked   : out std_logic
	      );
end component;

component clock_baudrate
    port(
	      clk_in       : in std_logic;
		   clk_baudrate : out std_logic
		   );
end component;
	  
component signal_generation
    port(
         clk_100M   : in std_logic;
	      en_fifo    : in std_logic;
		   en_write   : in std_logic;
		   pulsein    : out std_logic_vector(7 downto 0)
		   );
end component;

component test_UART_TX is
    port(
	      clk_baudrate : in std_logic;
			fifo_in      : in std_logic_vector(7 downto 0);
			en_TX        : in std_logic;
			act_TX       : out std_logic; 
			data_TX      : out std_logic	
			);	      
end component;

begin

Inst_clock_100M: clockman
    port map(
	          clk_in1  => clk_in_s,
				 clk_out1 => clk_100M,
				 reset    => clk_reset,
				 locked   => clk_locked
				 ); 
				 
Inst_clock_baudrate: clock_baudrate
    port map(
	          clk_in       => clk_100M,
				 clk_baudrate => clk_baudrate
				 );

Inst_test_signal: signal_generation
    port map(
	          clk_100M => clk_100M,
				 en_fifo  => en_general_s,
				 en_write => en_write,
				 pulsein => fifo_pulse
				 );
				 
Inst_test_UART_TX: test_UART_TX
    port map(
	          clk_baudrate => clk_baudrate,
		       fifo_in      => fifo_pulse,
			    en_TX        => en_TX,
			    act_TX       => act_TX, 
			    data_TX      => data_out
				 );
				        
en_general_IBUF: IBUF
    generic map (IOSTANDARD => "LVCMOS33")
    port map (O => en_general_s, I => en_general);

clk_in_IBUF : IBUF
    generic map (IOSTANDARD => "LVCMOS33")
    port map (O => clk_in_s, I => clk_in);

fifo_out_OBUF : OBUF
    generic map (IOSTANDARD => "LVCMOS33")
    port map (O => data_out_s, I => data_out);

    fifo_load_proc: process(clk_100M)
    begin
	     if rising_edge(clk_100M) then
		      case fifo_state is
				when ready =>
				    if (act_TX = '0') then
					     en_TX <= '1';
						  en_write <= '1';
						  fifo_state <= load;
					 else 
					     en_TX <= '0';
						  en_write <= '0';
					 end if;
				when load =>
                en_write <= '0';
					 if (act_TX = '1') then
					     en_TX <= '0';
						  fifo_state <= idle;
					 else en_TX <= '1';
					 end if;
				when idle =>
				    if (act_TX <= '0') then
					     fifo_state <= ready;
					 end if;
				end case;
		  end if;
    end process;
	 
end Behavioral;

