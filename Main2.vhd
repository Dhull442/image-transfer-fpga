
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity Main is
  Port (rawclk, rawreset, rx_in, tx_en, rx_en: in std_logic; 
        tx_out: out std_logic;
        ledin, ledout: out std_logic_vector(7 downto 0);
        switch: in std_logic
        );
end Main;

architecture Behavioral of Main is
    signal tmpbaud_clk: std_logic := '0';
    signal tmpbaud16_clk: std_logic := '0';
    signal countera, diva, divb, counterb: integer := 0;
    signal ctr: std_logic_vector(3 downto 0) := "0000"; 
    signal baud_clk, baud16_clk, reset, rx_empty, tx_empty, uld_rx, ld_tx, enb, wea: std_logic := '0';
    signal dina, doutb: std_logic_vector(7 downto 0) := "00000000";
    signal addra, addrb: std_logic_vector(14 downto 0) := "000000000000000";
    signal tempa: std_logic_vector(7 downto 0) := "00000000";
    signal dataar: std_logic_vector(19199 downto 0);
begin

        diva <= 651; divb <= 10416;
    clockgenerator: process(rawclk, reset) begin
        if (reset = '1') then 
            tmpbaud_clk <= '0'; tmpbaud16_clk <= '0';
            countera <= 0; 
            counterb <= 0;
        end if;
        
        if (rising_edge(rawclk)) then
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
    
        
    timing:
        entity work.timing(Behavioral)
        PORT MAP(
            reset => reset,   
            clk => baud16_clk,
            rx_empty => rx_empty,
            tx_empty => tx_empty,
            uld_rx => uld_rx,
            ld_tx => ld_tx,
            enb => enb,
            wea => wea, 
            addra => addra, 
            addrb => addrb         
        );
        
    transmitter:
        entity work.transmitter(Behavioral)
        PORT MAP(
            tx_out => tx_out,
            tx_en => tx_en,
            reset => reset,
            txclk => baud_clk, 
            tx_data => doutb,
            tx_empty => tx_empty,
            ld_tx => ld_tx
        );
        
    receiver:
        entity work.receiver(Behavioral)
        PORT MAP(
            reset => reset,
            rx_en => rx_en,
            rxclk => baud16_clk,
            rx_data => dina,
            uld_rx => uld_rx,
            rx_empty => rx_empty,
            rx_in => rx_in
        );
    debounce: process(clk)
    begin
        if rising_edge(clk) then
            ctr <= ctr + 1;
            if (ctr = "1111") then
                    outsignal <= insignal;
               end if;
        end if;
        
        
    end process;

    dualport: 
        entity work.dualport(Behavioral)
        PORT MAP(
            clk => baud16_clk, 
            enb => enb, 
            wea => wea,
            addra => addra, 
            addrb => addrb,
            dina => dina, 
            doutb => doutb,
            reset => reset,
            switch => smooth
        );
        
      ledin <= dina;
      ledout <= doutb;
end Behavioral;

