function He = He_matrix(M, N, integrals_map, d, sigma)
L = array_length(M, N);
K = numel(d);
p = ca_element_locations(M, N);
pd = kron(p, ones(L, 1));
pdd = kron(ones(L, 1), p);
omega = pd - pdd;
He = zeros(L * L, L * L);
for i = 1 : L * L
    mcol = zeros(L * L,1);
    for m = 1 : L * L
        arg = omega(i) - omega(m);
        t1 = norm(d,'fro')^2 * integrals_map(arg);
        t2 = sigma^2 * (omega(i)==0) * (omega(m)==0);
        vi = integrals_map(omega(i));
        vm = integrals_map(-omega(m));
        t3 = vi * vm * ((ones(K,1)'*d)^2 - norm(d,'fro')^2);
        t4 = sigma * ones(K,1)' * d * ((omega(i) == 0) * vm + vi * (-omega(m) == 0));
        mcol(m) = t1 + t2 + t3 + t4;
    end
    He(i,:)=mcol.';
end
end

