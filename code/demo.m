
% --- Étape 1 : Initialisation et Préparation des Données ---
verbose = 2;    % Niveau d'affichage

% 1. Charger et normaliser une image
Im = rescale(double(imread('cameraman.tif')));
N = size(Im);

% 2. Générer une image bruitee (y)
sigma = 0.1; 
rng(1);      
y = Im + sigma * randn(N);
y = rescale(y); 

% 3. Définir le point de départ de la solution
x0 = y;


% --- Étape 2 : Définition des Fonctions f1 et f2 ---

% --- 2.1. Définition de f1 : Terme TV (Non-Lisse) ---
lambda = 0.05; % Paramètre d'équilibre
param_tv.verbose = verbose - 1;

f1.prox = @(x, T) prox_tv(x, lambda * T, param_tv); % Opérateur Proximal (Soft-Thresholding pour TV)
f1.eval = @(x) lambda * norm_tv(x); % Fonction d'évaluation

% --- 2.2. Définition de f2 : Terme d'Erreur Quadratique (Lisse) ---
% Gradient de f2(x) = 0.5 * ||x - y||^2 est (x - y)
% Constante de Lipschitz (beta) est 1
f2.grad = @(x) (x - y);         % Gradient requis
f2.eval = @(x) 0.5 * norm(x - y, 'fro')^2; 
f2.beta = 1;                    % Constante de Lipschitz L=1

% --- Étape 3 : Configuration et Exécution ---
param.verbose = verbose; 
param.maxit = 100;       
param.tol = 1e-4;        

% Le pas (tau) doit être < 2/beta. Ici beta=1, donc on prend 1.9.
param.tau = 1.9 / f2.beta; 

% Exécution du solveur universel, qui sélectionne Forward-Backward
sol = solvep(x0, {f1, f2}, param);
% --- Étape 4 : Affichage et Analyse des Résultats ---

% Calcul de l'erreur MSE (Mean Squared Error) pour l'analyse
MSE_bruit = norm(y - Im, 'fro')^2 / numel(Im);
MSE_denoised = norm(sol - Im, 'fro')^2 / numel(Im);

fprintf('\n--- Analyse des performances ---\n');
fprintf('MSE Image Bruitee : %.4f\n', MSE_bruit);
fprintf('MSE Image Debruitee : %.4f\n', MSE_denoised);


% Affichage des images pour comparaison
figure;
subplot(1, 2, 1);
imagesc(y);
colormap gray;
title(sprintf('Image Bruitee (MSE: %.4f)', MSE_bruit));
axis image off;

subplot(1, 2, 2);
imagesc(sol);
colormap gray;
title(sprintf('Image Debruitee TV (MSE: %.4f)', MSE_denoised));
axis image off;
