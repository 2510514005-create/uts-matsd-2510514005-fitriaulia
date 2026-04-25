% =====================================================
%  UTS Matematika Sains Data — Semester Genap 2025/2026
%  Soal 7 — Forecasting Penjualan & Analisis Deret
%  ---------------------------------------------------
%  Nama  : Fitri Aulia
%  NIM   : 2510514005
%  Parameter: a=0, b=5, K=6
%  Tanggal: 25 April 2026
% =====================================================

clc; clear; close all;

%% --- 1. Parameter & Data Historis ---
a = 0; b = 5; K = 6;
n_hist = 1:12;

% Formula: Sn = 50 + 6n + (-1)^n * 1
S_hist = 50 + (K * n_hist) + ((-1).^n_hist) * (a + 1);

%% --- 2. Bagian 7.2: Verifikasi Operasi Sigma ---
T1_matlab = sum(S_hist);
T2_matlab = sum(S_hist.^2);

fprintf('--- 7.2 Verifikasi Operasi Sigma ---\n');
fprintf('T1 (Total Penjualan 12 Bulan): %.0f (Manual: 1068)\n', T1_matlab);
fprintf('T2 (Sum of Squares)          : %.0f (Manual: 96252)\n', T2_matlab);

%% --- 3. Bagian 7.3: Deret Geometri & Pertumbuhan ---
G1 = K;           % G1 = 6
r = 1 + (a/100);  % r = 1 (Karena a=0)

% Jika r=1, rumus deret geometri menjadi Sn = n * G1
n_target = 10;
S10_geometri = n_target * G1; 

% Mencari n minimum agar akumulasi > 500
% Karena r=1 (statis), maka 500 = n * 6 -> n = 500/6
n_min_500 = ceil(500 / G1);

fprintf('\n--- 7.3 Deret Geometri (Loyalty) ---\n');
fprintf('Akumulasi Pelanggan Bulan ke-10: %d\n', S10_geometri);
fprintf('Bulan minimum untuk > 500 pelanggan: %d bulan\n', n_min_500);

%% --- 4. Bagian 7.4: Forecasting & Garis Tren ---
% a) Regresi Linear (polyfit)
p = polyfit(n_hist, S_hist, 1); % p(1)=slope, p(2)=intercept
slope = p(1);
intercept = p(2);

% b) Prediksi 6 Bulan ke Depan (n=13 sampai 18)
n_pred = 13:18;
S_pred = polyval(p, n_pred);

% c) Hitung MAE (Mean Absolute Error)
S_fit = polyval(p, n_hist);
MAE = mean(abs(S_hist - S_fit));

fprintf('\n--- 7.4 Forecasting Linear ---\n');
fprintf('Slope (Tren per bulan): %.4f\n', slope);
fprintf('Intercept             : %.4f\n', intercept);
fprintf('MAE (Mean Absolute Error): %.4f\n', MAE);

%% --- 5. Visualisasi & Penyimpanan Figure ---
figure('Name', 'Forecasting Penjualan 18 Bulan');
hold on;

% Plot Data Historis (Biru, Titik)
plot(n_hist, S_hist, 'bo', 'MarkerFaceColor', 'b', 'DisplayName', 'Data Historis');

% Plot Garis Tren (Merah Putus-putus)
plot(n_hist, S_fit, 'r--', 'LineWidth', 1.5, 'DisplayName', 'Garis Tren Linear');

% Plot Prediksi 6 Bulan ke Depan (Hijau, Segitiga)
plot(n_pred, S_pred, 'g^', 'MarkerFaceColor', 'g', 'DisplayName', 'Prediksi 6 Bulan');

% Pengaturan Grafik
grid on;
title(['Forecasting Penjualan dengan K=', num2str(K)]);
xlabel('Bulan (n)');
ylabel('Penjualan (Juta Rp)');
legend('Location', 'northwest');

% Menghilangkan toolbar dari gambar yang disimpan
ax = gca;
ax.Toolbar.Visible = 'off';

% Simpan Figure
saveas(gcf, 'Visualisasi_Soal7_Forecasting.png');
fprintf('\nFigure visualisasi telah disimpan sebagai: Visualisasi_Soal7_Forecasting.png\n');