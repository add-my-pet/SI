function [L_f, L_m] = vBert(par,tL_f,tL_m)
  L_b = par(1); L_i = par(2); L_im  = par(3); g = par(4); k_M = par(5);
  g_m = g*L_i/L_im;
  r_B = k_M/ 3/ (1 + 1/g); r_Bm = k_M/ 3/ (1 + 1/g_m); 
  L_f = L_i - (L_i - L_b) * exp(-r_B * tL_f(:,1));
  L_m = L_im - (L_im - L_b) * exp(-r_Bm * tL_m(:,1));
end
