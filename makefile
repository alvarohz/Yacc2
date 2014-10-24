aritme: y.tab.c lex.yy.c main.c head.h
	gcc y.tab.c lex.yy.c main.c -o aritme
	
y.tab.c: aritmetica.y
	yacc -d aritmetica.y -o y.tab.c
	
lex.yy.c: aritmetica.l
	lex aritmetica.l
	
clean:
	rm aritme
	rm lex.yy.c
	rm y.tab.c
	rm y.tab.h
