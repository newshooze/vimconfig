#include <stdio.h>
#include <math.h>
#include <stdlib.h>
#include <string.h>

int main()
{
	int oct,freq;
	for(oct=0; oct<10; oct++)
	{
		for(freq=0; freq<12; freq++)
		{
			float val=__builtin_exp2f(4.0313842f+oct+freq/12.0);
			switch(freq)
			{
				case 0: 
					printf("giCNat%d=%f\n",oct,val);
					break;
				case 1:
					printf("giCSharp%d=%f\n",oct,val);
					printf("giDFlat%d=%f\n",oct,val);
					break;
				case 2:
					printf("giDNat%d=%f\n",oct,val);
					break;
				case 3:
					printf("giDSharp%d=%f\n",oct,val);
					printf("giEFlat%d=%f\n",oct,val);
					break;
				case 4:
					printf("giENat%d=%f\n",oct,val);
					break;
				case 5:
					printf("giFNat%d=%f\n",oct,val);
					break;
				case 6:
					printf("giFSharp%d=%f\n",oct,val);
					printf("giGFlat%d=%f\n",oct,val);
					break;
				case 7:
					printf("giGNat%d=%f\n",oct,val);
					break;
				case 8:
					printf("giGSharp%d=%f\n",oct,val);
					printf("giAFlat%d=%f\n",oct,val);
					break;
				case 9:
					printf("giANat%d=%f\n",oct,val);
					break;
				case 10:
					printf("giASharp%d=%f\n",oct,val);
					printf("giBFlat%d=%f\n",oct,val);
					break;
				case 11:
					printf("giBNat%d=%f\n",oct,val);
					break;
			}
		}
	}
}

