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
%  The scripts call functions read_popStat and read_allStat; the first call to these functions loads the .mat file, which can take some time
%  Click on a marker in the Matlab-figure to see the species name
%  Uncomment "print" to save the Matlab-figure to a png-file
%  Modify selection of taxa and markers by changing the legend, see https://add-my-pet.github.io/AmPtool/docs/index.html
%  Allowed names of taxa match the names of the tree nodes at http://www.bio.vu.nl/thb/deb/deblab/add_my_pet/species_tree_Animalia.html

  close all

  if ~exist('fig','var')
    fig = 1:20;
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
        [HfigLR, HlegLR] = shstat({'L_{\infty}','R_i'}, legend); 
        
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
  
      case 5 % fig 3a: kap, kap_opt

        figure % kappa
        kap = read_allStat('kap'); 
        kap_med = median(kap); kap_min = min(kap);  m = mean(kap); v = mean(kap.^2) - m^2;
        surv_kap = surv(kap); 
        a = m*(m*(1-m)/v-1); b = a*(1-m)/m;
        fprintf(['pars beta for kap: ', num2str(a), ' , ', num2str(b),'\n'])
        fprintf(['mean and variance for kap: ', num2str(m), ' , ', num2str(v),'\n'])
                
        kap = linspace(0,1,100);  S = 1 - betainc(kap,a,b);  
        plot(kap, S, '-', 'color', [0.75 0.75 1], 'linewidth',8)
        set(gca, 'FontSize', 15, 'Box', 'on', 'YTick', 0:0.2:1)
        
        hold on
        plot([0; kap_med; kap_med], [0.5;0.5;0], 'r', surv_kap(:,1), surv_kap(:,2), 'b', 'Linewidth', 2)
        xlabel('\kappa, -') 
        ylabel('survivor function')
        %saveas(gca,'kap.png')

        return
        pars_R = read_allStat({'kap','kap_R','g','k_J','k_M','L_T','v','U_Hb','U_Hp','L_b','L_j','L_p'}); % Lm will be replaced
        nmregr_options('report', 0); % no report
  
        for s = 1:n_species % loop across species
          %for s = S:S % loop across species
    
    if EHj(s) == EHb(s) % no acceleration  

      sM(s) = 1;   % -, acceleration factor

      % L*  at actual kap
      if TYPE(s)== 2
        pars_tx = [g(s) k(s) lT(s) v_Hb(s) (v_Hb(s) + 1e-10) v_Hp(s)];
        [tp tx tb lp lx lb] = get_tx(pars_tx', 1);
      else
        pars_tp = [g(s) k(s) lT(s) v_Hb(s) v_Hp(s)];
        [tp tb lp lb] = get_tp(pars_tp, 1);
      end
      Lb(s) = lb * Lm(s); Lj(s) = Lb(s); Lp(s) = lp * Lm(s); Li(s) = Lm(s);
      ab(s) = tb/ kM(s); aj(s) = tb/ kM(s); ap(s) = tp/ kM(s);

      % max reprod rate at actual kap
      pars_R = [kap(s) kapR(s) g(s) kJ(s) kM(s) LT(s) v(s) U_Hb(s) U_Hp(s)]; % Lm will be replaced
      if TYPE(s)== 2
        R(s) = reprod_rate_foetus(Lm(s), 1, pars_R); % actual max reprod rate      
      else
        R(s) = reprod_rate(Lm(s), 1, pars_R); % actual max reprod rate
      end
      
      % max reprod investment at actual kap
      pars_E0 = [V_Hb(s); g(s); kJ(s); kM(s); v(s)]; % pars for initial_scaled_reserve
      if TYPE(s) == 2
        E0 = pAm(s) * initial_scaled_reserve_foetus(1, pars_E0); % d cm^2, initial scaled reserve
      else
        E0 = pAm(s) * initial_scaled_reserve(1, pars_E0); % d cm^2, initial scaled reserve
      end
      pR(s) = R(s) * E0;
      
      kap_try = 2/3;
      if TYPE(s) == 2
        par = nmregr('fnreprod_rate_foetus', [[kap_try 1]; pars_R', zeros(9,1)], [0 0 1]);
      else
        par = nmregr('fnreprod_rate', [[kap_try 1]; pars_R', zeros(9,1)], [0 0 1]);
      end
      kapm(s) = par(1);
      [L par] = change_parsR (kapm(s), pars_R);         % Lm and par_R at optimized kap
      if TYPE(s) == 2
        Rm(s) = reprod_rate_foetus(L, 1, par);          % #/d, optimized max reprod rate 
      else
        Rm(s) = reprod_rate(L, 1, par);                 % #/d, optimized max reprod rate 
      end

      V_Hbm = U_Hb(s)/ (1 - kapm(s));  pars_E0(1:2) = [V_Hbm; par(3)];
      if TYPE(s) == 2
        E0 = pAm(s) * initial_scaled_reserve_foetus(1, pars_E0); % d cm^2, initial scaled reserve
      else
        E0 = pAm(s) * initial_scaled_reserve(1, pars_E0); % d cm^2, initial scaled reserve
      end
      pRm(s) = Rm(s) * E0; Lim(s) = kapm(s) * pAm(s)/ pM(s);
              
    else % acceleration
      
      % L* and sM at actual kap
      pars_tj = [g(s) k(s) lT(s) v_Hb(s) v_Hj(s) v_Hp(s)];
      [t_j t_p t_b l_j l_p l_b] = get_tj(pars_tj, 1);
      Lb(s) = l_b * Lm(s); Lp(s) = l_p * Lm(s);  Lj(s) = l_j * Lm(s); 
      sM(s) = Lj(s)/ Lb(s);  % -, acceleration
      Li(s) = sM(s) * Lm(s); % cm, max length (for adult)
      ab(s) = t_b/ kM(s); aj(s) = t_j/ kM(s); ap(s) = t_p/ kM(s);

      % max reprod rate at actual kap
      pars_R = [kap(s) kapR(s) g(s) kJ(s) kM(s) LT(s) v(s) U_Hb(s) U_Hp(s) Lb(s) Lj(s) Lp(s)]; % Lm will be replaced
      R(s) = reprod_rate_metam(Li(s), 1, pars_R); % actual max reprod rate

      % max reprod investment at actual kap
      pars_E0 = [V_Hb(s); g(s); kJ(s); kM(s); v(s)]; % pars for initial_scaled_reserve
      E0 = pAm(s) * initial_scaled_reserve(1, pars_E0); % d cm^2, initial scaled reserve
      pR(s) = R(s) * E0;

      par = nmregr('fnreprod_rate_metam', [[0.45 1]; [pars_R', zeros(12,1)]; [U_Hj(s) 0]], [0 0 1]);
      kapm(s) = par(1);
      [L par] = change_parsR_metam (kapm(s), pars_R, U_Hj(s));        % new length and pars
      Rm(s) = reprod_rate_metam(L, 1, par);                           % #/d, optimized max reprod rate 
      V_Hbm = U_Hb(s)/ (1 - kapm(s));  pars_E0(1:2) = [V_Hbm; par(3)];
      if TYPE(s) == 2
        E0 = pAm(s) * initial_scaled_reserve_foetus(1, pars_E0); % d cm^2, initial scaled reserve
      else
        E0 = pAm(s) * initial_scaled_reserve(1, pars_E0); % d cm^2, initial scaled reserve
      end
      pRm(s) = Rm(s) * E0; Lim(s) = kapm(s) * pAm(s)/ pM(s);
    end
       
    fprintf([species{s}, '\n'])
  end  
  sR = R ./ Rm; % -, max reprod rate as fraction of optimized max reprod rate
  
  figure % kap
  hold on
  x = linspace(1e-5, 1 - 1e-5, 100)';
  plot(x, 1 - betainc(x, 1.9948, 0.4625), 'c', 'Linewidth', 2)
  plot(x, 1 - betainc(x, 38.9, 42.9), 'm', 'Linewidth', 2)
  s_kap = surv(kap,0);  s_kapm = surv(kapm,0); 
  plot(s_kap(:,1), s_kap(:,2),'b', 'Linewidth', 2)
  plot(s_kapm(:,1), s_kapm(:,2),'r', 'Linewidth', 2)
  set(gca, 'FontSize', 15, 'Box', 'on')
  xlim([0 1])
  xlabel('\kappa  (-)')
  ylabel('Survivor function (-)')
  saveas(gca,'surv_kap.png')
  saveas(gca,'surv_kap.fig')

  figure % kap-kapm
  hold on
  scatter(kap(TYPE>0), kapm(TYPE>0), 60, color(TYPE>0,:), 'LineWidth', 2)
  plot([0;1], [0;1], 'k', 'Linewidth', 2)
  set(gca, 'FontSize', 15, 'Box', 'on')
  xlim([0 1])
  ylim([0 1])
  xlabel('\kappa  (-)')
  ylabel('\kappa_m  (-)')
  saveas(gca,'kap_kapm.png')
  saveas(gca,'kap_kapm.fig')

  figure % s_R
  hold on
  s_sR = surv(-log10(sR),0);  
  plot(s_sR(:,1), s_sR(:,2),'b', 'Linewidth', 2)
  set(gca, 'FontSize', 15, 'Box', 'on')
  xlabel('-_{10}Log s_R  (-)')
  ylabel('Survivor function  (-)')
  xlim([0;8])
  saveas(gca,'surv_sR.png')
  saveas(gca,'surv_sR.fig')

  figure % R-Rm
  hold on
  scatter(log10(R(TYPE>0)), log10(Rm(TYPE>0)), 60, color(TYPE>0,:), 'LineWidth', 2)
  plot([-4;8], [-4;8], 'k', 'Linewidth', 2)
  set(gca, 'FontSize', 15, 'Box', 'on')
  xlabel('_{10}Log R  (# d^{-1})')
  ylabel('_{10}Log R_m  (# d^{-1})')
  saveas(gca,'R_Rm.png')
  saveas(gca,'R_Rm.fig')


  figure % Lim-pRm
  hold on
  scatter(log10(Lim(TYPE>0)), log10(pRm(TYPE>0)), 60, color(TYPE>0,:), 'LineWidth', 2)
  plot([-3;3], [-8;10], 'k', 'Linewidth', 2)
  set(gca, 'FontSize', 15, 'Box', 'on')
  xlabel('_{10}log L_{mm}  (cm)')
  ylabel('_{10}log p_{Rm}  (J d^{-1})')
  xlim([-3 3])

  figure % sM - sR
  scatter(log10(sM(TYPE>0)), log10(sR(TYPE>0)), 60, color(TYPE>0,:), 'LineWidth', 2)
  set(gca, 'FontSize', 15, 'Box', 'on')
  xlabel('_{10}Log s_M  (-)')
  ylabel('_{10}Log s_R  (-)')
  saveas(gca,'sM_sR.png')
  saveas(gca,'sM_sR.fig')
  
  figure % Li - t*, sR - t*
  subplot(2,3,1)
  scatter(log10(Li(TYPE>0)), log10(ab(TYPE>0)), 60, color(TYPE>0,:), 'LineWidth', 2)
  set(gca, 'FontSize', 15, 'Box', 'on')
  xlabel('_{10}log L_m, cm')
  ylabel('_{10}log a_b, d')

  subplot(2,3,2)
  scatter(log10(Li(TYPE>0)), log10(aj(TYPE>0)), 60, color(TYPE>0,:), 'LineWidth', 2)
  set(gca, 'FontSize', 15, 'Box', 'on')
  xlabel('_{10}log L_m, cm')
  ylabel('_{10}log a_j, d')

  subplot(2,3,3)
  scatter(log10(Li(TYPE>0)), log10(ap(TYPE>0)), 60, color(TYPE>0,:), 'LineWidth', 2)
  set(gca, 'FontSize', 15, 'Box', 'on')
  xlabel('_{10}log L_m, cm')
  ylabel('_{10}log a_p, d')

  subplot(2,3,4)
  scatter(log10(sR(TYPE>0)), log10(ab(TYPE>0)), 60, color(TYPE>0,:), 'LineWidth', 2)
  set(gca, 'FontSize', 15, 'Box', 'on')
  xlabel('_{10}log s_R, -')
  ylabel('_{10}log a_b, d')

  subplot(2,3,5)
  scatter(log10(sR(TYPE>0)), log10(aj(TYPE>0)), 60, color(TYPE>0,:), 'LineWidth', 2)
  set(gca, 'FontSize', 15, 'Box', 'on')
  xlabel('_{10}log s_R, -')
  ylabel('_{10}log a_j, d')

  subplot(2,3,6)
  scatter(log10(sR(TYPE>0)), log10(ap(TYPE>0)), 60, color(TYPE>0,:), 'LineWidth', 2)
  set(gca, 'FontSize', 15, 'Box', 'on')
  xlabel('_{10}log s_R, -')
  ylabel('_{10}log a_p, d')

  fprintf('\n\n sub-optimal species, s_R \n')
  printpar(species(sR<.8 & kap<.5), sR(sR<.8 & kap<.5))
  fprintf(['number of sub-optimal species ', num2str(sum(sR<.8 & kap<.5)),'\n'])

  fprintf('\n\n optimal species, s_R \n')
  printpar(species(sR>.8), sR(sR>.8))
  fprintf(['number of optimal species ', num2str(sum(sR>.8)),'\n'])
  fprintf(['total number of species ', num2str(length(sR)),'\n'])


    end
  end
end

