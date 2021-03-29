clear all
close all
clc
%%
addpath utils
% Coprime array with coprime naturals M, N
M = 2;
N = 3;
L = array_length(M, N);
Lco = coarray_length(M, N);
p = ca_element_locations(M, N);
% Number of signal emitting sources --should be less than coarray's length
K = 7;
% Powers in linear scale
source_powers = rand(K, 1) * 10;
noise_power = 1;
% Standard autocorrelation sampling matrices
dict = J_index_sets(pair_wise_distances(p));
Es = selection_sampling(dict, L, Lco);
Ea = averaging_sampling(dict, L, Lco);
% Matrices required for forming Emmse
distribution = 'truncated_normal'; % this can be either 'uniform' or 'truncated_normal'
low_lim = - pi / 12;
high_lim = pi / 3;
mu = 0; % mean of truncated normal - meaningful only when distribution = 'truncated_normal'
d_var = 1.5; % variance of truncated normal - meaningful only when distribution = 'truncated_normal'
integrals = integrals_map(p, distribution, low_lim, high_lim, mu, d_var);
He = He_matrix(M, N, integrals, source_powers, noise_power);
Ve_tilde = Ve_tilde_matrix(M, N, integrals, source_powers, noise_power);
% Smoothing matrix F
F = smoothing_matrix(Lco);
% Sample support axis and number of realizations
number_of_snapshots_axis = [1, 10, 100, 1000, 10000];
number_of_realizations = 350;
% Zero - padding
err_s = zeros(numel(number_of_snapshots_axis), number_of_realizations);
err_a = zeros(numel(number_of_snapshots_axis), number_of_realizations);
err_m = zeros(numel(number_of_snapshots_axis), number_of_realizations);
for real = 1 : number_of_realizations
    thetas = thetas_gen(K, distribution, low_lim, high_lim, mu, d_var);
    S = response_matrix(thetas, p);
    R = autocorrelation_matrix(S, source_powers, noise_power);
    Z = spatial_smoothing(F, Es' * R(:));
    for i = 1 : numel(number_of_snapshots_axis)
        Q = number_of_snapshots_axis(i);
        Emmse = mmse_sampling(He, Ve_tilde, Es, Q);
        Y = snapshots(S, source_powers, noise_power, Q);
        Rest = autocorrelation_matrix_est(Y);
        r = Rest(:);
        Zs = spatial_smoothing(F, Es' * r);
        Za = spatial_smoothing(F, Ea' * r);
        Zm = spatial_smoothing(F, Emmse.' * r);
        err_s(i, real) = norm(Z - Zs, 'fro')^2;
        err_a(i, real) = norm(Z - Za, 'fro')^2;
        err_m(i, real) = norm(Z - Zm, 'fro')^2;
    end
end
err_sel = mean(err_s, 2);
err_avg = mean(err_a, 2);
err_mmse = mean(err_m, 2);
figure,
loglog(number_of_snapshots_axis, err_sel,'-.b'); hold on
loglog(number_of_snapshots_axis, err_avg,'--r');
loglog(number_of_snapshots_axis, err_mmse,'-k');
grid on
legend('Selection', 'Averaging', 'MMSE (proposed)')
xlabel('Sample support')
ylabel('Squared estimation error')