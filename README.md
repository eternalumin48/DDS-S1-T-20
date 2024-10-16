# BEATSYNC

<!-- First Section -->
## Team Details
<details>
  <summary>Detail</summary>

  > Semester: 3rd Sem B. Tech. CSE

  > Section: S1

  > Member-1: Name T Amith Teja, Roll No. 231CS159, email amithtejat.231cs159@nitk.edu.in

  > member-2: Name Tejavath Shashank, Roll No. 231CS160, email tejavathshashank.231cs160@nitk.edu.in

  > Member-3: Name S V Karthikeya, Roll No. 231CS150, email svkarthikeya.231cs150@nitk.edu.in
</details>

<!-- Second Section -->
## Abstract
<details>
  <summary>details</summary>

  
 > MOTIVATION

  We are passionate about developing a tool that helps teach music to visually
impaired individuals, opening up new avenues for creativity and expression.We are inspired
to create a music beat visualizer that translates audio rhythms into captivating visual displays, enhancing both entertainment and performance experiences for everyone. Additionally,
We are motivated to explore the therapeutic applications of a music beat visualizer, using
sound-to-visual conversions to provide calming and engaging experiences for individuals in
therapy. Together, these initiatives reflect our commitment to making music more accessible
and enjoyable for all.

  
 > PROBLEM STATEMENT
 
  The objective of the music beat visualizer project is to create a visual
representation of audio signals without relying on microcontrollers or digital circuitry. Current
visualizers often depend on complex digital systems that may not effectively capture the nuances of music’s rhythm and amplitude. This project aims to develop an analog-based solution
capable of accurately converting audio frequencies into vibrant LED displays. By emphasizing
simplicity and creativity, the goal is to enhance the auditory experience, allowing users to see
the music in real-time while providing an engaging and immersive experience for audiences.


>  FEATURES
 
  The music beat visualizer project boasts several key features for design and demo
evaluation. It utilizes an analog signal processing approach, offering hands-on experience without reliance on digital controllers. The system is capable of real-time visualization, displaying
audio signal variations and allowing immediate interaction with the music, enhancing audience engagement. A vibrant LED array responds dynamically to different amplitudes and frequencies, creating an appealing visual representation. Additionally, custom circuit schematics
are developed for optimal filtering and amplification, ensuring accurate signal representation.
Overall, the project provides educational value, offering insights into analog electronics and
signal processing for students and enthusiasts.
</details>

