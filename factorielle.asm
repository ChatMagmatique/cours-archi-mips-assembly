# Author: ChatEnMagma
# Data: 2025
# Brief: Définit une fonction factoriel, puis le code en main affiche tous les résultats jusqu'au choix de l'utilisateur
.data
    msg:        .asciiz "Donner un nombre entier pour le calcule de la factoriel:\n"
    msg_res:    .asciiz "Le resultat de la factorielle "
    msg_res2:   .asciiz " est de "
    msg_res3:   .asciiz "\n"
.text
main:
    # affiche le message du début
    li $v0, 4                   # code syscall pour print un message
    la $a0, msg
    syscall

    # récupère l'entier donné par l'utilisateur
    li $v0, 5                   # code syscall pour demander à l'utilisateur un entier
    syscall

    move $s0, $v0               # mets la valeur récupère au registe $s0

    li $s1, 0                   # compteur de la boucle
debut_boucle:
    # sauvegarde des registes dans la 
    sw $s0, 0($sp)
    sw $s1, -4($sp)
    addi $sp, $sp, -8

    # appelle la fonction en param la valeur donée
    move $a0, $s1               # met en paramètre pour la fonction
    jal factoriel

    # restauration des registes de la pile
    lw $s1, 4($sp)
    lw $s0, 8($sp)
    addi $sp, $sp, 8

    move $t0, $v0               # récupère la valeur de retour de la fonction

    # affiche le message du résultat
    li $v0, 4                   # code syscall pour print un message
    la $a0, msg_res
    syscall

    # affiche i-ème factorielle
    li $v0, 1                   # code syscall pour print un entier
    move $a0, $s1
    syscall

    # affiche deuxième message du résultat
    li $v0, 4                   # code syscall pour print un message
    la $a0, msg_res2
    syscall

    # affiche le résultat de la factorielle
    li $v0, 1
    move $a0, $t0
    syscall

    # affiche le saut à la ligne pour la prochaine itération
    li $v0, 4                   # code syscall pour print un message
    la $a0, msg_res3
    syscall

    beq $s0, $s1, end_main      # si le coupteur = n donné par l'utilisateur alors on sort de la boucle
    addi $s1, $s1, 1            # incrémente le compteur

    j debut_boucle              # boucle pour
end_main:
    # sortie du programme
    li $v0, 10
    syscall
# fonction factoriel
# $a0 = n
factoriel:
    move $v0, $zero
    blez $a0, fac_renvoie

    li $v0, 1                   # valeur à renvoyer
    li $s0, 1                   # int i = 1
fac_boucle:
    multu $v0, $s0              # factoriel * i
    mflo $v0                    # récupère les bits de point faible et mets à la valeur à renvoyer

    beq $s0, $a0, fac_renvoie   # sort de la boucle si i = $a0
    addi $s0, $s0, 1            # incrémente i

    j fac_boucle                # boucle pour
fac_renvoie:
    jr $ra                      # retourne au programme principal