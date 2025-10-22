---
## Mon suivi personnel
---
## TPE 3 : Optimisation Convexe avec Unlockbox

# UNLOCKBOX 

* **NOMS** : KEMBOU FOSSO
* **PRENOMS** : RICHEL
* **MATRICULE** : 22U2118

---


### 1. Contexte d'apprentissage
L’**UNLocBoX** (UNiversal LOCal BOx) est une boîte à outils libre développée à l’EPFL (École Polytechnique Fédérale de Lausanne) pour la \résolution de problèmes d’optimisation convexe non lisse.  
Elle est conçue pour fonctionner sous **MATLAB et GNU Octave**, et permet d’expérimenter aisément avec des méthodes. 

On peut utiliser ce outil pour plusieurs problèmes comme :
- Réduction du bruit dans une image
- Traitement du signal (séparation du signal)
- Apprentissage parcimonieux


## 2. Travail réalisé

### Jour 1 : Apprentissage de l'outil unlockbox
    Grâce à UNLocBoX, il devient aisé de :

- modéliser un problème d’optimisation convexe sous forme d’une somme de fonctions convexes,

- tester différentes régularisations convexes (L1, L2, TV, etc.) sur une même donnée,

- comparer les performances de chaque méthode selon des critères de convergence, de fidélité et de stabilité au bruit.

- Appliquée à des images, cette approche permet par exemple d’ajouter un bruit contrôlé, puis de le minimiser à l’aide de fonctions convexes adaptées, afin d’évaluer objectivement quelle stratégie produit le meilleur compromis entre clarté visuelle et préservation des détails.

**En somme, UNLocBoX offre une approche expérimentale et modulaire pour explorer la convexité et l’optimisation dans Octave ou MATLAB, tout en fournissant une plateforme cohérente pour la comparaison et l’analyse des méthodes numériques modernes.**

### Jour 2 : Prise en main de l'outil
- Installation de unlockbox avec le lien du repo **github** : [https://github.com/epfl-lts2/unlocbox](https://github.com/epfl-lts2/unlocbox)
- Ajout du chemin de Unlockbox au **path** de  Octave
- Test avec **init_unlockbox** dans le terminal de commade
- Réalisation d'un bruitage d'image avec UnlockBox et reconstrcution via les 3 opérateur de prox qui sont :  ***prox TV(Total Variation)***, ***prox L1***, et ***prox L2*** et conclusion sur la meilleure méthode d'approcimation. 

### Jour 3 : Soumission des travaux effectués
- Création de la branche **22U2118_KEMBOU** Depuis github sur le repo : **TPE_UNLOCKBOX**, 
- Soumission du travail