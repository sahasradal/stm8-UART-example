# stm8-UART-example
stm8 UART example in ST ASSEMBLER
This code was written to introduce myself to stm8 microcontrollers UART periphral. This is written in crude ST ASSEMBLER.
I have written the whole program as a single file as I started out with ATMEL. The stack initialisation and the interrupt vector
tables are created by the ST-VISUAL DEVELOPER on creating a new project. The STM8SF103.inc & STM8SF103.asm files should be manually included
from the C:\Program Files (x86)\STMicroelectronics\st_toolset\asm\include    to the project source folder where the main.s file resides.
The program can be burned to the chip using stlink chinese clone with ST VISUAL PROGRAMMER software from ST electronics.
The stm8 chip uses the (UART1_TX) PD5 and (UART1_RX) PD6 for hardware UART. Using USBtoSERIAL converter (FTDI) the stm8 can be connected to
a PC which runs TERRATERM or PUTTY. Use local echo option in the terminal to see what is typed on the screen. The program waits till 23 characters
are keyed in and after a delay of 250ms it outputs the typed characters on the terminal screen as a new line.The TX of stm8 is connected to RX of the FTDI and the
RX of stm8 is connected to TX of FTDI dongle. Te ground also need to be shared between the stm8 and FTDI serial to USB converter. Select "serial"in terminal options,
select the correct COM port on which the PC recognises the FTDI dongle.
this was to test the TX and RX function
