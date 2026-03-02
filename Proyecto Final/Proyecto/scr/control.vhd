library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity control is 
    generic( N : natural := 8);
    port(

        clk,rst,listo : in std_logic;
        luces : out std_logic_vector(5 downto 0);
        reload : out unsigned(N-1 downto 0)
    );
end entity;

architecture controlLogic of control is 
    
        type estado is (RR,VR,AR,RV,RA);
        signal estado_sig, estado_act : estado;
        signal listo_i : std_logic;


        begin
        reload <= to_unsigned(2,N); 
        
        ME : process(clk)
                begin
                    if rising_edge(clk)then 
                        if rst = '1' then 
                            estado_act <= RR;
                        else
                            estado_act <= estado_sig;
                        end if;
                    end if;
                end process;

        LES: process(all)
                begin
                    case estado_act is 
                        when RR => 
                            if listo = '1' then estado_sig <= VR; else estado_sig <= RR;
                            end if;
                        when VR =>
                            if listo = '1' then estado_sig <= AR; else estado_sig <= VR;
                            end if;
                        when AR =>
                            if listo = '1' then estado_sig <= RV; else estado_sig <= AR;
                            end if;
                        when RV =>
                            if listo = '1' then estado_sig <= RA; else estado_sig <= RV;
                            end if;
                        when RA =>
                            if listo = '1' then estado_sig <= VR; else estado_sig <= RA;
                            end if;
                        end case;
                end process;

        LS: with estado_act select
                luces <= "100100" when RR,
                         "001100" when VR,
                         "010100" when AR,
                         "100001" when RV,
                         "100010" when RA,
                         "000000" when others;

    end architecture;