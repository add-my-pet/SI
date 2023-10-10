function rB = LirB(par, Li_rB)
 
  r0 = par(1); L0 = par(2); L=10.^Li_rB(:,1);
  rB = log10(r0./(1 + L/L0));
end
