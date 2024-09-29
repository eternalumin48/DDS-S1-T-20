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
  <summary>Detail</summary>
  
  1 Background
The music beat visualizer project aims to create a dynamic display that visually
represents audio signals by illuminating LEDs based on the rhythm and ampli-
tude of the music. By utilizing analog components such as the ADC 0804 and
IC 8038, the project converts audio frequencies into digital signals, allowing for
real-time visualization. This engaging device enhances the auditory experience,
making it ideal for events and personal enjoyment, showcasing the interplay
between sound and light in an innovative manner.
2 Motivation
I am passionate about developing a tool that helps teach music to visually
impaired individuals, opening up new avenues for creativity and expression.
I’m inspired to create a music beat visualizer that translates audio rhythms
into captivating visual displays, enhancing both entertainment and performance
experiences for everyone. Additionally, I’m motivated to explore the therapeutic
applications of a music beat visualizer, using sound-to-visual conversions to
provide calming and engaging experiences for individuals in therapy. Together,
these initiatives reflect my commitment to making music more accessible and
enjoyable for all.
3 Our Contribution
My contribution to the music beat visualizer project involves designing and im-
plementing the entire system using analog components, which distinguishes it
from typical digital solutions. I am responsible for selecting and integrating key
elements like the ADC 0804 and IC 8038 to convert audio signals into captivat-
ing visual displays. This analog approach emphasizes creativity and simplicity,
steering clear of microcontrollers and digital circuitry. I will also develop circuit
schematics, ensuring effective filtering and amplification for accurate signal pro-
cessing. My role includes testing and calibrating the system to deliver a unique
visual experience that showcases music’s rhythm and amplitude in real-time.
4 Unique Components
• Op-Amp LM386
• Timer IC-555
• Darlington Transistor array ULN2803
• Comparator LM339
• Decoder 74HC154
1
• Resistor 100 ohm,120 ohm,180 ohm
• capacitors
• LED Display
• Up-Down counter 74HC193
• ADC
• bandpass filters
• wave-generator IC8038
5 Limitations
The proposed system has several limitations. First, it will not output visual-
izations for higher frequencies, restricting its effectiveness with certain music
types. Additionally, the comparator threshold must be set manually, which
makes the system less adaptable to varying music styles or loudness levels. The
use of simple band-pass filters may not provide sufficient frequency isolation,
particularly when compared to more advanced techniques like FFT without a
microcontroller. Furthermore, the system is vulnerable to noise sensitivity and
signal degradation, which can affect performance. Finally, the lack of color
variations in the visual output limits the overall user experience.
6 Assumptions
Several key assumptions underlie this project. It assumes that the audio input
signal is clean and free from significant noise or interference, ensuring accurate
detection of beats and amplitudes. The focus is on audio frequencies between
20 Hz and 20 kHz. It also assumes that all necessary components are available
and functioning as specified; alternative components can be used if needed (e.g.,
substituting TL072 with LM358). Additionally, the project assumes that tem-
perature and environmental humidity will not significantly affect performance
and that the system will be calibrated with adjustable resistors and capacitors
to accommodate LED brightness.
7 References
• https://wmpvis.fandom.com/wiki/Windows_Media_Player_Visualization_Wiki
• https://www.accessengineeringlibrary.com/content/book/9780071816717/chapter/chapter5
• https://en.m.wikipedia.org/wiki/Music_visualization
2
</details>

<!-- Third Section -->
## Working
<details>
  <summary>Detail</summary>

  > Explain the working of your model with the help of a functional table (compulsory) followed by the flowchart.
</details>

<!-- Fourth Section -->
## Logisim Circuit Diagram
<details>
  <summary>Detail</summary>

  > Update a neat logisim circuit diagram
</details>

<!-- Fifth Section -->
## Verilog Code
<details>
  <summary>Detail</summary>

  > Neatly update the Verilog code in code style only.
</details>
