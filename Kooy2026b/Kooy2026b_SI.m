function Kooy2026b_SI(fig)
% Supporting Information for Kooy2026b
% Title: Evolution favours over-exploitation avoidance, not fitness maximization
% Authors: Kooijman
% Journal: Theor. Ecol.
% DOI: 
% Date: 2026/08/17
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
      case 1 % fig kap
        figure % kappa
        kap = read_allStat('kap'); n = length(kap);
        kap_med = median(kap); kap_min = min(kap);  m = mean(kap); v = mean(kap.^2) - m^2;
        surv_kap = surv(kap); 
        a = m*(m*(1-m)/v-1); b = a*(1-m)/m;
        fprintf(['pars beta for kap: ', num2str(a), ' , ', num2str(b),'\n'])
        fprintf(['mean and variance for kap: ', num2str(m), ' , ', num2str(v),'\n'])
        
        AB = betaML(kap); % gives MLEs 
        A =AB(1); B = AB(2);
        fprintf(['ML est for scale, shape pars of beta distr for kap: ', num2str(A), ' , ', num2str(B),'\n'])
        [M, V] = betaStat(A,B); 
        fprintf(['mean & var of beta distr: ', num2str(M), ' , ', num2str(V),'\n'])
        
        kap =linspace(0,1,100);  S = 1 - betainc(kap,a,b);  
        plot(kap, S, '-', 'color', [0.75 0.75 1], 'linewidth',8)
        set(gca, 'FontSize', 15, 'Box', 'on', 'YTick', 0:0.2:1)
        
        hold on
        plot([0; kap_med; kap_med], [0.5;0.5;0], 'r', surv_kap(:,1), surv_kap(:,2), 'b', 'Linewidth', 2)
        xlabel('frac of mobilized reserve to soma, \kappa, -') 
        ylabel('survivor function')
        title([num2str(n), '\it animal species @ ',datestr(datenum(date),'yyyy/mm/dd')], 'FontSize',15, 'FontWeight','normal'); 
        saveas(gca,'kap.png')

      case 2 % fig kapRA
        figure % kappaRA
        data = read_allStat('kap','s_s');
        kap = data(:,1); s_s = data(:,2); kap_RA = 1 - kap - s_s./kap.^2; n = length(kap);

        kapRA_med = median(kap_RA); kapRA_min = min(kap_RA);  m = mean(kap_RA); v = mean(kap_RA.^2) - m^2;
        surv_kapRA = surv(kap_RA); 
        a = m*(m*(1-m)/v-1); b = a*(1-m)/m;
        fprintf(['pars beta for kap_RA: ', num2str(a), ' , ', num2str(b),'\n'])
        fprintf(['mean and variance for kap_RA: ', num2str(m), ' , ', num2str(v),'\n'])
        
        AB = betaML(kap_RA); % gives MLEs 
        A =AB(1); B = AB(2);
        fprintf(['ML est for scale, shape pars of beta distr for kap_RA: ', num2str(A), ' , ', num2str(B),'\n'])
        [M, V] = betaStat(A,B); 
        fprintf(['mean & var of beta distr: ', num2str(M), ' , ', num2str(V),'\n'])
        
        kapRA =linspace(0,1,100);  S = 1 - betainc(kapRA,a,b);  
        plot(kapRA, S, '-', 'color', [0.75 0.75 1], 'linewidth',8)
        set(gca, 'FontSize', 15, 'Box', 'on', 'YTick', 0:0.2:1)
        
        hold on
        plot([0; kapRA_med; kapRA_med], [0.5;0.5;0], 'r', surv_kapRA(:,1), surv_kapRA(:,2), 'b', 'Linewidth', 2)
        xlabel('frac of assimilation to reproduction, \kappa_R^A, -') 
        ylabel('survivor function')
        title([num2str(n), '\it animal species @ ',datestr(datenum(date),'yyyy/mm/dd')], 'FontSize',15, 'FontWeight','normal'); 
        saveas(gca,'kapRA.png')

      case 3 % s_s
        figure 
        ss = read_allStat('s_s'); ss_max = 4/27; n = length(ss);
        ss_med = median(ss); ss_min = min(ss);  m = mean(ss); v = mean(ss.^2) - mean(ss)^2;
        surv_ss = surv(ss); 
        M = m/ss_max; V = v/ss_max^2; 
        a = M*(M*(1-M)/V-1); b = a*(1-M)/M;
        fprintf(['pars beta for s_s: ', num2str(a), ' , ', num2str(b),'\n'])
        ss =linspace(0,1,100)'; S = 1 - betainc(ss,a,b);
        plot(ss*ss_max, S, '-', 'color', [0.75 0.75 1], 'linewidth',8)
        set(gca, 'FontSize', 15, 'Box', 'on', 'YTick', 0:0.2:1)
       
        hold on
        plot([ss_min; ss_med; ss_med], [0.5;0.5;0], 'r', surv_ss(:,1), surv_ss(:,2), 'b', 'Linewidth', 2)
        xlabel('supply stress s_s, -') 
        ylabel('survivor function')
        title([num2str(n), '\it animal species @ ',datestr(datenum(date),'yyyy/mm/dd')], 'FontSize',15, 'FontWeight','normal'); 
        saveas(gca,'ss.png')
           
      case 4 % f_min
        figure 
        sskap = read_allStat({'s_s','kap',}); ss = sskap(:,1); kap = sskap(:,2); fmin = (ss./kap.^2./(1-kap)).^(1/3); n = length(kap);    
        fmin_med = median(fmin); fmin_min = min(fmin);  fmin_max = 1; m = mean(fmin); v = mean(fmin.^2) - mean(fmin)^2;
        surv_fmin = surv(fmin); 
        a = m*(m*(1-m)/v-1); b = a*(1-m)/m;
        fprintf(['pars beta for fmin: ', num2str(a), ' , ', num2str(b),'\n'])
        fprintf(['mean and variance for fmin: ', num2str(m), ' , ', num2str(v),'\n'])
        fmin =linspace(0,1,100)'; S = 1 - betainc(fmin,a,b);
        set(gca, 'FontSize', 15, 'Box', 'on', 'YTick', 0:0.2:1)
       
        hold on
        plot([fmin_min; fmin_med; fmin_med], [0.5;0.5;0], 'r', surv_fmin(:,1), surv_fmin(:,2), 'b', 'Linewidth', 2)
        xlabel('f_{min}, -') 
        ylabel('survivor function')
        title([num2str(n), '\it animal species @ ',datestr(datenum(date),'yyyy/mm/dd')], 'FontSize',15, 'FontWeight','normal'); 
        %saveas(gca,'fmin.png')

      case 5 % kap_ss_fmin & kap_ss_kapRA for invertebrates and vertebrates
        prt_patterns(7:10,'')

    end
  end
end

