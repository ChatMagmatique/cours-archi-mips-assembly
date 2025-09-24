# Author: ChatEnMagma
# Data: 2025
# Brief: Crée un tableau, initie et le lit
.data
    tab:    .word   0:2             # initialise le tableau de taille 2 avec 0 à chaque case
    tabn:   .word 2                 # nombre d'éléments du tableau
.text
.glob __start

__start:
    # Initialisation du tableau
    la $s1, tab                     # Met l'adresse du tableau
    lw $s2, tabn                    # Met le nombre d'éléments
    move $t0, $zero                 # Met l'indice du tableau est à 0

    li $t1, 1                       # Met cette valeur à $t1
    sw $t1, ($s1)                   # Met la veleur ci-dessus à la case 0

    li $t1, 3                       # Met cette valeur à $t1
    sw $t1, 4($s1)                  # Met la veleur ci-dessus à la case 1
loop:
    # Boucle pour afficher chaque éléments du tableau
    beq $t0, $s2, exit              # si le compteur est égale au nombre d'élements
    
    # Affiche le chiffre à la i-ème indice
    li $v0, 1
    lw $a0, ($s1)                   # récupère la valeur dans le tableau
    syscall

    # Affiche un caractère
    li $v0, 11
    la $a0, ' '
    syscall

    addi $t0, $t0, 1                # incrémente le compteur de la boucle
    addi $s1, $s1, 4                # parcours le tableau +4 car un .word c'est 4 bytes

    j loop                          # boucle pour
exit:
    # Quitte le programme
    li $v0, 10
    syscall
    