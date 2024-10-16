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