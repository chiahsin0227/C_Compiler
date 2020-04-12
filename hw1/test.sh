flex scanner.l 
gcc -o scanner lex.yy.c -lfl
./scanner < test.txt > out.txt 
golden_scanner <test.txt  > output.txt
diff out.txt  output.txt