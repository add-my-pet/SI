function t = W2t(W,f,p)
  rB = p.kM/3/(1+f/p.g);
  L = (W/(1+f*p.ome)).^(1/3);
  Li= f*p.Lm;
  Lb = p.Lm*get_lb([p.g, p.k, p.vHb],f);
  t = log((Li-Lb)./(Li-L))/rB;
end 