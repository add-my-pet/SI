function KooyLika2014_SI(fig)
% Supporting Information for KooyLika2014
% Title: Resource allocation to reproduction in animals.
% Authors: Kooijman, Lika
% Journal: Biol. Rev. 89 (2014): 849–859
% DOI: 10.1111/brv.12082
% Date: 2023/02/23
% 
% Matlab scripts to generate the figures in the publication
%
% To run the scripts you need
% 1) Matlab (the student or Home version will suffice)
% 2) Download AmPdata from http://www.bio.vu.nl/thb/deb/deblab/add_my_pet/
%    Goto AmPdata in dropdown "COLLECTION", unpack the zip-file, save the 2 .mat-files in a directory, set the path in Matlab to this directory.
% 3) Copy DEBtool from http://www.github.com/add-my-pet/DEBtool_M/ in a directory, set the path in Matlab to this directory.
% 4) Copy AmPtool from http://www.github.com/add-my-pet/AmPtool/ in a directory, set the path in Matlab to this directory.
%
% Set Path in Matlab is in the toolbar of the Command Window of Matlab if full-screen
% Load this script-file in the Matlab Editor
% To run the code for a figure: type in the Matlab window e.g. KooyLika2014_SI(2)
%
% Remarks: 
%  The figures show current AmP data, which might change in time; the results might differ from the publication
%  Case 6 evalues kappa that maximizes ultimate reproduction; this might take some computation time.
%  The scripts call functions read_popStat and read_allStat; the first call to these functions loads the .mat file, which can take some time
%  Click on a marker in the Matlab-figure to see the species name
%  Uncomment "print" to save the Matlab-figure to a png-file
%  Modify selection of taxa and markers by changing the legend, see https://add-my-pet.github.io/AmPtool/docs/index.html
%  Allowed names of taxa match the names of the tree nodes at http://www.bio.vu.nl/thb/deb/deblab/add_my_pet/species_tree_Animalia.html

  close all

  if ~exist('fig','var')
    fig = 1:7;
  end

  legend = {...
    % type, size, linewidth, edge color and face color of a marker, taxon
    {'o', 8, 3, [0 0 0],     [1 1 1]}, 'Radiata'; ...
    {'o', 8, 3, [0 1 1],     [1 1 1]}, 'Spiralia'; ...
    {'o', 8, 3, [0 0.5 0.5], [1 1 1]}, 'Ecdysozoa'; ....
    {'o', 8, 3, [0 0 0.5],   [1 1 1]}, 'Chondrichthyes'; ....
    {'o', 8, 3, [0 0 1],     [1 1 1]}, 'Actinopterygii'; ....
    {'o', 8, 3, [0.5 0 0],   [1 1 1]}, 'Mammalia'; ....
    {'o', 8, 3, [1 0 0],     [1 1 1]}, 'Theropoda'; ....
    {'o', 8, 3, [0.5 0 0.5], [1 1 1]}, 'Deuterostomata'; ....
  };

  close all
  
  shstat_options('default');
  shstat_options('y_label', 'on'); 
  shstat_options('x_label', 'off'); 
  
  for i=1:length(fig)
    switch fig(i)
      case 1 % fig 1a: Li-R 
        LiRicT = read_allStat({'L_i','R_i','c_T'});
        [HfigLR, HlegLR] = shstat([LiRicT(:,1), LiRicT(:,2)./LiRicT(:,3)], legend); 
        
        figure(HfigLR)
        plot([-3;3], [2;-4], 'k', 'Linewidth', 2)
        set(gca, 'FontSize', 15, 'Box', 'on')
        xlabel('_{10}Log L_{\infty}, cm')
        ylabel('_{10}Log R_{\infty}, # d^{-1}')
        xlim([-3 3])
        %saveas(gca,'Li_R.png')
        %saveas(gca,'Li_R.fig')

      case 2 % fig 1b: Li-pR
        [HfigLpR, HlegLpR] = shstat({'L_i','p_Ri'}, legend); 
        
        figure(HfigLpR)
        plot([-3;3], [-8;10], 'k', 'Linewidth', 2)
        set(gca, 'FontSize', 15, 'Box', 'on')
        xlabel('_{10}Log L_{\infty}, cm')
        ylabel('_{10}Log p_R, J d^{-1}')
        xlim([-3 3])
        %saveas(gca,'Li_pR.png')
        %saveas(gca,'Li_pR.fig')
        
      case 3 % fig 2a: Li-Em
        [HfigLEm, HlegLEm] = shstat({'L_i','E_m'}, legend); 
        
        figure(HfigLEm)
        plot([-2;3], [1;6], 'k', 'Linewidth', 2)
        set(gca, 'FontSize', 15, 'Box', 'on')
        xlabel('_{10}Log L_\infty, cm')
        ylabel('_{10}Log [E_m], J cm^{-3}')
        %saveas(gca,'Li_Em.png')
        %saveas(gca,'Li_Em.fig')

      case 4 % fig 2b: Li_adj-Em
        LipMEm = read_allStat({'L_i','p_M','E_m'}); L_i = LipMEm(:,1); p_M = LipMEm(:,2); E_m = LipMEm(:,3);
        p_Mm = mean(p_M); L_iadj = L_i .* p_M ./ p_Mm;
        [HfigLiaEm, HlegLiaEm] = shstat([L_iadj, E_m], legend); 
       
        figure(HfigLiaEm)
        plot([-3;2], [1.5;6.5], 'k', 'Linewidth', 2)
        set(gca, 'FontSize', 15, 'Box', 'on')
        xlabel('_{10}Log L_{\infty} [p_M]/ mean([p_M]), cm')
        ylabel('_{10}Log [E_m], J cm^{-3}')
        %saveas(gca,'Liadj_Em.png')
        %saveas(gca,'Liadj_Em.fig')  
  
      case 5 % fig 3a, 3b, 4a, 4b, 5
        par = read_allStat({'kap','kap_R','p_Am','v','p_M','k_J','E_G','E_Hb','E_Hj','E_Hp','s_M'}); 
        sel = isnan(par(:,9)); par(sel,9) = par(sel,8)+1e-3; % E_Hj=E_Hb+1e-3 for non-accelerating species 
        mod = read_allStat('model'); s_M = par(:,11);
        
        kap = par(:,1); kap_med = median(kap); kap_min = min(kap); m = mean(kap); v = mean(kap.^2) - m^2;
        surv_kap = surv(kap); 
        a = m*(m*(1-m)/v-1); b = a*(1-m)/m;
        fprintf(['pars beta for kap: ', num2str(a), ' , ', num2str(b),'\n'])
        fprintf(['mean and variance for kap: ', num2str(m), ' , ', num2str(v),'\n'])
          
        figure % fig 3a: kap, kap_m
        kapX = linspace(0,1,100);  S = 1 - betainc(kapX,a,b);  
        plot(kapX, S, '-', 'color', [0.75 0.75 1], 'linewidth',8)
        set(gca, 'FontSize', 15, 'Box', 'on', 'YTick', 0:0.2:1)
        
        hold on
        plot([0; kap_med; kap_med], [0.5;0.5;0], 'b', surv_kap(:,1), surv_kap(:,2), 'b', 'Linewidth', 2)
        xlabel('\kappa, -') 
        ylabel('survivor function')

        [kap_m, R_m, R_i] = get_kapm(mod,par); sel = ~isnan(kap_m); 
        kap_med_m = median(kap_m(sel)); m = mean(kap_m(sel)); v = mean(kap_m(sel).^2) - m^2;
        surv_kap_m = surv(kap_m(sel)); 
        a = m*(m*(1-m)/v-1); b = a*(1-m)/m;
        fprintf(['pars beta for kap_m: ', num2str(a), ' , ', num2str(b),'\n'])
        fprintf(['mean and variance for kap_m: ', num2str(m), ' , ', num2str(v),'\n'])
        plot(kapX, 1 - betainc(kapX,a,b), '-', 'color', [1 0.75 1], 'linewidth',8)
        plot([0; kap_med_m; kap_med_m], [0.5;0.5;0], 'magenta', surv_kap_m(:,1), surv_kap_m(:,2), 'magenta', 'Linewidth', 2)
        %saveas(gca,'kap.png')

        % fig 3b: kap_kapm
        shstat_options('x_transform','none');
        shstat_options('y_transform','none');
        Hfigkap = shstat([kap, kap_m], legend); 
        figure(Hfigkap)
        xlim([0 1]); ylim([0 1]);
        plot([0;1],[0;1], 'color','k', 'linewidth',3)
        xlabel('allocation fraction, \kappa, -') 
        ylabel('optimal allocation fraction, \kappa_m, -')
        %saveas(gca,'kap_kapm.png')
                
        figure % fig 4a: surv s_R
        s_R = R_i./R_m;
        surv_sR = surv(s_R(sel));
        plot(log10(surv_sR(:,1)), surv_sR(:,2), 'k', 'Linewidth', 2)
        xlabel('_{10}log R_{\infty)/R_{max}, -') 
        ylabel('survival function, -')

        % fig 4b: Ri_Rm
        shstat_options('default');
        HfigRR = shstat([R_i, R_m], legend);     
        figure(HfigRR)
        plot([-5;10],[-5;10], 'k', 'Linewidth',2)
        xlabel('_{10}log R_{\infty), #/d') 
        ylabel('_{10}log R_{max), #/d')
        %saveas(gca,'Ri_Rm.png')
        
        figure % fig 5: sM_sR
        shstat_options('default');
        HfigsMsR = shstat([s_M, s_R], legend);
        figure(HfigsMsR)
        xlabel('acceleration factor, _{10}log s_M, -') 
        ylabel('reprod ratio, _{10}log s_R, -')
        %saveas(gca,'sM_sR.png')

      case 6 % fig 6a, fb: kap_R, t_dW
        % chemical indices
        %       X     V     E     P
        n_O = [1.00, 1.00, 1.00, 1.00;   % C/C, equals 1 by definition
               1.80, 1.80, 1.80, 1.80;   % H/C  these values show that we consider dry-mass
               0.50, 0.50, 0.50, 0.50;   % O/C
               0.15, 0.15, 0.15, 0.15];  % N/C
        % specific densities
        %       X     V     E     P
        d_O = [.38; .38; .38; .38];      % g/cm^3, specific densities for organics (from the dry weight/wet weight ratio) (Weiss, 1958)

        % chemical potentials
        mu_X = 525000;                   % J/mol, chemical potential of food
        mu_V = 500000;                   % J/mol, chemical potential of structure
        mu_E = 550000;                   % J/mol, chemical potential of reserve
        mu_P = 480000;                   % J/mol, chemical potential of faeces
        mu_O = [mu_X; mu_V; mu_E; mu_P]; % J/mol, chemical potentials of organics

        % molecular weights
        w_O = n_O' * [12; 1; 16; 14];    % g/mol, mol-weights for org. compounds

        % pack coefficients
        dwm = [d_O, w_O, mu_O];          % g/cm^3, g/mol, kJ/mol spec density, mol weight, chem pot

        % Gallus_gallus_IR_f
        T_ref  = 293;       % 1 K, temperature for which rate parameters are given; DO NOT CHANGE THIS VALUE
        T_A  = 17974;       % 2 K, Arrhenius temperature
        f = 1.0;            % 3 scaled functional response
        z = 8.391;          % 4 -, zoom factor; for z = 1: L_m = 1 cm
        del_M = 0.18;       % 5 -, shape coefficient
        F_m = 6.5;          % 6 l/d.cm^2, {F_m} max spec searching rate
        kap_X = 0.6109;    % 7 -, digestion efficiency of food to reserve
        v = 0.009649;       % 8 cm/d, energy conductance
        kap = 0.3492;       % 9 -, allocation fraction to soma = growth + somatic maintenance
        kap_R = 0.95;       %10 -, reproduction efficiency
        p_M = 18.09;        %11 J/d.cm^3, [p_M] volume-specific somatic maintenance
        p_T = 0;            %12 J/d.cm^2, {p_T} surface-specific somatic maintenance
        k_J = 0.002022;     %13 1/d, maturity maintenance rate
        E_G = 7709;         %14 J/cm^3, [E_G], specific cost for structure
        E_Hb = 9.121e4;     %15 J, E_H^b maturation threshold for feeding (birth)
        E_Hp = 6.532e6;     %16 J, E_H^p maturation threshold for reproduction (puberty)
        h_a = 5.236e-21;    %17 1/d^2, Weibull ageing acceleration
        s_G = 0.1;          %18 -, Gompertz stress coefficient
        mu_Xf = 279630;     %19 J/mol, energy in food for tW_f data 
        kap_Xf = 0.9;       %20 -, digestion efficiency of food to reserve for tW_f data 

        pars_IR = [T_ref 0; T_A 0; f    0; z     1; del_M 0; F_m 0;  
          kap_X 1; v   1; kap  1; kap_R 0; p_M   1; p_T 0;  
          k_J   1; E_G 1; E_Hb 1; E_Hp  1; h_a   1; s_G 0];

        % Gallus_gallus_WL_f
        T_ref  = 293;       % 1 K, temperature for which rate parameters are given; DO NOT CHANGE THIS VALUE
        T_A  = 17974;       % 2 K, Arrhenius temperature
        f = 1.0;            % 3 scaled functional response
        z = 8.649;          % 4 -, zoom factor; for z = 1: L_m = 1 cm
        del_M = 0.18;       % 5 -, shape coefficient
        F_m = 6.5;          % 6 l/d.cm^2, {F_m} max spec searching rate
        kap_X = 0.8;        % 7 -, digestion efficiency of food to reserve
        v = 0.01129;        % 8 cm/d, energy conductance
        kap = 0.5051;       % 9 -, allocation fraction to soma = growth + somatic maintenance
        kap_R = 0.95;       %10 -, reproduction efficiency
        p_M = 15.79;        %11 J/d.cm^3, [p_M] volume-specific somatic maintenance
        p_T = 0;            %12 J/d.cm^2, {p_T} surface-specific somatic maintenance
        k_J = 0.002;        %13 1/d, maturity maintenance rate
        E_G = 9948;         %14 J/cm^3, [E_G], specific cost for structure
        E_Hb = 8.144e4;     %15 J, E_H^b maturation threshold for feeding (birth)
        E_Hp = 2.871e6;     %16 J, E_H^p maturation threshold for reproduction (puberty)
        h_a = 2.317e-22;    %17 1/d^2, Weibull ageing acceleration
        s_G = 0.1;          %18 -, Gompertz stress coefficient

        % pack parameters and fix T_ref and f and possibly other at well (in second column: 0 = fix; 1 = release)
        pars_WL = [T_ref 0; T_A 0; f    0; z     1; del_M 0; F_m 0;  
          kap_X 1; v   1; kap  1; kap_R 0; p_M   1; p_T 0;  
          k_J   1; E_G 1; E_Hb 1; E_Hp  1; h_a   1; s_G 0];  

        % Gallus_gallus_RJ_f
        T_ref  = 293;       % 1 K, temperature for which rate parameters are given; DO NOT CHANGE THIS VALUE
        T_A  = 17974;       % 2 K, Arrhenius temperature
        f = 1.0;            % 3 scaled functional response
        z = 4.97;         % 4 -, zoom factor; for z = 1: L_m = 1 cm
        del_M = 0.18;     % 5 -, shape coefficient
        F_m = 6.5;          % 6 l/d.cm^2, {F_m} max spec searching rate
        kap_X = 0.8;        % 7 -, digestion efficiency of food to reserve
        v = 0.008253;         % 8 cm/d, energy conductance
        kap = 0.2486;       % 9 -, allocation fraction to soma = growth + somatic maintenance
        kap_R = 0.95;       %10 -, reproduction efficiency
        p_M = 21.38;      %11 J/d.cm^3, [p_M] volume-specific somatic maintenance
        p_T = 0;            %12 J/d.cm^2, {p_T} surface-specific somatic maintenance
        k_J = 0.002519;        %13 1/d, maturity maintenance rate coefficient
        E_G = 9918;    %14 J/cm^3, [E_G], specific cost for structure
        E_Hb = 8.985e4;   %15 J, E_H^b maturation threshold for feeding (birth)
        E_Hp = 2.674e6; %16 J, E_H^p maturation threshold for reproduction (puberty)
        h_a = 2.7223e-49;   %17 1/d^2, Weibull ageing acceleration
        s_G = 0.1;         %18 -, Gompertz stress coefficient

        pars_RJ = [T_ref 0; T_A 0; f    0; z     1; del_M 0; F_m 0;  
          kap_X 1; v   1; kap  1; kap_R 0; p_M   1; p_T 0;  
          k_J   1; E_G 1; E_Hb 1; E_Hp  1; h_a   1; s_G 0];

        kap_vec = linspace(.22,.95,100)';
        t = linspace(1e-3,365,100)';
        [kapR_WL tG_WL tGm_WL kapG_WL] = kap_rep(kap_vec, t, pars_WL(:,1), dwm);
        [kapR_IR tG_IR tGm_IR kapG_IR] = kap_rep(kap_vec, t, pars_IR(:,1), dwm);
        [kapR_RJ tG_RJ tGm_RJ kapG_RJ] = kap_rep(kap_vec, t, pars_RJ(:,1), dwm);

        figure
        R_WL = spline1(pars_WL(9), kapR_WL); 
        R_IR = spline1(pars_IR(9), kapR_IR); 
        R_RJ = spline1(pars_RJ(9), kapR_RJ); 
        plot(kapR_WL(:,1), kapR_WL(:,2), 'b', pars_WL(9), R_WL, 'ob', ...
          kapR_IR(:,1), kapR_IR(:,2), 'r', pars_IR(9), R_IR, 'or',...
          kapR_RJ(:,1), kapR_RJ(:,2), 'g', pars_RJ(9), R_RJ, 'og', 'Linewidth', 2')
        set(gca, 'FontSize', 15, 'Box', 'on', 'Linewidth', 2)
        ylim([0 1.5])
        xlabel('\kappa  (-)')
        ylabel('R (# d^{-1})')
        %saveas(gca,'Gallus_kap_R.png')
        %saveas(gca,'Gallus_kap_R.fig')

        figure
        plot(t, tG_WL(:,2), 'b', ...
          t, tG_IR(:,2), 'r', ...
          t, tG_RJ(:,2), 'g', 'Linewidth', 2)
        set(gca, 'FontSize', 15, 'Box', 'on', 'Linewidth', 2)
        xlabel('t  (d)')
        ylabel('(W(t) - W_b)/t  (g d^{-1})')
        %saveas(gca,'Gallus_t_W.png')
        %saveas(gca,'Gallus_t_W.fig')

        figure
        hold on
        plot(kapG_WL(:,1), kapR_WL(:,2) .* kapG_WL(:,2), 'b', ...
          kapG_IR(:,1), kapR_IR(:,2) .* kapG_IR(:,2), 'r', ...
          kapG_RJ(:,1), kapR_RJ(:,2) .* kapG_RJ(:,2), 'g', 'Linewidth', 2)
        plot(pars_WL(9), R_WL * tGm_WL(2), 'ob', ...
          pars_IR(9), R_IR * tGm_IR(2), 'or', ...
          pars_RJ(9), R_RJ * tGm_RJ(2), 'og')
        set(gca, 'FontSize', 15, 'Box', 'on', 'Linewidth', 2)
        xlabel('\kappa, -')
        ylabel('max(R) * max (W(t) - W_b)/ t, #g d^{-2}')

      case 7 % fig 7: kap_scaled R,N,r
        T_ref  = 293;      % 1 K, temp for which rate pars are given; don't change this vulue
        T_A  = 8000;       % 2 K, Arrhenius temp 
        f = 1.0;           % 3 -, scaled functional response
        z = 1;             % 4 -, zoom factor; for z = 1: L_m = 1 cm
        del_M = 0.16;      % 5 -, shape coefficient
        F_m = 6.5;         % 6 l/d.cm^2, {F_m}, max spec searching rate
        kap_X = 0.8;       % 7 -, digestion efficiency of food to reserve
        v = 0.02;          % 8 cm/d, energy conductance
        kap = 0.8;         % 9 -, allocation fraction to soma = growth + somatic maintenance
        kap_R = 0.95;      %10 -, reproduction efficiency
        p_M = 18;          %11 J/d.cm^3, [p_M], vol-specific somatic maintenance
        p_T =  0;          %12 J/d.cm^2, {p_T}, surface-specific som maintenance
        k_J = 0.002;       %13 1/d, maturity maint rate coefficient
        E_G = 2800;        %14 J/cm^3, [E_G], spec cost for structure
        E_Hb = .275;       %15 J, E_H^b, maturity at birth
        E_Hp = 50;         %16 J, E_H^p, maturity at puberty
        h_a = 1e-6;        %17 1/d^2, Weibull aging acceleration
        s_G = 1e-4;        %18 -, Gompertz stress coefficient

        p_Am = z * p_M/ kap;    % J/d.cm^2, {p_Am} max spec assimilation flux
        k_M = p_M/ E_G;         % 1/d, som maint rate coeff
        L_T = p_T/ p_M;         % cm, heating length (also applies to osmotic work)
        U_Hb = E_Hb/ p_Am;      % cm^2 d, scaled maturity at birth
        U_Hp = E_Hp/ p_Am;      % cm^2 d, scaled maturity at birth

        kap_min_max = roots3([1 -1 0 k_J * U_Hp * p_M^2/ p_Am^2], 2); % range for kap at f=1
        kap_vec = linspace(kap_min_max(1)+1e-2, kap_min_max(2)-1e-2,100)';
        RNr = zeros(100,3);

        for i = 1:100
          kap = kap_vec(i);
          g = E_G * v/ kap/ p_Am;  % -, energy investment ratio
          L_m = kap * p_Am/ p_M;   % cm, max structural length
          l_T = L_T/ L_m;          % -, scaled heating length
  
          pars_R = [kap; kap_R; g; k_J; k_M; L_T; v; U_Hb; U_Hp]; % compose parameter vector at T
          R = reprod_rate(L_m, f, pars_R); % #/d, ultimate reproduction rate at T
          pars_tm = [g; l_T; h_a/ k_M^2; s_G];     % compose parameter vector at T_ref
          t_m = get_tm_s(pars_tm, f);              % -, scaled mean life span at T_ref
          a_m = t_m/ k_M;                          % d, mean life span at T
          if kap<.2 || kap>.955
            N = 0;
          else
            N = cum_reprod(a_m, f, pars_R);        % #, life time reprod output
          end
          if kap<.22 || kap>.96
            r = 0;
          else  
            pars_sgr = [pars_R; h_a; s_G];           % compose parameter vector at T_ref
            r = sgr_iso (pars_sgr, f);              % 1/d, population growth rate
          end
          RNr(i,:) = [R N r];                      % fill reprod rate, lifetime reprod output, pop growth rate
        end

        [Rm i_R] = max(RNr(:,1)); 
        [Nm i_N] = max(RNr(:,2)); 
        [rm i_r] = max(RNr(:,3));
        %[kap_vec(i_R) Rm; kap_vec(i_N) Nm; kap_vec(i_r) rm]

        plot(kap_vec, RNr(:,1)/Rm, 'r',...
        kap_vec(RNr(:,2)>0), RNr(RNr(:,2)>0,2)/Nm, 'b',...
        kap_vec(RNr(:,3)>0), RNr(RNr(:,3)>0,3)/rm, 'g','Linewidth', 2)
        set(gca, 'FontSize', 15, 'Box', 'on')
        xlabel('\kappa  (-)')
        ylabel('Scaled R, N, r  (-)')
        xlim([0;1])
        ylim([0;1])
        %saveas(gca,'kap_RNr.png')
        %saveas(gca,'kap_RNr.fig')
    end
  end
end

function [kap_m, R_m, R_i] = get_kapm(mod, par)
  %nm=select; 
  n=size(par,1); kap_m = NaN(n,1); R_m = NaN(n,1); R_i = NaN(n,1); dkap = 1e-4;
  get_kap = @(kap,mod,pari,dkap) (reprod_rate_max(mod,[kap, pari]) - reprod_rate_max(mod,[kap-dkap, pari]))/ dkap;
  
  for i=1:n
    R_i(i) = reprod_rate_max(mod{i}, par(i,:));
    if ~isnan(R_i(i))
      try
        kap_m(i) = fzero(@(kap) get_kap(kap,mod{i},par(i,2:end),dkap), 0.45);
        R_m(i) = reprod_rate_max(mod{i},[kap_m(i), par(i,2:end)]);
        %if R_m(i) < R_i(i); keyboard; end
        %fprintf('%g %s %s %g %g & %g %g\n',i, nm{i}, mod{i}, par(i,1), R_i(i), kap_m(i), R_m(i));
      end
    end
  end
end

function [kapR tG tGm kapG] = kap_rep(kap_vec, t, par, dwm)
  % unpack par
  T_ref  = par(1); % K, temp for which rate pars are given 
  T_A    = par(2); % K, Arrhenius temp
  f      = par(3); % -, scaled functional response
  z      = par(4); % -, zoom factor
  del_M  = par(5); % -, shape coefficient to convert vol-length to physical length
  F_m    = par(6); % l/d.cm^2, {F_m} max spec searching rate
  kap_X  = par(7); % -, digestion efficiency of food to reserve
  v      = par(8); % cm/d, energy conductance
  kap    = par(9); % -, alloaction fraction to soma = growth + somatic maintenance
  kap_R  = par(10);% -, reproduction efficiency
  p_M    = par(11);% J/d.cm^3, [p_M] vol-specific somatic maintenance
  p_T    = par(12);% J/d.cm^2, {p_T} surface-specific som maintenance
  k_J    = par(13);% 1/d, maturity maint rate coefficient
  E_G    = par(14);% J/cm^3, [E_G], spec cost for structure
  E_Hb   = par(15);% J, E_H^b maturity at birth
  E_Hp   = par(16);% J, E_H^p maturity at puberty
  p_Am = z * p_M/ kap; % J/d.cm^2, {p_Am} max spec assimilation flux

  d_X = dwm(1,1); d_V = dwm(2,1);  d_E = dwm(3,1); % g/cm^3, specific densities for structure and reserve
  w_X = dwm(1,2); w_V = dwm(2,2);  w_E = dwm(3,2); % g/mol,  molecular weights for structure and reserve
  mu_X =dwm(1,3); mu_V = dwm(2,3); mu_E = dwm(3,3);% J/mol,  chemical potentials for structure and reserve

  TC = tempcorr(273+41, T_ref, T_A);   % -, Temperature Correction factor for R_i; ONLY WORK WITH T_A
  J_E_Am = p_Am/ mu_E;             % mol/d.cm^2, {J_EAm}, max surface-spec assimilation flux
  k_M = p_M/ E_G;                  % 1/d, somatic maintenance rate coefficient
  k = k_J/ k_M;                    % -, maintenance ratio
  p_Xm = p_Am/ kap_X;              % J/d.cm^2, max spec feeding power

  M_V = d_V/ w_V;                  % mol/cm^3, [M_V], volume-specific mass of structure
  kap_G = M_V * mu_V/ E_G;         % -, growth efficiency
  y_V_E = mu_E * M_V/ E_G;         % mol/mol, yield of structure on reserve
  y_E_V = 1/ y_V_E;                % mol/mol, yield of reserve on structure

  E_m = p_Am/ v;                   % J/cm^3, [E_m] reserve capacity 
  m_Em = y_E_V * E_m/ E_G;         % mol/mol, reserve capacity 
  g = E_G/ kap/ E_m;               % -, energy investment ratio
  w = m_Em * w_E/ w_V;             % -, contribution of reserve to weight

  L_m = v/ k_M/ g;                 % cm, maximum structural length
  L_T = p_T/ p_M;                  % cm, heating length (also applies to osmotic work)
  l_T = L_T/ L_m;                  % -, scaled heating length
  L_i = (f - L_T) * L_m;
  % maturity at birth
  M_Hb = E_Hb/ mu_E;               % mol, maturity at birth  
  U_Hb = M_Hb/ J_E_Am;             % cm^2 d, scaled maturity at birth
  u_Hb = U_Hb * g^2 * k_M^3/ v^2;  % -, scaled maturity at birth
  V_Hb = U_Hb/ (1 - kap);          % cm^2 d, scaled maturity at birth
  v_Hb = V_Hb * g^2 * k_M^3/ v^2;  % -, scaled maturity at birth

  pars_tp = [g; k; v_Hb]; % compose parameter vector
  l_b = get_lb(pars_tp, f); % -, scaled length at birth at f
  w = m_Em * w_E/ w_V;             % -, contribution of reserve to weight
  L_m = v/ k_M/ g;                 % cm, maximum structural length
  L_b = L_m * l_b;
  l_i = f - l_T;                % -, scaled ultimate length at f
  L_i = L_m * l_i;              % cm, ultimate structural length at f
  rT_B = TC * k_M/ 3/ (1 + f/g);
  L = L_i - (L_i - L_b) * exp(- rT_B * t);
  W = L.^3 * (1 + f * w);
  W_b = L_b^3 * (1 + f * w);
  G = (W - W_b)./t; tG = [t, G];
  [Gm i] = max(G); tGm = [t(i), Gm];
  
  n_kap = length(kap_vec);
  R_vec = 0*kap_vec; G_vec = 0*kap_vec;
  
  for i = 1:n_kap
  kap = kap_vec(i);
  
  % Selected copy-paste from parscomp & statistics
  J_E_Am = p_Am/ mu_E;             % mol/d.cm^2, {J_EAm}, max surface-spec assimilation flux
  k_M = p_M/ E_G;                  % 1/d, somatic maintenance rate coefficient
  k = k_J/ k_M;                    % -, maintenance ratio

  M_V = d_V/ w_V;                  % mol/cm^3, [M_V], volume-specific mass of structure
  y_V_E = mu_E * M_V/ E_G;         % mol/mol, yield of structure on reserve
  y_E_V = 1/ y_V_E;                % mol/mol, yield of reserve on structure

  E_m = p_Am/ v;                   % J/cm^3, [E_m] reserve capacity 
  m_Em = y_E_V * E_m/ E_G;         % mol/mol, reserve capacity 
  g = E_G/ kap/ E_m;               % -, energy investment ratio
  w = m_Em * w_E/ w_V;             % -, contribution of reserve to weight

  L_m = v/ k_M/ g;                 % cm, maximum structural length
  L_T = p_T/ p_M;                  % cm, heating length (also applies to osmotic work)
  l_T = L_T/ L_m;                  % -, scaled heating length
  L_i = (f - L_T) * L_m;

  % maturity at birth
  M_Hb = E_Hb/ mu_E;               % mol, maturity at birth  
  U_Hb = M_Hb/ J_E_Am;             % cm^2 d, scaled maturity at birth
  u_Hb = U_Hb * g^2 * k_M^3/ v^2;  % -, scaled maturity at birth
  V_Hb = U_Hb/ (1 - kap);          % cm^2 d, scaled maturity at birth
  v_Hb = V_Hb * g^2 * k_M^3/ v^2;  % -, scaled maturity at birth
  % maturity at puberty
  M_Hp = E_Hp/ mu_E;               % mol, maturity at puberty
  U_Hp = M_Hp/ J_E_Am;             % cm^2 d, scaled maturity at puberty 
  u_Hp = U_Hp * g^2 * k_M^3/ v^2;  % -, scaled maturity at puberty  
  V_Hp = U_Hp/ (1 - kap);          % cm^2 d, scaled maturity at puberty
  v_Hp = V_Hp * g^2 * k_M^3/ v^2;  % -, scaled maturity at puberty

  % reproduction
  pars_R = [kap; kap_R; g; k_J; k_M; L_T; v; U_Hb; U_Hp]; % compose parameter vector at T
  R_vec(i) = TC * reprod_rate(L_i, f, pars_R); % #/d, ultimate reproduction rate at T
  
  % max growth
  % L = (1 - f/3) * L_m - L_T * 2/3;
  % r = TC * v * (f/ L - (1 + L_T/ L)/ L_m)/ (f + g);
  % dW_vec(i) = r * L^3;
  
  pars_tp = [g; k; l_T; v_Hb; v_Hp]; % compose parameter vector
  [t_p t_b l_p l_b info] = get_tp(pars_tp, f); % -, scaled length at birth at f
  if info ~= 1 % numerical procedure failed
      fprintf('warning: invalid parameter value combination for get_tp \n')
  end
  L_b = L_m * l_b;
  l_i = f - l_T;                % -, scaled ultimate length at f
  L_i = L_m * l_i;              % cm, ultimate structural length at f
  rT_B = TC * k_M/ 3/ (1 + f/g);
  L = L_i - (L_i - L_b) * exp(- rT_B * t);
  W = L.^3 * (1 + f * w);
  W_b = L_b^3 * (1 + f * w);
  G_vec(i) = max((W - W_b)./t);

  end
  kapR = [kap_vec, R_vec]; kapG = [kap_vec, G_vec];
end