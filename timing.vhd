
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity timing is
  Port (reset, clk, rx_empty, tx_empty: in std_logic;
        ld_tx, uld_rx, enb, wra: out std_logic;
        addra, addrb: out std_logic_vector(14 downto 0)
        );
end timing;

architecture Behavioral of timing is
    type state_typer is (r0, r1, r2);
    signal stater: state_typer := r0;
    type state_typet is (t0, t1, t2);
    signal statet: state_typet := t0; 
    signal ctrr, ctrw: std_logic_vector(14 downto 0) := "000000000000000";
    signal writestop, readstop, incr, incw: std_logic := '0';
begin
    state_transition: process(clk, reset) begin
        if (reset = '1') then 
           stater <= r0;
           statet <= t0;
        end if;
        
        if (rising_edge(clk)) then
            case stater is
                when r0 =>
                    if rx_empty = '0' then stater <= r1; else stater <= r0; end if;
                when r1 =>
                    if writestop = '0' then stater <= r2; else stater <= r0; end if;
                when r2 =>
                    stater <= r0;
            end case;
            
            case statet is 
                when t0 => 
                    if tx_empty = '1' and readstop = '0' then statet <= t1; else statet <= t0; end if;
                when t1 =>
                    statet <= t2;
                when t2 => 
                    if (tx_empty = '0') then statet <= t0; else statet <= t2; end if;
            end case;   
        end if;
    end process;        

    signal_assignr: process(stater) begin
        uld_rx <= '0'; incw <= '0'; wra <= '0';
        case stater is 
            when r0 =>
                -- Do nothing
            when r1 =>
                uld_rx <= '1';
            when r2 =>
                wra <= '1'; incw <= '1';
        end case;
    end process;
    
    signal_assignt: process(statet) begin
        ld_tx <= '0'; incr <= '0'; enb <= '0';
        case statet is
            when t0 =>
                -- Do nothing
            when t1 =>
                incr <= '1'; enb <= '1';
            when t2 =>
                ld_tx <= '1';
        end case;
    end process; 
    
    increments: process(reset, clk) begin
        if (reset = '1') then 
            ctrr <= "000000000000000";
            ctrw <= "000000000000000";
        end if;
        
        if (rising_edge(clk)) then
            if (incr = '1') then ctrr <= ctrr + 1; end if;
            if (incw = '1') then ctrw <= ctrw + 1; end if;    
        end if;
    end process;
    
    addr_proc_read: process(ctrr, ctrw) begin
        addrb <= ctrr;
        if (ctrr < ctrw) then 
            readstop <= '0'; 
        else readstop <= '1'; end if;
    end process;
    
    addr_proc_write: process(ctrw) begin
        addra <= ctrw;
        writestop <= '0';
        if (ctrw = "111111111111111") then writestop <= '1'; end if;
    end process;
end architecture;
  

