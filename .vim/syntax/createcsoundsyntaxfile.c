/***************************************************************
 requires libcsound64-dev (libcsound64)
 Uses the csound API to write a Vim syntax file for csound
 gcc xxxx.c -o xxxx -lcsound64 
***************************************************************/
#include <time.h>
#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include <csound/csound.h>

#define MAX_COL 80
#define SYNTAX_PREFIX "syn keyword csoundOpcode "
#define SYNTAX_PREFIX_LENGTH 25

int main(int argc,char **argv)
{
	int i = 0;
	int wordlen = 0;
	char *timestring;
	time_t currenttime;
	opcodeListEntry *ole;
	int linelen = SYNTAX_PREFIX_LENGTH;
	FILE *outfile = NULL;
	CSOUND *csound = csoundCreate(NULL);
	int cnt = csoundNewOpcodeList(csound,&ole);
	if(argc > 1)
	{
		if(strcmp(argv[1],"-h")==0 || strcmp(argv[1],"--help")==0)
		{
			printf("\n");
			printf("Usage: %s [FILENAME]\n",argv[0]);
			printf("  Creates a Vim syntax file (FILENAME) for csound.\n");
			printf("  No FILENAME prints to standard out.\n");
			printf("\n");
		}
		else
		{
			outfile=fopen(argv[1],"w");
			if(!outfile)
			{
				fprintf(stdout,"Error opening file %s. Exiting.\n",argv[1]); // int
				return 1;
			}
		}
	}	
	else
	{
		outfile = stdout;
	}
	fprintf(outfile,"\" Vim syntax file");
	fprintf(outfile,"\n");
	fprintf(outfile,"\" Language: csound");	
	fprintf(outfile,"\n");
	currenttime = time(NULL);
	if(currenttime != ((time_t)-1) && (timestring = ctime(&currenttime)))
	{
		fprintf(outfile,"\" Created: %s",timestring); 
		fprintf(outfile,"\n");
	}
	fprintf(outfile,"\n");
	fprintf(outfile,"\n");
	fprintf(outfile,"if version < 600");
	fprintf(outfile,"\n");
	fprintf(outfile,"  syntax clear");
	fprintf(outfile,"\n");
	fprintf(outfile,"elseif exists(\"b:current_syntax\")");
	fprintf(outfile,"\n");
	fprintf(outfile,"  finish");
	fprintf(outfile,"\n");
	fprintf(outfile,"endif");
	fprintf(outfile,"\n");
	fprintf(outfile,"\n");
	fprintf(outfile,SYNTAX_PREFIX);
	if(cnt > 0)
	{
		wordlen = strlen(ole[i].opname);	
		linelen = SYNTAX_PREFIX_LENGTH + wordlen;
		fprintf(outfile,"%s",ole[0].opname);
	}
	for(i=1; i<cnt; i++)
	{
		wordlen = strlen(ole[i].opname);
		if(strcmp(ole[i-1].opname,ole[i].opname) != 0)
		{
			if(linelen + wordlen > MAX_COL)
			{
				fprintf(outfile,"\n%s",SYNTAX_PREFIX);
				fprintf(outfile,"%s",ole[i].opname);
				linelen = SYNTAX_PREFIX_LENGTH + wordlen;
			}
			else
			{
				fprintf(outfile," %s",ole[i].opname);
				linelen = linelen + wordlen + 1;
			}
		}
	}
	csoundDisposeOpcodeList(csound,ole);
	fprintf(outfile,"\n");
	fprintf(outfile,"\n");
	fprintf(outfile,"syn match csoundNumber \"\\<\\d\\+\\>\"");
	fprintf(outfile,"\n");
	fprintf(outfile,"syn match csoundNumber \"\\<\\d\\+\\.\\d*\\>\"");
	fprintf(outfile,"\n");
	fprintf(outfile,"syn match csoundNumber \"\\.\\d\\+\\>\"");
	fprintf(outfile,"\n");
	fprintf(outfile,"syn region csoundString start=+\"+ skip=+\\\\\\\\\\|\\\\\"+ end=+\"+"); 
	fprintf(outfile,"\n");
	fprintf(outfile,"syn match csoundMathsOperator \"-\\|=\\|[:<>+\\*^/\\\\]\\|AND\\|OR\"");
	fprintf(outfile,"\n");
	fprintf(outfile,"syn region csoundComment start=\"\\/\\*\" end=\"\\*\\/\"");
	fprintf(outfile,"\n");
	fprintf(outfile,"syn region csoundComment start=\";\" end=\"$\"");
	fprintf(outfile,"\n");
	fprintf(outfile,"syn region csoundDefine start=\"^\\s*#\\s*define\" skip=\"\\\\$\" end=\"$\""); 
	fprintf(outfile,"\n");
	fprintf(outfile,"syn region csoundInclude start=\"^\\s*#\\s*include\" skip=\"\\\\$\" end=\"$\"");
	fprintf(outfile,"\n");
	fprintf(outfile,"\n");


	fprintf(outfile,"if version >= 508 || !exists(\"did_csound_syntax_inits\")");
	fprintf(outfile,"\n");
	fprintf(outfile,"  if version < 508");
	fprintf(outfile,"\n");
	fprintf(outfile,"    let did_csound_syntax_inits = 1");
	fprintf(outfile,"\n");
	fprintf(outfile,"    command -nargs=+ HiLink hi link <args>");
	fprintf(outfile,"\n");
	fprintf(outfile,"  else");
	fprintf(outfile,"\n");
	fprintf(outfile,"    command -nargs=+ HiLink hi def link <args>");
	fprintf(outfile,"\n");
	fprintf(outfile,"  endif");
	fprintf(outfile,"\n");
	fprintf(outfile,"\n");

	fprintf(outfile,"  HiLink csoundDefine PreProc");
	fprintf(outfile,"\n");
	fprintf(outfile,"  HiLink csoundInclude	PreProc");
	fprintf(outfile,"\n");
	fprintf(outfile,"  HiLink csoundConditional	Conditional");
	fprintf(outfile,"\n");
	fprintf(outfile,"  HiLink csoundNumber Number");
	fprintf(outfile,"\n");
	fprintf(outfile,"  HiLink csoundError	Error");
	fprintf(outfile,"\n");
	fprintf(outfile,"  HiLink csoundOpcode Statement");
	fprintf(outfile,"\n");
	fprintf(outfile,"  HiLink csoundString String");
	fprintf(outfile,"\n");
	fprintf(outfile,"  HiLink csoundComment Comment");
	fprintf(outfile,"\n");
	fprintf(outfile,"  HiLink csoundTodo Todo");
	fprintf(outfile,"\n");
	fprintf(outfile,"  HiLink csoundMathsOperator Operator");
	fprintf(outfile,"\n");
	fprintf(outfile,"  delcommand HiLink");
	fprintf(outfile,"\n");
	fprintf(outfile,"endif");
	fprintf(outfile,"\n");
	fprintf(outfile,"let b:current_syntax = \"csound\"");
	fprintf(outfile,"\n");

	fclose(outfile); // int
	return 0;
}


