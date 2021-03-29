function R = autocorrelation_matrix(response_matrix, source_powers, noise_power)
L = size(response_matrix, 1);
R = response_matrix * diag(source_powers) * response_matrix' + noise_power * eye(L);
end