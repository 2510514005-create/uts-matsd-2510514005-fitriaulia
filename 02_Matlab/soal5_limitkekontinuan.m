% =====================================================
%  UTS Matematika Sains Data — Semester Genap 2025/2026
%  Soal 5 — Konvergensi CLV dan Kekontinuan Biaya
%  ---------------------------------------------------
%  Nama  : Fitri Aulia
%  NIM   : 2510514005
%  Parameter: a=0, b=5, K=6
%  Tanggal: 25 April 2026
% =====================================================

clc; clear; close all;

%% --- 1. Parameter Personalisasi ---
a = 0; b = 5; K = 6;

%% --- 5.1 & 5.2 Analisis Limit (Aljabar & Trigonometri) ---
syms x n;

% L1: Limit Pemfaktoran
L1_sym = limit((x^2 - K^2) / (x - K), x, K); % Hasil manual: 12

% L2: Limit Rasionalisasi Akar
L2_sym = limit((sqrt(x + (K+1)^2) - (K+1)) / x, x, 0); % Hasil manual: 1/14

% L3: Limit Tak Hingga (Derajat Polinomial Sama)
L3_sym = limit(((a+2)*x^3 + b*x + 7) / (x^3 - x + K), x, inf); % Hasil manual: 2

% L4: Limit Trigonometri (Model Seasonal)
% Formula: sin((a+1)x) * tan((b+2)x) / x^2
L4_sym = limit((sin((a+1)*x) * tan((b+2)*x)) / x^2, x, 0); % Hasil manual: 7

fprintf('--- 5.1 & 5.2 Verifikasi Limit ---\n');
fprintf('L1 (x->K)   : %d\n', double(L1_sym));
fprintf('L2 (x->0)   : %.4f (1/14)\n', double(L2_sym));
fprintf('L3 (x->inf) : %d\n', double(L3_sym));
fprintf('L4 (x->0)   : %d\n', double(L4_sym));

%% --- 5.3 Limit Tak Hingga & Konvergensi CLV ---
% d) Pendapatan Stabil Jangka Panjang (Steady-state)
R_n = (100*n + K) / (n + (a+b+1));
CLV_steady = limit(R_n, n, inf);

% e) Selisih Dua Model CLV
L_root = limit(sqrt(n^2 + K*n) - sqrt(n^2 + b*n), n, inf); % Hasil manual: 0.5

fprintf('\n--- 5.3 Analisis CLV ---\n');
fprintf('Pendapatan Stabil (Steady-state): Rp %d ribu/bulan\n', double(CLV_steady));
fprintf('Limit Selisih Model Akar: %.2f\n', double(L_root));

%% --- 5.4 Kekontinuan Fungsi Biaya Piecewise ---
% Berdasarkan syarat kontinu: Limit Kiri = Limit Kanan = f(K)
% Syarat p: p = L1 = 12
% Syarat q: a*K + q = 12 -> 0*6 + q = 12 -> q = 12
p = double(L1_sym); 
q = p - (a * K); 

fprintf('\n--- 5.4 Parameter Kekontinuan ---\n');
fprintf('Nilai p agar kontinu: %d\n', p);
fprintf('Nilai q agar kontinu: %d\n', q);

%% --- Visualisasi Fungsi Biaya C(x) ---
figure('Name', 'Analisis Kekontinuan Fungsi Biaya');
hold on;

% Bagian 1: x < K
fplot(@(x) (x.^2 - K^2)./(x - K), [0 K-0.01], 'b', 'LineWidth', 2);

% Bagian 2: Titik Sambungan x = K
plot(K, p, 'ro', 'MarkerFaceColor', 'r', 'DisplayName', 'Titik Kontinu (K,p)');

% Bagian 3: x > K
fplot(@(x) a*x + q, [K+0.01 2*K], 'g', 'LineWidth', 2);

% Garis Vertikal Penanda Sambungan
line([K K], [0 p+5], 'Color', [0.5 0.5 0.5], 'LineStyle', '--');

grid on;
title(['Fungsi Biaya C(x) Kontinu di x = ', num2str(K)]);
xlabel('Volume Produksi (x)');
ylabel('Biaya Distribusi per Unit');
legend('x < K (Aljabar)', 'Titik Sambung (p)', 'x > K (Linear)', 'Location', 'best');

% Simpan Figure
saveas(gcf, 'Visualisasi_Soal5_Kontinu.png');
fprintf('\nFigure visualisasi telah disimpan sebagai: Visualisasi_Soal5_Kontinu.png\n');