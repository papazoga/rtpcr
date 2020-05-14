library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity advanced_controller_board is
  port(
    p0 : in unsigned(7 downto 0);
    row : out unsigned(11 downto 0);
    column : out unsigned(7 downto 0)
    );
end;

architecture behavioral of advanced_controller_board is
  signal led_ff_row: std_logic_vector(11 downto 0);
  signal led_ff_col: std_logic_vector(7 downto 0);

  signal led_ff_row_clks: std_logic_vector(2 downto 0);
  signal led_ff_col_clks: std_logic_vector(1 downto 0);

  signal unused_1 :std_logic_vector(2 downto 0);
begin
  --
  -- P0 (the PCI-6036E data bus) is used as follows:
  --
  -- bits 3 downto 0 go to all the LED flipflops in parallel.
  -- bits 6 downto 4 go to the decoders and are used to generate clock signals
  -- bit 7 is a clock signal. it connects to the enable bit on the decoder.
  --

  gen_row_ffs:
  for index in 0 to 2 generate
    led_ff : entity work.flipflop port map (
      clk => led_ff_row_clks(index),
      q => led_ff_row(index*4+3 downto index*4),
      d => std_logic_vector(p0(3 downto 0))
    );
  end generate;

  gen_col_ffs:
  for index in 0 to 1 generate
    led_ff : entity work.flipflop port map (
      clk => led_ff_col_clks(index),
      q => led_ff_col(index*4+3 downto index*4),
      d => std_logic_vector(p0(3 downto 0))
    );
  end generate;

  --
  -- Clock decoder
  --
  led_ff_decoder: entity work.decoder port map(
    A => std_logic_vector(p0(6 downto 4)),
    Y(2 downto 0) => led_ff_row_clks,
    Y(4 downto 3) => led_ff_col_clks,
    Y(7 downto 5) => unused_1,
    G1 => std_logic(p0(7)),
    G2A => '0',
    G2B => '0'
    );

end;
