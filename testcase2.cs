
int a;
int b;
double c[]={100.0,600.0,500.0};
double d[5]={100.0,600.0,500.0};
double e[5][4][3];
const double blabla=1.1;

int main()
{
   int i=0;
   int j;
   int k;
   c[1]=10.0;

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
	switch (froufrou){
	  case 1:
		i=1;
		break;
	  case 2:
		i=2;
		break;
	  default:
		i=7;
	}
   }

  switch (froufrou){
	case 'a':
	 i=1;
	 break;
	case 'b':
	 i=2;
	 break;
	default:
	 i=7;
  }

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
   
   blabla(1,1.1,'c');
   
   return 0;
}

double blabla(int para1,double para2,char para3){
   para1=para2&&para3;
   para1=para1||para2;
}