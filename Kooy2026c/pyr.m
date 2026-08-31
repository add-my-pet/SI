function norm = pyr(f,p)
  fn = @(t,f,p) surv_pyr(t,f,p) .* reprod_rate_t(t,f,p);
  norm = 1 - integral(@(t)fn(t,f,p),0,Inf); % characteristic eqn for r_N=0
end
