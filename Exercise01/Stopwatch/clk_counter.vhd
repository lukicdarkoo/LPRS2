-------------------------------------------------------------------------------
--  Odsek za racunarsku tehniku i medjuracunarske komunikacije
--  Autor: LPRS2  <lprs2@rt-rk.com>                                           
--                                                                             
--  Ime modula: timer_counter                                                          
--                                                                             
--  Opis:                                                               
--                                                                             
--    Modul odogvaran za indikaciju o proteku sekunde
--                                                                             
-------------------------------------------------------------------------------
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;

ENTITY clk_counter IS GENERIC(
                              -- maksimalna vrednost broja do kojeg brojac broji
                              -- max_cnt : STD_LOGIC_VECTOR(25 DOWNTO 0) := "10111110101111000010000000" -- 50 000 000
										max_cnt : STD_LOGIC_VECTOR(25 DOWNTO 0) := "00000000000000000000010000"
                             );
                      PORT   (
                               clk_i     : IN  STD_LOGIC; -- ulazni takt
                               rst_i     : IN  STD_LOGIC; -- reset signal
                               cnt_en_i  : IN  STD_LOGIC; -- signal dozvole brojanja
                               cnt_rst_i : IN  STD_LOGIC; -- signal resetovanja brojaca (clear signal)
                               one_sec_o : OUT STD_LOGIC  -- izlaz koji predstavlja proteklu jednu sekundu vremena
                             );
END clk_counter;

ARCHITECTURE rtl OF clk_counter IS


COMPONENT reg 
	is generic(
		WIDTH    : positive := 26;
		RST_INIT : integer := 0
	);
	port
	(
	i_clk  : in  std_logic;
	in_rst : in  std_logic;
	i_d    : in  std_logic_vector(WIDTH-1 downto 0);
	o_q    : out std_logic_vector(WIDTH-1 downto 0)
	);
END COMPONENT reg;

SIGNAL   counter_r : STD_LOGIC_VECTOR(25 DOWNTO 0) := (others => '0');
SIGNAL   counter_r_successor : STD_LOGIC_VECTOR(25 DOWNTO 0);
SIGNAL   counter_r_successor_en : STD_LOGIC_VECTOR(25 DOWNTO 0);
SIGNAL   counter_r_successor_rst : STD_LOGIC_VECTOR(25 DOWNTO 0);


BEGIN

i_reg: reg PORT MAP (
                i_clk  => clk_i,
                in_rst => not rst_i,
                i_d    => counter_r,
                o_q   => counter_r_successor_rst
                );


--process (clk_i, rst_i) begin
--	if (rst_i = '1') then
--		counter_r <= (others => '0');
--	elsif (rising_edge(clk_i)) then
--		counter_r <= counter_r_successor_rst;
--	end if;
--end process;

counter_r_successor <= counter_r + 1 when counter_r < max_cnt - 1 else
							(others => '0');
							
counter_r_successor_en <= counter_r_successor when cnt_en_i = '1' else
							counter_r;
							
counter_r_successor_rst <= counter_r_successor_en when cnt_rst_i = '0' else
							(others => '0');
							
one_sec_o <= '1' when counter_r = max_cnt - 1 else '0';

END rtl;