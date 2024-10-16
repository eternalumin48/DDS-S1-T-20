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
</details>

 <!--Seventh Section-->
##  References
<details>
  <summary>Click To See</summary>
  
- https://www.electrialtechnology.org/2019/02/analog-to-digital-converter-adc.html

- https://www.accessengineeringlibrary.com/content/book/9780071816717/chapter/chapter5

- https://en.m.wikipedia.org/wiki/Music_visualization.
</details>

