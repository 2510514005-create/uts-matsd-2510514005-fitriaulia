% ===================================================== 
%  UTS Matematika Sains Data — Semester Genap 2025/2026 
%  Soal  —  1: Analisis Penjualan Harian 7 Toko
%  --------------------------------------------------- 
%  Nama  : Fitri Aulia
%  NIM   : 2510514005
%  Parameter: N=5, a=0, b=5, K=6, theta0=50, alpha=0.01
%  Tanggal: 25 April 2026
% ===================================================== 

clc; clear; close all;

% --- 1. Parameter Personalisasi ---
a = 0;  
b = 5;  
K = 6;
N = 5; 
theta0 = 50; 
alpha_lr = 0.01;

% --- 2. Data Toko (D_i) ---
i = 1:7;
D = 20 + (K .* i) + mod(a .* i, 7) - mod(b .* i, 5);

% --- 3. Statistik Deskriptif ---
rata_rata    = mean(D);
nilai_tengah = median(D);
jangkauan    = range(D);
stdev_pop    = std(D, 1); 

% Modus
[m, freq] = mode(D);
if freq == 1
    nilai_modus = 0;
else
    nilai_modus = m;
end

% --- Output Command Window ---
fprintf('--- Verifikasi Statistik Deskriptif (Soal 1) ---\n');
fprintf('Data Penjualan (D1-D7): [%s]\n', num2str(D));
fprintf('Mean           : %.2f\n', rata_rata);
fprintf('Median         : %.2f\n', nilai_tengah);
fprintf('Modus          : %.2f\n', nilai_modus);
fprintf('Range          : %.2f\n', jangkauan);
fprintf('Std. Deviasi   : %.2f\n\n', stdev_pop);
fprintf('Timestamp: %s\n', datestr(now));

% --- 4. Visualisasi ---
figure('Name', 'Analisis Penjualan Toko - Fitri Aulia');

toko_labels = {'Toko 1','Toko 2','Toko 3','Toko 4','Toko 5','Toko 6','Toko 7'};

% Diagram batang (aman semua versi)
b_plot = bar(D);
set(b_plot, 'FaceColor', [0.2 0.6 0.8]);
hold on;

% Garis rata-rata (pengganti yline agar tidak error)
x_limits = xlim;
plot(x_limits, [rata_rata rata_rata], 'r--', 'LineWidth', 2);

% Label garis rata-rata
text(7, rata_rata, ' Rata-rata', 'Color','r');

% Format grafik
title('Penjualan Per Toko - NIM: 2510514005');
xlabel('Nama Toko');
ylabel('Penjualan (Juta Rupiah)');
set(gca, 'XTick', 1:7, 'XTickLabel', toko_labels);
grid on;

% Identitas
text(1, max(D)*0.95, 'Fitri Aulia / 2510514005', ...
    'FontSize', 9, 'FontWeight', 'bold');

% Simpan gambar
saveas(gcf, 'Hasil_Soal1_FitriAulia.png');

fprintf('Status: Grafik telah disimpan sebagai Hasil_Soal1_FitriAulia.png\n');