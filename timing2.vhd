----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 09/27/2018 04:42:39 PM
-- Design Name: 
-- Module Name: timing - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

---- Uncomment the following library declaration if using
---- arithmetic functions with Signed or Unsigned values
----use IEEE.NUMERIC_STD.ALL;

---- Uncomment the following library declaration if instantiating
---- any Xilinx leaf cells in this code.
----library UNISIM;
----use UNISIM.VComponents.all;

--entity timing is
--  Port (reset, clk, rx_empty, tx_empty: in std_logic;
--        ld_tx, uld_rx, enb, wea: out std_logic;
--        addra, addrb: out std_logic_vector(14 downto 0);
--        a_in: out std_logic_vector(3 downto 0)
--        );
--end timing;


--architecture Behavioral of timing is
--    type state_type1 is (r0, r1, r2);
--    type state_type2 is (t0, t1, t2);
--    signal stater: state_type1;
--    signal statet: state_type2;
--    signal wctr: std_logic_vector(3 downto 0) := "0000";
--    signal dec, inc, memfull, memempty: std_logic;
--begin
--    state_transition: process(clk) begin
--        if (reset = '1') then
--            stater <= r0;
--            statet <= t0; 
--        end if;

--        if (rising_edge(clk)) then
--            case stater is
--                when r0 =>
--                    if (rx_empty = '0' and memfull = '0') then stater <= r1; end if;
--                when r1 =>
--                    stater <= r2;
--                when r2 => 
--                    stater <= r0;
--            end case;
            
--            case statet is 
--                when t0 =>
--                    if tx_empty = '1' and memempty = '0' then statet <= t1; end if;
--                when t1 =>
--                    statet <= t2;
--                when t2 =>
--                    statet <= t0; 
--            end case;
--        end if;
--    end process; 
    
--    signal_assignr: process(statet, reset, rx_empty) begin
--        uld_rx <= '0'; wea <= '0'; inc <= '0';
--        case stater is
--            when r0 =>
--                -- do nothing
--            when r1 =>
--                uld_rx <= '1';
--            when r2 =>
--                wea <= '1'; inc <= '1';
--         end case;
--    end process;
    
--    signal_assignt: process(statet, reset, tx_empty) begin
--        ld_tx <= '0'; enb <= '0'; dec <= '0';
--        case statet is
--            when t0 =>
--                -- do nothing
--            when t1 =>
--                enb <= '1'; dec <= '1';
--            when t2 =>
--                ld_tx <= '1';      
--        end case;
--    end process;    

--    -- This process increments and decrements wctr
--    ctr_increment: process(clk, reset) begin 
--        if (reset = '1') then wctr <= "0000"; end if;
--        if (rising_edge(clk)) then
--            if (inc = '1') then wctr <= wctr + 1; end if;
--            if (dec = '1') then wctr <= wctr - 1; end if;
--        end if;
--    end process;

--    ctr_assign: process(wctr) begin
--        memfull <= '0'; memempty <= '0';
--        if (wctr = "1000") then memfull <= '1'; end if;
--        if (wctr = "0000") then memempty <= '1'; end if;
--    end process;
    
--    addr_assign: process(wctr) begin
--        if (wctr = "0000") then addra <= "000";
--        elsif (wctr = "0001") then addra <= "001";
--        elsif (wctr = "0010") then addra <= "010";
--        elsif (wctr = "0011") then addra <= "011";
--        elsif (wctr = "0100") then addra <= "100";
--        elsif (wctr = "0101") then addra <= "101";
--        elsif (wctr = "0110") then addra <= "110";
--        elsif (wctr = "0111") then addra <= "111";
--        end if;
        
--        if (wctr = "0001") then addrb <= "000";
--        elsif (wctr = "0010") then addrb <= "001";
--        elsif (wctr = "0011") then addrb <= "010";
--        elsif (wctr = "0100") then addrb <= "011";
--        elsif (wctr = "0101") then addrb <= "100";
--        elsif (wctr = "0110") then addrb <= "101";
--        elsif (wctr = "0111") then addrb <= "110";
--        elsif (wctr = "1000") then addrb <= "111"; 
--        end if;
--    end process;
    
--    a_in <= wctr;
----    led_assign: process(state, wctr, rx_empty, tx_empty) begin
------        ledin <= "00000000";
------        ledin(0) <= memfull;
------        ledin(1) <= memempty;
        
------        if (wctr = 0) then ledout <= "00000001";
------        elsif (wctr = 1) then ledout <= "00000010";
------        elsif (wctr = 2) then ledout <= "00000100";
------        elsif (wctr = 3) then ledout <= "00001000";
------        elsif (wctr = 4) then ledout <= "00010000";
------        elsif (wctr = 5) then ledout <= "00100000";
------        elsif (wctr = 6) then ledout <= "01000000";
------        elsif (wctr = 7) then ledout <= "10000000";
------        end if;
        
------        if (state = Idle) then ledin(2) <= '1'; end if;
------        if (state = Rd) then ledin(3) <= '1'; end if;
------        if (state = Wrt) then ledin(4) <= '1'; end if;
------        ledin(5) <= rx_empty;
------        ledin(6) <= tx_empty;
----     end process;

----    a_in (2 to 1) <= addra;

--    ledin(0) <= rx_empty;
--    ledin(1) <= tx_empty;
--end Behavioral;

entity timing is
  Port (reset, clk, rx_empty, tx_empty: in std_logic;
        ld_tx, uld_rx, enb, wea: out std_logic;
        addra, addrb: out std_logic_vector(7 downto 0)
        );
end timing;

architecture Behavioral of timing is
    type state_typer is (r0, r1, r2);
    signal stater: state_typer := r0;
    type state_typet is (t0, t1, t2);
    signal statet: state_typet := t0; 
    signal ctrr, ctrw: std_logic_vector(7 downto 0) := "00000000";
    signal writestop, readstop, incr, incw: std_logic := '0';
begin
    state_transition: process(clk, reset) begin
        if (reset = '1') then 
           -- Assign default values
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
        uld_rx <= '0'; incw <= '0'; wea <= '0';
        case stater is 
            when r0 =>
                -- Do nothing
            when r1 =>
                uld_rx <= '1';
            when r2 =>
                wea <= '1'; incw <= '1';
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
    
    increment_proc: process(reset, clk) begin
        if (reset = '1') then 
            ctrr <= "00000000";
            ctrw <= "00000000";
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
        if (ctrw = "11111111") then writestop <= '1'; end if;
    end process;
end architecture;
  

