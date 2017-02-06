

#include "test.h"
#include "libavutil/fifo.h"
#include "libavutil/base64.h"
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

//==========================//
// unit test

int test_demo()
{
	AVFifoBuffer *fifos = NULL;
	char *szin = "hlafasflk;sf;ewhfwehf";
	char szout[256];
	
	printf("demo \n");
	
	fifos = av_fifo_alloc_array(128, 10);
	
	av_fifo_free(fifos);
	
	av_base64_encode(szout, 256, szin, strlen(szin));
	printf(szout);
}