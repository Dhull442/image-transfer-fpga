
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity clock is
  Port (reset, clk: in std_logic;
        baud_clk, baud16_clk: out std_logic
         );
end clockgen;

architecture Behavioral of clockgen is
    signal tmpbaud_clk: std_logic := '0';
    signal tmpbaud16_clk: std_logic := '0';
    signal countera, diva, divb, counterb: integer := 0;
begin
    diva <= 651; divb <= 10416;
    process(clk, reset) begin
        if (reset = '1') then 
            tmpbaud_clk <= '0'; tmpbaud16_clk <= '0';
            countera <= 0; 
            counterb <= 0;
        end if;
        
        if (rising_edge(clk)) then
            if (countera < diva/2 - 1) then      
                countera <= countera + 1;
                tmpbaud16_clk <= '0';
            elsif (countera < diva - 1) then
                countera <= countera + 1;
                tmpbaud16_clk <= '1';
            else 
                countera <= 0;
                tmpbaud16_clk <= '0';
            end if;
            
            if (counterb < divb/2 - 1) then
                counterb <= counterb + 1;
                tmpbaud_clk <= '0';
            elsif (counterb < divb - 1) then
                counterb <= counterb + 1;
                tmpbaud_clk <= '1';
            else 
                counterb <= 0;
                tmpbaud_clk <= '0';
        end if;
            
        end if;
    end process;
    
    baud16_clk <= tmpbaud16_clk;
    baud_clk <= tmpbaud_clk;
    
end Behavioral;
