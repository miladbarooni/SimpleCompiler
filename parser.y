%{ 
   /* Definition section */

  #include<stdio.h> 
  #include<ctype.h>
  #include <stdlib.h>

  int temp = 1;
%} 

%union
{
        int number;
        char *string;
}


%token <string> NUMBER END PLUS MINUS MUL DIV POP PCL
%type <string> expr program factor term
%left '+' '-'
%left '*' '/' '%'
%left '(' ')'
/* Rule Section */
%%

program: expr END{
            $$ = $2;
            if($1[0] != 't'){
               char temp [3];
               temp_maker(temp);
               printf("Assign %s to %s\n", $1, temp);
            }
            char final_temp[3];
            temp--;
            int length = snprintf( NULL, 0, "%d", temp );
            snprintf( final_temp, length+6 , "t%d", temp );
            printf("Print %s\n",final_temp);
				exit(1);
			}

		;

expr: expr PLUS term{
         char instruction[100];
         char temp[3];
         temp_maker(temp);
         snprintf(instruction, 100,"Assign %s Plu %s to %s", $1, $3, temp);
         printf("%s\n", instruction);
         $$ = strdup(temp);
      }
	 | expr MINUS term{
         char instruction[100];
         char temp[3];
         temp_maker(temp);
         snprintf(instruction, 100,"Assign %s Min %s to %s", $1, $3, temp);
         printf("%s\n", instruction);
         $$ = strdup(temp);
      }
    | term{$$ = $1;}
    ;
term: term MUL factor{
         char instruction[100];
         char temp[3];
         temp_maker(temp);
         snprintf(instruction, 100,"Assign %s Mul %s to %s", $1, $3, temp);
         printf("%s\n", instruction);
         // printf("%s\n", temp);
         $$ = strdup(temp);
      }
	 | term DIV factor{
         char instruction[100];
         char temp[3];
         temp_maker(temp);
         snprintf(instruction, 100,"Assign %s Div %s to %s", $1, $3, temp);
         printf("%s\n", instruction);
         $$ = strdup(temp);
      }
    | factor{$$ = $1;}
    ;
factor: POP expr PCL{
         char temp[3];
         $$ = $2;
      }
	 | NUMBER {
       $$ = $1;}
	 ;

%% 


//driver code 

void temp_maker(char* temp_string){
    int length = snprintf( NULL, 0, "%d", temp );
    snprintf( temp_string, length+6 , "t%d", temp );
    temp++;
}

main()
{
   yyparse();
}
yywrap()
{
  return(1);
}

yyerror()
{
  
}