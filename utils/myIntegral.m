function v = myIntegral( arg, distribution, low_lim, high_lim, mu, d_var)
if strcmp('truncated_normal', distribution)
    sd = sqrt(d_var); % standard deviation
    con1 = 1 / (sqrt(2 * pi));
    con2 = 0.5 * (1 + erf((high_lim - mu) / sd / sqrt(2)));
    con3 = 0.5 * (1 + erf((low_lim - mu) / sd / sqrt(2)));
    con4 = con2 - con3;
    fun = @(x)  1 / sd / con4 * (con1 * exp(-0.5 * ((x - mu) / sd) .^ 2 - 1i * pi * arg * sin(x)));
elseif strcmp('uniform', distribution)
    fun = @(x)  (1 / (high_lim-low_lim)) * exp(-1i * pi * arg * sin(x));
else
    error('Only ''uniform'' and ''truncated_normal'' distributions have been implemented.');
end
v = integral(fun, low_lim, high_lim, 'AbsTol', 1e-6);
end