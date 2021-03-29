function p = ca_element_locations( M, N )
L = array_length(M, N);
p = zeros(L, 1);
for i = 1 : N
    p(i) = (i - 1) * M;
end
for i = 1 : 2 * M - 1
    p(N + i) = i * N;
end
p = sort(p, 'ascend');
end

