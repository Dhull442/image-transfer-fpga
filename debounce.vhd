
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity debounce is
  Port (insignal, clk: in std_logic;
        outsignal: out std_logic 
       );
end debounce;

architecture Behavioral of debounce is
    signal ctr: std_logic_vector(3 downto 0) := "0000"; 
begin
    process(clk)
    begin
        if rising_edge(clk) then
            ctr <= ctr + 1;
            if (ctr = "1111") then
                    outsignal <= insignal;
               end if;
        end if;
        
        
    end process;
end Behavioral;
