function p = weibull(par,tS)
  p = exp(-(tS(:,1)*par(1)).^par(2));
end
