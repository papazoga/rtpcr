library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

--
-- Models a DM74LS175M
--
entity flipflop is
  port(
    clk : in std_logic;
    q : out std_logic_vector(3 downto 0);
    qn : out std_logic_vector(3 downto 0);
    d : in std_logic_vector(3 downto 0)
    );
end;

architecture behavioral of flipflop is
  signal q_state : std_logic_vector(3 downto 0);

begin
  flipflop_proc: process(clk)
  begin
    if rising_edge(clk) then
      q_state <= d;
    end if;
  end process;

  q <= q_state;
  qn <= not q_state;
end;

