function W = t2W(t,f,p)
  rB = p.kM/3/(1+f/p.g);
  Li= f*p.Lm;
  Lb = p.Lm*get_lb([p.g, p.k, p.vHb],f);
  L = Li-(Li-Lb)*exp(-rb*t);
  W= L.^3*(1+p.ome);
end 