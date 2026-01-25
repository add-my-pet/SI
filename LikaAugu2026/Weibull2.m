function f = Weibull2(p, S_pM)

  % unpack p
  lambda_relax = p(1); lambda_hurry = p(2); k_relax = p(3); k_hurry = p(4); p_relax = p(5);

  p_M = 10.^S_pM(:,1); % undo log10-transform
  f = p_relax.*exp(-(p_M/lambda_relax).^k_relax)+(1-p_relax).*exp(-(p_M/lambda_hurry).^k_hurry);
end
