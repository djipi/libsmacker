
	.globl OSJAG_Directory
	.globl OSJAG_SeekPosition
	.globl OSJAG_PtrBuffer


	.data
	.even

OSJAG_Directory:
OSJAG_Directory_Deb:
	dc.l	OSJAG_Directory_File1_Info
OSJAG_Directory_End:
	dc.l	0

	.even

OSJAG_Directory_File1_Info:
	dc.l	OSJAG_Directory_File1_File
	dc.l	OSJAG_Directory_File1_End-OSJAG_Directory_File1_Deb
	dc.b	"out_Test1.smk",0
	.even
OSJAG_Directory_File1_File:
OSJAG_Directory_File1_Deb:
	.incbin	"C:/Projects/Smacker/Samples/wetlands/out_Test.smk"
OSJAG_Directory_File1_End:

	.bss
	.even

OSJAG_SeekPosition:
	ds.l	(OSJAG_Directory_End-OSJAG_Directory_Deb)/4
OSJAG_PtrBuffer:
	ds.l	(OSJAG_Directory_End-OSJAG_Directory_Deb)/4


	.end