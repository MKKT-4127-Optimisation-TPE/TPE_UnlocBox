%% Initialisation
clear;

init_unlocbox;

pkg load image; %Chargement du paquet des images


% Débruitage avec fonction L2 (quadratique)
% --- paramètres utilisateur
img_file = 'Exemple.png';    % <-- remplace par le nom de ton png
sigma = 0.05;                  % amplitude du bruit gaussien (std)
lambda_tv = 0.08;             % poids TV
lambda_l1 = 0.06;             % poids L1
lambda_l2 = 0.06;             % poids L2 (Tikhonov via prox_l2)
maxit_solver = 200;

% --- lire image
I0 = im2double(imread(img_file));
if size(I0,3) == 3
  I0 = rgb2gray(I0);
end
[H, W] = size(I0);

% --- ajouter bruit gaussien
rng(0);  % pour reproductibilité
Inoisy = I0 + sigma * randn(size(I0));
Inoisy = min(max(Inoisy, 0), 1);

figure('Name','Original / Noisy','NumberTitle','off');
subplot(1,2,1); imshow(I0); title('Original');
subplot(1,2,2); imshow(Inoisy); title(sprintf('Noisy (\\sigma=%.3f)', sigma));

% --- fonctions communes (fidelity = 0.5*||x-y||^2)
y = Inoisy;                % mesure
f2.eval = @(x) 0.5 * norm(x(:) - y(:))^2;
f2.grad = @(x) (x - y);    % gradient of 0.5||x-y||^2 is (x-y)

% solver params
param_solver.maxit = maxit_solver;
param_solver.verbose = 1;   % 0 pour muet
param_solver.gamma = 1.0;   % step size (OK ici car Lipschitz constant L=1 for grad)

% -------------------------
% METHOD A: TV regularization
% minimize 0.5||x-y||^2 + lambda_tv * TV(x)
% -------------------------
param_tv.verbose = 0;
param_tv.maxit = 50;

f_tv.prox = @(x, tau) prox_tv(x, lambda_tv * tau, param_tv);  % prox for lambda*TV with step tau
f_tv.eval = @(x) lambda_tv * norm_tv(x);

x0 = y;  % init
[x_tv, info_tv] = forward_backward(x0, f_tv, f2, param_solver);

% -------------------------
% METHOD B: L1 regularization (sparsity on pixels)
% minimize 0.5||x-y||^2 + lambda_l1 * ||x||_1
% -------------------------
% prox_l1 applies soft-thresholding element-wise
f_l1.prox = @(x, tau) prox_l1(x, lambda_l1 * tau);
f_l1.eval = @(x) lambda_l1 * norm(x(:), 1);

[x_l1, info_l1] = forward_backward(x0, f_l1, f2, param_solver);

% -------------------------
% METHOD C: L2 regularization (Tikhonov)
% minimize 0.5||x-y||^2 + lambda_l2 * ||x||_2^2
% prox_l2 solves prox for weighted L2; with default A=Id and y=0 gives shrinkage
% -------------------------
% prox_l2 signature: sol = prox_l2(x, gamma, param)
param_l2 = struct(); % default ok (A = Id, y = 0)
f_l2.prox = @(x, tau) prox_l2(x, lambda_l2 * tau, param_l2);
f_l2.eval = @(x) lambda_l2 * (norm(x(:),2)^2);

[x_l2, info_l2] = forward_backward(x0, f_l2, f2, param_solver);

% -------------------------
% Eval metrics: MSE / PSNR
% -------------------------
mse = @(A,B) mean((A(:)-B(:)).^2);
psnr_from_mse = @(m) 10*log10(1./m);

MSE_noisy = mse(I0, Inoisy);
MSE_tv    = mse(I0, x_tv);
MSE_l1    = mse(I0, x_l1);
MSE_l2    = mse(I0, x_l2);

fprintf('\n--- MSE / PSNR ---\n');
fprintf('Noisy: MSE=%.6f, PSNR=%.2f dB\n', MSE_noisy, psnr_from_mse(MSE_noisy));
fprintf('TV   : MSE=%.6f, PSNR=%.2f dB\n', MSE_tv,    psnr_from_mse(MSE_tv));
fprintf('L1   : MSE=%.6f, PSNR=%.2f dB\n', MSE_l1,    psnr_from_mse(MSE_l1));
fprintf('L2   : MSE=%.6f, PSNR=%.2f dB\n', MSE_l2,    psnr_from_mse(MSE_l2));

% -------------------------
% Show results
% -------------------------
figure('Name','Denoising results','NumberTitle','off');
subplot(2,2,1); imshow(Inoisy); title('Noisy');
subplot(2,2,2); imshow(x_tv);   title(sprintf('TV (\\lambda=%.3f)', lambda_tv));
subplot(2,2,3); imshow(x_l1);   title(sprintf('L1 (\\lambda=%.3f)', lambda_l1));
subplot(2,2,4); imshow(x_l2);   title(sprintf('L2 (\\lambda=%.3f)', lambda_l2));
