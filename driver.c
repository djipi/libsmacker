/*
 * libsmacker - A C library for decoding .smk Smacker Video files Copyright
 * (C) 2012-2013 Greg Kennedy
 * 
 * See smacker.h for more information.
 * 
 * driver.c Driver program
 */


#include <stdio.h>
#include <string.h>
#include "smacker.h"

#ifdef NO_LOG_SUPPORT
#define log_printf(...)
#define log_fprintf(...)
#else
#define log_printf	printf
#define log_fprintf	fprintf
#endif

#ifndef NO_EXPORT_BMP
void
dump_bmp(const unsigned char *pal, const unsigned char *image_data, unsigned int w, unsigned int h, unsigned int framenum)
{
	int		i;
	FILE           *fp;
	char		filename  [128];
	unsigned int	temp;
	sprintf(filename, "bmp/out_%04u.bmp", framenum);
	fp = fopen(filename, "wb");
	if (!fp) { log_fprintf(stderr, "Failed to open %s for write\n", filename); return; }
	fwrite("BM", 2, 1, fp);
	temp = 1078 + (w * h);
	fwrite(&temp, 4, 1, fp);
	temp = 0;
	fwrite(&temp, 4, 1, fp);
	temp = 1078;
	fwrite(&temp, 4, 1, fp);
	temp = 40;
	fwrite(&temp, 4, 1, fp);
	fwrite(&w, 4, 1, fp);
	fwrite(&h, 4, 1, fp);
	temp = 1;
	fwrite(&temp, 2, 1, fp);
	temp = 8;
	fwrite(&temp, 4, 1, fp);
	temp = 0;
	fwrite(&temp, 2, 1, fp);
	temp = w * h;
	fwrite(&temp, 4, 1, fp);
	temp = 0;
	fwrite(&temp, 4, 1, fp);
	fwrite(&temp, 4, 1, fp);
	temp = 256;
	fwrite(&temp, 4, 1, fp);
	temp = 256;
	fwrite(&temp, 4, 1, fp);
	temp = 0;
	for (i = 0; i < 256; i++)
	{
		fwrite(&pal[(i * 3) + 2], 1, 1, fp);
		fwrite(&pal[(i * 3) + 1], 1, 1, fp);
		fwrite(&pal[(i * 3)], 1, 1, fp);
		fwrite(&temp, 1, 1, fp);
	}

	for (i = h - 1; i >= 0; i--)
	{
		fwrite(&image_data[i * w], w, 1, fp);
	}

	fclose(fp);
}
#else
#define dump_bmp(...)
#endif

int
main(int argc, char *argv[])
{
	unsigned long	w, h, f;
	double 	usf;
	smk		s;

	#ifndef NO_AUDIO_SUPPORT
	char		filename[128];
	FILE           *fpo[7] = {NULL};
	#endif

	if (argc != 2)
	{
		log_printf("Usage: %s file.smk\n", argv[0]);
		return -1;
	}
	else
	{
	/* s = smk_open(argv[1], SMK_MODE_DISK); */
	s = smk_open_file(argv[1], SMK_MODE_MEMORY);
	if (s == NULL)
	{
		log_printf("Errors encountered opening %s, exiting.\n", argv[1]);
		return -1;
	}
		else
		{
	/* print some info about the file */
	smk_info_all(s, NULL, &f, &usf);
	smk_info_video(s, &w, &h, NULL);

	log_printf("Opened file %s\nWidth: %lu\nHeight: %lu\nFrames: %lu\nFPS: %f\n", argv[1], w, h, f, 1000000.0 / usf);

#ifndef NO_AUDIO_SUPPORT
	unsigned char	a_t, a_c[7], a_d[7];
	unsigned long	a_r[7];

	smk_info_audio(s, &a_t, a_c, a_d, a_r);

	int		i;
	for (i = 0; i < 7; i++)
	{
		log_printf("Audio track %d: %u bits, %u channels, %luhz\n", i, a_d[i], a_c[i], a_r[i]);
	}
#endif

	/* Turn on decoding for palette, video, and audio track 0 */
	smk_enable_video(s, 1);

#ifndef NO_AUDIO_SUPPORT
	for (i = 0; i < 7; i++)
	{
		if (a_t & (1 << i))
		{
			smk_enable_audio(s, i, 1);
			sprintf(filename, "out_%01d.raw", i);
			fpo[i] = fopen(filename, "wb");
		} else
		{
			fpo[i] = NULL;
		}
	}
#endif	

	//Get a pointer to first frame

		smk_first(s);

	unsigned long	cur_frame;

	smk_info_all(s, &cur_frame, NULL, NULL);
	dump_bmp(smk_get_palette(s), smk_get_video(s), w, h, cur_frame);

#ifndef NO_AUDIO_SUPPORT
	for (i = 0; i < 7; i++)
	{
		if (fpo[i] != NULL)
		{
			fwrite(smk_get_audio(s, i), smk_get_audio_size(s, i), 1, fpo[i]);
		}
	}
#endif	
	log_printf(" -> Frame %lu\n", cur_frame);


	for (cur_frame = 1; cur_frame < f; cur_frame ++)
	{	
		smk_next(s);
		/* smk_info_all(s, &cur_frame, NULL, NULL); */

		dump_bmp(smk_get_palette(s), smk_get_video(s), w, h, cur_frame);

#ifndef NO_AUDIO_SUPPORT
		for (i = 0; i < 7; i++)
		{
			if (fpo[i] != NULL)
			{
				fwrite(smk_get_audio(s, i), smk_get_audio_size(s, i), 1, fpo[i]);
			}
		}
#endif		
		log_fprintf(stderr," -> Frame %lu\n", cur_frame);
		//Advance to next frame

	}

#ifndef NO_AUDIO_SUPPORT
	for (i = 0; i < 7; i++)
	{
		if (fpo[i] != NULL)
		{
			fclose(fpo[i]);
		}
			}
#endif		
	smk_close(s);

	return 0;
		}
	}
}
