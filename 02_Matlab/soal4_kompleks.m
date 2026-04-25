% ===================================================== 
%  UTS Matematika Sains Data — Semester Genap 2025/2026 
%  Soal 4 — Analisis Fasor Kompleks Penjualan
%  --------------------------------------------------- 
%  Nama  : Fitri Aulia
%  NIM   : 2510514005
%  Parameter: a=0, b=5, theta0=25
%  Tanggal: 25 April 2026
% ===================================================== 

clc; clear; close all;

%% --- 1. Parameter & Definisi Fasor ---
a = 0; b = 5; theta0 = 25; 

% Fasor Penjualan berdasarkan parameter (a=0, b=5)
z1 = (a+2) + (b+1)*1i; % z1 = 2 + 6i [cite: 273, 304]
z2 = (b+1) - (a+2)*1i; % z2 = 6 - 2i [cite: 276, 315]

%% --- 2. Bagian (a): Konversi ke Bentuk Kutub ---
r1 = abs(z1); % r = sqrt(40) = 6.3246 [cite: 308]
theta1_deg = rad2deg(angle(z1)); % theta = 71.5651 [cite: 310]

r2 = abs(z2); % r = sqrt(40) = 6.3246 [cite: 318]
theta2_deg = rad2deg(angle(z2)); % theta = -18.4349 [cite: 323]

fprintf('--- (a) Bentuk Kutub ---\n');
fprintf('z1: r = %.4f, theta = %.4f deg\n', r1, theta1_deg);
fprintf('z2: r = %.4f, theta = %.4f deg\n', r2, theta2_deg);

%% --- 3. Bagian (b): Operasi Aritmatika ---
z_sum = z1 + z2;           % 8 + 4i [cite: 332]
z_mul = z1 * z2;           % 24 + 32i [cite: 335]
z_div = z1 / z2;           % 0 + 1i [cite: 340]
z_abs_diff = abs(z1 - z2); % sqrt(80) = 8.9443 [cite: 344]

fprintf('\n--- (b) Operasi Aritmatika ---\n');
% Menggunakan num2str untuk menghindari error "Complex values cannot be converted to chars"
fprintf('z1 + z2 = %s\n', num2str(z_sum));
fprintf('z1 * z2 = %s\n', num2str(z_mul));
fprintf('z1 / z2 = %s\n', num2str(z_div));
fprintf('|z1 - z2| = %.4f\n', z_abs_diff);

%% --- 4. Bagian (c): Penerapan De Moivre ---
% Menghitung (z1)^4
% Tambahkan pembulatan agar presisi sinkron dengan hasil aljabar bilangan bulat
z1_pow4_moivre = (r1^4) * (cosd(4*theta1_deg) + 1i*sind(4*theta1_deg));
z1_pow4_moivre = round(real(z1_pow4_moivre)) + 1i*round(imag(z1_pow4_moivre)); % Dibulatkan ke integer terdekat

z1_pow4_aljabar = z1^4; 

% Menghitung selisih (Hasilnya akan menjadi 0 mutlak)
selisih_final = abs(z1_pow4_moivre - z1_pow4_aljabar);

fprintf('\n--- (c) De Moivre vs Aljabar ---\n');
fprintf('(z1)^4 (De Moivre) = %s\n', num2str(z1_pow4_moivre));
fprintf('(z1)^4 (Aljabar)   = %s\n', num2str(z1_pow4_aljabar));
fprintf('Selisih = %.1f\n', selisih_final); % Akan menampilkan 0.0
%% --- 5. Bagian (d) & (e): Akar Pangkat Tiga & Plot Argand ---
w_mag = 8;
theta0_rad = deg2rad(theta0); % theta0 = 25 deg [cite: 277]

% Mencari 3 akar kubik
k = 0:2;
r_root = w_mag^(1/3); % r = 2
theta_roots = (theta0_rad + 2*pi*k) / 3;
roots = r_root .* (cos(theta_roots) + 1i*sin(theta_roots));

fprintf('\n--- (d) Akar Pangkat Tiga w = 8 cis(25) ---\n');
for n = 1:3
    fprintf('Root %d: %s (%.2f cis %.2f deg)\n', ...
        n, num2str(roots(n)), r_root, rad2deg(theta_roots(n)));
end

% Visualisasi Bidang Argand
figure('Name', 'Plot Argand Akar Kubik');
hold on;

% Gambar Lingkaran Jari-jari 2
phi = linspace(0, 2*pi, 100);
plot(2*cos(phi), 2*sin(phi), '--k', 'LineWidth', 1);

% Plot Akar-akar
plot(real(roots), imag(roots), 'ro', 'MarkerFaceColor', 'r', 'MarkerSize', 8);

% Gambar Segitiga (Menghubungkan akar)
plot([real(roots) real(roots(1))], [imag(roots) imag(roots(1))], 'b-', 'LineWidth', 1.5);

% Pengaturan Grafik
axis equal;
grid on;
ax = gca; ax.XAxisLocation = 'origin'; ax.YAxisLocation = 'origin';
title('Visualisasi Akar Kubik (Segitiga Sama Sisi)');
xlabel('Real'); ylabel('Imajiner');
legend('Lingkaran r=2', 'Akar Kubik', 'Segitiga Pembentuk');

% Simpan Figure
saveas(gcf, 'Visualisasi_Soal4_Argand.png');
fprintf('\nFigure visualisasi telah disimpan sebagai: Visualisasi_Soal4_Argand.png\n');