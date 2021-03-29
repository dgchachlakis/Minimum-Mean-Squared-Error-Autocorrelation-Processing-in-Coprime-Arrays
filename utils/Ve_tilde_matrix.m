function Ve = Ve_tilde_matrix(M, N, integrals_map, d, sigma)
L = array_length(M, N);
K = numel(d);
p = ca_element_locations(M, N);
pd = kron(p, ones(L, 1));
pdd = kron(ones(L, 1), p);
Omd = pd * ones(1,L * L) - ones(L * L, 1) * pd';
Omdd = pdd * ones(1, L* L) - ones(L * L, 1) * pdd';
u = [1 : K + L]';
x = kron(ones(K + L, 1), u);
y = kron(u, ones(K + L, 1));
Ve=zeros(L * L, L * L);
for i = 1:L * L
    for m = 1:L * L
        for j = 1:(K+L)^2
            if x(j) <= K && y(j) <= K
                if x(j) == y(j)
                    arg = Omdd(m,i) + Omd(i,m);
                    a = integrals_map(arg);
                    Ve(i,m) = Ve(i,m) + d(y(j)) * d(x(j)) * a;
                else
                    arg = Omdd(m,i);
                    a = integrals_map(arg);
                    arg = Omd(i,m);
                    b = integrals_map(arg);
                    Ve(i,m) = Ve(i,m) + d(y(j)) * d(x(j)) * a * b;
                end
            elseif x(j) == (mod(i-1,L)+K+1) && x(j)==(mod(m-1,L)+K+1) && y(j)==(floor((i-1)/L)+K+1) && y(j)==(floor((m-1)/L)+K+1)
                Ve(i,m) = Ve(i,m) + sigma^2;
            elseif x(j) == (mod(i-1,L)+K+1) && x(j)==(mod(m-1,L)+K+1)  && y(j)<=K
                arg = Omdd(m,i);
                a = integrals_map(arg);
                Ve(i,m) = Ve(i,m) + sigma * d(y(j)) * a;
            elseif y(j) == (floor((i-1)/L)+K+1) && y(j)==(floor((m-1)/L)+K+1) && x(j)<=K
                arg = Omd(i,m);
                a = integrals_map(arg);
                Ve(i,m) = Ve(i,m) + sigma * d(x(j)) * a;
            else
                Ve(i,m) = Ve(i,m) + 0;
            end
        end
    end
end
end