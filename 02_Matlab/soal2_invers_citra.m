% ===================================================== 
%  UTS Matematika Sains Data — Semester Genap 2025/2026 
%  Soal 2 — Enkripsi Citra Logo Toko
%  --------------------------------------------------- 
%  Nama  : Fitri Aulia
%  NIM   : 2510514005
%  Parameter: N=5, a=0, b=5
%  Tanggal: 25 April 2026
% ===================================================== 

clc; clear; close all;

%% 1. Definisi Parameter dan Matriks Kunci A
N = 5; a = 0; b = 5;

% Matriks Kunci A sesuai formula [cite: 43]
% Row 1: [a+1, b, 2] -> [1, 5, 2]
% Row 2: [1, a+2, b] -> [1, 2, 5]
% Row 3: [b, 1, a+3] -> [5, 1, 3]
A = [a+1, b, 2; 
     1, a+2, b; 
     b, 1, a+3];

% Hitung Determinan Manual vs MATLAB
det_manual = 93; % Berdasarkan hasil perhitungan manual [cite: 36]
det_matlab = det(A);

fprintf('Determinan A (Manual): %d\n', det_manual);
fprintf('Determinan A (MATLAB): %.2f\n', det_matlab);

%% 2. Perhitungan Matriks Invers Manual (Metode Adjoin)
% Matriks Kofaktor C berdasarkan hasil manual [cite: 79, 81, 83]
C = [ 1,  22, -9; 
    -13,  -7,  24; 
     21,  -3,  -3];

% Matriks Adjoin (Transpose dari Kofaktor) [cite: 94]
adj_A = C'; 

% Matriks Invers Manual [cite: 111]
A_inv_manual = (1/det_manual) * adj_A;

%% 3. Verifikasi Error Frobenius (Soal d)
A_inv_matlab = inv(A);
error_fro = norm(A_inv_manual - A_inv_matlab, 'fro');

fprintf('\n--- Verifikasi Invers ---\n');
fprintf('Norm Error Frobenius: %.1e\n', error_fro);

if error_fro < 1e-10
    disp('Status: VERIFIKASI BERHASIL (Error < 1e-10)');
else
    disp('Status: VERIFIKASI GAGAL');
end

%% 4. Studi Kasus Citra (Soal e)
% Blok Piksel Asli P [cite: 65]
P = [120, 55, 200;
      80,  2,  15;
      35, 90, 170];

% Proses Enkripsi E = A * P [cite: 67, 115]
E = A * P;

% Proses Deskripsi P_prime = A_inv * E [cite: 118]
P_prime = A_inv_manual * E;

fprintf('\n--- Hasil Enkripsi (Matriks E) ---\n');
disp(E);

fprintf('--- Hasil Deskripsi (Matriks P'') ---\n');
disp(P_prime);

%% 5. Visualisasi MATLAB (Soal f)
figure('Name', 'Visualisasi Enkripsi Citra Logo');

% Tampilkan Citra Asli
subplot(1,2,1);
imshow(uint8(P)); % Menggunakan uint8 untuk visualisasi grayscale standar
title('Blok Piksel Asli (P)');
axis on;

% Tampilkan Citra Terenkripsi
subplot(1,2,2);
imshow(uint8(E)); 
title('Blok Terenkripsi (E)');
axis on;

sgtitle('Perbandingan Citra Asli vs Terenkripsi');

% Diskusi Singkat:
% Jika det(A) = 0, matriks bersifat singular sehingga tidak memiliki invers.
% Hal ini menyebabkan proses deskripsi tidak mungkin dilakukan secara matematis,
% dan data citra akan rusak secara permanen[cite: 128, 146].

%% 6. Penyimpanan Figure (Tambahan)
% Menentukan nama file berdasarkan parameter
filename = sprintf('Hasil_Enkripsi_N%d_a%d_b%d.png', N, a, b);

% Opsi 1: Menggunakan saveas (Sederhana)
saveas(gcf, filename); 

% Opsi 2: Menggunakan exportgraphics (Hasil lebih tajam/High Res)
% exportgraphics(gcf, filename, 'Resolution', 300);

fprintf('\nFigure telah disimpan dengan nama file: %s\n', filename);