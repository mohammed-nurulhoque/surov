
int time(int *p) {
    int cycles;  
    __asm__ volatile ("rdcycle %0" : "=r" (cycles));
    if (p) *p = cycles;
    return cycles;
}
