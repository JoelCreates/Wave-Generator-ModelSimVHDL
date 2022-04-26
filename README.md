# Wave Generator ModelSim VHDL
This contains a wave generation code that takes advantage of the Moore State Machine, using a counter as a clock to generate a multitude of different frequencies by flipping between two different states. This number **N**, is a ratio which is determined by the device's clock period and the intended frequency to be generated. For example, the intended frequency (IF) is 100kHz, the device's clock frequency(CF) is 50MHz. By doing T = 1/F to get  the time period of both frequencies, you would get 1x10^-5s and 2x10^-8s respectively. 

In order to account for each state change, the period of the intended frequency is halved, in this case getting 5x10^-6s. This is then divided by the period of the clock frequency (5x10^-6/2x10^-8) to get **250** counts **per state**.

However, this is not as simple as just inserting 250 into the conditional statement, as doing so results in 2 extra clock cycles being added before a change of state occurs, generating an altogether different frequency compared to the initial specified frequency. This happens due to not accounting for the processes that occurs whenever the threshold number is reached, as the state is toggled to another state along with the counter being reset. 
Therefore, simply subtracting 2 from the number of counts allows for the specified frequency to be generated. The frequency is determined (when simulating on ModelSim or using an Oscilloscope by other means) by measuring a full period of the generated wave, analysing the time period beneath, then doing 1/T to get its frequency.

# Example of 100kHz Square Wave 
![image](https://user-images.githubusercontent.com/48869133/165290150-3b63f810-d766-4260-8ef4-2f6a10fa914c.png)


# Triangle Wave Generation
The triangle wave works on a similar basis to the aforementioned square wave explanation, albeit with some alterations.
- A new signal named "Tri" is added on to each of the states on the state machine, incrementing by a certain number until the counter hits the specified limit N. This number is decremented on the next state to create a triangular wave.
- Removing the below "process" of state that would set the 12 bits to all 0's or 1's within each state change.
- Replaing the removed process with the output, using std_logic_vector with the help of VHDL's "to_unsigned" function to convert the incoming "tri" signal into 12 bits through the use of output'length.
- Since output was set to be 12 bits(11 down to 0 is 12), this allows for tri to also become a 12-bit unsigned integer.

As this is now an unsigned 12 bit integer, running this simply generates a simple triangle wave that would go up and down, following the path of addition and subtraction within each state loop.

# Example of 100kHz Triangle Wave
![image](https://user-images.githubusercontent.com/48869133/165292799-35e10a90-0f13-44c8-9057-ef40039c5002.png)






