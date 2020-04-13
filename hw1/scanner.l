%{

#include <stdio.h>
#include <stdlib.h>

char buffer[500];
int line_count=1;
int char_count=0;

int token=1;
int source=1;

%}

DIGIT         ([0-9])
INTEGER       ([-+]?{DIGIT}+)
IDENTIFIER    ([a-zA-Z_][a-zA-Z_0-9]*)
BEG_COMMENT   ("/*")
END_COMMENT   ("*/")
SINGLE_COMM   ("//"[^\n]*)
STRING        (\"[^\"]*\")
DOUBLE_a      ([0-9]+[.][0-9]*)
DOUBLE_b      ([0-9]*[.][0-9]+)
CHARACTER     ('([^\r^\n^']|\\0)')
NON_NEXT_LINE ([^\n])
SOURCE_ON     ("#"[ \t]*"pragma"[ \t]*"source"[ \t]*"on")
SOURCE_OFF    ("#"[ \t]*"pragma"[ \t]*"source"[ \t]*"off")
TOKEN_ON      ("#"[ \t]*"pragma"[ \t]*"token"[ \t]*"on")
TOKEN_OFF     ("#"[ \t]*"pragma"[ \t]*"token"[ \t]*"off")

%x COMMENT

%%

{SOURCE_OFF}  { sprintf(&(buffer[char_count]), "%s", yytext); char_count+=yyleng; source=0; }
{SOURCE_ON}   { sprintf(&(buffer[char_count]), "%s", yytext); char_count+=yyleng; source=1; }
{TOKEN_OFF}   { sprintf(&(buffer[char_count]), "%s", yytext); char_count+=yyleng; token=0; }
{TOKEN_ON}    { sprintf(&(buffer[char_count]), "%s", yytext); char_count+=yyleng; token=1; }

{BEG_COMMENT} { sprintf(&(buffer[char_count]), "%s", yytext); char_count+=yyleng; BEGIN COMMENT; }
<COMMENT>{NON_NEXT_LINE} { sprintf(&(buffer[char_count]), "%s", yytext); char_count+=yyleng; }
<COMMENT>\n   { if(source) printf("%d:%s\n", line_count, buffer); buffer[0]='\0'; char_count=0; line_count++; }
<COMMENT>{END_COMMENT} { sprintf(&(buffer[char_count]), "%s", yytext); char_count+=yyleng; BEGIN 0; }
{SINGLE_COMM} { sprintf(&(buffer[char_count]), "%s", yytext); char_count+=yyleng; }

"void"        { if(token) printf("#token key:void\n"); sprintf(&(buffer[char_count]), "%s", yytext); char_count+=yyleng; }
"const"       { if(token) printf("#token key:const\n"); sprintf(&(buffer[char_count]), "%s", yytext); char_count+=yyleng; }
"NULL"        { if(token) printf("#token key:NULL\n"); sprintf(&(buffer[char_count]), "%s", yytext); char_count+=yyleng; }
"for"         { if(token) printf("#token key:for\n"); sprintf(&(buffer[char_count]), "%s", yytext); char_count+=yyleng; }
"do"          { if(token) printf("#token key:do\n"); sprintf(&(buffer[char_count]), "%s", yytext); char_count+=yyleng; }
"while"       { if(token) printf("#token key:while\n"); sprintf(&(buffer[char_count]), "%s", yytext); char_count+=yyleng; }
"break"       { if(token) printf("#token key:break\n"); sprintf(&(buffer[char_count]), "%s", yytext); char_count+=yyleng; }
"continue"    { if(token) printf("#token key:continue\n"); sprintf(&(buffer[char_count]), "%s", yytext); char_count+=yyleng; }
"if"          { if(token) printf("#token key:if\n"); sprintf(&(buffer[char_count]), "%s", yytext); char_count+=yyleng; }
"else"        { if(token) printf("#token key:else\n"); sprintf(&(buffer[char_count]), "%s", yytext); char_count+=yyleng; }
"return"      { if(token) printf("#token key:return\n"); sprintf(&(buffer[char_count]), "%s", yytext); char_count+=yyleng; }
"struct"      { if(token) printf("#token key:struct\n"); sprintf(&(buffer[char_count]), "%s", yytext); char_count+=yyleng; }
"switch"      { if(token) printf("#token key:switch\n"); sprintf(&(buffer[char_count]), "%s", yytext); char_count+=yyleng; }
"case"        { if(token) printf("#token key:case\n"); sprintf(&(buffer[char_count]), "%s", yytext); char_count+=yyleng; }
"default"     { if(token) printf("#token key:default\n"); sprintf(&(buffer[char_count]), "%s", yytext); char_count+=yyleng; }

