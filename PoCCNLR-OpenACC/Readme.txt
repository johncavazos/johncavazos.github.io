How to Run:

1) Double click cmd-WindowsXP(.exe) located in this directory or start your 
native command prompt
2) Set path environment variable in the command prompt:
   set path=your:\absolute\directory\of\this\folder\bin\ 
   for example:
   set path=C:\Users\Wei\Desktop\PoCCNLR-OpenACC\bin\
3) Reconstruct sequential program from traces (memory trace + precedence trace)

   pocc -t -k 100 APP-GetMemoryTrace/gemver.memtrace.txt APP-GetExecutionTrace/ExecutionTrace
   
   Note: the last two parameters should use Unix style address, i.e. the path 
separator to use is "/" instead of "\". Of course, you can also use the 
following command if the two files are copied into the top directory:
   
   pocc -t -k 100 gemver.memtrace.txt ExecutionTrace
   
4) If you see the output (only) to be :

   loop reconstructed, please see Reconstructed-seq.c file located here!
 
   Then the sequential program is successfully reconstructed and stored in 
Reconstructed-seq.c file, otherwise please contact me at weiwang@udel.edu.

--------------------------------------------------------------------------------
5) To generate the OpenACC code from the original gemver.c program,
type:
	pocc --target=acc-kernel --target=acc-parallel gemver.c
	
	Outcome: the generated OpenACC code is in gemver.pocc.c 
--------------------------------------------------------------------------------

What is contained in this top folder:

-- APP-GetExecutionTrace contains the scripts to generate execution trace.
   Take gemver program for example, the instrumented code is gemverInstrumented.c
   This file is also the file to generate memory trace. 
   To get the execution trace, type the following command  in this subdirectory:
   
   ./gen-ExecutionTrace.sh gemverInstrumented 
   
   Upon finish, the above script will generate ExecutionTrace file.
   This file is like the following: 
   
	68@0=0;
	69@0=0;
	72@0=0;
	73@0=(0+0)/0/0;
	74@0=(0+0)/0/0;
	75@0=(0+0)/0/0;
	76@0=(0+0)/0/0;
	77@0=(0+0)/0/0;
	78@0=0;
	79@0=0;
	82@0=(((DATA_TYPE)0)*0)/0;
	125@0=0+0*0+0*0;
	131@0=0+0*0*0;
	136@0=0+0;
	142@0=0+0*0*0;

   The numbers before "@" are the line numbers. The abstract expressions after "@"
   record the operators between operands (memory accesses).
   
-- APP-GetMemoryTrace contains the original program (gemver.c), the same
   instrumented code (gemverInstrumented.c), and the memory trace (gemver.memtrace.c)
   
   In instrumenting the original code, the following rules should be respected:
   1) Currently, only assignment statements are supported, so please do not
   instrument if statements, print statements etc.
   2) Currently, each instrumented assignment statements should only occupy ONE line.
   3) Detailed documentation of restrictions will be provided later.
   
-- bin/, generators/, lib/ are directories that provide linux "sh" and cygwin
environment. 

-- pocc.exe 
   the executable that integrate NLR and other scripts located in this folder
   
   