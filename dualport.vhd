Library IEEE; 
use IEEE.std_logic_1164.all; 
use IEEE.numeric_std.all; 
use IEEE.STD_LOGIC_UNSIGNED.ALL; 
library UNISIM;
use UNISIM.VComponents.all;

entity dualport is
  Port (clk, enb, wea, reset: in std_logic;
        addrb, addra: in std_logic_vector(14 downto 0);
        dina: in std_logic_vector(7 downto 0);
        doutb: out std_logic_vector(7 downto 0)
        smooth: in std_logic
       );
end dualport;

architecture Behavioral of dualport is
      type  RAM is array(0 to 200) of integer range 0 to 256;
      signal intmem: RAM; 
      signal v0,v1,v2,v3,v4,v5,v6,v7,v8,value,check,pass0s: integer:=0;
begin
    process(clk, reset) begin
        if (reset = '1') then 
            doutb <= "00000000";
        end if;
        
        if rising_edge(clk) then
            if enb = '1' then
            check <= to_integer(unsigned(addrb);
            if((check > 24 and check < 47) or( check > 48 and check < 71 )or( check > 72 and check < 95)or( check > 96 and check < 119)or( check > 120 and check < 143))then
              v0 <= intmem(to_integer(unsigned(addrb)) + 24 + 1);
              v1 <= intmem(to_integer(unsigned(addrb)) + 24);
              v2 <= intmem(to_integer(unsigned(addrb)) + 24 - 1);
              v3 <= intmem(to_integer(unsigned(addrb)) + 1);
              v4 <= intmem(to_integer(unsigned(addrb)));
              v5 <= intmem(to_integer(unsigned(addrb)) - 1);
              v6 <= intmem(to_integer(unsigned(addrb)) - 24 + 1);
              v7 <= intmem(to_integer(unsigned(addrb)) - 24 );
              v8 <= intmem(to_integer(unsigned(addrb)) - 24 - 1);
              if(smooth='1') then
                value <= ((v0 + v2 + v6 + v8)*8 + (v1 + v3 + v5 + v7)*16 + v4 * 32)/128  ;
              else
                value <= (v4 * 241 - (v0 + v1 + v2 + v3 + v5 + v6 + v7 + v8)*14)/128;
              end if;
              
              if(value > 0 and value < 256)
                doutb <= std_logic_vector(to_unsigned(value));
              elsif( value < 0)
                doutb <= "00000000";
              else
                doutb <= "11111111";
              end if;

            else
              doutb <= "00000000";
            end if;
            
            end if;

            if wea = '1' then 
              intmem(to_integer(unsigned(addra))) <= to_integer(unsigned(dina));
            end if;
      end if;
    end process;
end Behavioral;

