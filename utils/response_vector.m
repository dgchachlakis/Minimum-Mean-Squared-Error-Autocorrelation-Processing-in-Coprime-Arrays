function s = response_vector( theta, element_locations )
s = exp(-1i * pi* sin(theta) * element_locations);
end