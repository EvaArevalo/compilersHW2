/*
 * Testcase_3
 *
 *
 */

int afunc(int *p)
{
    printf("afunc result");
}

int bfunc(int *p)
{
    printf("+++bfunc result---");
}

int main(void)
{
#pragma token off
    const int a = 123;
    int point = 1;
    bool flag = true;
    char b = 'X';

#pragma token on

    switch(b) {
        case 'X':
            afunc(&point);
            break;
        case 'b':
            bfunc(&point);
            break;
        case 'c':
            flag = false;
        default:
            break;
    }

ADD:do {
        if (a == 123) {
            a = a + (point * 5) - a;
            goto ADD;
        }
    } while (flag);

    printf("This is a string constant");

    return 0;
}
