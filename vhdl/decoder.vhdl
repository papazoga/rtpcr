library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

--
-- Models a DM74LS138
--
-- This is all combinatorial
entity decoder is
  port(
    A: in std_logic_vector(2 downto 0);       -- Actually A, B, C
    G1: in std_logic;
    G2A: in std_logic;
    G2B: in std_logic;
    Y: out std_logic_vector(7 downto 0)
  );
end;

architecture behavioral of decoder is
begin
  decoder_proc: process(A, G1, G2A, G2B)
  begin
    if (G2A or G2B)='1' or G1='0' then
      Y <= (others => '1');
    else
      if A = "000" then Y <=    "11111110";
      elsif A = "001" then Y <= "11111101";
      elsif A = "010" then Y <= "11111011";
      elsif A = "011" then Y <= "11110111";
      elsif A = "100" then Y <= "11101111";
      elsif A = "101" then Y <= "11011111";
      elsif A = "110" then Y <= "10111111";
      elsif A = "111" then Y <= "01111111";
      else Y <= "11111111";
      end if;
    end if;
  end process;
end;
