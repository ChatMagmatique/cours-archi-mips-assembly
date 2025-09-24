# Author: ChatEnMagma
# Data: 2025
# Brief: fonction récursive de la somme
.data
    ask_msg:    .asciiz "Donne-moi un chiffre:\n"
    res_msg:    .asciiz "Le resultat:\n"
.text
main:
    # Affiche le message de demande
    li $v0, 4
    la $a0, ask_msg
    syscall

    # Récupère la valeur entière
    li $v0, 5
    syscall

    move $a0, $v0               # Met en paramètre la valeur récupérer
    jal sum                     # Appelle la fonction sum avec en param la valeur donnée par l'utilisateur

    move $t0, $v0               # Sauvegarde la valeur renvoyer par une var temporel
    
    # Affiche le résultat de l'appel récursive de somme
    li $v0, 1
    move $a0, $t0
    syscall
exit:
    # Quitte le programme
    li $v0, 10
    syscall
sum:
    move $v0, $a0               # la valeur de retour = au paraù
    beq $a0, $zero, sum_return  # Si n en param est à zéro, alors on renvoie la valeur 0

    # Sauvegarde de la pile de la fonction
    sw $ra, 0($sp)
    sw $v0, -4($sp)
    sw $a0, -8($sp)
    add $sp, $sp, -12

    addi $a0, $a0, -1           # Décrémente n
    jal sum                     # Appelle récursive

    move $t0, $v0               # Sauvegarde de renvoie

    # Réstauration de la pile
    lw $a0, 4($sp)
    lw $v0, 8($sp)
    lw $ra, 12($sp)
    add $sp, $sp, 12

    add $v0, $v0, $t0           # son renvoie + la valeur du renvoie de l'appel récursive
sum_return:
    jr $ra                      # Retour