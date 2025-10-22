# Mon Parcours avec UNLOCBOX : Optimisation Convexe et Séparation Proximale

**Titre du Projet :** Maîtrise des Méthodes de Séparation Proximale avec UNLOCBOX
* **NOMS** : KELODJOU DJOMO
* **PRENOMS** : NAFISSATOU IVANA
* **MATRICULE** : 22T2894


**Date :** Octobre 2025

---

## Qu'est-ce que UNLOCBOX ?

UNLOCBOX est une **boîte à outils MATLAB** dédiée à la résolution de problèmes d'**optimisation convexe**. Elle est spécialement conçue pour gérer des problèmes où la fonction objectif ($f(\mathbf{x})$) peut être exprimée comme une **somme de fonctions convexes** :

$$\min_{\mathbf{x}} \sum_{i=1}^{K} f_{i}(\mathbf{x})$$

Son pouvoir réside dans l'implémentation efficace des **méthodes de Séparation Proximale (Proximal Splitting)**. Ces méthodes sont cruciales lorsque l'on combine des contraintes (ou coûts) de natures différentes, notamment celles qui sont trop complexes ou impossibles à dériver directement.

### Le Principe Fondamental

UNLOCBOX résout cette complexité en forçant l'utilisateur à catégoriser chaque fonction $f_i$ :

| Nature de $f_i$ | Opérateur Mathématique | Rôle dans UNLOCBOX |
| :--- | :--- | :--- |
| **Lisse** (facilement dérivable) | **Gradient** ($\nabla f_i$) | Utilisé pour l'étape de descente (\texttt{.grad}). |
| **Non-Lisse** (coins, non-dérivable) | **Opérateur Proximal** ($\text{prox}_{f_i}$) | Utilisé pour l'étape de projection ou de correction (\texttt{.prox}). |

En fournissant le bon opérateur pour chaque terme, UNLOCBOX sélectionne ou exécute le solveur le plus efficace (Forward-Backward, Douglas-Rachford, ADMM, etc.) pour trouver la solution optimale.

---

## Connaissances Acquises durant le Tutoriel TV Denoising

La réalisation du tutoriel sur le Débruitage par Variation Totale (TV Denoising) a permis de solidifier les connaissances théoriques et pratiques suivantes :

### 1. Théorie Lisse vs. Non-Lisse
* **Compréhension du Problème ROF :** J'ai décomposé le modèle ROF en une partie non-lisse ($f_1$: Régularisation TV) et une partie lisse ($f_2$: Fidélité Quadratique), justifiant ainsi la nécessité du *Proximal Splitting*.
* **Signification des Opérateurs :** J'ai appris que \texttt{.grad} cherche la direction de la descente la plus rapide, tandis que \texttt{.prox} est une projection spécialisée qui gère les singularités (les "coins") introduites par les termes de régularisation (comme la norme $\ell_1$ ou la Variation Totale).

### 2. Maîtrise du Forward-Backward (Proximal Gradient)
* **Justification du Choix :** Le Forward-Backward est l'algorithme optimal lorsqu'une seule fonction est non-lisse (cas $f_1 + f_2$).
* **Mécanisme de l'Itération :** J'ai décortiqué la formule d'itération et son interprétation physique :
    * **Phase Forward** ($\mathbf{x}^{(k)} - \tau \nabla f_2$) : C'est la *proposition* de solution basée uniquement sur la minimisation de l'erreur brute.
    * **Phase Backward** ($\text{prox}_{\tau f_1}(\cdot)$) : C'est la *correction* de cette proposition, où la contrainte TV est appliquée pour supprimer le bruit tout en préservant les structures (les bords).

### 3. Application Pratique en MATLAB
* Savoir configurer les structures de fonction MATLAB (\texttt{f.grad}, \texttt{f.prox}, \texttt{f.beta}).
* Comprendre le rôle crucial du paramètre de pas \texttt{param.tau} pour assurer la convergence de l'algorithme ($\tau < 2/\beta$).
* Savoir interpréter les sorties du solveur (\texttt{f(x*)} et la convergence MSE) pour valider l'efficacité du débruitage.

---

## Améliorations Futures et Projets

Pour approfondir mes compétences en optimisation convexe avec UNLOCBOX, je prévois d'explorer les directions suivantes :

1.  **Exploration des Autres Solveurs** : Étudier et implémenter le solveur **Douglas-Rachford** pour gérer les problèmes où deux fonctions sont non-lisses (ex : la somme de deux opérateurs proximaux).
2.  **Régularisation Avancée (Lasso)** : Résoudre un problème de Régression Linéaire Sparse (Lasso) en utilisant la norme $\ell_1$ simple ($\lambda \|\mathbf{x}\|_1$), et comparer l'efficacité du Forward-Backward avec FISTA.
3.  **Problèmes de Déconvolution** : Appliquer le modèle TV à la déconvolution d'image (défloutage), ce qui nécessitera l'intégration d'un opérateur linéaire (matrice $\mathbf{A}$) dans le terme de fidélité.
4.  **Optimisation des Paramètres** : Développer des méthodes pour automatiser le choix du paramètre $\lambda$ (paramètre de régularisation) afin d'obtenir le meilleur compromis bruit/détail de manière adaptative.