"int"         { if(token) printf("#token key:int\n"); sprintf(&(buffer[char_count]), "%s", yytext); char_count+=yyleng; }
"double"      { if(token) printf("#token key:double\n"); sprintf(&(buffer[char_count]), "%s", yytext); char_count+=yyleng; }
"float"       { if(token) printf("#token key:float\n"); sprintf(&(buffer[char_count]), "%s", yytext); char_count+=yyleng; }
"char"        { if(token) printf("#token key:char\n"); sprintf(&(buffer[char_count]), "%s", yytext); char_count+=yyleng; }

"fclose"      { if(token) printf("#token key:fclose\n"); sprintf(&(buffer[char_count]), "%s", yytext); char_count+=yyleng; }
"clearerr"    { if(token) printf("#token key:clearerr\n"); sprintf(&(buffer[char_count]), "%s", yytext); char_count+=yyleng; }
"feof"        { if(token) printf("#token key:feof\n"); sprintf(&(buffer[char_count]), "%s", yytext); char_count+=yyleng; }
"ferror"      { if(token) printf("#token key:ferror\n"); sprintf(&(buffer[char_count]), "%s", yytext); char_count+=yyleng; }
"fflush"      { if(token) printf("#token key:fflush\n"); sprintf(&(buffer[char_count]), "%s", yytext); char_count+=yyleng; }
"fgetpos"     { if(token) printf("#token key:fgetpos\n"); sprintf(&(buffer[char_count]), "%s", yytext); char_count+=yyleng; }
"fopen"       { if(token) printf("#token key:fopen\n"); sprintf(&(buffer[char_count]), "%s", yytext); char_count+=yyleng; }
"fread"       { if(token) printf("#token key:fread\n"); sprintf(&(buffer[char_count]), "%s", yytext); char_count+=yyleng; }
"freopen"     { if(token) printf("#token key:freopen\n"); sprintf(&(buffer[char_count]), "%s", yytext); char_count+=yyleng; }
"fseek"       { if(token) printf("#token key:fseek\n"); sprintf(&(buffer[char_count]), "%s", yytext); char_count+=yyleng; }
"fsetpos"     { if(token) printf("#token key:fsetpos\n"); sprintf(&(buffer[char_count]), "%s", yytext); char_count+=yyleng; }
"ftell"       { if(token) printf("#token key:ftell\n"); sprintf(&(buffer[char_count]), "%s", yytext); char_count+=yyleng; }
"fwrite"      { if(token) printf("#token key:fwrite\n"); sprintf(&(buffer[char_count]), "%s", yytext); char_count+=yyleng; }
"remove"      { if(token) printf("#token key:remove\n"); sprintf(&(buffer[char_count]), "%s", yytext); char_count+=yyleng; }
"rename"      { if(token) printf("#token key:rename\n"); sprintf(&(buffer[char_count]), "%s", yytext); char_count+=yyleng; }
"rewind"      { if(token) printf("#token key:rewind\n"); sprintf(&(buffer[char_count]), "%s", yytext); char_count+=yyleng; }
"setbuf"      { if(token) printf("#token key:setbuf\n"); sprintf(&(buffer[char_count]), "%s", yytext); char_count+=yyleng; }
"setvbuf"     { if(token) printf("#token key:setvbuf\n"); sprintf(&(buffer[char_count]), "%s", yytext); char_count+=yyleng; }
"tmpfile"     { if(token) printf("#token key:tmpfile\n"); sprintf(&(buffer[char_count]), "%s", yytext); char_count+=yyleng; }
"tmpnam"      { if(token) printf("#token key:tmpnam\n"); sprintf(&(buffer[char_count]), "%s", yytext); char_count+=yyleng; }
"fprintf"     { if(token) printf("#token key:fprintf\n"); sprintf(&(buffer[char_count]), "%s", yytext); char_count+=yyleng; }
"printf"      { if(token) printf("#token key:printf\n"); sprintf(&(buffer[char_count]), "%s", yytext); char_count+=yyleng; }
"sprintf"     { if(token) printf("#token key:sprintf\n"); sprintf(&(buffer[char_count]), "%s", yytext); char_count+=yyleng; }
"vfprintf"    { if(token) printf("#token key:vfprintf\n"); sprintf(&(buffer[char_count]), "%s", yytext); char_count+=yyleng; }
"vprintf"     { if(token) printf("#token key:vprintf\n"); sprintf(&(buffer[char_count]), "%s", yytext); char_count+=yyleng; }
"vsprintf"    { if(token) printf("#token key:vsprintf\n"); sprintf(&(buffer[char_count]), "%s", yytext); char_count+=yyleng; }
"fscanf"      { if(token) printf("#token key:fscanf\n"); sprintf(&(buffer[char_count]), "%s", yytext); char_count+=yyleng; }
"scanf"       { if(token) printf("#token key:scanf\n"); sprintf(&(buffer[char_count]), "%s", yytext); char_count+=yyleng; }
"sscanf"      { if(token) printf("#token key:sscanf\n"); sprintf(&(buffer[char_count]), "%s", yytext); char_count+=yyleng; }
"fgetc"       { if(token) printf("#token key:fgetc\n"); sprintf(&(buffer[char_count]), "%s", yytext); char_count+=yyleng; }
"fgets"       { if(token) printf("#token key:fgets\n"); sprintf(&(buffer[char_count]), "%s", yytext); char_count+=yyleng; }
"fputc"       { if(token) printf("#token key:fputc\n"); sprintf(&(buffer[char_count]), "%s", yytext); char_count+=yyleng; }
"fputs"       { if(token) printf("#token key:fputs\n"); sprintf(&(buffer[char_count]), "%s", yytext); char_count+=yyleng; }
"getc"        { if(token) printf("#token key:getc\n"); sprintf(&(buffer[char_count]), "%s", yytext); char_count+=yyleng; }
"getchar"     { if(token) printf("#token key:getchar\n"); sprintf(&(buffer[char_count]), "%s", yytext); char_count+=yyleng; }
"gets"        { if(token) printf("#token key:gets\n"); sprintf(&(buffer[char_count]), "%s", yytext); char_count+=yyleng; }
"putc"        { if(token) printf("#token key:putc\n"); sprintf(&(buffer[char_count]), "%s", yytext); char_count+=yyleng; }
"putchar"     { if(token) printf("#token key:putchar\n"); sprintf(&(buffer[char_count]), "%s", yytext); char_count+=yyleng; }
"puts"        { if(token) printf("#token key:puts\n"); sprintf(&(buffer[char_count]), "%s", yytext); char_count+=yyleng; }
"ungetc"      { if(token) printf("#token key:ungetc\n"); sprintf(&(buffer[char_count]), "%s", yytext); char_count+=yyleng; }
"perror"      { if(token) printf("#token key:perror\n"); sprintf(&(buffer[char_count]), "%s", yytext); char_count+=yyleng; }

