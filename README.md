# Cours d'assembleur sur l'architecture mips

Bienvenue dans mon petit cours en assembleur MIPS32.

## Les registres

Les registres sont comme des variables mais directements accessibles pour le processeur. Ils sont au nombre limité, et avec chacune une utilité. Vous pouvez modifier une valeur qui ne devrait pas être modifié, cependant c'est une mauvaise chose à faire car trop confusant, et peut même cassé le system.

| numéro de registre |  opcode |                           Description                               |
|--------------------|---------|---------------------------------------------------------------------|
|         0          |  $zero  | Toujours égale à zéro                                               |
|         1          |   $at   | Variable temporel pour l'assembleur (à ne pas l'utiliser)           |
|        2-3         | $v0-$V1 | Valeurs de retour d'une fonction appelée                            |
|        4-7         | $a0-$a3 | Les paramètres pour une fonction appelée                            |
|        8-15        | $t0-$t7 | Variables temporelles, qu'elles ne devraient pas être préservées    |
|       16-23        | $s0-$s7 | Variables d'une fonction, qu'elle devraient être préservées         |
|       24-25        | $t8-$t9 | Deux variables temporelles en plus                                  | 
|       26-27        | $k1-$k2 | Registres du noyau                                                  |
|        28          |   $gp   | Pointeur global                                                     |
|        29          |   $sp   | Pointeur de la pile                                                 |
|        30          | $fp/$s8 | Pointeur de la pille d'appelle de fonction                          |
|        31          |   $ra   | L'addresse de retour du dernier appel de fonction                   |

## Les types

| opcodes   | Description                                           |
|-----------|-------------------------------------------------------|
| .ascii    | Chaîne de caractère sans le caractère nul à la fin    |
| .asciiz   | Chaîne de caractère avec le caractère nul à la fin    |
| .space    | Alloue un tableau de n octets                         |
| .word     | Un entier signé de 16 bits                            |

## Instructions du MIPS32

Vous allez trouvez toutes les instructions possibles que MIPS32 peut exécuter. Certaiens sont plutôt du haut-niveau tel que `li`, cependant elles sont nécessaire à apprendre pour mieux programmer en assembleur.

> ### Légende
>
> - Rd = Registre de destination
> - Rs, Rt = Registres de sources d'opérande
> - Ra = Registre de l'adresse de retour ($ra)
> - PC = Program counteur ($pc)
> - Acc = Accumulateur 64 bits

### Opérations arithmétiques

| opcode                 | C équivalent         |                            Description                            |
|------------------------|----------------------|-------------------------------------------------------------------|
| add Rd, Rs, Rt         | Rd = Rs + Rt         | Additionne deux registres signées                                 |
| addi Rd, Rs, const16   | Rd = Rs + const16    | Additionne un registre avec une constance à 16 bits               |
| addu Rd, Rs, Rt        | Rd = Rs + Rt         | Additionne deux registres non-signés                              |
| addiu Rd, Rs, const16  | Rd = Rs + const16    | Additionne une registre non-signés avec une constance à 16 bits   |
| sub Rd, Rs, Rt         | Rd = Rs - Rt         | Soustrait deux registres signés                                   |
| subu Rd, Rs, Rt        | Rd = Rs - Rt         | Soustrait deux registres non-signés                               |
| la Rd, Label           | Rd = &Label          | Initie un registre avec une adresse                               |
| li Rd, const16         | Rd = const16         | Initie un registre avec une constance signé à 16 bits             |
| lui Rd, const16        | Rd = const16         | Initie un registre avec un constance non-signé à 16 bits          |
| move Rd, Rs            | Rd = Rs              | Charge dans un registre la valeur d'un autre registre             |
| negu Rd, RS            | Rd = -Rs             | Charge dans un registre l'opposé de la valeur d'un autre registre |

### Opération sur les bits

| opcode                 | C équivalent         |
|------------------------|----------------------|
| not Rd, Rs             | Rd = ~Rs             |
| and Rd, Rs, Rt         | Rd = Rs & Rt         |
| andi Rd, const16       | Rd = Rs $ const16    |
| or Rd, Rs, Rt          | Rd = Rs 丨 Rt        |
| ori Rd, const16        | Rd = Rs 丨 const16   |
| nor Rd, Rs, Rt         | Rd = ~(Rs 丨 Rt)     |
| xor Rd, Rs, Rt         | Rd = Rs Rt           |
| xori Rd, Rs, const16   | Rd = Rs const16      |

### Opération de comparaision

| opcode                 | C équivalent                 |
|------------------------|------------------------------|
| movn Rd, Rs, Rt        | if(Rt != 0) Rd = Rs          |
| movz Rd, Rs, Rt        | if(Rt == 0) Rd = Rs          |
| slt Rd, Rs, Rt         | Rd = (Rs < Rt)? 1: 0         |
| slti Rd, Rs, const16   | Rd = (Rs < const16)? 1: 0    |

## Sources

* [Instruction set MIPS](/instruction_set_MIPS.pdf)