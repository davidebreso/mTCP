
all : clean ptach

clean : .symbolic
  rm -f ptach
  rm -f *.o
  rm -f *.map

ptach : patch.cpp
  gcc patch.cpp -o ptach