"+"           { if(token) printf("#token op:%s\n", yytext); sprintf(&(buffer[char_count]), "%s", yytext); char_count+=yyleng; }
"-"           { if(token) printf("#token op:%s\n", yytext); sprintf(&(buffer[char_count]), "%s", yytext); char_count+=yyleng; }
"*"           { if(token) printf("#token op:%s\n", yytext); sprintf(&(buffer[char_count]), "%s", yytext); char_count+=yyleng; }
"/"           { if(token) printf("#token op:%s\n", yytext); sprintf(&(buffer[char_count]), "%s", yytext); char_count+=yyleng; }
"%"           { if(token) printf("#token op:%s\n", yytext); sprintf(&(buffer[char_count]), "%s", yytext); char_count+=yyleng; }
"++"          { if(token) printf("#token op:%s\n", yytext); sprintf(&(buffer[char_count]), "%s", yytext); char_count+=yyleng; }
"--"          { if(token) printf("#token op:%s\n", yytext); sprintf(&(buffer[char_count]), "%s", yytext); char_count+=yyleng; }
"<"           { if(token) printf("#token op:%s\n", yytext); sprintf(&(buffer[char_count]), "%s", yytext); char_count+=yyleng; }
"<="          { if(token) printf("#token op:%s\n", yytext); sprintf(&(buffer[char_count]), "%s", yytext); char_count+=yyleng; }
">"           { if(token) printf("#token op:%s\n", yytext); sprintf(&(buffer[char_count]), "%s", yytext); char_count+=yyleng; }
">="          { if(token) printf("#token op:%s\n", yytext); sprintf(&(buffer[char_count]), "%s", yytext); char_count+=yyleng; }
"=="          { if(token) printf("#token op:%s\n", yytext); sprintf(&(buffer[char_count]), "%s", yytext); char_count+=yyleng; }
"!="          { if(token) printf("#token op:%s\n", yytext); sprintf(&(buffer[char_count]), "%s", yytext); char_count+=yyleng; }
"="           { if(token) printf("#token op:%s\n", yytext); sprintf(&(buffer[char_count]), "%s", yytext); char_count+=yyleng; }
"&&"          { if(token) printf("#token op:%s\n", yytext); sprintf(&(buffer[char_count]), "%s", yytext); char_count+=yyleng; }
"||"          { if(token) printf("#token op:%s\n", yytext); sprintf(&(buffer[char_count]), "%s", yytext); char_count+=yyleng; }
"!"           { if(token) printf("#token op:%s\n", yytext); sprintf(&(buffer[char_count]), "%s", yytext); char_count+=yyleng; }
"&"           { if(token) printf("#token op:%s\n", yytext); sprintf(&(buffer[char_count]), "%s", yytext); char_count+=yyleng; }
"|"           { if(token) printf("#token op:%s\n", yytext); sprintf(&(buffer[char_count]), "%s", yytext); char_count+=yyleng; }

