function norm = pyr(f,p)
  fn = @(t,f,p) surv_pyr(t,f,p) .* reprod_rate_t(t,f,p);
  norm = 1 - integral(@(t)fn(t,f,p),0,Inf); % characteristic eqn for r_N=0
end

function S = surv_pyr(t,f,p)
  rB = p.kM/3/(1+f/p.g); lb = get_lb([p.g, p.k, p.vHb],f); l = f-(f-lb)*exp(-rB*t);
  S = exp(-p.hp*t-2*rB*(f./l-1).*t-(p.hW*t).^3);
end
