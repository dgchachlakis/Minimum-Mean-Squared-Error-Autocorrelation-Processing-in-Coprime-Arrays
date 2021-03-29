function E = mmse_sampling( H, V, Esel, sample_support)
E = (H + V / sample_support) \ H * Esel;
end

