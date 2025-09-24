# Author: ChatEnMagma
# Data: 2025
# Brief: tri par sélection
.data
    tab:    .word 3, 7, 5, 4, 10, 2, 5
    tabn:   .word 7
.text
main:
    la $s0, tab         # L'addresse du tableau
    lw $s1, tabn        # La taille du tableau

    ## PRINT LE TAB NON TRIE
    # Sauvegarde de la pile
    sw $s1, 0($sp)
    sw $s0, -4($sp)
    addi $sp, $sp, -8
    # Paramétrage de la fonction
    move $a0, $s0
    move $a1, $s1
    jal printtab       # Appelle de la procédure
    # Réstauration de la pile
    lw $s0, 4($sp)
    lw $s1, 8($sp)
    addi $sp, $sp, 8

    ## TRI LE TAB
    # Sauvegarde de la pile
    sw $s1, 0($sp)
    sw $s0, -4($sp)
    addi $sp, $sp, -8
    # Paramétrage de la fonction
    move $a0, $s0
    move $a1, $s1
    jal selectsort      # Appelle de la procédure
    # Réstauration de la pile
    lw $s0, 4($sp)
    lw $s1, 8($sp)
    addi $sp, $sp, 8

    move $s0, $a0       # récupère le pointeur du tableau trié

    # print ln
    li $v0, 11
    la $a0, '\n'
    syscall

    ## PRINT LE TAB TRIE
    # Sauvegarde de la pile
    sw $s1, 0($sp)
    sw $s0, -4($sp)
    addi $sp, $sp, -8
    # Paramétrage de la fonction
    move $a0, $s0
    move $a1, $s1
    jal printtab    # Appelle de la procédure
    # Réstauration de la pile
    lw $s0, 4($sp)
    lw $s1, 8($sp)
    addi $sp, $sp, 8
exit:
    # Quitte le programme
    li $v0, 10
    syscall

#==== FUNCTIONS ====

printtab:
    move $s0, $zero             # i
    move $t0, $a0               # tab
fortab:
    beq $s0, $a1, print_return  # i == n

    # Affiche le nombre à l'indice i
    li $v0, 1
    lw $a0, ($t0)
    syscall

    # Ajour un caractère pour espacer
    li $v0, 11
    la $a0, ' '
    syscall

    addi $t0, $t0, 4            # Passe à la prochaine case
    addi $s0, $s0, 1            # Incrémente i

    j fortab                    # boucle pour
print_return:
    jr $ra                      # return

selectsort:
    move $s2, $zero             # i
    move $s0, $a0               # &tab[i]
for_i:
    # Contrôle de la boucle pour
    slt $t0, $s2, $a1           # i < n
    beqz $t0, selectsort_return # for(i = 0; i < n; i++)

    move $s4, $s0               # &tab[min]

    # Initialise j pour la boucle pour
    addi $s3, $s2, 1            # j = i + 1
    addi $s1, $s0, 4            # &tab[j]
for_j:
    # Contrôle de la boucle pour
    slt, $t0, $s3, $a1
    beqz $t0, next_i            # for(j = i; j < n; j++)
    
    lw $t2, ($s1)               # val = tab[j]
    lw $t3, ($s4)               # valmin = tab[min]

    slt, $t0, $t2, $t3
    beqz $t0, next_j            # si valmin < val
    
    move $s4, $s1               # &tab[min] = &tab[j]
next_j:
    addi $s3, $s3, 1            # j += 1
    addi $s1, $s1, 4            # (tab + j + 1)
    j for_j                     # boucle pour
next_i:
    beq $s0, $s4, incr_i        # if(&tab[i] == &tab[min])

    # Nous procédons à l'échange de valeur
    lw $t0, ($s0)               # tmpi = tab[i]         
    lw $t1, ($s4)               # tmpmin = tab[min]
    sw $t1, ($s0)               # tab[i] = tmpmin
    sw $t0, ($s4)               # tab[min] = tmpi
incr_i:
    addi $s2, $s2, 1            # i += 1
    addi $s0, $s0, 4            # &tab[i] + 4

    j for_i                     # boucle pour
selectsort_return:
    jr $ra              # return