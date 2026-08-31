function Kooy2026c_SI(fig)
% Supporting Information for Kooy2026c
% Title: The energetics of trophic pyramids
% Authors: Kooijman
% Journal: Theoretical Ecology
% DOI: 
% Date: 2026/07/27
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
% To run the code for a figure: type in the Matlab window e.g. LikaAugu2019_SI(2)
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
    fig = 1:5;
  end

  close all
  shstat_options('default');
  shstat_options('y_label', 'on'); 
  shstat_options('x_label', 'off'); 
  

  for i=1:length(fig)
    switch fig(i)
    case 1 % ss_kap_r +- thinning
      sskap = read_allStat({'s_s','kap'}); ss = sskap(:,1); kap = sskap(:,2); kapRA = 1 - kap - ss./kap.^2; n = length(kap);    
      [r, nm] = read_popStat('f1.thin1.f.r'); sel = ~isnan(r);
      
      figure
      hold on
      plot(ss(sel),kap(sel), '.b', 'MarkerSize',4); 
      plot(ss(~sel),kap(~sel), '.r', 'MarkerSize',12); 
      xlim([0 4/27]); ylim([0 1]);
      xlabel('supply stress, s_s')
      ylabel('frac of mobilised reserve to soma, \kappa')
      set(gca, 'FontSize', 15, 'Box', 'on')

      kap = linspace(0, 1, 100)';
      kapRA = (0:0.1:0.9)'; 
      for j=1:10
        ss = kap.^2 .*(1 - kapRA(j) - kap); if j==1; lw=2; else lw=1; end
        plot(ss, kap, 'color',color_lava(kapRA(j)), 'Linewidth', lw)
      end
      % kap(s_s) for which kapRA is max 
      ss = linspace(1e-8,4/27,500)'; kap = (2*ss).^(1/3); kapRA = 1 - kap - ss./kap.^2; 
      for j=0:10; plot(ss(kapRA>j/10), kap(kapRA>j/10), 'color',color_lava(j/10), 'Linewidth',2); end
      text(0.14, -0.06, '4/27', 'FontSize',15)
      text(0.15,  2/3+.02, '2/3', 'FontSize',15)

      %saveas(gca,'ss_kap_r.png')

    case 2 % ss_s_Hbp_r +- thinning
      sssH = read_allStat({'s_s','s_Hbp'}); s_s = sssH(:,1); s_Hbp = sssH(:,2); n = length(s_s);    
      [r, nm] = read_popStat('f1.thin1.f.r'); sel = ~isnan(r);
      
      figure
      hold on
      plot(s_s(sel),log10(s_Hbp(sel)), '.b', 'MarkerSize',4); 
      plot(s_s(~sel),log10(s_Hbp(~sel)), '.r', 'MarkerSize',4); 
      xlim([0 4/27]); 
      xlabel('supply stress, s_s')
      ylabel('precociality index, _{10}log s_H^{bp}')
      set(gca, 'FontSize', 15, 'Box', 'on')

      %saveas(gca,'ss_sHbp_r.png')

    case 3 % kapRA_s_Hbp_r +- thinning
      sskap = read_allStat({'s_s','kap'}); ss = sskap(:,1); kap = sskap(:,2); kapRA = 1 - kap - ss./kap.^2; n = length(kap);    
      [r, nm] = read_popStat('f1.thin1.f.r'); sel = ~isnan(r);
      
      figure
      hold on
      plot(ss(sel),kapRA(sel), '.b', 'MarkerSize',4); 
      plot(ss(~sel),kapRA(~sel), '.r', 'MarkerSize',6); 
      xlim([0 4/27]); 
      xlabel('supply stress, s_s')
      ylabel('frac assim to reprod, \kappa_R^A')
      set(gca, 'FontSize', 15, 'Box', 'on')
      text(0.14, -0.06, '4/27', 'FontSize',15)

      %saveas(gca,'ss_kapRA_r.png')

    case 4 % ss_Wwi 
      ssWwi = read_allStat({'s_s','Ww_i'}); ss = ssWwi(:,1); Wwi = ssWwi(:,2); n = length(Wwi);
      
      figure
      hold on
      plot(ss, log10(Wwi), '.b', 'MarkerSize',4); 
      xlabel('supply stress, s_s')
      ylabel('_{10}log ultimate weight, W_w^\infty, g')
      set(gca, 'FontSize', 15, 'Box', 'on')
      xlim([0 4/27]); 
      text(0.14, -11, '4/27', 'FontSize',15) 
      title([num2str(n) '\it  species @ ',datestr(datenum(date),'yyyy/mm/dd')], 'FontSize',15, 'FontWeight','normal'); 

      %saveas(gca,'ss_Wwi.png')
      
    case 5 % f_X
      
      figure
      hold on
      X = linspace(0,10,100)';
      
      K_s = 1; plot(X, X./(K_s+X),  'b', 'LineWidth',2); 
      K_d = 0.1; plot(X, X./(K_d+X), 'r', 'LineWidth',2); 
      
      plot([0.5; 6], [0.5/(K_s+0.5); 0.5/(K_s+0.5)], 'b', 'LineWidth',4);
      plot([0.5; 0.5], [0.5/(K_s+0.5); 6/(K_s+6)], 'b', 'LineWidth',4);
      plot([0;K_s],[0;1], 'b', [0;K_s],[0.5; 0.5], 'b', [K_s;K_s],[1; 0], 'b')
      
      plot([1; 4], [1/(K_d+1); 1/(K_d+1)], 'r', 'LineWidth',4);
      plot([1; 1], [1/(K_d + 1); 4/(K_d + 4)], 'r', 'LineWidth',4);
      plot([0;K_d],[0;1], 'r', [0;K_d],[0.5; 0.5], 'r',[K_d;K_d],[1; 0], 'r')
      
      xlabel('food density, mMol')
      ylabel('scaled functional response, -')
      text(8, 0.52, 'supply', 'color','blue', 'FontSize',15) 
      text(8, 0.6, 'demand', 'color','red', 'FontSize',15) 
      text(1.2, 0.05, 'K_s', 'color','blue', 'FontSize',15) 
      text(0.2, 0.05, 'K_d', 'color','red', 'FontSize',15) 
      set(gca, 'FontSize', 15, 'Box', 'on')

      saveas(gca,'X_f.png')

    case 6 % pyramid 
      % pars
