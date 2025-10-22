--------------------------------------------------------------------------------------------------------------------------------------
# SUIVI PERSONNEL DE L'ETUDIANT
---------------------------------------------------------------------------------------------------------------------------------------

## UNLOCBOX: BOITE A OUTILS MATLAB POUR L OPTIMISATION CONVEXE


##  Informations
- **NomS & pRENOMS :** MEFFO TAHAFO LEA JECY
- **Matricule:** 22U2194
- **Spécialité :** MASTER 1 SPÉCIALITÉ DATASCIENCES 
- **Projet :** Optimisation Convexe et Méthodes de Décomposition Proximale (UNLocBoX)


-----------------------------------------------------------------------------------------------------------------------------------------
##  Objectifs personnels
- Contexte : Comprendre le rôle des méthodes de décomposition proximale face aux défis du Big Data.
- Structure : Décomposer l'architecture de la boîte à outils UNLocBoX (Matlab).
- Application : Maîtriser le processus de modélisation d'un problème convexe pour une implémentation rapide et efficace.

	
## Qu'est-ce que UNLocBoX ?

UNLocBoX est une toolbox MATLAB open-source dédiée à l'optimisation convexe par méthodes de splitting proximal. Elle offre des fonctionnalités complètes pour :

- La résolution de problèmes convexes de la forme min Σf_i(x)
- L'implémentation d'algorithmes proximales récents
- Une bibliothèque d'opérateurs proximaux communs
- La gestion de contraintes via des projecteurs

## Contexte : Le Problème d'Optimisation Cible

	UNLocBoX est spécialisé dans la résolution de problèmes qui se formulent comme la somme de fonctions convexes :
		x∈RNmin​n=1∑K​fn​(x)

### Fondamentaux Théoriques : L'Opérateur Proximal

	Le concept central est l'opérateur proximal, généralisation de la projection. Pour une fonction f, l'opérateur est défini par :
proxλf​(x):=argy∈RNmin​{21​∥x−y∥22​+λf(y)}
	Ce concept permet aux algorithmes de décomposition de traiter des termes complexes (non-lisses) individuellement à chaque itération.
	
### Définition

L'optimisation convexe avec splitting proximal consiste à résoudre des problèmes de minimisation en décomposant la fonction objectif en sommes de fonctions simples, puis en appliquant alternativement leurs opérateurs proximaux. Contrairement aux méthodes classiques qui nécessitent des fonctions différentiables, les méthodes proximales peuvent traiter des fonctions non-différentiables.

### Caractéristiques principales

- Traitement de fonctions non-différentiables via les opérateurs proximaux
- Découplage des sous-problèmes pour une résolution efficace
- Convergence garantie pour les fonctions convexes
- Particulièrement adapté aux problèmes de grande dimension

## Architecture Globale - Les 4 Groupes de Fonctions

1. **Solvers** : Cœur de la toolbox (Forward-Backward, Douglas-Rachford, etc.)
2. **Proximal Operators** : Opérateurs proximaux prédéfinis (normes, contraintes...)
3. **Fichiers de Démonstration**  
4. **Fonctions Utilitaires** 

## Modélisation des Fonctions - Le concept de structure MATLAB

Dans UNLocBoX, chaque terme fk(x) de la somme est représenté par une structure MATLAB avec quatre champs principaux :

- **f.eval** : Une fonction pour évaluer fk(x)
- **f.grad** : Une fonction pour calculer le gradient ∇fk(x) (si différentiable)
- **f.prox** : Une fonction pour appliquer l'opérateur proximal (si non-différentiable)  
- **f.beta** : La constante de Lipschitz du gradient (si différentiable)

## La Fonction Centrale : solvep - Le Solveur Automatique

solvep est la fonction principale qui analyse les fonctions fournies et sélectionne automatiquement le solveur le plus adapté.
	sol = solvep(x0, {f1, f2, f3}, param);
	
### Vue d'ensemble des Solvers (Slide 16)
Les solveurs sont choisis en fonction des propriétés du problème :	

 **Solvers Spécifiques**  (optimisés pour 2-3 fonctions) :
   - Forward-Backward (FISTA)
   - Douglas-Rachford
   - ADMM
   - Chambolle-Pock
**Solvers Généraux** (pour sommes avec nombreuses fonctions) :
   - PPXA
   - SDMM
    
## Journal de travail
Jour 1: [20/10/25]
   - Installation d'UNLocBoX et configuration MATLAB
   - Étude des concepts de base du splitting proximal
Jour 2: [21/10/25]
   - Implémentation de la régularisation par Variation Totale
   - Définition des fonctions f1, f2, f3 pour la reconstruction d'image
Jour 3: [21/10/25]
   - Comparaison des solveurs Douglas-Rachford et Forward-Backward
   - Analyse des paramètres d'optimisation (γ, λ, tolérance)
   - Validation des résultats de reconstruction

	
## Compétences acquises
   - Maîtrise des méthodes de splitting proximal
   - Utilisation avancée d'UNLocBoX pour l'optimisation convexe
   - Capacité à formuler un problème de reconstruction d'image comme problème d'optimisation
   - Comparaison critique de différentes approches (contrainte vs régularisation)

## Améliorations futures
   - Étudier l'influence des paramètres (λ, ε) sur la qualité de reconstruction
   - Étendre l'approche à d'autres types de dégradations (flou, compression)
   - Explorer l'utilisation du calcul GPU pour l'accélération

	
	
	
	
	
	
	
	
	
