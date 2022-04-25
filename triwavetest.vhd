library ieee;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.NUMERIC_STD.ALL;

entity triwavetest is

    port(
        clk      : in   std_logic;
        reset    : in   std_logic;
        output   : out  std_logic_vector(11 downto 0)
    );

end entity;

architecture rtl of triwavetest is

    -- Build an enumerated type for the state machine
    type state_type is (lw, hg);

    -- Register to hold the current state
    signal state   : state_type;

    -- Define new signal "tri" to create a triangle wave
    signal tri:integer:=0;

begin

    -- Logic to advance to the next state
    process (clk, reset)
    variable counter : integer:=0; 
    begin
        if reset = '1' then -- When reset is 1, then state, tri and counter should be set to 0 to restart the program
            state <= lw;
	    tri <= 0;
	    counter:= 0;
        elsif (rising_edge(clk)) then
            case state is
                when lw=> -- States are kept the same, low and high states. 
                    if counter <= 248 then
                        state <= lw; -- If the current condition does not change, remain at current state.
                        counter := counter + 1; --Counter incrementor
                        tri <= tri + 5; -- "Tri" Signal incrementor, random value 5 given to it
                    else
                        state <= hg; -- When counter reaches specified number N, set state to high and reset counter
                        counter :=0;
                    end if;
                when hg=>
                    if counter <= 248 then
                        state <= hg;
                        counter := counter + 1; --Counter incrementor
                        tri <= tri - 5; -- "Tri" Signal Decrementor, equal value 5 given to it to avoid comb-like/sawtooth wave.
                    else
                        state <= lw;
                        counter:=0;
                    end if;
            end case;
        end if;
    end process;

output <= std_logic_vector (to_unsigned(tri, output'length)); 
-- By doing this, tri will become unsigned. Furthermore, it will also set this signal to become 12 bits through the use of output'length
-- How it does this is through the line "to_unsigned()", where it will set the tri to become the same length in bits as the output
-- As the output was declared in the ports section to be of 12 bits (11 down to 0), this means that it will set tri to become 12-bit unsigned integer.
-- Therefore, running this should generate no issue, as the output will steadily follow the addition and subtraction of the signal "tri" within the counter loop.

    

end rtl;
