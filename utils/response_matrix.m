function S = response_matrix( thetas, element_locations )
L = numel(element_locations);
K = numel(thetas);
S = zeros(L, K);
for i = 1 : numel(thetas)
    theta = thetas(i);
    S(:, i) = response_vector(theta, element_locations);
end
end