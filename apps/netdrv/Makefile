#
# NetDrv makefile
#
# -oa   Relax alias checking
# -ob   Try to generate straight line code
# -oe - expand user functions inline (-oe=20 is default)
# -oh   Enable repeated optimizations
# -oi   generate certain lib funcs inline
# -oi+  Set max inline depth (C++ only, use -oi for C)
# -ok   Flowing of register save into function flow graph
# -ol   loop optimizations
# -ol+  loop optimizations plus unrolling
# -or   Reorder for pipelined (486+ procs); not sure if good to use
# -os   Favor space over time
# -ot   Favor time over space
# -ei   Allocate an "int" for all enum types
# -zp2  Allow compiler to add padding to structs
# -zpw  Use with above; make sure you are warning free!
# -0    8088/8086 class code generation
# -s    disable stack overflow checking
# -zmf  put each function in a new code segment; helps with linking

# For this code performance is not an issue.  Make it small.

tcp_h_dir = ../../tcpinc/
tcp_c_dir = ../../tcplib/
common_h_dir = ../../include

memory_model = -ms
compile_options = -0 $(memory_model) -DCFG_H=\"netdrv.cfg\" -oh -ok -os -s -oa -ei -zp2 -zpw -we -zmf
compile_options += -i=$(tcp_h_dir) -i=$(common_h_dir)

tcpobjs = packet.o arp.o eth.o ip.o utils.o timer.o ipasm.o udp.o dns.o trace.o
objs = netdrv.o

all : clean netdrv.exe simple.sys rename

rename : .symbolic
	mv -f netdrv.exe netdrive.exe
	mv -f simple.sys netdrive.sys

clean : .symbolic
	rm -f netdrv.exe
	rm -f netdrive.exe
	rm -f netdrive.sys
	rm -f *.o
	rm -f *.map
	rm -f *.lst
	rm -f simple.exe
	rm -f simple.sys
	rm -f simple_tmp.asm
	rm -f chksum_t.*

patch : .symbolic
	../../utils/ptach netdrv.exe netdrv.map $(memory_model)

.asm : $(tcp_c_dir)

.cpp : $(tcp_c_dir)

.asm.o :
	wasm -0 $(memory_model) $[*

.cpp.o :
	wpp $[* $(compile_options)

netdrv.exe : $(tcpobjs) $(objs)
	wlink system dos option map option eliminate option stack=4096 name $@ file {$(tcpobjs) $(objs)}


simple.o :
	bash fixdate.sh
	wasm simple_tmp.asm
	mv -f simple_tmp.o simple.o

simple.sys : simple.o
	wlink system dos file simple.o
	exe2bin simple.exe simple.sys



# Special binaries for chksum code testing.  These are not normally built.

chksum_test : clean chksum_t.exe chksum_t.sys

chksum_t.exe : chksum_test.o ipasm.o
	wlink system dos option map option eliminate option stack=4096 name $@ file chksum_test.o file ipasm.o

simple_chksum_test.o :
	bash fixdate.sh
	wasm simple_tmp.asm -dCHKSUM_TESTING
	mv -f simple_tmp.o simple_chksum_test.o

chksum_t.sys : simple_chksum_test.o
	wlink system dos file simple_chksum_test.o
	exe2bin simple_chksum_test.exe chksum_t.sys
	rm -f simple_chksum_test.exe
