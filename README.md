
## Operace - Mocnina
- Bude se používat ve formátu pow(a, b), kde "a" je číslo, které bude umocněno číslem "b".

## Datové typy - integer, hexadecimal, float
### Integer
- Je celé číslo zapsané ve formátu např.: 111, 123, 511, 0, 22, 5 atd.
### Hexadecimal
- Hexadecimalní číslo bude zapsané ve formátu 0xA, kde "A" bude číslo zapsané v hexadecimálním formátu malými písmeny nebo čísly.
- Povolené zápisy budou např.: 0x1, 0x25d, 0x32f, 0x15c.
### Float
- Float bude oddělen desetinnou tečkou. 
- Povolené hodnot budou např.: 1.2, 25.25, 0.123, 0.2222.
## Něco unikátního - Operátor "|"
- Unikátní bude operátor "|", který bude umožňovat rozdělení celého výrazu na více menších které budou na sobě plně nezávislé.
- Každý z výrazů bude oddělen samostatně a nebudou mít na sebe vliv.
- Povolené vstupy budou např.: (1+2)|(2+1)|(1.1+0xa)|pow(1,1)|4+2*1.
- Výraz nemůže začínat či končit "|".