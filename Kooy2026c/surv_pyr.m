function S = surv_pyr(t,f,p)
  % survivor function of a level in the trophic pyramid
  rB = p.kM/3/(1+f/p.g); lb = get_lb([p.g, p.k, p.vHb],f); l = f-(f-lb)*exp(-rB*t);
  S = exp(-p.hp*t-2*rB*(f./l-1).*t-(p.hW*t).^3);
end
