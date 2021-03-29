function thetas = thetas_gen( K, distribution, low_lim, high_lim, mu, d_var )
if strcmp(distribution, 'uniform')
    thetas  = low_lim + rand(1, K) * (high_lim - low_lim);
elseif strcmp(distribution, 'truncated_normal')
    i = ones(K, 1);
    tmp = trandn((i  * low_lim - mu) / sqrt(d_var), (i  * high_lim - mu) / sqrt(d_var));
    thetas = mu + sqrt(d_var) * tmp;
else
    error('Only ''uniform'' and ''truncated_normal'' distributions have been implemented.');
end
end

