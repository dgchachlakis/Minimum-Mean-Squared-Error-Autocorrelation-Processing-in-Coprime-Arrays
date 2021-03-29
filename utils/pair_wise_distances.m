function pwd = pair_wise_distances( loc )
N = size(loc, 1);
o = ones(N, 1);
v = loc * o';
u = o * loc';
pwd = v(:) - u(:);
end