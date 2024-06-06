CC            = gcc
CFLAGS        = -O3 -Wall -W -march=native -mtune=native
INCPATH       = -I/usr/include
DEL_FILE      = rm -f
OBJECTS       = vingrep.o
TARGET        = vingrep
first: all

all: $(TARGET)

$(TARGET): vingrep.c makefile
	$(CC) $(CFLAGS) vingrep.c -o vingrep	
	cp vingrep ~/bin

clean:
	$(DEL_FILE) *.o $(TARGET)

run:
	./$(TARGET) char ~/projects 5
