# Create a virtual clock with a T ns period where clk is initialized
create_clock -period 20.000 -name virtual -waveform {0.000 10.000} -add [get_ports clk]


# Set correct input delays (min should be <= max)
set_input_delay -clock virtual -min 2.2 [get_ports a]
set_input_delay -clock virtual -max 3.3 [get_ports a]
set_input_delay -clock virtual -min 2.2 [get_ports b]
set_input_delay -clock virtual -max 3.3 [get_ports b]

# Set correct output delays (min should be <= max)
set_output_delay -clock virtual -min 0.2 [get_ports out]
set_output_delay -clock virtual -max 0.9 [get_ports out]
set_output_delay -clock virtual -min 0.2 [get_ports done]
set_output_delay -clock virtual -max 0.9 [get_ports done]
