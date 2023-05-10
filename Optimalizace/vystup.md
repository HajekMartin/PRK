### Změna funkce condition1
- Změna if/else na pouze jeden if s return aby nemusle být else nepřinesl značné zlepšení.

### Odebrání těch ifů v main co se nikdy nevykonají
- Odebrání ifů co se nikdy nevykonají podle očekávání něpřineslo skoro žádnou úsporu né-li žádnou!

### Odebrání ve funkci condition1 celkově toho if
- Při celém odebrání if ve funkci condition1 nepřineslo značné zlepšení, protože opět to optimalizátor asi hned vyhodil.

### Odebrání include stdio.h
- Odebrání include snížilo počet řádků o asi jeden nebo dva řádky výsledného .asm.

### Nahrazení funkce samotným výpisem pouze stringu.