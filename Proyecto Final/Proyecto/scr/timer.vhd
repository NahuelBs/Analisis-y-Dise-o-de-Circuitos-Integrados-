library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


entity timer is
    generic( N : natural := 8);
    port (

        reload  			 : in unsigned(N-1 downto 0); 
        enable, rst, clk     : in std_logic;
        t, z        		 : out std_logic
    );
end entity;

architecture timerLogic of timer is 

	signal cuenta, cuenta_sig  : unsigned(N-1 downto 0);
		
	begin

		process (clk)
	 
			begin
		
				if rising_edge(clk) then 
					cuenta <= cuenta_sig;
				end if; 
		end process;
		
		cuenta_sig <= (others => '0')   when rst = '1'else 
				      cuenta            when enable = '0' else	
				      cuenta - 1        when not z else reload; 					  
		
		t <= cuenta ?= 1; 
		z <= cuenta ?= 0; 
			
		
end architecture;