<!-- Third Section -->
## Functional Block Diagram
<details>
  <summary>Click To See</summary>
  
   ![S1-T20 drawio](https://github.com/eternalumin48/DDS-S1-T-20/blob/c90aa96922660bfae0e332aece832964e5c1e0be/Snapshots/S1-T20.drawio.png)
</details>

<!-- Fourth Section -->
## Working
<details>
  <summary>Detail</summary>

  The music beat visualizer works by taking the digital representation of frequency and amplitude from a musical signal and lighting up LEDs based on those values. Here's a breakdown of how it works:
  
  |Component        |Description     | 
| ------------- |:-------------:| 
|  1.input     |  | 
|  Frequency (6-bit input)   |   Represents the pitch of the music. Higher values = higher-pitched notes.   |   
| Amplitude (4-bit input) |  Compare the 4-bit amplitude against set values to determine the number of LEDs to light up.      |    
|   2. Comparators          |                  |
|  Frequency Comparators   |  Compare the 6-bit frequency against predefined ranges for visual representation.  |
|    Amplitude Comparators   |    Compare the 4-bit amplitude against set values to determine the number of LEDs to light up.   |
|   3. LED Display Logic   |       |
|    LEDs for Amplitude  |   Number of illuminated LEDs corresponds to the amplitude level.   |
|   LEDs for Frequency |    Illuminated LEDs or colors determined by frequency comparator:  <ul><li> Low frequency: Left-most LEDs </li> <li> Medium frequency: Middle LEDs </li><li>High frequency: Right-most LEDs</li> </ul> |
|    4. State Changes Based on Clock               |     The system updates with a clock signal, re-evaluating inputs on each pulse to adjust the LEDs.     |
|    5. RGB LED Color Control     |  RGB LEDs used to represent frequencies with different colors: <ul><li> Red:  Low frequencies </li><li> Green: Mid frequencies </li><li> Blue: High frequencies</li> </ul> |
|   6. Final Output         |   LED Matrix Display (5x3): The configuration of lit LEDs (number, position, color) reflects the music's frequency and amplitude.             |

Truth Table :

Frequency (6-bit): Represents different ranges of frequency input (e.g., low, mid, high).

Amplitude (4-bit): Controls how many LEDs light up based on the loudness of the music.

LED1-LED5: LEDs represent the output visual display based on the input values.

| Frequency(F)       | Amplitude(A)           | L1 | L2| L3 | L4 | L5|
| ------------- |:-------------:| -----:|-----:|-------:|-------:|------:|
| 000000        |          0000 |   0    |   0   | 0       | 0       | 0      |
| 010001        |         0100 |  1     |0      | 0       | 0       | 0      |
| 011010         |  1000             | 1      | 1    | 0       | 0       |0        |
| 101011              |1100               |1       | 1     |   1       | 0     |0        |
|110100   |1111   |1|1|1|1|1|
|111111 |1111 |1|1|1|1| 1|

State Diagram

The state diagram represents the system’s operation as the clock ticks:

1. Idle State: Initial state before any input is received.


2. Input State: Input frequency and amplitude are read.


3. Comparator State: Inputs are compared with predefined thresholds.


4. LED Update State: LEDs are updated based on the results of the comparators.

5. Repeat: The system returns to the idle state, waiting for the next clock tick to process the next input values.
</details>

<!-- Fifth Section -->
## Logisim Circuit Diagram
<details>
  <summary>Detail</summary>

  <h4>Main Circuit</h4>
  
  ![S1-T20](https://github.com/eternalumin48/DDS-S1-T-20/blob/969378e15fdf68ded27ae2c65f376e46591d0ca3/Logisim/S1-T20.png)

  <h4>6-bit Comparator</h4>

  ![6-bit](https://github.com/eternalumin48/DDS-S1-T-20/blob/c067ba0f5a6b886293000077e98c4d37be41ec03/Logisim/6-bit%20comparator.png)

  <h4>4-bit Comparator</h4>
  
  ![4-bit](https://github.com/eternalumin48/DDS-S1-T-20/blob/c067ba0f5a6b886293000077e98c4d37be41ec03/Logisim/4-bit%20comparator.png)
</details>

<!-- Sixth Section -->
## Verilog Code
<details>
  <summary>Detail</summary>

    module waveform_generator(
    input wire clk,                  // System clock
    input wire [3:0] amplitude,      // 4-bit amplitude input (0-15)
    input wire [5:0] frequency,      // 6-bit frequency input (0-63)
    output reg waveform_out          // Output waveform
    );

    // Internal parameters
    reg [31:0] counter;              // Counter for frequency division
    reg [31:0] amplitude_scaled;      // Scaled amplitude value
    reg [31:0] frequency_divider;     // Frequency divider value
    reg [31:0] threshold;             // Threshold for waveform switching
    reg [31:0] amplitude_limit;       // Amplitude limit for scaling

    // Set amplitude limit (maximum amplitude)
    parameter MAX_AMPLITUDE = 15;    // Max value for 4-bit amplitude

    // Frequency divisor calculation based on system clock
    always @(*) begin
        if (frequency > 0)
            frequency_divider = (100_000_000 / (frequency * 2)); // Adjust clock rate as needed
        else
            frequency_divider = 0; // Prevent division by zero
    end

    // Update amplitude scaling
    always @(*) begin
        if (amplitude > MAX_AMPLITUDE)
            amplitude_scaled = MAX_AMPLITUDE;
        else
            amplitude_scaled = amplitude;
        // Scale amplitude to voltage levels (assuming a 5V system)
        amplitude_limit = (amplitude_scaled * 5) / MAX_AMPLITUDE;
        threshold = frequency_divider * amplitude_limit; // Set the threshold based on frequency
    end

    // Main clock for waveform generation
    always @(posedge clk) begin
        counter <= counter + 1;

        // Check if counter reached threshold
        if (counter >= threshold) begin
            waveform_out <= ~waveform_out; // Toggle the output waveform
            counter <= 0; // Reset counter
        end
    end
    endmodule
    module pre_amplifier (
    input wire [3:0] in_signal,  // 4-bit input signal from waveform generator
    input wire [1:0] gain_ctrl,  // 2-bit gain control (00 = x1, 01 = x2, 10 = x4, 11 = x8)
    output reg [5:0] out_signal  // 6-bit amplified output signal
    );

    always @(*) begin
        case (gain_ctrl)
            2'b00: out_signal = in_signal;            // Gain of x1 (no amplification)
            2'b01: out_signal = in_signal << 1;       // Gain of x2 (shift left by 1 bit)
            2'b10: out_signal = in_signal << 2;       // Gain of x4 (shift left by 2 bits)
            2'b11: out_signal = in_signal << 3;       // Gain of x8 (shift left by 3 bits)
            default: out_signal = 6'b000000;          // Default output (in case of unexpected input)
        endcase
    end
    endmodule
    module bandpass_filters (
    input wire [5:0] freq_in,   // 6-bit input frequency
    output reg low_band,        // Output for low frequency band
    output reg mid_band,        // Output for mid frequency band
    output reg high_band        // Output for high frequency band
    );

    // Define frequency ranges for each band
    parameter low_min = 6'b000001;  // Minimum frequency for low band
    parameter low_max = 6'b001010;  // Maximum frequency for low band (example: 10)

    parameter mid_min = 6'b001011;  // Minimum frequency for mid band
    parameter mid_max = 6'b011100;  // Maximum frequency for mid band (example: 28)

    parameter high_min = 6'b011101; // Minimum frequency for high band
    parameter high_max = 6'b111111; // Maximum frequency for high band (example: 63)

    // Compare input frequency to predefined bands
    always @(*) begin
        // Low frequency band
        if (freq_in >= low_min && freq_in <= low_max)
            low_band = 1;
        else
            low_band = 0;

        // Mid frequency band
        if (freq_in >= mid_min && freq_in <= mid_max)
            mid_band = 1;
        else
            mid_band = 0;

        // High frequency band
        if (freq_in >= high_min && freq_in <= high_max)
            high_band = 1;
        else
            high_band = 0;
    end
    endmodule
    module adc_converter (
    input wire [5:0] freq_in,        // 6-bit frequency input from the bandpass filter
    input wire [3:0] amp_in,         // 4-bit amplitude input from the pre-amplifier
    output reg [9:0] digital_out,    // 10-bit digital output (6-bit freq + 4-bit amp)
    output reg [1:0] freq_label      // 2-bit label for bandpass filter range: 00 (low), 01 (mid), 10 (high)
    );

    // Frequency range labels for bandpass filter outputs
    parameter low_min = 6'b000001;    // Minimum frequency for low band
    parameter low_max = 6'b001010;    // Maximum frequency for low band (10)

    parameter mid_min = 6'b001011;    // Minimum frequency for mid band
    parameter mid_max = 6'b011100;    // Maximum frequency for mid band (28)

    parameter high_min = 6'b011101;   // Minimum frequency for high band
    parameter high_max = 6'b111111;   // Maximum frequency for high band (63)

    // Process to combine inputs and label frequency range
    always @(*) begin
        // Combine 6-bit frequency and 4-bit amplitude to form a 10-bit digital output
        digital_out = {freq_in, amp_in};  // Concatenate frequency and amplitude

        // Determine the frequency band label based on freq_in
        if (freq_in >= low_min && freq_in <= low_max)
            freq_label = 2'b00;  // Low frequency range
        else if (freq_in >= mid_min && freq_in <= mid_max)
            freq_label = 2'b01;  // Mid frequency range
        else if (freq_in >= high_min && freq_in <= high_max)
            freq_label = 2'b10;  // High frequency range
        else
            freq_label = 2'b11;  // Undefined/Out of range (for safety)
    end
    endmodule
    module Timer (
    input wire clk,           // Clock signal
    input wire reset,         // Reset signal
    input wire trigger,       // Signal that indicates a new amplitude trigger
    output reg [15:0]time1  // 16-bit output to store the time
    );
    reg [15:0] counter;

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            counter <= 16'b0;
            time1 <= 16'b0;
        end else if (trigger) begin
            time1 <= counter;   // Capture the current counter value
            counter <= 16'b0;  // Reset counter for the next time period
        end else begin
            counter <= counter + 1;  // Increment counter at every clock cycle
        end
    end
    endmodule
    module Frequency_Amplitude_Color_Comparator (
    input wire [5:0] frequency,  // 6-bit frequency input
    input wire [3:0] amplitude,   // 4-bit amplitude input
    output reg [3:0] red,         // 4-bit amplitude for Red
    output reg [3:0] yellow,      // 4-bit amplitude for Yellow
    output reg [3:0] green,       // 4-bit amplitude for Green
    output reg [3:0] blue,        // 4-bit amplitude for Blue
    output reg [3:0] white        // 4-bit amplitude for White
    );
    always @(*) begin
        // Default values
        red = 4'b0000;
        yellow = 4'b0000;
        green = 4'b0000;
        blue = 4'b0000;
        white = 4'b0000;

        // Determine color based on frequency
        if (frequency < 48) begin
            // Red range
            red = amplitude;  // Set Red amplitude
        end else if (frequency < 96) begin
            // Yellow range
            yellow = amplitude; // Set Yellow amplitude
        end else if (frequency < 144) begin
            // Green range
            green = amplitude; // Set Green amplitude
        end else if (frequency < 192) begin
            // Blue range
            blue = amplitude; // Set Blue amplitude
        end else begin
            // White range
            white = amplitude; // Set White amplitude
        end
    end
    endmodule
    module UpDownCounter (
    input wire clk,             // Clock input
    input wire reset,           // Reset input (active high)
    input wire up_down,         // Control signal: 1 for up, 0 for down
    input wire [3:0] amplitude, // 4-bit amplitude input
    output reg [3:0] count      // 4-bit count output
    );

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            count <= 4'b0000;  // Reset count to 0
        end else if (up_down) begin
            // Up Counter Mode
            if (count < amplitude) begin
                count <= count + 1; // Increment counter
            end else begin
                count <= 4'b0000;   // Wrap around to 0
            end
        end else begin
            // Down Counter Mode
            if (count > 4'b0000) begin
                count <= count - 1; // Decrement counter
            end else begin
                count <= amplitude; // Wrap around to max amplitude
            end
        end
    end
    endmodule
    module LED_Display (
    input wire clk,                  // Clock input
    input wire reset,                // Reset input (active high)
    input wire [5:0] frequency,      // 6-bit frequency input
    input wire [3:0] amplitude,      // 4-bit amplitude input
    output reg [1:0] color_value,    // 2-bit color value output (1, 2, 3)
    output reg [2:0] current_color   // 3-bit current color name (Red, Green, Yellow, Blue, White)
    );

    // Color names encoded as 3-bit values
    localparam RED    = 3'b000;
    localparam GREEN  = 3'b001;
    localparam YELLOW = 3'b010;
    localparam BLUE   = 3'b011;
    localparam WHITE  = 3'b100;

    // Frequency ranges for each color
    localparam FREQ_RED_MAX    = 6'd10;
    localparam FREQ_GREEN_MAX  = 6'd20;
    localparam FREQ_YELLOW_MAX = 6'd30;
    localparam FREQ_BLUE_MAX   = 6'd40;
    localparam FREQ_WHITE_MAX  = 6'd63;

    reg [2:0] color_sequence;   // Holds the current color index in the sequence
    reg match_found;            // Flag to indicate if a matching color is found

    // Sequential logic to update the current color and value based on frequency and amplitude
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            color_sequence <= RED;
            color_value <= 2'b00;
            match_found <= 1'b0;
        end else begin
            // Cycle through color sequence
            case (color_sequence)
                RED: begin
                    if (frequency <= FREQ_RED_MAX && !match_found) begin
                        color_value <= amplitude;  // Use amplitude as color value
                        match_found <= 1'b1;
                    end else begin
                        color_value <= 2'b11; // Colors before match get value 3
                    end
                    color_sequence <= GREEN;  // Move to next color
                end

                GREEN: begin
                    if (frequency <= FREQ_GREEN_MAX && !match_found) begin
                        color_value <= amplitude;
                        match_found <= 1'b1;
                    end else begin
                        color_value <= 2'b11; // Colors before match get value 3
                    end
                    color_sequence <= YELLOW;  // Move to next color
                end

                YELLOW: begin
                    if (frequency <= FREQ_YELLOW_MAX && !match_found) begin
                        color_value <= amplitude;
                        match_found <= 1'b1;
                    end else begin
                        color_value <= 2'b11; // Colors before match get value 3
                    end
                    color_sequence <= BLUE;  // Move to next color
                end

                BLUE: begin
                    if (frequency <= FREQ_BLUE_MAX && !match_found) begin
                        color_value <= amplitude;
                        match_found <= 1'b1;
                    end else begin
                        color_value <= 2'b11; // Colors before match get value 3
                    end
                    color_sequence <= WHITE;  // Move to next color
                end

                WHITE: begin
                    if (frequency <= FREQ_WHITE_MAX && !match_found) begin
                        color_value <= amplitude;
                        match_found <= 1'b1;
                    end else begin
                        color_value <= 2'b11; // Colors before match get value 3
                    end
                    color_sequence <= RED;  // Loop back to the first color
                end
            endcase
        end
    end

    // Output the current color
    always @(color_sequence) begin
        case (color_sequence)
            RED: current_color <= RED;
            GREEN: current_color <= GREEN;
            YELLOW: current_color <= YELLOW;
            BLUE: current_color <= BLUE;
            WHITE: current_color <= WHITE;
            default: current_color <= RED;
        endcase
    end

    endmodule

### TestBench:

    `timescale 1ns/1ps

    module tb_music_visualizer;

    // Declare testbench inputs and outputs
    reg clk;
    reg reset;
    reg [5:0] freq_ctrl;
    reg [3:0] amp_ctrl;
    reg trigger;
    reg up_down;
    reg [1:0] gain_ctrl;
    
    // Outputs from modules
    wire  wave_out;
    wire [5:0] pre_amp_out;
    wire low_band, mid_band, high_band;
    wire [9:0] adc_out;
    wire [1:0] freq_label;
    wire [15:0] time_out;
    wire [3:0] red, yellow, green, blue, white;
    wire [15:0] led_output;
    wire [3:0] counter_out;
    wire [1:0] color_value;
    wire [2:0] current_color;

    // Instantiate the waveform generator
    waveform_generator UUT_waveform (
        .clk(clk),
        
        .frequency(freq_ctrl),
        .amplitude(amp_ctrl),
        .waveform_out(wave_out)
    );

    // Instantiate the pre-amplifier
    pre_amplifier UUT_preamp (
        .in_signal(4'b0000+wave_out),
        .gain_ctrl(gain_ctrl),
        .out_signal(pre_amp_out)
    );

    // Instantiate the bandpass filters
    bandpass_filters UUT_bandpass (
        .freq_in(pre_amp_out),
        .low_band(low_band),
        .mid_band(mid_band),
        .high_band(high_band)
    );

    // Instantiate the ADC converter
    adc_converter UUT_adc (
        .freq_in(pre_amp_out),
        .amp_in(amp_ctrl),
        .digital_out(adc_out),
        .freq_label(freq_label)
    );

    // Instantiate the Timer module
    Timer UUT_timer (
        .clk(clk),
        .reset(reset),
        .trigger(trigger),
        .time1(time_out)
    );

    // Instantiate the Frequency-Amplitude-Color Comparator
    Frequency_Amplitude_Color_Comparator UUT_color_comp (
        .frequency(pre_amp_out),
        .amplitude(amp_ctrl),
        .red(red),
        .yellow(yellow),
        .green(green),
        .blue(blue),
        .white(white)
    );

    // Instantiate the Up-Down Counter
    UpDownCounter UUT_up_down_counter (
        .clk(clk),
        .reset(reset),
        .up_down(up_down),
        .amplitude(amp_ctrl),
        .count(counter_out)
    );

    // Instantiate the LED Display
    LED_Display UUT_led_display (
        .clk(clk),
        .reset(reset),
        .frequency(pre_amp_out),
        .amplitude(amp_ctrl),
        .color_value(color_value),
        .current_color(current_color)
    );

    // Clock generation logic
    always #5 clk = ~clk;  // Clock toggles every 5ns

    // Testbench routine
    initial begin
        // Initialize inputs
        clk = 0;
        reset = 1;
        freq_ctrl = 6'd0;
        amp_ctrl = 4'd0;
        gain_ctrl = 2'b00;
        trigger = 0;
        up_down = 1'b1; // Start with Up counting mode

        // Reset the system
        #10 reset = 0;

        // Apply test stimuli
        #10 freq_ctrl = 6'd15; amp_ctrl = 4'd5; // Set frequency and amplitude
        gain_ctrl = 2'b01; // Amplification x2

        // Trigger the timer
        #20 trigger = 1;
        #10 trigger = 0;

        // Change frequency and amplitude
        #50 freq_ctrl = 6'd35; amp_ctrl = 4'd9;
        gain_ctrl = 2'b10; // Amplification x4

        // Toggle the up/down counter
        #50 up_down = 1'b0;  // Switch to Down counting mode
        amp_ctrl = 4'd3;

        // Trigger again
        #20 trigger = 1;
        #10 trigger = 0;

        // Test for bandpass filter ranges
        #50 freq_ctrl = 6'd55; // Test high frequency band
        amp_ctrl = 4'd12;

        // Test multiple frequencies and amplitude levels
        repeat (5) begin
            #50 freq_ctrl = freq_ctrl + 6'd5;
            amp_ctrl = amp_ctrl + 4'd1;
        end

        // Finish the testbench
        #200 $finish;
    end

    // Dump waveform data for debugging
    initial begin
        $dumpfile("music_visualizer_test.vcd");
        $dumpvars(0, tb_music_visualizer);
    end
    endmodule
</details>



 <!--Seventh Section-->
##  References
<details>
  <summary>Click To See</summary>
  
- https://www.electrialtechnology.org/2019/02/analog-to-digital-converter-adc.html

- https://www.accessengineeringlibrary.com/content/book/9780071816717/chapter/chapter5

- https://en.m.wikipedia.org/wiki/Music_visualization.
</details>

