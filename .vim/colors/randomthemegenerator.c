#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include <time.h>

#define KEYWORD_COUNT 45

char *words[KEYWORD_COUNT]={"Comment","Constant","Cursor","Default","Define","DiffAdd","DiffChange","DiffDelete","DiffText",
"Directory","Error","ErrorMsg","FoldColumn","Folded","Function","Identifier","Ignore","IncSearch","Include",
"LineNr","ModeMsg","MoreMsg","NonText","Normal","Operator","PreProc","Question","Search",
"Special","SpecialKey","SpellErrors","Statement","StatusLine","StatusLineNC","String","Structure","Title",
"Todo","Type","Underlined","VertSplit","Visual","VisualNOS","WarningMsg","WildMenu"};

int random_int(int max)
{
	return rand () % max;
}
unsigned int random_24bit_color()
{
	int r = random_int(0xfe);
	int g = random_int(0xfe);
	int b = random_int(0xfe);
	unsigned int ru = r << 16;
	unsigned int gu = g << 8;
	return ru + gu + b;
}
char *random_filename(char *s)
{
	int i;
	char fname[0xff];
	strcpy(fname,"");
	for(i=0; i<12; i++)
	{
		char a = rand() % 26 + 97; /* ascii letters a-z */
		fname[i] = a;
	}	
	fname[i] = '\0';
	strcpy(s,fname);
	return s;
}

int main(int argc,char **argv)
{
	int i,j,k;
	int linelen = 0;
	int padding = 0;
	char buf[0xff];
	char fname[0xff];
	char themename[0xff];
	FILE *outfile = NULL;
	srand(time(NULL));	
	random_filename(fname);
	strcpy(themename,fname);
	strcat(fname,".vim");
	outfile = fopen(fname,"w"); // FILE*
	if(!outfile)
	{
		printf("Error opening file %s for writing.\n",fname);
		return 1;	
	}
	fprintf(outfile,"\"File: %s\n\n",fname); // int
	fprintf(outfile,"hi clear\n\n"); // int
	fprintf(outfile,"if exists(\"syntax on\")\n  syntax reset\nendif\n\n"); // int
	for(i=0; i<KEYWORD_COUNT; i++)
	{
		char colorint8bit[0xff];
		char colorhex24bit[0xff];
		sprintf(colorint8bit,"%1d",random_int(232));
		sprintf(colorhex24bit,"%.6x",random_24bit_color());
		sprintf(buf,"hi %s ",words[i]); // int
		linelen = strlen(buf);
		padding = 20 - linelen;
		for(j=0; j<padding; j++)
			strcat(buf," ");
		strcat(buf,"ctermfg=");
		strcat(buf,colorint8bit);
		linelen = strlen(buf);
		padding = 35 - linelen;
		for(j=0; j<padding; j++)
			strcat(buf," ");
		strcat(buf,"guifg=#");
		strcat(buf,colorhex24bit);	
		linelen = strlen(buf);
		padding = 50 - linelen;
		for(j=0; j<padding; j++)
			strcat(buf," ");
		strcat(buf,"ctermbg=235");
		linelen = strlen(buf);
		padding = 65 - linelen;
		for(j=0; j<padding; j++)
			strcat(buf," ");
		strcat(buf,"guibg=#262626");
		linelen = strlen(buf);
		padding = 80 - linelen;
		for(j=0; j<padding; j++)
			strcat(buf," ");
		strcat(buf,"cterm=none");
		linelen = strlen(buf);
		padding = 95 - linelen;
		for(j=0; j<padding; j++)
			strcat(buf," ");
		strcat(buf,"gui=none");
		fprintf(outfile,"%s\n",buf);
	}
	fprintf(outfile,"\n"); // int
	fprintf(outfile,"let colors_name = \"%s\"",themename); // int
	fclose(outfile); // int
	return 0;
}
