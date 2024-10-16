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