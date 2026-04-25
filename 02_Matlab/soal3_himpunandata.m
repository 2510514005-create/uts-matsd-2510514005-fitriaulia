% ===================================================== 
%  UTS Matematika Sains Data — Semester Genap 2025/2026 
%  Soal 3 — Segmentasi Pelanggan dan Komposisi Fungsi
%  --------------------------------------------------- 
%  Nama  : Fitri Aulia
%  NIM   : 2510514005
%  Parameter: N=5, a=0, b=5, K=6 [cite: 153]
%  Tanggal: 25 April 2026
% ===================================================== 

clc; clear; close all;

%% --- Parameter Personalisasi ---
N = 5; 
a = 0; 
b = 5; 
K = 6;

%% --- BAGIAN A & B: Operasi Himpunan ---
% Definisi Himpunan
U = N:(N+20);
A = [5, 7, 9, 12, 15, 18, 20];
B = [8, 10, 12, 15, 17, 23];
C = [6, 12, 15, 16, 22, 25];

% Operasi Himpunan
A_union_B_union_C = union(A, union(B, C));
A_int_B_int_C     = intersect(A, intersect(B, C));
C_prime           = setdiff(U, C);
A_union_B         = union(A, B);
Final_C_prime     = intersect(A_union_B, C_prime);
A_xor_B           = setxor(A, B);

% Output
fprintf('--- Verifikasi Operasi Himpunan ---\n');
fprintf('|A U B U C|      : %d (Manual: 15)\n', length(A_union_B_union_C));
fprintf('|A ∩ B ∩ C|      : %d (Manual: 2)\n', length(A_int_B_int_C));
fprintf('|(A U B) ∩ C''|  : %d (Manual: 9)\n', length(Final_C_prime));
fprintf('|A ⊕ B|          : %d (Manual: 9)\n', length(A_xor_B));

%% --- BAGIAN C: Komposisi Fungsi ---
syms x y;

f = K*x + (a+b);        % f(x) = 6x + 5
g = (x^2)/(b+1) + a;    % g(x) = x^2 / 6

fog = simplify(subs(f, x, g)); % (f o g)(x)
gof = simplify(subs(g, x, f)); % (g o f)(x)

% Uji numerik di x = 7
x_val = b + 2;
val_fog = double(subs(fog, x, x_val));
val_gof = double(subs(gof, x, x_val));

fprintf('\n--- Komposisi Fungsi ---\n');
fprintf('(f o g)(x) = %s\n', char(fog));
fprintf('(g o f)(x) = %s\n', char(gof));
fprintf('(f o g)(7) = %.2f\n', val_fog);
fprintf('(g o f)(7) = %.2f\n', val_gof);

% Cek komutatif (lebih aman pakai toleransi)
if abs(val_fog - val_gof) < 1e-6
    disp('Hasil: Komutatif');
else
    disp('Hasil: Tidak Komutatif');
end

%% --- BAGIAN D: Invers dan Analisis ---
target_y = (K*100 + a + b); % target = 605

% Invers fungsi
f_inv = solve(y == K*x + (a+b), x);

% Cari x dari target
x_sol = double(solve(f == target_y, x));

fprintf('\n--- Analisis Akuntansi ---\n');
fprintf('Invers f(x) : x = %s\n', char(f_inv));
fprintf('Volume pembelian untuk Rp %d ribu: %.0f unit\n', target_y, x_sol);

%% --- BAGIAN F: Visualisasi ---
figure('Name', 'Analisis Fungsi');

bar_data = [val_fog, val_gof];
bar(bar_data);

set(gca, 'XTickLabel', {'(f o g)(7)', '(g o f)(7)'});
title('Perbandingan Komposisi Fungsi');
ylabel('Nilai Output');
grid on;

% Label angka
text(1:length(bar_data), bar_data, string(bar_data), ...
    'VerticalAlignment','bottom', ...
    'HorizontalAlignment','center');

% Simpan gambar
saveas(gcf, 'Visualisasi_Soal3.png');

fprintf('\nFigure disimpan sebagai: Visualisasi_Soal3.png\n');