Note: If there are errors in this description, please inform me, and I will try
to correct them. Please have a look a day later or so, and it is hopefully fixed.


CONVERT PNG to BIN (in the format used in the VGA lab):

0. Make sure you have a picture as a 640x480 PNG format. This is refered to X.png

1. Start Matlab.

2. Copy the file im.m to the folder where you have the image.

3. In Matlab: Go to this folder.

4. > im loadPNG,saveBin X
   => Now you should have X.bin in your folder.
   (see more help > helpwin im)

UPLOAD BIN to the DE2 board:

0. Log in at the computer that is connected to the DE2 board.

1. Upload DE2_USB_API.sof to the DE2 board.

2. Start DE2_Control_Panel.exe

3. In the menu: Connect to the DE2 board.
Now, try to control the LEDs etc on the board from the control panel.

4. In the SRAM tab: Guess what to do.

5. In the menu again: Disconnect from the USB.
   (Otherwise, you will not be able to program the board again).

6. DO NOT RESTART the board. If you do, the default application will overwrite
   your background.

7. Upload your .sof file for the VGA lab to the DE2
   => You should see your picture as it is (using the color compression that is).

Good luck.
Petter
