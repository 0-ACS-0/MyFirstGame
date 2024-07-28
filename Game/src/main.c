#include "main.h"

int main()
{
    char readBuffer[64] = {0};

    print("\nIntroduce cualquier cosa: ");
    scan(readBuffer, sizeof(readBuffer));
    print("\n-> ");
    print(readBuffer);
    print("\n");
    return 0;
}