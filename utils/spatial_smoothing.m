function [ Z ] = spatial_smoothing( smoothing_matrix, autocorrelations )
L = size(smoothing_matrix, 1);
Z = smoothing_matrix * kron(eye(L), autocorrelations);
end

