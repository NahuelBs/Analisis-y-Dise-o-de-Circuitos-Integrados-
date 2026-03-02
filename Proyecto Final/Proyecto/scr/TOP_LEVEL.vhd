library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity TOP_LEVEL is 
	generic (N : natural := 8);
	port(
	
		clk,rst,enable : in std_logic;
        luces          : out std_logic_vector(5 downto 0)
	);
end TOP_LEVEL;

architecture TL of TOP_LEVEL is

	signal t,z : std_logic;
	signal reload_timer : unsigned(N-1 downto 0);
	
	begin

	Timer: entity work.timer 
              generic map (N => N)
              port map (reload => reload_timer, enable => enable , rst => rst, z => z, t => t, clk => clk);

	Control: entity work.control
					 generic map (N => N)	
					 port map (reload => reload_timer, rst => rst, listo => t, luces => luces, clk => clk);
end TL;


