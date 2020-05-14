library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use std.textio.all;

entity advanced_controller_tb is port(
    row : out unsigned(11 downto 0);
    column : out unsigned(7 downto 0)
      );
end;

architecture behavioral of advanced_controller_tb is
  constant C_CLK        : time          := 100 ns;
  constant C_FILENAME   : string        := "data.txt";

  signal p0 : unsigned(7 downto 0);
  signal done : std_logic := '0';
  signal clk : std_logic;
begin

  advanced_controller_board_inst : entity work.advanced_controller_board port map(
    row => row,
    column => column,
    p0 => p0
    );

  tb_proc : process
    variable fstatus : file_open_status;
    variable dataline : line;
    variable data : bit_vector(7 downto 0);
    file datafile : text is in C_FILENAME;
  begin
    while not endfile(datafile) loop
      readline(datafile, dataline);
      read(dataline, data);
      p0 <= unsigned(to_stdlogicvector(data));
      wait for C_CLK;
    end loop;

    wait until clk = '1';
    report "done";

  end process;
end;

-- seq1 = [ 112, 240, 176, 192,
--         240, 143, 255, 159,
--         255, 127, 113, 241,
--         49, 177, 113, 241,
--         39, 167, 119, 247 ]  
