-------------------------------------------------------------------------------
--  Odsek za racunarsku tehniku i medjuracunarske komunikacije
--  Autor: LPRS2  <lprs2@rt-rk.com>                                           
--                                                                             
--  Ime modula: timer_counter                                                           
--                                                                             
--  Opis:                                                               
--                                                                             
--    Modul broji sekunde i prikazuje na LED diodama                                         
--                                                                             
-------------------------------------------------------------------------------
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;

ENTITY timer_counter 
IS GENERIC (
	max_cnt: STD_LOGIC_VECTOR(7 DOWNTO 0) := "11111111" -- 255
);
PORT (
	clk_i     : IN STD_LOGIC; -- ulazni takt
	rst_i     : IN STD_LOGIC; -- reset signal 
	one_sec_i : IN STD_LOGIC; -- signal koji predstavlja proteklu jednu sekundu vremena 
	cnt_en_i  : IN STD_LOGIC; -- signal dozvole brojanja                              
	cnt_rst_i : IN STD_LOGIC; -- signal resetovanja brojaca (clear signal)
	led_o     : OUT STD_LOGIC_VECTOR(7 DOWNTO 0) -- izlaz ka led diodama
);
END timer_counter;

ARCHITECTURE rtl OF timer_counter IS

SIGNAL counter_r : STD_LOGIC_VECTOR(7 DOWNTO 0) := (others => '0');
SIGNAL counter_r_successor: STD_LOGIC_VECTOR(7 DOWNTO 0);
SIGNAL counter_r_successor_en: STD_LOGIC_VECTOR(7 DOWNTO 0);
SIGNAL counter_r_successor_rst : STD_LOGIC_VECTOR(7 DOWNTO 0);

BEGIN

process(clk_i, rst_i)
begin	
	if(rst_i = '1') then
		counter_r <= (others => '0');
	elsif(rising_edge(clk_i)) then
		counter_r <= counter_r_successor_rst;
	end if;	
end process;


counter_r_successor <= counter_r + 1 when one_sec_i = '1' else
							counter_r;
							
counter_r_successor_en <= counter_r_successor when cnt_en_i = '1' else
							counter_r;
							
counter_r_successor_rst <= counter_r_successor_en when cnt_rst_i = '0' else
							(others => '0');
							
led_o <= counter_r_successor_rst;

END rtl;