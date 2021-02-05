%{ 
    #include <stdio.h> 
    #include <string.h> 
    #include "y.tab.h"

%} 

%% 
"+"	{return PLUS;}
"-"	{return MINUS;}
"*"	{return MUL;}
"/"	{return DIV;}
"(" {return POP;}
")" {return PCL;}
[ \t]	{}
[\n]	{return END;}
[0-9]+ {
    int len = strlen(yytext);
    char number[10];
    strcpy(number, yytext);
    char *single_digits[] = { "Zer", "One", "Two", 
                               "Thr", "Fou","Fiv", 
                               "Six", "Sev", "Eig", "Nin"};
 
    char *two_digits[] = {"ZerTen", "OneTen","TwoTen", 
                               "ThrTen", "FouTen",
                               "FivTen", "SixTen", 
                               "SevTen", "EigTen", "NinTen"};
 
    char *tens_multiple[] =  {"ZerHun", "OneHun","TwoHun", 
                               "ThrHun", "FouHun",
                               "FivHun", "SixHun", 
                               "SevHun", "EigHun", "NinHun"};
    char result[100];
    if (len == 1){
        strcpy(result, single_digits[number[len-1] - '0']);
    }
    else if (len == 2){
        strcpy(result,two_digits[number[len-2] - '0']);
        strcat(result, "_");
        strcat(result, single_digits[number[len-1] - '0']);
    }
    else if (len == 3){
        strcpy(result, tens_multiple[number[len-3] - '0']);
        strcat(result, "_");
        strcat(result,two_digits[number[len-2] - '0'] );
        strcat(result,  "_");
        strcat(result, single_digits[number[len-1] - '0']);

    }
    else if (len == 4){
        strcpy(result, "(");
        strcat(result, single_digits[number[len-4] - '0']);
        strcat(result, ")");
        strcat(result, "Tou_");
        strcat(result, tens_multiple[number[len-3] - '0']);
        strcat(result, "_");
        strcat(result,two_digits[number[len-2] - '0'] );
        strcat(result,  "_");
        strcat(result, single_digits[number[len-1] - '0']);
    }
    else if (len == 5){
        strcpy(result, "(");
        strcat(result, two_digits[number[len-5] - '0']);
        strcat(result, "_");
        strcat(result, single_digits[number[len-4] - '0']);
        strcat(result, ")");
        strcat(result, "Tou_");
        strcat(result, tens_multiple[number[len-3] - '0']);
        strcat(result, "_");
        strcat(result,two_digits[number[len-2] - '0'] );
        strcat(result,  "_");
        strcat(result, single_digits[number[len-1] - '0']);
    }
    else if (len == 6){
        strcpy(result, "(");
        strcat(result, tens_multiple[number[len-6] - '0']);
        strcat(result, "_");
        strcat(result, two_digits[number[len-5] - '0']);
        strcat(result, "_");
        strcat(result, single_digits[number[len-4] - '0']);
        strcat(result, ")");
        strcat(result, "Tou_");
        strcat(result, tens_multiple[number[len-3] - '0']);
        strcat(result, "_");
        strcat(result,two_digits[number[len-2] - '0'] );
        strcat(result,  "_");
        strcat(result, single_digits[number[len-1] - '0']);
    }
    // printf("%s\n", result);
    yylval.string = strdup(result);
    return NUMBER;
} 
%% 


// int yywrap() 
// { 
// 	return 1; 
// } 

// int main() 
// {    
//     // The function that starts the analysis 
//     yylex(); 
  
//     return 0; 
// } 