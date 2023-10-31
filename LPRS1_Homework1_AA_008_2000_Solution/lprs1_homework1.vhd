
library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
-- Libraries.

entity lprs1_homework1 is
	port(
		i_x   :  in std_logic_vector(3 downto 0);
		i_y   :  in std_logic_vector(3 downto 0);
		i_z   :  in std_logic_vector(1 downto 0);
		i_sel :  in std_logic_vector(1 downto 0);
		o_res : out std_logic_vector(3 downto 0);
		o_cmp : out std_logic_vector(1 downto 0);
		o_enc : out std_logic_vector(1 downto 0)
	);
end entity;


architecture arch of lprs1_homework1 is
	-- Signals.
	signal s_dec    : std_logic_vector(3 downto 0);
	signal s_const1 : std_logic_vector(3 downto 0);
	signal s_sub    : std_logic_vector(3 downto 0);
	signal s_const0 : std_logic_vector(3 downto 0);
	signal s_shr    : std_logic_vector(3 downto 0);
	signal s_add    : std_logic_vector(3 downto 0);
	signal s_shl    : std_logic_vector(3 downto 0);
	signal s_mux    : std_logic_vector(3 downto 0);
	
begin
	-- Design.
	-- Pomerac u levo logicki za 2 bita--
	s_shl <= i_x(1 downto 0) & "00";
	
	-- Pomerac u desno aritmeticki --
	s_shr <= i_y(3) & i_y(3) & i_y(3 downto 2);
	
	-- Dekoder --
	s_dec <= "0001" when i_z = "00" else
				"0010" when i_z = "01" else
				"0100" when i_z = "10" else
				"1000" when i_z = "11" else
				"0000";
	
	-- Sabirac --
	s_add <= s_shl + s_shr;	
	s_sub <= s_dec - i_x;
	
	-- Dodela vrednosti --
	s_const0 <= "0100";
	s_const1 <= "1001";
	
	-- Multiplekser --
	s_mux <= s_const0 when i_sel = "00" else
				s_sub when i_sel = "01" else
				s_const1 when i_sel = "10" else
				s_add;
		
   -- Dodela vrednosti --		
	o_res <= s_mux;
	
	-- Komparator --
	o_cmp(0) <= '1' when s_mux = "0000" else
					'0';
	o_cmp(1) <= '1' when s_mux < "0110" else
					'0';
					
	-- Prioritetni koder --
	o_enc <= "00" when s_mux(0) = '1' else
				"01" when s_mux(1) = '1' else
				"10" when s_mux(2) = '1' else
				"11" when s_mux(3) = '1' else
				"11";

	
end architecture;
