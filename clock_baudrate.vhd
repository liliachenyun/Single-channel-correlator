----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    11:16:56 06/06/2018 
-- Design Name: 
-- Module Name:    clock_baudrate - Behavioral 
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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity clock_baudrate is
    port(
	      enable        : in std_logic;
	      clk_in       : in std_logic;
		   clk_baudrate : out std_logic
		  );
end clock_baudrate;

architecture Behavioral of clock_baudrate is

signal cnt_clk : std_logic_vector(9 downto 0) := (others => '0');

begin

    clk_baudrate_gen: process(clk_in, enable)
    begin
	     if (enable = '0') then
		      cnt_clk <= (others => '0');
				clk_baudrate <= '0';
		  else
            if rising_edge(clk_in) then
	             if (cnt_clk = "1101100011") then -- 100MHz/115200bdp=868 
		              clk_baudrate <= '1';
			           cnt_clk <= (others => '0');
		          else
		              cnt_clk <= cnt_clk + 1;
			           clk_baudrate <= '0';
		          end if;
				end if;
	     end if;
    end process;
	 
end Behavioral;

