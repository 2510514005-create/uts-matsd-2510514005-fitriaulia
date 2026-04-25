% =====================================================
%  UTS Matematika Sains Data — Semester Genap 2025/2026
%  Soal 6 — Optimasi Harga via Gradient Descent
%  ---------------------------------------------------
%  Nama  : Fitri Aulia
%  NIM   : 2510514005
%  Parameter: a=0, b=5, K=6, alpha=0.006
%  Tanggal: 25 April 2026
% =====================================================

clc; clear; close all;

% --- 1. Parameter & Model ---
a = 0; b = 5; K = 6;
alpha = 0.006; % sesuai parameter

% Fungsi Profit
pi_func = @(x) -(a+1)*x.^3 + (b+5)*K*x.^2 + 100*x - (K^2 * 10);

% Turunan pertama
pi_prime = @(x) -3*(a+1)*x.^2 + 2*(b+5)*K*x + 100;

%% --- 2. Gradient Descent (500 Iterasi) ---
x0 = 1;
n_iter = 500;

% Alpha normal
x_normal = zeros(n_iter,1); 
x_normal(1) = x0;

for k = 1:n_iter-1
    x_normal(k+1) = x_normal(k) + alpha * pi_prime(x_normal(k));
end

% Alpha besar (overshoot)
x_big = zeros(n_iter,1); 
x_big(1) = x0;

for k = 1:n_iter-1
    x_big(k+1) = x_big(k) + (10*alpha) * pi_prime(x_big(k));
end

% Alpha kecil (slow)
x_small = zeros(n_iter,1); 
x_small(1) = x0;

for k = 1:n_iter-1
    x_small(k+1) = x_small(k) + (0.1*alpha) * pi_prime(x_small(k));
end

%% --- 3. Solusi Analitik ---
A_quad = -3; B_quad = 120; C_quad = 100;
D = B_quad^2 - 4*A_quad*C_quad;

x1 = (-B_quad + sqrt(D)) / (2*A_quad);
x2 = (-B_quad - sqrt(D)) / (2*A_quad);

% Pilih yang maksimum (pakai uji turunan kedua)
pi_second = @(x) -6*(a+1)*x + 2*(b+5)*K;

if pi_second(x1) < 0
    x_opt_analitik = x1;
else
    x_opt_analitik = x2;
end

fprintf('--- Verifikasi Optimasi ---\n');
fprintf('Akar 1: %.6f\n', x1);
fprintf('Akar 2: %.6f\n', x2);
fprintf('Solusi Analitik (maksimum): %.6f\n', x_opt_analitik);
fprintf('Hasil GD (500 iter): %.6f\n', x_normal(end));
fprintf('Selisih GD vs Analitik: %.6f\n', abs(x_normal(end)-x_opt_analitik));
fprintf('Profit maksimum: Rp %.2f ribu\n', pi_func(x_normal(end)));

%% --- 4. Visualisasi Konvergensi ---
figure('Name','Analisis Sensitivitas Learning Rate');

plot(1:n_iter, pi_func(x_normal),'b','LineWidth',1.5); hold on;
plot(1:n_iter, pi_func(x_big),'r--','LineWidth',1);
plot(1:n_iter, pi_func(x_small),'g-.','LineWidth',1);

title('Konvergensi Profit vs Iterasi');
xlabel('Iterasi (k)');
ylabel('\pi(x_k)');
legend(['\alpha = ',num2str(alpha)], ...
       ['10\alpha = ',num2str(10*alpha)], ...
       ['0.1\alpha = ',num2str(0.1*alpha)], ...
       'Location','southeast');
grid on;

saveas(gcf,'Visualisasi_Soal6_Konvergensi.png');

%% --- 5. Visualisasi Kurva Profit ---
figure('Name','Kurva Profit');

fplot(pi_func,[0 50],'Color',[0.4 0.4 0.4],'LineWidth',1.5); hold on;

% titik awal
plot(x0, pi_func(x0),'ms','MarkerFaceColor','m','DisplayName','Start');

% hasil GD
plot(x_normal(end), pi_func(x_normal(end)),'ro','MarkerSize',10,...
    'DisplayName','Optimum GD');

% solusi analitik
plot(x_opt_analitik, pi_func(x_opt_analitik),'g*','MarkerSize',10,...
    'DisplayName','Optimum Analitik');

title('Kurva Profit dan Titik Optimal');
xlabel('Harga (x) (ribuan Rp)');
ylabel('Profit \pi(x)');
legend('show');
grid on;

saveas(gcf,'Visualisasi_Soal6_Profit.png');

fprintf('\nFigure tersimpan.\n');

%% --- 6. Aplikasi Bisnis ---
harga_optimal = x_normal(end) * 1000;
profit_maks = pi_func(x_normal(end));
biaya = K * 10 * 1000;
margin = harga_optimal - biaya;

fprintf('\n--- Aplikasi Bisnis ---\n');
fprintf('Harga optimal: Rp %.2f\n', harga_optimal);
fprintf('Profit maksimum: Rp %.2f ribu\n', profit_maks);
fprintf('Margin per unit: Rp %.2f\n', margin);