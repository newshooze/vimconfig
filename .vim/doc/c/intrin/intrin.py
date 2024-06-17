#!/usr/bin/python3 -c
'''
    This will create a vim help file for simd routines.
    The data file is inside the Intel Intrinsics Guide.
    https://cdrdv2.intel.com/v1/dl/getContent/671338
'''
import sys
import shutil
import textwrap
import fileinput
from bs4 import BeautifulSoup

def GetInstructionCount(intrinsic):
    cnt = 0
    for instructions in intrinsic.find_all('instruction'):
        cnt = cnt +1
    return cnt

def GetInstructionTopic(intrinsic):
    ret = ''
    for instructions in intrinsic.find_all('instruction'):
        ret = ret + '*' + instructions["name"] + '*' + ' '
        ret = ret.lower()
    return ret
        
def ProcessIntinrsicFile():
    INTRINSICFILE = 'data.js'

    filehandle = open(INTRINSICFILE)
    filetext = filehandle.read()
    filehandle.close()
    filetext = filetext.replace('\\n\\','')
    filetext = filetext.replace('\\','')
    filetext = filetext.replace('var data_js = "','')
    filetext = filetext.replace('";','')
    filehandle = open(INTRINSICFILE,'w')
    filehandle.write(filetext)
    filehandle.close()

    infile = open(INTRINSICFILE)
    soup = BeautifulSoup(infile)
    intrinsicslist = soup.find('intrinsics_list')
    print('Intel Intrinsics Guide',end='')
    try:
        print(' Version ',end='')
        print(intrinsicslist['version'],end='')
    except:
        print('',end='') 
    try:
        print('    ',end='')
        print(intrinsicslist['date'])
    except:
        print('',end='') 
    infile = open("data.js")
    soup = BeautifulSoup(infile)
    intrinsics = soup.find_all('intrinsic')
    indent = '    '
    for intrinsic in intrinsics:
        print('===============================================================================')
        paramstring = ''
        intrinsicstring = intrinsic['name']
        intrinsiclength = len(intrinsicstring)
        instructiontopic = GetInstructionTopic(intrinsic)
        padding = GetInstructionCount(intrinsic) * 2
        offset = 79 - len(instructiontopic) - intrinsiclength - 2
        if offset < 0:
            offset = 0
        print(' ' * offset,end='')
        print(instructiontopic,end='')
        print('*',end='')
        print(intrinsicstring,end='')
        print('*',end='')
        print('')
        print('Synopsis ~')
        print('')
        returntype = intrinsic.find('return')['type']
        returntypelength = len(returntype)
        print(indent,end='')
        print(returntype,end='')
        print(' ',end='')
        print(intrinsicstring,end='')
        print('(',end='')
        parametercount = 0
        for params in intrinsic.find_all('parameter'):
            if parametercount > 0:
                paramstring = paramstring + indent + ' ' * returntypelength + ' ' * intrinsiclength + ' ' * 2
            paramstring = paramstring + params['type'] + ' '
            try:
                paramstring = paramstring + params['varname']
                paramstring = paramstring + ',' + '\n'
            except:
                paramstring = paramstring
            parametercount = parametercount + 1
        ''' remove the comma '''
        paramstring = paramstring[:-2]
        print(paramstring,end='')
        print(')',end='')
        print('')
        print('')
        print('    #include     <',end='')
        for headers in intrinsic.find_all('header'):
            print(headers.string,end='')
        print('>',end='')
        print('')
        instructioncount = 0
        for instructions in intrinsic.find_all('instruction'):
            if instructioncount > 0:
                print('                 ',end='')
            else:
                print('    Instruction:',end='')
                print(' ',end='')
                print('',end='')
            try:
                print(instructions['name'].lower(),end='') 
                print(' ',end='')
            except:
                print('',end='')
            try:
                instructionstring = instructions['form']
                print(instructions['form'],end='') 
                instructioncount = instructioncount + 1
            except:
                print('',end='')
            print('')
        print('    CPUID Flags:',end='')
        print(' ',end='')
        for cpuid in intrinsic.find_all('cpuid'):
            print('',end='')
            print(cpuid.string)
        print('')
        print('Description ~')
        print('')
        print(textwrap.indent(textwrap.fill(intrinsic.description.string,79),'    '))
        print('')
        print('Operation ~') 
        print('>')
        try:
            operationstring = intrinsic.find('operation').string
            print(textwrap.indent(operationstring,'    '))
        except:
            print('',end='')
        print('<')

if __name__ == '__main__':
    ProcessIntinrsicFile()
