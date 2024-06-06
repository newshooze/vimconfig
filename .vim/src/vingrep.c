#include <stdio.h>
#include <string.h>
#include <unistd.h>
#include <stdlib.h>
#include <malloc.h>
#include <dirent.h>

#define MAX_PATH_LENGTH 0x200
#define MAX_SEARCH_LENGTH 0x200

int searchwordlen = 0;
int searchdepth = 1;
char searchroot[MAX_PATH_LENGTH];
char searchword[MAX_SEARCH_LENGTH];

char *RemoveTrailingSlash(char *s)
{
  char *a = s;
  int index = 0;
  if(!s)
    return NULL;
  if(s[0] == '/' && s[1] == '\0')
    return s;
  while(*s++)
  {
    index++;
  }
  if(a[index - 1] == '/')
    a[index - 1] = '\0';
  return a;
}

/* TODO: Fix search context */
int FindInFile(const char *filename)
{
  int matchlen = 0;
  int currentcolumn = 0;
  char *psearchword = searchword;
  int linecount = 0;
  FILE *f = fopen(filename,"r"); /* FILE* */
  if(!f)
  {
    fprintf(stderr,"%s:1:1:Error opening file %s\n",filename,filename); /* int */ 
    return 0;
  }
  char currentchar = fgetc(f); /* int */
  currentcolumn++;
  /* Skip binary files (files with a NULL char) */
  while(currentchar != '\0' && currentchar != EOF)
  {
    while(currentchar == *psearchword)
    {
      matchlen++;
      psearchword++;
      currentcolumn++;
      long matchstart = ftell(f); /* long */
      if(matchlen == searchwordlen)
      {
        printf("%s:%d:%d:",filename,linecount + 1,currentcolumn - searchwordlen); /* int */  
        fseek(f,matchstart - matchlen,SEEK_SET);
        currentchar = fgetc(f); /* int */
        while(currentchar != '\n' && currentchar != EOF)  
        {
          printf("%c",currentchar);
          currentchar = fgetc(f); /* int */
        }
        printf("\n"); /* int */ 
        fseek(f,matchstart,SEEK_SET);
      }
      currentchar = fgetc(f); /* int */
    }
    if(currentchar == '\n')
    {
      linecount++;
      currentcolumn = 0;
    }
    matchlen = 0;
    currentcolumn++;
    psearchword = searchword;
    currentchar = fgetc(f); /* int */
  }
  fclose(f); /* int */
  return 0;
}
int FindWordInPath(char *root,int depth)
{
  char *fullpath = root;
  DIR *di = opendir(fullpath);
  if(!di)
    return -1;
  struct dirent *dir = readdir(di);
  if(depth == 0)
    return 0;
  while(dir != NULL)
  {
    char currentfile[MAX_PATH_LENGTH];
    if(dir->d_type & DT_DIR)
    {
      /* Check for "." and ".." */
      if(dir->d_name[0] != '.') 
      {
        strcpy(currentfile,root); /* char* */
        strcat(currentfile,"/"); /* char* */
        strcat(currentfile,dir->d_name); /* char* */
        FindWordInPath(currentfile,depth - 1);
      }
    }
    else
    {
      strcpy(currentfile,root); /* char* */
      strcat(currentfile,"/"); /* char* */
      strcat(currentfile,dir->d_name); /* char* */
      FindInFile(currentfile);
    }
    dir = readdir(di);
  }
  closedir(di);
  return 0;
}
void ShowUsage()
{
  printf("Usage: %s SEARCHWORD [PATH] [DEPTH]\n","vingrep");
  printf("       Set depth to -1 for to search all subdirectories.\n");
}
int main(int argc,char **argv)
{
  if(argc < 2)
  {
    ShowUsage();
    return 0;
  }
  if(argc > 1)
  {
    if( strcmp("--help",argv[1]) == 0 || strcmp("-h",argv[1]) == 0)
    {
      ShowUsage();
      return 0;
    }
    searchwordlen = strnlen(argv[1],MAX_SEARCH_LENGTH - 1); /* size_t */
    strncpy(searchword,argv[1],MAX_SEARCH_LENGTH - 1); /* char* */
  }
  if(argc > 2)
  {
    strncpy(searchroot,argv[2],MAX_PATH_LENGTH - 1); /* char* */
  }
  else
  {
    char *currentdir = getcwd(NULL,0); /* char* */
    strncpy(searchroot,currentdir,MAX_PATH_LENGTH - 1); /* char* */
  }
  if(argc > 3)
  {
    searchdepth = atoi(argv[3]);
  }
  else
  {
    searchdepth = 1;
  }
  RemoveTrailingSlash(searchroot);
  FindWordInPath(searchroot,searchdepth);
  return 0;
}
