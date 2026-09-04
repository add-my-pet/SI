function t = L2t(L,f,p)
  rB = p.kM/3/(1+f/p.g);
  Li = f*p.Lm;
  Lb = p.Lm*get_lb([p.g, p.k, p.vHb],f);
  t = log((Li-Lb)./(Li-L))/rB;
end 