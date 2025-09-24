# Author: ChatEnMagma
# Data: 2025
# Brief: Plusieurs fonctions de print pour dire bonjour et d'input
.data
    n:          .word   42

    msg:        .asciiz "Hello world\n"
    msg2:       .asciiz "Le nombre de la vie est "

    age_msg:    .asciiz "Votre âge:\n"
    name_msg:   .asciiz "Dis-moi ton nom:\n"
    res_msg:    .asciiz "Vous appelez "
    res_msg2:   .asciiz "Et vous avez "
    res_msg3:   .asciiz " ans\n"

    namesz:     .word   32  # la taille du nom
    name:       .space  32  # dédie 32 bytes dans la mémoire

    bye_msg:    .asciiz "Merci de m'avoir essayé... Au revoir, <3"
.text
main:
    ## PARTIE I

    # affiche le Hello World
    li $v0, 4       # Met le code pour afficher un message
    la $a0, msg     # Met en argument le message
    syscall

    # Affiche le second message
    li $v0, 4       # Met le code pour afficher un message
    la $a0, msg2    # Met en argument le message
    syscall

    # Affiche l'entier n
    li $v0, 1       # Met le code pour afficher un entier
    lw $a0, n
    syscall

    # Affiche le saut à ligne
    li $v0, 11      # Met le code pour afficher un seul caractère
    la $a0, '\n'
    syscall

    ## PARTIE II

    # Affiche le message pour demander l'âge
    li $v0, 4
    la $a0, age_msg
    syscall

    # Demande l'entier de votre âge
    li $v0, 5
    syscall

    move $s0, $v0   # Met l'âge dans $s0

    # Affiche le message pour demander le nom
    li $v0, 4
    la $a0, name_msg
    syscall

    # Demande le string de votre nom
    li $v0, 8
    la $a0, name    # L'addresse du buffer
    la $a1, namesz  # Définit la taille du buffer
    syscall

    move $s1, $a0   # Récupère le string de votre nom

    # Affiche le message de votre identité
    li $v0, 4
    la $a0, res_msg
    syscall

    # Affiche votre nom
    li $v0, 4
    move $a0, $s1
    syscall

    # Affiche le message deuxième de votre identité
    li $v0, 4
    la $a0, res_msg2
    syscall

    # Affiche votre âge
    li $v0, 1
    move $a0, $s0
    syscall

    # Affiche le message troisième de votre identité
    li $v0, 4
    la $a0, res_msg3
    syscall
    
    ## PARTIE III
    # Affiche le message d'adieu
    li $v0, 4
    la $a0, bye_msg
    syscall
exit:    
    # Quitte le programme
    li $v0, 10      # Met le code pour couper le programme
    syscall 