function [ F ] = smoothing_matrix( coarray_length )
m = 0;
F = [];
A = zeros(coarray_length, coarray_length - m - 1);
B = eye(coarray_length);
C = zeros(coarray_length, m);
F = [F A B C];
for m = 1:coarray_length - 1
    A = zeros(coarray_length, coarray_length - m - 1);
    C = zeros(coarray_length, m);
    F = [F A B C];
end
end

