" vim autocommand file for makefiles
:insert
DEBUG					= #-g
CC            = gcc
CXX           = g++
DEFINES       = 
CXXFLAGS      = $(DEBUG) -W -Wall -pipe -O3 -msse -march=pentium4 -mfpmath=sse  
INCPATH       = -I/usr/include 
LINK          = g++
LFLAGS        = 
LIBS          =  
RANLIB        = 
DEL_FILE      = rm -f
SOURCES       = main.cpp 
OBJECTS       = main.o 
TARGET        = main

first: all

all: $(TARGET)

$(TARGET):  $(OBJECTS)  
	$(LINK) $(LFLAGS) -o $(TARGET) $(OBJECTS) $(OBJCOMP) $(LIBS)
main.o: main.cpp 
	$(CXX) -c $(CXXFLAGS) $(INCPATH) -o main.o main.cpp
clean:
	$(DEL_FILE) *.o $(TARGET)


