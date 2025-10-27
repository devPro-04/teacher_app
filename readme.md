Retour APP:
Partie 1 : Synchronisation en direct (en attente)
Partie 2 : Fonctionnement clique bouton S'inscrire (ok)
Partie 3 : 
 1- Fonctionnement clique bouton Mot de passe oublié (ok)
 2- Fonctionnement clique bouton pas encore de compte s'inscrire (ok)
Partie 4 (en cours) 
Je viens de terminer quelques amélioration du code dans la page Login 
maintenant je suis sur la partie 4


Retour APP :
Partie 4:
1- La photo doit être celle du profil (ok)
2- Enlever le point Vert et Disponible (ok)
3- Amélioration de l'Icon notification et redirection vers la liste des notification (ok)
4- modification du texte : Réponse(s) attendue(s) (ok)
5- Modification du texte: Session(s) cette semaine (ok)

15-Gerer l’affichage du prix (à discuter)
6- il y a 3 possibilités : ETABLISSEMENT, GOUPEMENT, OLINOM CAMPUS (ok)
7- Il faut réajuster pour que ca affiche ce point de la bdd
Table: Replacement (à discuter)

Retour App:
Pour la partie 1
Synchronisation en direct: pour la liste des missions (ok)
Synchronisation pour la liste des messages (ok)
Synchronisation Liste Sessions (ok)

je continue sur la partie 5

Retour App:
9- Il faut réduire l’espace (ok)
10- Mettre la date en Français (ok)
11- Mettre en francais : Connexion réussie (ok)

Retour App:
12- Le point bleu doit s’afficher, uniquement lorsqu’il y a un message non lu dans la
messagerie (ok)

13- Il faut rajouter le nombre d’évaluations 
=> Comment savoir le nombre d'évaluation, dans quelle table, il me faut une requette/API via le backend pour cela 

14- Il faut rajouter le le mode 3 possibilités : Présentiel, Distanciel, Présentiel ou Distanciel
=> d'où vient le 3 mode de possibilités, dans quelle table et nom du champ? 

16- Intégrer en cas de pb de conflit d’agenda, l’affichage comme sur la maquette

5) Dans la partie mission.
1- Il faut classer les missions les dates ou il va ou va avoir lieu le remplacement, a savoir du
plus proche au plus éloigné.

=> ça se fait au niveau Backend, ll faut paramétrer la requette SQL backend pour cela selon le besoin

2- Il faut que les missions une fois prises par un autre enseignants, ou annulées, ou la date
est dépassée, ne soient du coup plus visible
=> Idem pour cela

6) Les points bleus de notification doivent s’afficher uniquement si il y a un nouvel élément non
vu dans chaque partie. (ok)


Retour app partie 2
1) En cas d’erreur de connexion. Remplacer Unable to log in! par Impossible de se connecter (ok)

Prochaine étape:
2) Parametrer la mise en place de la page notifications en cliquant sur la cloche avec le point
bleu lorsqu’il y a une notif non lue.

