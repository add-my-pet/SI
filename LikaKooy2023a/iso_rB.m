function iso_rB
  % iso-rB lines given
  % T = T_ref, f = 1
  % L_i = L_ref = kap {p_Am}/ [p_M] = 1 cm 
  E_G = 5260; % J/cm^3, spec cost for structure, typical value in AmP
  r_B = [.001 .005 .01 .02 .03 .04 .05]; % 1/d, von Bert growth rate
  n = length(r_B); color = color_lava((0:n-1)/n);
  v = linspace(1e-20,.2,1e3); % cm/d, energy conductance
  
  close all
  figure(1)
  hold on
  L_m = 1; % cm, max struc length
  for i=1:n
    p_M = 3 * r_B(i) * E_G ./ (1 - 3 * r_B(i) * L_m ./v);
    sel = p_M > 0;
    plot(p_M(sel), v(sel), '-', 'color',color(i,:), 'linewidth',2)
  end
  xlabel('spec som maint [p_M], J/d.cm^3')
  ylabel('energy conductance v, cm/d')
  xlim([0 1e4])
  ylim([0 0.2])
  text(9000,0.19, 'r_B, 1/d')
  text( 200,0.01, '0.001','color', color(1,:))
  text( 700,0.025,'0.005','color', color(2,:))
  text(1200,0.045,'0.01', 'color', color(3,:))
  text(2000,0.08, '0.02', 'color', color(4,:))
  text(3000,0.115,'0.03', 'color', color(5,:))
  text(4000,0.15, '0.04', 'color', color(6,:))
  text(5000,0.185, '0.05', 'color', color(7,:))
  set(gca, 'FontSize', 15, 'Box', 'on')
  %title(['T=T_{ref}; f=1; L_m=',num2str(L_m),' cm; [E_G]=5.26 kJ/cm^3'], 'FontWeight','normal', 'FontSize',9)
  saveas (gca, 'pM_v_Li.png')
  
  % k_M = p_M/ E_G; g = k_M * v/ L_m; 
  % v_Hb = E_Hb/ (E_G * L_m^3 * kap * (1 - kap))
  % a_b = get_tb([g k v_Hb], 1)/ k_M
  
  figure(2)
  % iso-rB lines given W_m; T = T_ref, f = 1
  hold on
  W_m = 1; % g, max weight
  E_E = 35e3; % J/cm^3, E_E = mu_E*d_Ed/ w_Ed with w_Ed = 23.9 g/mol
  kap = 0.9; % -, allocation fraction to soma
  for i=1:n
    p_M = linspace(1e-2,1e4,1e3);
    v = p_M; n_v = length(v);
    for j=1:n_v
      v(j) = fzero(@find_v, 1, [], r_B(i), p_M(j), W_m, E_E, E_G, kap);
    end
    plot(p_M(p_M>0&v>0), v(p_M>0&v>0), '-', 'color',color(i,:), 'linewidth',2)
  end
  xlabel('spec som maint [p_M], J/d.cm^3')
  ylabel('energy conductance v, cm/d')
  xlim([0 1e4])
  ylim([0 0.2])
  text(9000,0.19, 'r_B, 1/d')
  text( 200,0.01, '0.001','color', color(1,:))
  text( 700,0.025,'0.005','color', color(2,:))
  text(1200,0.045,'0.01', 'color', color(3,:))
  text(2000,0.08, '0.02', 'color', color(4,:))
  text(3000,0.115,'0.03', 'color', color(5,:))
  text(4000,0.15, '0.04', 'color', color(6,:))
  text(5000,0.185,'0.05', 'color', color(7,:))
  set(gca, 'FontSize', 15, 'Box', 'on')
  title(['T=T_{ref}; f=1; W_m=',num2str(W_m),' g; [E_G]=5.26 kJ/cm^3; [E_E]=35 kJ/cm^3; \kappa=0.9'], 'FontWeight','normal', 'FontSize',9)
  saveas (gca, 'pM_v_Wi.png')
end

function F = find_pM(p_M, r_B, v, W_m, E_E, E_G, kap)
  p_Am = (p_M/ r_B/ 3 - E_G) * v/ kap; 
  F = W_m - (kap * p_Am/ p_M)^3 * (1 + p_Am/ v/ E_E);
end

function F = find_v(v, r_B, p_M, W_m, E_E, E_G, kap)
  p_Am = (p_M/ r_B/ 3 - E_G) * v/ kap; 
  F = W_m - (kap * p_Am/ p_M)^3 * (1 + p_Am/ v/ E_E);
end
