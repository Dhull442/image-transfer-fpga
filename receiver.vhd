
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use STD.textio.all;
use IEEE.std_logic_textio.all;


entity receiver is
  Port (rx_in, rx_en, uld_rx, reset, rxclk: in std_logic; 
        rx_empty: out std_logic;
        rx_data: out std_logic_vector(7 downto 0)
        );
end receiver;

architecture Behavioral of receiver is
    type state_type is (idles1, idles2, s0, s1, s2, s3, s4, s5, s6, s7, stop, start);
    signal state: state_type;
    signal ctr: std_logic_vector(3 downto 0) := "0000";
    signal data: std_logic_vector(7 downto 0) := "00000000";
    signal ldctr, inc, z, load0, load1, load2, load3, load4, load5, load6, load7: std_logic;
begin


    state_change: process(rxclk, reset) 
        begin 
        if (reset = '1') then state <= idles1; end if;
        if (rising_edge(rxclk) and rx_en = '1') then
            case state is
                when idles1 => 
                    if rx_in = '0' then state <= start; end if;
                when idles2 =>
                    if rx_in = '0' then state <= start; 
                    elsif uld_rx = '1' then state <= idles1; end if;
                when start =>
                    if z = '1' then state <= s0; end if;
                when s0 =>
                    if z = '1' then state <= s1; end if;
                when s1 =>
                    if z = '1' then state <= s2; end if;
                when s2 =>
                    if z = '1' then state <= s3; end if;
                when s3 =>
                    if z = '1' then state <= s4; end if;
                when s4 => 
                    if z = '1' then state <= s5; end if;
                when s5 =>
                    if z = '1' then state <= s6; end if;
                when s6 =>
                    if z = '1' then state <= s7; end if;
                when s7 => 
                    if z = '1' then state <= stop; end if;
                when stop =>
                    if z = '1' then state <= idles2; end if;
            end case;
        end if;
    end process;
    
    control_outputs: process(z, state, rx_en) begin
        ldctr <= '0'; load0 <= '0'; load1 <= '0'; load2 <= '0'; load3 <= '0';
        load4 <= '0'; load5 <= '0'; load6 <= '0'; load7 <= '0'; rx_empty <= '1';
        inc <= '0';
        case state is
            when idles1 => 
                rx_empty <= '1';
                if (rx_in = '0') then ldctr <= '1'; end if;
            when idles2 => 
                rx_empty <= '0';
                if (rx_in = '0') then ldctr <= '1'; end if;
            when start => inc <= '1';
            when s0 =>
                inc <= '1';
                if (z = '1') then load0 <= '1'; end if;
            when s1 =>
                inc <= '1';
                if (z = '1') then load1 <= '1'; end if;
            when s2 =>
                inc <= '1';
                if (z = '1') then load2 <= '1'; end if;
            when s3 =>
                inc <= '1';
                if (z = '1') then load3 <= '1'; end if;
            when s4 =>
                inc <= '1';
                if (z = '1') then load4 <= '1'; end if;
            when s5 =>
                inc <= '1';
                if (z = '1') then load5 <= '1'; end if;
            when s6 =>
                inc <= '1';
                if (z = '1') then load6 <= '1'; end if;
            when s7 =>
                inc <= '1';
                if (z = '1') then load7 <= '1'; end if;
            when stop =>
                inc <= '1';
                if (z = '1') then rx_empty <= '0'; end if;    
         end case;
    end process;
    
    -- Datapath circuit
    datapath: process(rxclk, reset) begin
        if (reset = '1') then
            ctr <= "0000"; data <= "00000000";
        end if;
        
        if (rising_edge(rxclk)) then 
            if (inc = '1') then ctr <= ctr + 1; end if;
            if (ldctr = '1') then ctr <= "0000"; end if;
            if (inc = '1') then ctr <= ctr + 1; end if;
            if (load0 = '1') then data(0) <= rx_in; end if; 
            if (load1 = '1') then data(1) <= rx_in; end if;
            if (load2 = '1') then data(2) <= rx_in; end if;
            if (load3 = '1') then data(3) <= rx_in; end if;
            if (load4 = '1') then data(4) <= rx_in; end if;
            if (load5 = '1') then data(5) <= rx_in; end if;
            if (load6 = '1') then data(6) <= rx_in; end if;
            if (load7 = '1') then data(7) <= rx_in; end if;
            if (uld_rx) = '1' then rx_data <= data; end if;
        end if;
    end process;
    
    signals_datapath: process(data, ctr) begin
        if (ctr = "0110") then z <= '1'; else z <= '0'; end if; 
    end process;
end Behavioral;

