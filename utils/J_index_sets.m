function dict = J_index_sets(pw_dist)
dict = containers.Map('keyType', 'double', 'ValueType', 'any');
for i = 1:numel(pw_dist)
    n =  pw_dist(i);
    if isKey(dict, n)
        vv = values(dict,{n});
        dict(n) = [vv{1}  i];
    else
        dict(n) = i;
    end
end
end