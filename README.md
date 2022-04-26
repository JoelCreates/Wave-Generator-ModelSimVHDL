# Wave Generator ModelSim VHDL
This contains a wave generation code that takes advantage of the Moore State Machine, using a counter as a clock to generate a multitude of different frequencies by flipping between two different states. This number **N**, is a ratio which is determined by the device's clock period and the intended frequency to be generated. For example, the intended frequency (IF) is 100kHz, the device's clock frequency(CF) is 50MHz. By doing T = 1/F to get  the time period of both frequencies, you would get 1x10^-5s and 2x10^-8s respectively. 

In order to account for each state change, the period of the intended frequency is halved, in this case getting 5x10^-6s. This is then divided by the period of the clock frequency (5x10^-6/2x10^-8) to get **250** counts **per state**.

However, this is not as simple as just inserting 250 into the conditional statement, as doing so results in 2 extra clock cycles being added before a change of state occurs, generating an altogether different frequency compared to the initial specified frequency. This happens due to not accounting for the processes that occurs whenever the threshold number is reached, as the state is toggled to another state along with the counter being reset. 
Therefore, simply subtracting 2 from the number of counts allows for the specified frequency to be generated. The frequency is determined (when simulating on ModelSim or using an Oscilloscope by other means) by measuring a full period of the generated wave, analysing the time period beneath, then doing 1/T to get its frequency.

# Example of 100kHz Square Wave   
![image](https://user-images.githubusercontent.com/48869133/165289914-147c7f83-5a8e-456a-a261-d83f50c5cdc1.png)


