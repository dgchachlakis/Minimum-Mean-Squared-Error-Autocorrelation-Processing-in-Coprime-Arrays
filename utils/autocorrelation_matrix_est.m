function R = autocorrelation_matrix_est(snapshots)
Q = size(snapshots, 2);
R = snapshots * snapshots' / Q;
end