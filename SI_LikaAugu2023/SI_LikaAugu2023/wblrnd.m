function r = wblrnd(lambda,k,r,c)

if ~exist('r','var')
  r = 1;
end
if ~exist('c','var')
  c = 1;
end

% Generate uniform random values, and apply the Weibull inverse CDF.
r = 1/lambda .* (-log(rand(r,c))) .^ (1/k); 
