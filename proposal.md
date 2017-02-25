LED Matrix Driver
Stephen Hitchcock

--- Background ---
LEDs have revolutionized the world of entertainment technology. With applications ranging from small light strips to large matrix displays, the technology has flourished due to its low bar for entry and affordability. In the Spring of 2015, I was part of a project helmed by Matt Lathrop (B.S. Computer Science, Class of 2016) that took advantage of these factors to drastically reduce the cost of building a large scale Video Wall for theatrical performance (http://scarlet.stanford.edu/teach/index.php/HitchcockLathrop). The core principle behind the project was our ability to purchase addressable LEDs at an extremely low unit price, which could be combined to create a 40’ x 20’, 200 pixel x 100 pixel wall for under $10,000. 

The caveat to this affordability was that the LEDs had poor color replication abilities, leading to inconsistent color across the display. Our method involved capturing media from a computer, performing per pixel color correction, and distributing the signal to 25 Arduino chips to run the display. Since version one, we have identified several problems with the process, mostly stemming from the capture and distribution components. The Arduinos struggle to meet the processing requirements, leading to poor synchronization and framerate performance.

We have identified FPGAs as a promising technology to meet these challenges while providing additional opportunities to simplify the operation of the wall. To this end, we are looking to replace our Arduino system with FPGAs, with the long term goal of moving control onto each individual panel given the affordability of the chipset. 

--- Goals ---
As mentioned above, existing solutions for driving matrices of LEDs involve large numbers of microcontrollers which suffer from synchronization and bandwidth problems. Options for content delivery are limited, as most microcontrollers in our price range cannot decode unprocessed video inputs while efficiently outputting color corrected LED protocols; in our case, we had to run all of the processing on a large workstation. Our goal is to move the entire pipeline to a single FPGA with the extended goal of distributing image management and distribution to individual panels.

--- Deliverables ---
Our deliverable is a new control pipeline for operating the existing LED video wall. Depending on the time available for the project, this pipeline may include new features such as automated image mapping and support for standard video interfaces.

--- Timeline ---
Our primary deliverable targets include:
	Generating the WS2811 protocol to drive the LED matrix from a static buffer
	Accepting serialized video data over USB to display images on the wall
	Reworking the desktop framework to support larger matrices from a single control board

Our secondary deliverable targets include:
	Performing pixel color correction on the FPGA
	Accepting video data through more traditional protocols (VGA, SDI, etc)

Our tertiary deliverable targets include:
	Moving to a single FPGA per panel model with built in color correction
	Synchronizing chips through a new digital video protocol
	Generating said protocol from standard protocols (VGA, SDI, etc)
	Automating content mapping through spatially aware video inputs and outputs


