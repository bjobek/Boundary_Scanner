----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 06.02.2020 13:44:18
-- Design Name: 
-- Module Name: TopBlock_tb - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity TopBlock_tb is
--  Port ( );
end TopBlock_tb;

architecture Behavioral of TopBlock_tb is

component TopBlock is
port (
 TDI,TMS, TCK : in std_logic;
  DIN : in std_logic_vector(5 downto 0);
  DOUT : out std_logic_vector( 5 downto 0);
  TDO : out std_logic
  
);
end component;

constant clock_time : time := 10ns;

signal TDI,TMS,TCK,TDO : std_logic;
signal DIN,DOUT : std_logic_vector(5 downto 0);

begin

uut: TopBlock 
port map(
TDI=>TDI, TDO=>TDO, TMS=>TMS, TCK=>TCK, DIN=>DIN, DOUT=>DOUT

);

clk_proc : process
begin
tck<='0';
wait for clock_time/2;
tck<='1';
wait for clock_time/2;
end process;

process
begin
DIN<= (others=>'0');
TDI <= '0';
TMS<='1';
wait for clock_time;
tms<='0';
wait for clock_time*2;
TMS<='1'; -- run test idle
wait for clock_time;
TMS<='1'; -- select dr scan
wait for clock_time;
TMS<='0'; -- select ir scan

wait for clock_time;
TMS<='0'; -- capture ir

wait for clock_time;
TMS<='1'; -- shift ir
TDI<='0';
wait for clock_time;


TMS<='1'; -- exit-1 ir
tdi<='1';
wait for clock_time;
TMS<='1'; -- update ir
TDI<='0';
wait for clock_time;
TMS<='0';-- select DR scan
wait for clock_time;
TMS<='0';-- Capture DR
TDI<='1';
wait for clock_time;
TMS<='0'; -- shift DR * 7
wait for clock_time*6;
tms<='1';
wait for clock_time;
tdi<='0';
tms <='1'; --exit-1DR
wait for clock_time;
tms<='0'; -- udate dr
-----------------------------
wait for clock_time*2;
-- run Test/Idle;
TMS<='1'; -- run test idle
wait for clock_time;
TMS<='1'; -- select dr scan
wait for clock_time;
TMS<='0'; -- select ir scan

wait for clock_time;
TMS<='0'; -- capture ir
tdi<='0';
wait for clock_time;
TMS<='1'; -- shift ir
TDI<='0';
wait for clock_time;


TMS<='1'; -- exit-1 ir
TDI<='0';
wait for clock_time;
TMS<='1'; -- update ir

wait for clock_time;
------------------
TMS<='0';-- select DR scan
wait for clock_time;
TMS<='1';-- Capture DR
--TDI<='1';
wait for clock_time;


tms <='1'; --exit-1DR
wait for clock_time;
tms<='1'; -- udate dr
wait for clock_time*5;
---- tlr
end process;

end Behavioral;
