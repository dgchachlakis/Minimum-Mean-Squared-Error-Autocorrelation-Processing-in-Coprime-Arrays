function [ Y ] = snapshots( response_matrix, source_powers, noise_power, number_of_snapshots )
L = size(response_matrix, 1);
K = size(response_matrix, 2);
symbols = diag(sqrt(source_powers)) * (randn(K, number_of_snapshots) + 1i * randn(K, number_of_snapshots)) / sqrt(2);
awgn = sqrt(noise_power) * (randn(L, number_of_snapshots) + 1i * randn(L, number_of_snapshots)) / sqrt(2);
Y = response_matrix * symbols + awgn;
end