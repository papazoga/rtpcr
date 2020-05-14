library ieee;
use ieee.std_logic_1164.all;


entity dm74ls175m is
  port(
    clk : in std_logic;
    q : out std_logic_vector(3 downto 0);
    qn : out std_logic_vector(3 downto 0);
    d : in std_logic_vector(3 downto 0)
    );

end;

architecture behavioral of dm74ls175m is

signal q_storage : std_logic_vector(3 downto 0);

begin
  assign_proc : process
  begin
    if rising_edge(clk) then
      q_storage <= d;
    end if;
  end process;

  q <= q_storage;
  qn <= not q_storage;

end architecture;
