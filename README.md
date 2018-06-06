# UART-transmitter-and-receiver

1. UART has 4 pins: VDD, GND, RX, TX

2. One frame of UART comunication is usually combined with 11 or 12 bits.
   * 1 bit for start
   * 8 bits for data
   * 1 bit for parity check (optional)
   * 1/2 bit for stop    
   
3. The static states for RX and TX are high level. When the signal is sensed from high to low, it means UART starts working. 

4. Since UART is an asynchronous interface whose data doesn't come with the clock, we need to keep PC and FPGA has the same transmission and receiving rate. 
   This rate is Baud rate which is a common measure of the speed of communication over a data channel.
   For example, 9600 baud means 9600 bits per second. So a clock should be created to sample the data according to the baud rate.

Here is VHDL code and testbench based on Xilinx SPartan-6 to send FIFO data from FPGA to PC.
