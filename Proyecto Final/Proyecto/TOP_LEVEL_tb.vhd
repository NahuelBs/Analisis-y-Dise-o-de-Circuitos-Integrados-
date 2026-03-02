library ieee;
use ieee.std_logic_1164.all;
use std.env.all;

entity TOP_LEVEL_tb is
end entity;

architecture tb_TL of TOP_LEVEL_tb is

signal tbclk : std_logic := '1';
constant clk_half_period : time := 5 ns; 

constant N : natural := 8;
signal rst, listo, enable : std_logic;
signal luces : std_logic_vector (5 downto 0);

    begin 

    top_level: entity work.TOP_LEVEL
               generic map (N => N)
               port map (clk => tbclk, rst => rst, enable => '1', luces => luces);

    tbclk  <= not(tbclk) after clk_half_period;

    process
    begin

        rst  <= '1'; wait for  (clk_half_period * 5)/2;
        rst  <= '0';
        wait for 100 ns;
        rst  <= '1'; wait for  (clk_half_period * 10)/2;
        rst  <= '0'; wait for  (clk_half_period * 10)/2;
        wait for 300 ns;
        finish;

    end process;

end tb_TL;