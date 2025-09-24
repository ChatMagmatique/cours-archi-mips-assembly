# Cours d'assembleur sur l'architecture mips
## Les registres
|   0   | $zero   | Toujours égale à zéro                                               |
|   1   | $at     | Variable temporel pour l'assembleur (à ne pas l'utiliser)           |
|  2-3  | $v0-$V1 | Valeurs de retour d'une fonction appelée                            |
|  4-7  | $a0-$a3 | Les paramètres pour une fonction appelée                            |
| 8-15  | $t0-$t7 | Variables temporelles, qu'elles ne devraient pas être préservées    |
| 16-23 | $s0-$s7 | Variables d'une fonction, qu'elle devraient être préservées         |
| 24-25 | $t8-$t9 | Deux variables temporelles en plus                                  | 
| 26-27 | $k1-$k2 | Registres du noyau                                                  |
|  28   |   $gp   | Pointeur global                                                     |
|  29   |   $sp   | Pointeur de la pile                                                 |
|  30   | $fp/$s8 | Pointeur de la pille d'appelle de fonction                          |
|  31   |   $ra   | L'addresse de retour du dernier appel de fonction                   |
## Les types
| .ascii    | Chaîne de caractère sans le caractère nul à la fin    |
| .asciiz   | Chaîne de caractère avec le caractère nul à la fin    |
| .space    | Alloue un tableau de n octets                         |
| .word     | Un entier signé de 16 bits                            |
## Instructions du MIPS32
Légende:
Rd = Registre de destination
Rs, Rt = Registres de sources d'opérande
Ra = Registre de l'adresse de retour ($ra)
PC = Program counteur ($pc)
Acc = Accumulateur 64 bits

### Opérations arithmétiques

| opcode                 | C équivalent |
|------------------------|--------------|
| add Rd, Rs, Rt         | Rd = Rs + Rt |
| addi Rd, Rs, const16   | Rd = Rs + const16 |
| addu Rd, Rs, Rt        | Rd = Rs + Rt |
| addiu Rd, Rs, const16  | Rd = Rs + const16 |
|------------------------|------------------|
| sub Rd, Rs, Rt         | Rd = Rs - Rt |
| subu Rd, Rs, Rt        | Rd = Rs - Rt |
|------------------------|-------------------|
| la Rd, Label           | Rd = &Label |
| li Rd, const16         | Rd = const16 |
| lui Rd, const16        | Rd = const16 |
| move Rd, Rs            | Rd = Rs |
| negu Rd, RS            | Rd = -Rs |

### Opération sur les bits

| opcode                 | C équivalent |
|------------------------|--------------|
| not Rd, Rs             | Rd = ~Rs |
| and Rd, Rs, Rt         | Rd = Rs & Rt |
| andi Rd, const16       | Rd = Rs $ const16 |
| or Rd, Rs, Rt          | Rd = Rs | Rt |
| ori Rd, const16        | Rd = Rs | const16 |
| nor Rd, Rs, Rt         | Rd = ~(Rs | Rt) |
| xor Rd, Rs, Rt         | Rd = Rs Rt |
| xori Rd, Rs, const16   | Rd = Rs const16 |

### Opération de comparaision

| opcode                 | C équivalent |
|------------------------|--------------|
| movn Rd, Rs, Rt        | if(Rt != 0) Rd = Rs |
| movz Rd, Rs, Rt        | if(Rt == 0) Rd = Rs |
| slt Rd, Rs, Rt         | Rd = (Rs < Rt)? 1: 0 |
| slti Rd, Rs, const16   | Rd = (Rs < const16)? 1: 0 |
|  