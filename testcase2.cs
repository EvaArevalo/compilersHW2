
int a;
int b;

int main()
{
   int i=0;
   int j;
   int k;
   const double blabla=1.1;

   //test ifs
   if(i>3){
	j=3;
   }else{
	j=5;
   }

   if(i==2) k=2;
   else k=4;

   //test while/switch
   while(i<10){
	i++;
   }

   while(i!=5){
	int froufrou=i*3;
//	switch (froufrou){
//	  case 1:
//		i=1;
//		break;
//	  case 2:
//		i=2;
//		break;
//	  default:
//		i=7;
//	}
   }

//  switch (froufrou){
//	case 'a':
//	 i=1;
//	 break;
//	case 'b':
//	 i=2;
//	 break;
//	default:
//	 i=7;
//  }
   //test fors
   for(;;){
     i--;
   }

   for(i=0;i<10;i++){
	j=j/2;
   }

   a = a + b + 3 + 6;
   a = i + j + k + 3;
   a = a / 2;
   a = i - j;
   a = k % j;
   a = a--;
   
   
   return 0;
}
