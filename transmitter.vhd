library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity transmitter is
    Port (tx_out, tx_empty: out std_logic; 
          tx_en, ld_tx, reset, txclk: in std_logic;
          tx_data: std_logic_vector(7 downto 0)
          );
end transmitter;

architecture Behavioral of transmitter is
    signal data: std_logic_vector(7 downto 0) := "00000000";
    type state_type IS (Idle, start, s0, s1, s2, s3, s4, s5, s6, s7);
    signal state: state_type;
begin
    state_changes: process(reset, txclk) begin
        if (reset = '1') then state <= Idle; end if;
        if (rising_edge(txclk)) then 
            case state is 
                when Idle =>
                    if (ld_tx = '1'and tx_en = '1') then state <= start; end if;
                when start => state <= s0;
                when s0 => state <= s1;
                when s1 => state <= s2;
                when s2 => state <= s3;
                when s3 => state <= s4;
                when s4 => state <= s5;
                when s5 => state <= s6;
                when s6 => state <= s7;
                when s7 => state <= Idle;
            end case;
        end if;
    end process;
    
    signal_set: process(state) begin
        case state is
            when Idle => 
                tx_out <= '1'; tx_empty <= '1';
            when start =>
                tx_out <= '0'; tx_empty <= '0';
            when s0 =>        
                tx_out <= data(0); tx_empty <= '0';
            when s1 =>
                tx_out <= data(1); tx_empty <= '0';
            when s2 =>
                tx_out <= data(2); tx_empty <= '0';
            when s3 =>
                tx_out <= data(3); tx_empty <= '0';
            when s4 =>
                tx_out <= data(4); tx_empty <= '0';
            when s5 => 
                tx_out <= data(5); tx_empty <= '0';
            when s6 =>
                tx_out <= data(6); tx_empty <= '0';
            when s7 =>
                tx_out <= data(7); tx_empty <= '0';
        end case;
    end process;
    
    -- Datapath
    Load_data: process(txclk) begin
        if (rising_edge(txclk)) then 
            if (ld_tx = '1') then
                data <= tx_data;
            end if;
        end if;
    end process;
end Behavioral;
        

