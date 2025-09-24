# Author: ChatEnMagma
# Data: 2025
# Brief: Un petit jeu duquel il faut trouver un chiffre aléatoire, si le chiffre proposé est > au chiffre aléatoire alors il dit moins, sinon plus
.data
    max:        .word   100      # variable de valeur maximum entre 0 à max
    
    begin_msg:  .asciiz "Trouver mon nombre entre 0 à "
    begin_msg2: .asciiz ". Soyez le plus rapide ;)\n"
    aide_msg:   .asciiz "Ecrivez un chiffre...\n"
    plus_msg:   .asciiz "C'est plus!\n"
    moins_msg:  .asciiz "C'est moins!\n"
    end_msg:    .asciiz "Félicitation, vous avez trouvez en "
    end_msg2:   .asciiz " coups!\n Au revoir <3"
.text
main:
    li $v0, 42                  # génère un nombre aléatoire
    lw $a1 max                  # limitant au max
    syscall
    
    # initialise les variables de main
    move $s0, $a0               # s0 = valeur à chercher
    move $s1, $zero             # s1 = nombre de tour

    ## Affichage du début de jeu

    # affiche le début du message du début du jeu
    li $v0, 4
    la $a0, begin_msg
    syscall

    # affiche l'entier i.e. le max
    li $v0, 1
    lw $a0, max
    syscall

    # affiche la fin du message du début de jeu
    li $v0, 4
    la $a0, begin_msg2
    syscall
begin:                          # boucle principale du jeu, tant que le joeur n'a pas trouver le chiffre, on fait la boucle
    # affiche l'aide pour écrire un chiffre
    li $v0, 4
    la $a0, aide_msg
    syscall

    # récupère l'entier donner par l'utilisateur
    li $v0, 5
    syscall

    beq $s0, $v0, end           # Sort de la boucle si on trouve le bon nombre

    sub $t0, $s0, $v0           # calcule la différence entre la max et l'entier de l'utitilisateur

    bgtz $t0, plus              # Si la différence est > 0
    bltz $t0, moins             # Si la différence est < 0
moins:
    # affiche le texte c'est moins
    li $v0, 4
    la $a0, moins_msg
    syscall

    j continue
plus:
    # affiche le texte c'est plus

    li $v0, 4
    la $a0, plus_msg
    syscall

    j continue
continue:
    addi $s1, $s1, 1            # incrémente le nombre de tour

    j begin                     # retour à la boucle     
end:
    # affiche le message de fin la première partie
    li $v0, 4,
    la $a0, end_msg
    syscall

    # affiche le nombre de tours faits
    li $v0, 1
    move $a0, $s1
    syscall

    # affiche le message de fin la dernière partie
    li $v0, 4
    la $a0, end_msg2
    syscall

    li $v0, 10          # sortie du programme
    syscall