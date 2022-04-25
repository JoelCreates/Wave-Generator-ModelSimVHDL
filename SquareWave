library ieee;
use ieee.std_logic_1164.all;

entity sqwave is

	port(
		clk	 : in	std_logic;
		reset	 : in	std_logic;
		output	 : out	std_logic_vector(11 downto 0) -- 12 Bits for 12-bit DAC Converter 
	);

end entity;

architecture rtl of sqwave is

	-- Build an enumerated type for the state machine
	type state_type is (lw, hg); -- Types of states, in the case of this project it is both LOW and HIGH state

	-- Register to hold the current state
	signal state   : state_type;

begin

	-- Logic to advance to the next state
	process (clk, reset)
	variable counter : integer:=0; -- Defining new variable "counter" as an integer, meant to increment with clock rising edge.
	begin
		if reset = '1' then
			state <= lw; -- When reset is set to 1, the state will immediately flip to low.
		elsif (rising_edge(clk)) then
			case state is
				when lw=>
					if counter <= 248 then 
		--The number that the counter counts to, which is N, is the limiter. This is a ratio between clock period and  
			--the intended frequency. Number is split between both states, equating to one full period. 

						state <= lw; -- Apply low to state if counter does not surpass set value.
						counter:=counter+1; -- Increment counter through clock rising edge
					else
						state <= hg; -- When the counter does go over, change state to high
						counter :=0; -- Reset Counter
					end if;
				when hg=>
					if counter <= 248 then
						state <= hg;
						counter:=counter+1;
					else
						state <= lw;
						counter:=0;
					end if;
			end case;
		end if;
	end process;

	-- Output depends solely on the current state
	process (state)
	begin
		case state is
			when lw =>
				output <= X"000"; -- Hexadecimal through "X", each 0 consists of four 0's due to 1 hex being 4 bits in binary.
			when hg =>
				output <= X"FFF"; -- F is 1111 in binary, therefore triple F is enough for 12 bits.
		end case;
	end process;

end rtl;
