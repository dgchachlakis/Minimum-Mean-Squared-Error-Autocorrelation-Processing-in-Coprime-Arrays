function dict = integrals_map(element_locations, distribution, low_lim, high_lim, mu, d_var )
L = numel(element_locations);
pd = kron(element_locations, ones(L, 1));
pdd = kron(ones(L, 1), element_locations);
set1 = pd-pdd;
tmp1 = pdist(set1, @(x, y) x - y);
tmp2 = pdist(set1, @(x, y) y - x);
set2 = unique([tmp1(:); tmp2(:)]);
set3 = pd * ones(1, L * L) - ones(L * L, 1) * pd';
set4 = pdd * ones(1,L * L) - ones(L * L, 1) * pdd';
set5 = [];
for i = 1 : L * L
    for j = 1 : L * L
        arg = set3(j, i) + set4(i, j);
        set5 = [set5 arg];
    end
end
allsets = unique([set1(:); set2(:); set3(:); set4(:); set5(:)]);
dict = containers.Map('keyType', 'double', 'ValueType', 'any');
for i = 1: numel(allsets)
    key = allsets(i);
    I = myIntegral(key, distribution, low_lim, high_lim, mu, d_var);
    dict(key) = I;
end
end