":"           { if(token) printf("#token punc:%s\n", yytext); sprintf(&(buffer[char_count]), "%s", yytext); char_count+=yyleng; }
";"           { if(token) printf("#token punc:%s\n", yytext); sprintf(&(buffer[char_count]), "%s", yytext); char_count+=yyleng; }
","           { if(token) printf("#token punc:%s\n", yytext); sprintf(&(buffer[char_count]), "%s", yytext); char_count+=yyleng; }
"."           { if(token) printf("#token punc:%s\n", yytext); sprintf(&(buffer[char_count]), "%s", yytext); char_count+=yyleng; }
"["           { if(token) printf("#token punc:%s\n", yytext); sprintf(&(buffer[char_count]), "%s", yytext); char_count+=yyleng; }
"]"           { if(token) printf("#token punc:%s\n", yytext); sprintf(&(buffer[char_count]), "%s", yytext); char_count+=yyleng; }
"("           { if(token) printf("#token punc:%s\n", yytext); sprintf(&(buffer[char_count]), "%s", yytext); char_count+=yyleng; }
")"           { if(token) printf("#token punc:%s\n", yytext); sprintf(&(buffer[char_count]), "%s", yytext); char_count+=yyleng; }
"{"           { if(token) printf("#token punc:%s\n", yytext); sprintf(&(buffer[char_count]), "%s", yytext); char_count+=yyleng; }
"}"           { if(token) printf("#token punc:%s\n", yytext); sprintf(&(buffer[char_count]), "%s", yytext); char_count+=yyleng; }

{IDENTIFIER}  { if(token) printf("#token id:%s\n", yytext); sprintf(&(buffer[char_count]), "%s", yytext); char_count+=yyleng; }
{DOUBLE_a}    { if(token) printf("#token double:%s\n", yytext); sprintf(&(buffer[char_count]), "%s", yytext); char_count+=yyleng; }
{DOUBLE_b}    { if(token) printf("#token double:%s\n", yytext); sprintf(&(buffer[char_count]), "%s", yytext); char_count+=yyleng; }
{INTEGER}     { if(token) printf("#token integer:%s\n", yytext); sprintf(&(buffer[char_count]), "%s", yytext); char_count+=yyleng; }
{CHARACTER}   { if(token) printf("#token char:%s\n", yytext); sprintf(&(buffer[char_count]), "%s", yytext); char_count+=yyleng; }
{STRING}      { if(token) printf("#token string:%s\n", yytext); sprintf(&(buffer[char_count]), "%s", yytext); char_count+=yyleng; }

" "           { sprintf(&(buffer[char_count]), "%s", yytext); char_count+=yyleng; }
\t            { sprintf(&(buffer[char_count]), "%s", yytext); char_count+=yyleng; }
\n            { if(source) printf("%d:%s\n", line_count, buffer); buffer[0]='\0'; char_count=0; line_count++; }
.             {}

%%

int main(){
    yylex();
    return 0;
}