%       p.kap = [0.90 0.8 0.75]; p.kapR = 0.95; p.g = [10 15 20]; p.kJ = 0.001; p.kM = 0.006; p.k = p.kJ/p.kM; p.v = 0.02; 
%       p.hp = 2e-3; p.hW = 2e-4; p.ss = [0.001 0.05 0.1]; p.vHb = [0.002 0.005 0.05]; p.vHp = p.ss./(p.kap.^2.*(1-p.kap)*p.k);
%       p.Lm = p.v./p.g/p.kM; p.LT = 0; p.X = 1; p.ome = 3;

      p.kap = [0.93 0.8 0.7]; p.kapR = 0.95; p.g = .3*[20 15 10]; p.kJ = 0.002; p.kM = 0.003; p.k = p.kJ/p.kM; p.v = 0.02; 
      p.hp = [2e-3 1e-3 0.5e-3]; p.hW = 2e-4; p.ss = [0.001 0.05 0.1]; p.vHb = [0.002 0.005 0.01]; p.vHp = p.ss./(p.kap.^2.*(1-p.kap)*p.k);
      p.Lm = p.v./p.g/p.kM; p.LT = 0; p.X = 1; p.ome = 3;

%       p.kap = [0.93 0.8 0.7]; p.kapR = 0.95; p.g = 5; p.kJ = 0.002; p.kM = 0.003; p.k = p.kJ/p.kM; p.v = 0.02; 
%       p.hp = [2e-3 1e-3 0.5e-3]; p.hW = 2e-4; p.ss = [0.001 0.05 0.1]; p.vHb = [0.002 0.005 0.01]; p.vHp = p.ss./(p.kap.^2.*(1-p.kap)*p.k);
%       p.Lm = p.v./p.g/p.kM; p.LT = 0; p.X = 1; p.ome = 3;

      [f, norm, info] = pyramid(p); if any(~info); fprintf('warning from pyramid: some f''s did not converge\n'); end
      K = p.X*(1-f)./f; % mMol, half sat coeff
      prt_tab({(1:3)', f, norm, info, K},{'level','f','norm','info','K, mMol'},'pyramid')
      
      [t, S] = sad(f,p);
    end
  end
end

function [f, fval, info] = pyramid(par)
  n = length(par.ss); % -, length of the pyramid 
  f = NaN(n,1); fval = NaN(n,1); info = false(n,1); opt = []; opt.tol_fun = 1e-6; % opt.tol_simplex = 1e-10; 
  
  for i=1:n % scan levels
    % overwrite par to reduce vectors to scalars
    p = par;flds=fields(p);for j=1:length(flds);if length(p.(flds{j}))>1;p.(flds{j})=p.(flds{j})(i);end;end
    
    % initialize range for f(i)
    f_0 = (p.ss/p.kap^2/(1-p.kap))^(1/3); % lower boundary for f(i)
    f_1 = 1;         % upper boundary for f(i)
     
    [f(i), fval(i), info(i)] = fsolve('pyr', (f_0+f_1)/2, opt, p);
  end
end
