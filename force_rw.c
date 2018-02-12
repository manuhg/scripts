#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <sys/types.h>
#include <sys/mman.h>
#include <fcntl.h>
#include <byteswap.h>



int main(int argc, char *argv[])
{
	int fd = open(argv[1], O_RDWR); int i;
	if(fd < 0) {
		perror("open");
		return -1;
	}
	
	unsigned char *buffer = (unsigned char *)mmap(NULL, 2048, PROT_READ|PROT_WRITE, MAP_SHARED, fd, 0);
	if(buffer == (unsigned char*)0xffffffff) {
		perror("mmap");
		return -1;
	}
        for(i=0;i<2048;i++)
	buffer[i]=0;
	
	printf("Success!! :D\n");
	return 0;
}
