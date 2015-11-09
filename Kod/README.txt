Refer to the main_project/ folder for the latest versions of all .vhd files used in the system.

*********************************
** Quartus system project file **
*********************************

	main_project/Proj.qpf

Not all files used are included in the project file list, but navigating the block diagram (Proj.bdf)
allows access to all files used (that also exist in the main_project/ folder).

The top module of our system has no TestBench to simulate and test it.

However, refer to:

	analysis/
	bar_tender/
	bar_tender/Msim/
	Keyboard/
	Kayboard/kbsim/
	vga_drive/
	vga_drive/Msim/
	vol_bal/Msim/
	
... and one can find (hopefully) working versions of .mpf (Modelsim project files) and written *TB*.vhd files
to simulate and test (sub)modules.

**********************
** Background image **
**********************

	BILD7.png
	bild/BILD7.png

Refer to the bild/ folder for local upload tools.