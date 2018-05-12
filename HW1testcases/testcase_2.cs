/* 
 * Testcase_2
 *
 
 */

int main(void)
{
#pragma token off
    char a = 'a';
    double b = 0.01;
    int i = 1;
    int c[2];

    for (i = 0; i < 2; i++) {
        c[i] = i;
    }

#pragma token on
    printf("c[1]=%d\n", c[1]);
    if (c[0] > 1 && i != 0) {
        b = b * 100.1e+1;
        char d[3] = "XD";
    } 
    else {
        c[0] = 'X';
    }

    switch(a) {
        case 'a':
            a = 'b';
            break;
        case 'b':
            a = 'c';
            break;
        default:
            break;
    }

    printf("This is a string constant");
    
    return 0;
}
