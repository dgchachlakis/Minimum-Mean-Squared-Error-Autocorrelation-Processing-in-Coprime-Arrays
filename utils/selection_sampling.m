function E = selection_sampling(Js, array_length, coarray_length)
I = eye(array_length * array_length);
E = zeros(array_length * array_length, 2 * coarray_length - 1);
for n = - coarray_length + 1 : coarray_length - 1
    J = Js(n);
    cnt = 0;
    for e = J
        E(:, n + coarray_length) = E(:, n + coarray_length) + I(:, e);
        cnt = cnt + 1;
        break
    end
    E(:, n + coarray_length) = E(:, n + coarray_length) / cnt;
end
end