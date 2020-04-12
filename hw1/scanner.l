%{

#include <stdio.h>
#include <stdlib.h>

char buffer[500];
int line_count=1;
int char_count=0;

int token=1;
int source=1;
int comment=0;

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

%s SOURCEOFF
%s TOKENOFF
%x COMMENT

%%

{SOURCE_OFF}  { sprintf(&(buffer[char_count]), "%s", yytext); char_count+=yyleng; BEGIN SOURCEOFF; }
<SOURCEOFF>\n { buffer[0]='\0'; char_count=0; line_count++; }
<SOURCEOFF>{SOURCE_ON} { sprintf(&(buffer[char_count]), "%s", yytext); char_count+=yyleng; BEGIN 0; }
{TOKEN_OFF}   { sprintf(&(buffer[char_count]), "%s", yytext); char_count+=yyleng; BEGIN TOKENOFF; }
<TOKENOFF>{NON_NEXT_LINE} { sprintf(&(buffer[char_count]), "%s", yytext); char_count+=yyleng; }
<TOKENOFF>{TOKEN_ON} { sprintf(&(buffer[char_count]), "%s", yytext); char_count+=yyleng; BEGIN 0; }

{BEG_COMMENT} { sprintf(&(buffer[char_count]), "%s", yytext); char_count+=yyleng; BEGIN COMMENT; }
<COMMENT>{NON_NEXT_LINE} { sprintf(&(buffer[char_count]), "%s", yytext); char_count+=yyleng; }
<COMMENT>\n   { printf("%d:%s\n", line_count, buffer); buffer[0]='\0'; char_count=0; line_count++; }
<COMMENT>{END_COMMENT} { sprintf(&(buffer[char_count]), "%s", yytext); char_count+=yyleng; BEGIN 0; }
{SINGLE_COMM} { sprintf(&(buffer[char_count]), "%s", yytext); char_count+=yyleng; }

"void"        { printf("#token key:void\n"); sprintf(&(buffer[char_count]), "%s", yytext); char_count+=yyleng; }
"const"       { printf("#token key:const\n"); sprintf(&(buffer[char_count]), "%s", yytext); char_count+=yyleng; }
"NULL"        { printf("#token key:NULL\n"); sprintf(&(buffer[char_count]), "%s", yytext); char_count+=yyleng; }
"for"         { printf("#token key:for\n"); sprintf(&(buffer[char_count]), "%s", yytext); char_count+=yyleng; }
"do"          { printf("#token key:do\n"); sprintf(&(buffer[char_count]), "%s", yytext); char_count+=yyleng; }
"while"       { printf("#token key:while\n"); sprintf(&(buffer[char_count]), "%s", yytext); char_count+=yyleng; }
"break"       { printf("#token key:break\n"); sprintf(&(buffer[char_count]), "%s", yytext); char_count+=yyleng; }
"continue"    { printf("#token key:continue\n"); sprintf(&(buffer[char_count]), "%s", yytext); char_count+=yyleng; }
"if"          { printf("#token key:if\n"); sprintf(&(buffer[char_count]), "%s", yytext); char_count+=yyleng; }
"else"        { printf("#token key:else\n"); sprintf(&(buffer[char_count]), "%s", yytext); char_count+=yyleng; }
"return"      { printf("#token key:return\n"); sprintf(&(buffer[char_count]), "%s", yytext); char_count+=yyleng; }
"struct"      { printf("#token key:struct\n"); sprintf(&(buffer[char_count]), "%s", yytext); char_count+=yyleng; }
"switch"      { printf("#token key:switch\n"); sprintf(&(buffer[char_count]), "%s", yytext); char_count+=yyleng; }
"case"        { printf("#token key:case\n"); sprintf(&(buffer[char_count]), "%s", yytext); char_count+=yyleng; }
"default"     { printf("#token key:default\n"); sprintf(&(buffer[char_count]), "%s", yytext); char_count+=yyleng; }

"int"         { printf("#token key:int\n"); sprintf(&(buffer[char_count]), "%s", yytext); char_count+=yyleng; }
"double"      { printf("#token key:double\n"); sprintf(&(buffer[char_count]), "%s", yytext); char_count+=yyleng; }
"float"       { printf("#token key:float\n"); sprintf(&(buffer[char_count]), "%s", yytext); char_count+=yyleng; }
"char"        { printf("#token key:char\n"); sprintf(&(buffer[char_count]), "%s", yytext); char_count+=yyleng; }

"fclose"      { printf("#token key:fclose\n"); sprintf(&(buffer[char_count]), "%s", yytext); char_count+=yyleng; }
"clearerr"    { printf("#token key:clearerr\n"); sprintf(&(buffer[char_count]), "%s", yytext); char_count+=yyleng; }
"feof"        { printf("#token key:feof\n"); sprintf(&(buffer[char_count]), "%s", yytext); char_count+=yyleng; }
"ferror"      { printf("#token key:ferror\n"); sprintf(&(buffer[char_count]), "%s", yytext); char_count+=yyleng; }
"fflush"      { printf("#token key:fflush\n"); sprintf(&(buffer[char_count]), "%s", yytext); char_count+=yyleng; }
"fgetpos"     { printf("#token key:fgetpos\n"); sprintf(&(buffer[char_count]), "%s", yytext); char_count+=yyleng; }
"fopen"       { printf("#token key:fopen\n"); sprintf(&(buffer[char_count]), "%s", yytext); char_count+=yyleng; }
"fread"       { printf("#token key:fread\n"); sprintf(&(buffer[char_count]), "%s", yytext); char_count+=yyleng; }
"freopen"     { printf("#token key:freopen\n"); sprintf(&(buffer[char_count]), "%s", yytext); char_count+=yyleng; }
"fseek"       { printf("#token key:fseek\n"); sprintf(&(buffer[char_count]), "%s", yytext); char_count+=yyleng; }
"fsetpos"     { printf("#token key:fsetpos\n"); sprintf(&(buffer[char_count]), "%s", yytext); char_count+=yyleng; }
"ftell"       { printf("#token key:ftell\n"); sprintf(&(buffer[char_count]), "%s", yytext); char_count+=yyleng; }
"fwrite"      { printf("#token key:fwrite\n"); sprintf(&(buffer[char_count]), "%s", yytext); char_count+=yyleng; }
"remove"      { printf("#token key:remove\n"); sprintf(&(buffer[char_count]), "%s", yytext); char_count+=yyleng; }
"rename"      { printf("#token key:rename\n"); sprintf(&(buffer[char_count]), "%s", yytext); char_count+=yyleng; }
"rewind"      { printf("#token key:rewind\n"); sprintf(&(buffer[char_count]), "%s", yytext); char_count+=yyleng; }
"setbuf"      { printf("#token key:setbuf\n"); sprintf(&(buffer[char_count]), "%s", yytext); char_count+=yyleng; }
"setvbuf"     { printf("#token key:setvbuf\n"); sprintf(&(buffer[char_count]), "%s", yytext); char_count+=yyleng; }
"tmpfile"     { printf("#token key:tmpfile\n"); sprintf(&(buffer[char_count]), "%s", yytext); char_count+=yyleng; }
"tmpnam"      { printf("#token key:tmpnam\n"); sprintf(&(buffer[char_count]), "%s", yytext); char_count+=yyleng; }
"fprintf"     { printf("#token key:fprintf\n"); sprintf(&(buffer[char_count]), "%s", yytext); char_count+=yyleng; }
"printf"      { printf("#token key:printf\n"); sprintf(&(buffer[char_count]), "%s", yytext); char_count+=yyleng; }
"sprintf"     { printf("#token key:sprintf\n"); sprintf(&(buffer[char_count]), "%s", yytext); char_count+=yyleng; }
"vfprintf"    { printf("#token key:vfprintf\n"); sprintf(&(buffer[char_count]), "%s", yytext); char_count+=yyleng; }
"vprintf"     { printf("#token key:vprintf\n"); sprintf(&(buffer[char_count]), "%s", yytext); char_count+=yyleng; }
"vsprintf"    { printf("#token key:vsprintf\n"); sprintf(&(buffer[char_count]), "%s", yytext); char_count+=yyleng; }
"fscanf"      { printf("#token key:fscanf\n"); sprintf(&(buffer[char_count]), "%s", yytext); char_count+=yyleng; }
"scanf"       { printf("#token key:scanf\n"); sprintf(&(buffer[char_count]), "%s", yytext); char_count+=yyleng; }
"sscanf"      { printf("#token key:sscanf\n"); sprintf(&(buffer[char_count]), "%s", yytext); char_count+=yyleng; }
"fgetc"       { printf("#token key:fgetc\n"); sprintf(&(buffer[char_count]), "%s", yytext); char_count+=yyleng; }
"fgets"       { printf("#token key:fgets\n"); sprintf(&(buffer[char_count]), "%s", yytext); char_count+=yyleng; }
"fputc"       { printf("#token key:fputc\n"); sprintf(&(buffer[char_count]), "%s", yytext); char_count+=yyleng; }
"fputs"       { printf("#token key:fputs\n"); sprintf(&(buffer[char_count]), "%s", yytext); char_count+=yyleng; }
"getc"        { printf("#token key:getc\n"); sprintf(&(buffer[char_count]), "%s", yytext); char_count+=yyleng; }
"getchar"     { printf("#token key:getchar\n"); sprintf(&(buffer[char_count]), "%s", yytext); char_count+=yyleng; }
"gets"        { printf("#token key:gets\n"); sprintf(&(buffer[char_count]), "%s", yytext); char_count+=yyleng; }
"putc"        { printf("#token key:putc\n"); sprintf(&(buffer[char_count]), "%s", yytext); char_count+=yyleng; }
"putchar"     { printf("#token key:putchar\n"); sprintf(&(buffer[char_count]), "%s", yytext); char_count+=yyleng; }
"puts"        { printf("#token key:puts\n"); sprintf(&(buffer[char_count]), "%s", yytext); char_count+=yyleng; }
"ungetc"      { printf("#token key:ungetc\n"); sprintf(&(buffer[char_count]), "%s", yytext); char_count+=yyleng; }
"perror"      { printf("#token key:perror\n"); sprintf(&(buffer[char_count]), "%s", yytext); char_count+=yyleng; }

"+"           { printf("#token op:%s\n", yytext); sprintf(&(buffer[char_count]), "%s", yytext); char_count+=yyleng; }
"-"           { printf("#token op:%s\n", yytext); sprintf(&(buffer[char_count]), "%s", yytext); char_count+=yyleng; }
"*"           { printf("#token op:%s\n", yytext); sprintf(&(buffer[char_count]), "%s", yytext); char_count+=yyleng; }
"/"           { printf("#token op:%s\n", yytext); sprintf(&(buffer[char_count]), "%s", yytext); char_count+=yyleng; }
"%"           { printf("#token op:%s\n", yytext); sprintf(&(buffer[char_count]), "%s", yytext); char_count+=yyleng; }
"++"          { printf("#token op:%s\n", yytext); sprintf(&(buffer[char_count]), "%s", yytext); char_count+=yyleng; }
"--"          { printf("#token op:%s\n", yytext); sprintf(&(buffer[char_count]), "%s", yytext); char_count+=yyleng; }
"<"           { printf("#token op:%s\n", yytext); sprintf(&(buffer[char_count]), "%s", yytext); char_count+=yyleng; }
"<="          { printf("#token op:%s\n", yytext); sprintf(&(buffer[char_count]), "%s", yytext); char_count+=yyleng; }
">"           { printf("#token op:%s\n", yytext); sprintf(&(buffer[char_count]), "%s", yytext); char_count+=yyleng; }
">="          { printf("#token op:%s\n", yytext); sprintf(&(buffer[char_count]), "%s", yytext); char_count+=yyleng; }
"=="          { printf("#token op:%s\n", yytext); sprintf(&(buffer[char_count]), "%s", yytext); char_count+=yyleng; }
"!="          { printf("#token op:%s\n", yytext); sprintf(&(buffer[char_count]), "%s", yytext); char_count+=yyleng; }
"="           { printf("#token op:%s\n", yytext); sprintf(&(buffer[char_count]), "%s", yytext); char_count+=yyleng; }
"&&"          { printf("#token op:%s\n", yytext); sprintf(&(buffer[char_count]), "%s", yytext); char_count+=yyleng; }
"||"          { printf("#token op:%s\n", yytext); sprintf(&(buffer[char_count]), "%s", yytext); char_count+=yyleng; }
"!"           { printf("#token op:%s\n", yytext); sprintf(&(buffer[char_count]), "%s", yytext); char_count+=yyleng; }
"&"           { printf("#token op:%s\n", yytext); sprintf(&(buffer[char_count]), "%s", yytext); char_count+=yyleng; }
"|"           { printf("#token op:%s\n", yytext); sprintf(&(buffer[char_count]), "%s", yytext); char_count+=yyleng; }

":"           { printf("#token punc:%s\n", yytext); sprintf(&(buffer[char_count]), "%s", yytext); char_count+=yyleng; }
";"           { printf("#token punc:%s\n", yytext); sprintf(&(buffer[char_count]), "%s", yytext); char_count+=yyleng; }
","           { printf("#token punc:%s\n", yytext); sprintf(&(buffer[char_count]), "%s", yytext); char_count+=yyleng; }
"."           { printf("#token punc:%s\n", yytext); sprintf(&(buffer[char_count]), "%s", yytext); char_count+=yyleng; }
"["           { printf("#token punc:%s\n", yytext); sprintf(&(buffer[char_count]), "%s", yytext); char_count+=yyleng; }
"]"           { printf("#token punc:%s\n", yytext); sprintf(&(buffer[char_count]), "%s", yytext); char_count+=yyleng; }
"("           { printf("#token punc:%s\n", yytext); sprintf(&(buffer[char_count]), "%s", yytext); char_count+=yyleng; }
")"           { printf("#token punc:%s\n", yytext); sprintf(&(buffer[char_count]), "%s", yytext); char_count+=yyleng; }
"{"           { printf("#token punc:%s\n", yytext); sprintf(&(buffer[char_count]), "%s", yytext); char_count+=yyleng; }
"}"           { printf("#token punc:%s\n", yytext); sprintf(&(buffer[char_count]), "%s", yytext); char_count+=yyleng; }

{IDENTIFIER}  { printf("#token id:%s\n", yytext); sprintf(&(buffer[char_count]), "%s", yytext); char_count+=yyleng; }
{DOUBLE_a}    { printf("#token double:%s\n", yytext); sprintf(&(buffer[char_count]), "%s", yytext); char_count+=yyleng; }
{DOUBLE_b}    { printf("#token double:%s\n", yytext); sprintf(&(buffer[char_count]), "%s", yytext); char_count+=yyleng; }
{INTEGER}     { printf("#token integer:%s\n", yytext); sprintf(&(buffer[char_count]), "%s", yytext); char_count+=yyleng; }
{CHARACTER}   { printf("#token char:%s\n", yytext); sprintf(&(buffer[char_count]), "%s", yytext); char_count+=yyleng; }
{STRING}      { printf("#token string:%s\n", yytext); sprintf(&(buffer[char_count]), "%s", yytext); char_count+=yyleng; }

" "           { sprintf(&(buffer[char_count]), "%s", yytext); char_count+=yyleng; }
\t            { sprintf(&(buffer[char_count]), "%s", yytext); char_count+=yyleng; }
\n            { printf("%d:%s\n", line_count, buffer); buffer[0]='\0'; char_count=0; line_count++; }
.             {}

%%

int main(){
    yylex();
    return 0;
}