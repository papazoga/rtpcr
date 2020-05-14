library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

-- Models MM74HC148 Line Priority Encode
entity encoder is
  port(
    EO: out std_logic;
    GS: out std_logic;
    EI: in std_logic;
    A: out std_logic_vector(2 downto 0);
    X: in std_logic_vector(7 downto 0)
  );
end;

architecture behavioral of encoder is
begin
  encoder_proc: process(EI, X)
  begin
    EO <= '1';
    GS <= '0';

    if EI='1' then
      A <= "111";
      GS <= '1';
    elsif EI='0' then
      if X(0)='1' then A <= "111";
      elsif X(1)='1' then A <= "110";
      elsif X(2)='1' then A <= "101";
      elsif X(3)='1' then A <= "100";
      elsif X(4)='1' then A <= "011";
      elsif X(5)='1' then A <= "010";
      elsif X(6)='1' then A <= "001";
      elsif X(7)='1' then A <= "000";
      else
        A <= "111";
        GS <= '1';
        EO <= '1';
      end if;
    end if;
  end process;
end;

