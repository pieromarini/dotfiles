OBJECTS = main.cpp
STD = -std=c++17
MYFLAGS = -g -Wall -grecord-gcc-switches -O2 -pipe -Werror=format-security -Werror=implicit-function-declaration -D_FORTIFY_SOURCE=2 -D_GLIBCXX_ASSERTIONS -fstack-clash-protection	
CXX = g++
EXEC = main

all: $(OBJECTS)
	$(CXX) $(STD) $(MYFLAGS) $(OBJECTS) -o $(EXEC)

clean: 
	rm $(EXEC)
