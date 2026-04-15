function Kooy2026a_SI(fig)
% Supporting Information for Kooy2026a
% Title: DEB theory's equation of life
% Authors: Kooijman
% Journal: Ecol. Mod
% DOI: 
% Date: 2026/02/24
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
% To run the code for a figure: type in the Matlab window e.g. LikaAugu2025_SI(2)
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
   fig = 1:31;
end

      legend_moll = {...
        {'o', 8, 3, [0 0 1], [0 0 0]}, 'Lophophorata'; ...
        {'o', 8, 3, [0 0 1], [1 1 1]}, 'Annelida'; ...
        {'o', 8, 3, [1 0 0], [0 0 1]}, 'Bivalvia'; ...
        {'o', 8, 3, [1 0 0], [1 0 0]}, 'Gastropoda'; ....
        {'o', 8, 3, [1 0 0], [1 1 1]}, 'Cephalopoda'; ....
        {'.',16, 3, [0 0 1], [0 0 1]}, 'Spiralia'; ....
      };

      legend_crus = {...
        {'o', 8, 3, [0 0 1], [0 0 0]}, 'Branchiopoda'; ...
        {'o', 8, 3, [0 0 1], [1 1 1]}, 'Multicrustacea'; ...
        {'o', 8, 3, [1 0 0], [0 0 1]}, 'Oligostraca'; ...
      };

      legend_chon = {...
        {'o', 3, 3, [0 0 0], [0 0 0]}, 'Holocephali'; ...
        {'o', 8, 3, [0 0 1], [0 0 1]}, 'Heterodontiformes'; ....
        {'o', 8, 3, [0 0 1], [0 1 1]}, 'Orectolobiformes'; ....
        {'o', 8, 3, [0 0 1], [1 0 0]}, 'Carcharhiniformes'; ....
        {'o', 8, 3, [0 0 1], [1 1 1]}, 'Lamniformes'; ....
        {'o', 8, 3, [1 0 0], [0 0 0]}, 'Squatiniformes'; ....
        {'o', 8, 3, [1 0 0], [0 1 1]}, 'Pristiophoriformes'; ....
        {'o', 8, 3, [1 0 0], [1 0 0]}, 'Squaliformes'; ....
        {'o', 8, 3, [1 0 0], [1 1 1]}, 'Hexanchiformes'; ....
        {'o', 3, 3, [1 0 1], [0 0 0]}, 'Batoidea'; ...
      };

      legend_acti = { ... 
        {'o', 8, 3, [0 0 1], [0 0 0]}, 'Cladistii'; 
        {'o', 8, 3, [0 0 1], [0 0 1]}, 'Chondrostei'; 
        {'o', 8, 3, [0 0 1], [1 0 0]}, 'Holostei'; 
        {'o', 8, 3, [0 0 1], [1 1 1]}, 'Elopocephalai'; 
        {'o', 8, 3, [1 0 0], [0 0 0]}, 'Osteoglossocephala'; 
        {'o', 8, 3, [1 0 0], [1 0 0]}, 'Otomorpha'; 
        {'o', 8, 3, [1 0 0], [0 0 0]}, 'Euteleosteomorpha'; 
      };

      legend_amph = {...
        {'o', 8, 3, [0 0 0], [0 0 0]}, 'Gymnophiona'
        {'o', 8, 3, [0 0 1], [0 0 1]}, 'Cryptobranchoidea' % Caudata
        {'o', 8, 3, [0 0 1], [0 1 1]}, 'Salamandroidea'
        {'o', 8, 3, [0 0 1], [1 1 1]}, 'Sirenoidea'
        {'o', 8, 3, [1 0 0], [0 0 0]}, 'Archaeobatrachia' % Anura
        {'o', 8, 3, [1 0 0], [1 0 0]}, 'Mesobatrachia'
        {'o', 8, 3, [1 0 0], [1 1 1]}, 'Neobatrachia'
      };

      legend_rept = {...
        {'o', 8, 3, [0 0 0], [0 0 0]}, 'Rhynchocephalia'
        {'o', 8, 3, [0 0 1], [0 0 1]}, 'Gekkota' % Squamata
        {'o', 8, 3, [0 0 1], [1 1 1]}, 'Unidentata' % Squamata
        {'o', 8, 3, [1 0 0], [1 1 1]}, 'Testudines'
        {'o', 8, 3, [1 0 0], [1 0 0]}, 'Crocodilia'
      };
  
      legend_aves = {...
        %{'o', 8, 3, [0 0 0], [0 0 0]}, 'Crocodilia'
        {'o', 8, 3, [0 0 1], [0 0 1]}, 'Paleognathae'
        {'o', 8, 3, [0 0 1], [1 1 1]}, 'Galloanserae'
        % Neoaves: edge magenta and red
        {'o', 8, 3, [1 0 1], [0 0 0]}, 'Mirandornithes'
        {'o', 8, 3, [1 0 1], [0 1 0]}, 'Gruimorphae'
        {'o', 8, 3, [1 0 1], [1 0 1]}, 'Opisthocomiformes'
        {'o', 8, 3, [1 0 1], [0 0 1]}, 'Strisores'
        {'o', 8, 3, [1 0 1], [1 1 1]}, 'Columbea'
        % Passerea: edge red
        {'o', 8, 3, [1 0 0], [0 0 0]}, 'Elementaves'
        {'o', 8, 3, [1 0 0], [1 0 0]}, 'Afroaves'
        {'o', 8, 3, [1 0 0], [1 1 1]}, 'Australaves'
      };

      legend_mamm = {...
        {'o', 8, 3, [0 0 0], [0 0 0]}, 'Prototheria'; ...
        {'o', 8, 3, [0 0 0], [1 1 1]}, 'Marsupialia'; ...
        {'o', 8, 3, [0 0 1], [0 0 1]}, 'Xenarthra'; ...
        {'o', 8, 3, [0 0 1], [1 0 0]}, 'Afrotheria'; ....
        {'o', 8, 3, [0 0 1], [1 1 1]}, 'Laurasiatheria'; ....
        {'o', 8, 3, [1 0 1], [1 0 1]}, 'Glires'; ....
        {'o', 8, 3, [1 0 1], [1 1 1]}, 'Scandentia'; ....
        {'o', 8, 3, [1 0 0], [1 0 0]}, 'Dermoptera'; ....
        {'o', 8, 3, [1 0 0], [1 1 1]}, 'Primates'; ....
      };

 close all
 shstat_options('default');
 shstat_options('y_label', 'on'); 
 shstat_options('x_label', 'off'); 
  
for i=1:length(fig)
 
  switch fig(i)
      
    case 1 % Fig 1: ss_kap_kap_RA
      sskap = read_allStat({'s_s','kap',}); ss = sskap(:,1); kap = sskap(:,2); kapRA = 1 - kap - ss./kap.^2; n = length(kap);    

      close all
      figure
      hold on
      for j=1:n; plot(ss(j),kap(j), '.', 'MarkerSize',4, 'Color',color_lava(kapRA(j))); end
      xlim([0 4/27]); ylim([0 1]);
      xlabel('supply stress, s_s')
      ylabel('frac of mobilised reserve to soma, \kappa')
      set(gca, 'FontSize', 15, 'Box', 'on')

      kap = linspace(0, 1, 100)';
      kapRA = (0:0.1:0.9)'; 
      for j=1:10
        ss = kap.^2 .*(1 - kapRA(j) - kap); if j==1; lw=2; else lw=1; end
        plot(ss, kap, 'color', color_lava(kapRA(j)), 'Linewidth', lw)
      end
      % kap(s_s) for which kapRA is max 
      ss = linspace(1e-8,4/27,500)'; kap = (2*ss).^(1/3); kapRA = 1 - kap - ss./kap.^2; 
      for j=0:10; plot(ss(kapRA>j/10), kap(kapRA>j/10), 'color',color_lava(j/10), 'Linewidth',2); end
      kap = (2*ss).^(1/3)/0.2; kapRA = 1-kap-ss./kap.^2;
      for j=0:10; sel=kapRA>j/10; plot(ss(sel), kap(sel), 'color',color_lava(j/10), 'Linewidth',0.1); end
      kap = (2*ss).^(1/3)/0.4; kapRA = 1-kap-ss./kap.^2;
      for j=0:10; sel=kapRA>j/10; plot(ss(sel), kap(sel), 'color',color_lava(j/10), 'Linewidth',0.1); end
      kap = (2*ss).^(1/3)/0.6; kapRA = 1-kap-ss./kap.^2;
      for j=0:10; sel=kapRA>j/10; plot(ss(sel), kap(sel), 'color',color_lava(j/10), 'Linewidth',0.1); end
      kap = (2*ss).^(1/3)/0.8; kapRA = 1-kap-ss./kap.^2;
      for j=0:10; sel=kapRA>j/10; plot(ss(sel), kap(sel), 'color',color_lava(j/10), 'Linewidth',0.1); end
      kap = (2*ss).^(1/3)/1.2; kapRA = 1-kap-ss./kap.^2;
      for j=0:10; sel=kapRA>j/10; plot(ss(sel), kap(sel), 'color',color_lava(j/10), 'Linewidth',0.1); end
      kap = (2*ss).^(1/3)/1.4; kapRA = 1-kap-ss./kap.^2; 
      for j=0:10; sel=kapRA>j/10; plot(ss(sel), kap(sel), 'color',color_lava(j/10), 'Linewidth',0.1); end
      kap = (2*ss).^(1/3)/1.6; kapRA = 1-kap-ss./kap.^2; 
      for j=0:10; sel=kapRA>j/10; plot(ss(sel), kap(sel), 'color',color_lava(j/10), 'Linewidth',0.1); end
      kap = (2*ss).^(1/3)/1.8; kapRA = 1-kap-ss./kap.^2;
      for j=0:10; sel=kapRA>j/10; plot(ss(sel), kap(sel), 'color',color_lava(j/10), 'Linewidth',0.1); end
      kap = (2*ss).^(1/3)/2.0; kapRA = 1-kap-ss./kap.^2; 
      for j=0:10; sel=kapRA>j/10; plot(ss(sel), kap(sel), 'color',color_lava(j/10), 'Linewidth',0.1); end
      kap = (2*ss).^(1/3)/2.2; kapRA = 1-kap-ss./kap.^2;
      for j=0:10; sel=kapRA>j/10; plot(ss(sel), kap(sel), 'color',color_lava(j/10), 'Linewidth',0.1); end
      text(0.14, -0.06, '4/27', 'FontSize',15)
      text(0.15,  2/3+.02, '2/3', 'FontSize',15)
      text(0.148, 0.621, '\kappa_R^A=0',   'FontSize',8, 'color',color_lava(0))
      text(0.109, 0.566, '\kappa_R^A=0.1', 'FontSize',8, 'color',color_lava(0.1))
      text(0.078, 0.512, '\kappa_R^A=0.2', 'FontSize',8, 'color',color_lava(0.2))
      text(0.053, 0.447, '\kappa_R^A=0.3', 'FontSize',8, 'color',color_lava(0.3))
      text(0.033, 0.374, '\kappa_R^A=0.4', 'FontSize',8, 'color',color_lava(0.4))
      text(0.020, 0.313, '\kappa_R^A=0.5', 'FontSize',8, 'color',color_lava(0.5))
      %saveas(gca,'ss_kap_kapRA.png')

    case 2 % Fig 1: ss_kap_fmin
      sskap = read_allStat({'s_s','kap',}); ss = sskap(:,1); kap = sskap(:,2); fmin = (ss./kap.^2./(1-kap)).^(1/3); n = length(kap);    

      close all
      figure
      hold on
      for j=1:n; plot(ss(j),kap(j), '.', 'MarkerSize',4, 'Color',color_lava(fmin(j))); end
      xlim([0 4/27]); ylim([0 1]);
      xlabel('supply stress, s_s')
      ylabel('frac of mobilised reserve to soma, \kappa')
      set(gca, 'FontSize', 15, 'Box', 'on')

      kap = linspace(0, 1, 100)';
      plot(kap.^2.*(1 - kap),kap, 'color',[0 0 0], 'LineWidth',2)
      fMin = (0:0.1:0.9)'; n=length(fMin);
      for j=1:n
        ss = kap.^2 .*(1 - kap).*fMin(j)^3; 
        plot(ss,kap, 'color',color_lava(fMin(j)), 'LineWidth',1)
      end
      % kap(s_s) for which fmin is max 
      fMin = (0:0.01:0.99)'; n=length(fMin);
      ss = linspace(1e-8,4/27,500)'; kap = 2/3*ones(500,1); fmin = (ss./kap.^2./(1 - kap)).^(1/3); 
      for j=1:n; plot(ss(fmin>fMin(j)), kap(fmin>fMin(j)), 'color',color_lava(fMin(j)), 'Linewidth',2); end
      
      text(0.14, -0.06, '4/27', 'FontSize',15)
      text(0.15,  2/3+.02, '2/3', 'FontSize',15)
      text(0.149, 0.621, 'f_{min}=1', 'FontSize',8, 'color',color_lava(0))
      text(0.108, 0.621, 'f_{min}=0.9', 'FontSize',8, 'color',color_lava(0.9))
      text(0.076, 0.621, 'f_{min}=0.8', 'FontSize',8, 'color',color_lava(0.8))
      text(0.051, 0.621, 'f_{min}=0.7', 'FontSize',8, 'color',color_lava(0.7))
      text(0.032, 0.621, 'f_{min}=0.6', 'FontSize',8, 'color',color_lava(0.6))

      %saveas(gca,'ss_kap_fmin.png')
 
     case 3 % Fig 3: kapRA_Ni
      data = read_allStat({'N_i','Ww_b','Ww_i','kap','s_s'});
      N_i = data(:,1); Ww_b = data(:,2); Ww_i = data(:,3); kap = data(:,4); s_s = data(:,5); 
      kap_RA = 1 - kap - s_s./kap.^2; NWW = N_i.*Ww_b./Ww_i;

      shstat_options('default');
 
      shlegend(legend_moll, [0.7 0.2], [0.8 0.2]);
      %saveas(gca,'legend_moll.png'); cropWhite('legend_moll');
      Hfig_kapRANi_moll = shstat([kap_RA, NWW], legend_moll); 
      figure(Hfig_kapRANi_moll)
      plot([-6;0],[-5.5;0.5], 'k', 'Linewidth',2) % slope 1
      xlabel('_{10}log frac of assim to reprod \kappa_R^A, -')
      ylabel('_{10}log spec cum neonate mass prod, #')
      title(['\it lophotrochozoa @ ',datestr(datenum(date),'yyyy/mm/dd')], 'FontSize',15, 'FontWeight','normal'); 
      %saveas(gcf,'kapRA_Ni_moll.png')

      shlegend(legend_crus, [0.7 0.2], [0.8 0.2]);
      %saveas(gca,'legend_crus.png'); cropWhite('legend_crus');
      Hfig_kapRANi_crus = shstat([kap_RA, NWW], legend_crus); 
      figure(Hfig_kapRANi_crus)
      plot([-4;0],[-3;1], 'k', 'Linewidth',2) % slope 1
      xlabel('_{10}log frac of assim to reprod \kappa_R^A, -')
      ylabel('_{10}log spec cum neonate mass prod, #')
      title(['\it crustacea @ ',datestr(datenum(date),'yyyy/mm/dd')], 'FontSize',15, 'FontWeight','normal'); 
      %saveas(gcf,'kapRA_Ni_crus.png')

      shlegend(legend_chon, [0.7 0.2], [0.8 0.2]);
      %saveas(gca,'legend_chon.png'); cropWhite('legend_chon');
      Hfig_kapRANi_chon = shstat([kap_RA, NWW], legend_chon); 
      figure(Hfig_kapRANi_chon)
      plot([-2.5;0],[-1.8;0.7], 'k', 'Linewidth',2) % slope 1
      xlabel('_{10}log frac of assim to reprod \kappa_R^A, -')
      ylabel('_{10}log spec cum neonate mass prod, #')
      title(['\it chondrichthyes @ ',datestr(datenum(date),'yyyy/mm/dd')], 'FontSize',15, 'FontWeight','normal'); 
      %saveas(gcf,'kapRA_Ni_chon.png')
       
      shlegend(legend_acti, [0.7 0.2], [0.8 0.2]);
      %saveas(gca,'legend_acti.png'); cropWhite('legend_acti');
      Hfig_kapRANi_acti = shstat([kap_RA, NWW], legend_acti); 
      figure(Hfig_kapRANi_acti); cropWhite('legend_acti');
      plot([-4;0],[-3.8;0.2], 'k', 'Linewidth',2) % slope 1
      xlabel('_{10}log frac of assim to reprod \kappa_R^A, -')
      ylabel('_{10}log spec cum neonate mass prod, #')
      title(['\it actinopterygii @ ',datestr(datenum(date),'yyyy/mm/dd')], 'FontSize',15, 'FontWeight','normal'); 
      %saveas(gcf,'kapRA_Ni_acti.png')

      shlegend(legend_amph, [0.7 0.2], [0.8 0.2]);
      %saveas(gca,'legend_amph.png'); cropWhite('legend_amph');
      Hfig_kapRANi_amph = shstat([kap_RA, NWW], legend_amph); 
      figure(Hfig_kapRANi_amph)
      plot([-4;0],[-2.8;1.2], 'k', 'Linewidth',2) % slope 1
      xlabel('_{10}log frac of assim to reprod \kappa_R^A, -')
      ylabel('_{10}log spec cum neonate mass prod, #')
      title(['\it amphibia @ ',datestr(datenum(date),'yyyy/mm/dd')], 'FontSize',15, 'FontWeight','normal'); 
      %saveas(gcf,'kapRA_Ni_amph.png')

      shlegend(legend_rept, [0.7 0.2], [0.8 0.2]);
      %saveas(gca,'legend_rept.png'); cropWhite('legend_rept');
      Hfig_kapRANi_rept = shstat([kap_RA, NWW], legend_rept); 
      figure(Hfig_kapRANi_rept)
      plot([-3.3;0],[-2;1.3], 'k', 'Linewidth',2) % slope 1
      xlabel('_{10}log frac of assim to reprod \kappa_R^A, -')
      ylabel('_{10}log cum spec neonate mass prod, #')
      title(['\it reptilia @ ',datestr(datenum(date),'yyyy/mm/dd')], 'FontSize',15, 'FontWeight','normal'); 
      %saveas(gcf,'kapRA_Ni_rept.png')

      shlegend(legend_aves, [0.7 0.2], [0.8 0.2]);
      %saveas(gca,'legend_aves.png'); cropWhite('legend_aves');
      Hfig_kapRANi_aves = shstat([kap_RA, NWW], legend_aves); 
      figure(Hfig_kapRANi_aves)
      plot([-3.5;0],[-1;2.5], 'k', 'Linewidth',2) % slope 1
      xlabel('_{10}log frac of assim to reprod \kappa_R^A, -')
      ylabel('_{10}log spec cum neonate mass prod, #')
      title(['\it aves @ ',datestr(datenum(date),'yyyy/mm/dd')], 'FontSize',15, 'FontWeight','normal'); 
      %saveas(gcf,'kapRA_Ni_aves.png')

      shlegend(legend_mamm, [0.7 0.2], [0.8 0.2]);
      %saveas(gca,'legend_mamm.png'); cropWhite('legend_mamm');
      Hfig_kapRANi_mamm = shstat([kap_RA, NWW], legend_mamm); 
      figure(Hfig_kapRANi_mamm)
      plot([-5.8;-0.3],[-4;1.5], 'k', 'Linewidth',2) % slope 1
      xlabel('_{10}log frac of assim to reprod \kappa_R^A, -')
      ylabel('_{10}log spec cum neonate mass prod, #')
      title(['\it mammalia @ ',datestr(datenum(date),'yyyy/mm/dd')], 'FontSize',15, 'FontWeight','normal'); 
      %saveas(gcf,'kapRA_Ni_mamm.png')

    case 4 % Fig 4: Wwi_sHbp
      shstat_options('default');
      shstat_options('x_transform','none');
      
      data = read_allStat({'s_s','Ww_b','Ww_p','Ww_i','s_Hbp'});
      s_s = data(:,1); Ww_bi = data(:,2)./data(:,4); Ww_bp = data(:,2)./data(:,3); s_Hbp = data(:,4); 
      
      Hfig_ssWbi = shstat([s_s,Ww_bi], legend_mamm); 
      figure(Hfig_ssWbi)
      xlabel('supply stress, s_s, -')
      ylabel('_{10}log rel weight at birth, W_w^b/W_w^\infty, -')
      title(['\it mammalia @ ',datestr(datenum(date),'yyyy/mm/dd')], 'FontSize',15, 'FontWeight','normal'); 
      %saveas(gcf,'ss_Wbi_mamm.png')
 
      Hfig_sssHbp = shstat([s_s,s_Hbp], legend_mamm); 
      figure(Hfig_sssHbp)
      xlabel('supply stress, s_s, -')
      ylabel('_{10}log procociality coeff s_H^{bp}, -')
      title(['\it mammalia @ ',datestr(datenum(date),'yyyy/mm/dd')], 'FontSize',15, 'FontWeight','normal'); 
      %saveas(gcf,'ss_sHbp_mamm.png')

      shstat_options('x_transform','log10');
      Hfig_WbisHbp = shstat([Ww_bi,s_Hbp], legend_mamm); 
      figure(Hfig_WbisHbp)
      plot([-6;0],[-7;-1], 'k', 'Linewidth',2)
      xlabel('_{10}log rel weight at birth, W_w^b/W_w^\infty, -')
      ylabel('_{10}log procociality coeff s_H^{bp}, -')
      title(['\it mammalia @ ',datestr(datenum(date),'yyyy/mm/dd')], 'FontSize',15, 'FontWeight','normal'); 
      %saveas(gcf,'Wbi_sHbp_mamm.png')
      
      Hfig_WbisHbp = shstat([Ww_bi,s_Hbp], legend_aves); 
      figure(Hfig_WbisHbp)
      plot([-2.5;0],[-3;-0.5], 'k', 'Linewidth',2)
      xlabel('_{10}log rel weight at birth, W_w^b/W_w^\infty, -')
      ylabel('_{10}log procociality coeff s_H^{bp}, -')
      title(['\it aves @ ',datestr(datenum(date),'yyyy/mm/dd')], 'FontSize',15, 'FontWeight','normal'); 
      %saveas(gcf,'Wbi_sHbp_aves.png')

      Hfig_WbpsHbp = shstat([Ww_bp,s_Hbp], legend_mamm); 
      figure(Hfig_WbpsHbp)
      plot([-6;0],[-7;-1], 'k', 'Linewidth',2)
      xlabel('_{10}log rel weight at birth, W_w^b/W_w^p, -')
      ylabel('_{10}log procociality coeff s_H^{bp}, -')
      title(['\it mammalia @ ',datestr(datenum(date),'yyyy/mm/dd')], 'FontSize',15, 'FontWeight','normal'); 
      %saveas(gcf,'Wbp_sHbp_mamm.png')
      
      Hfig_WbpsHbp = shstat([Ww_bp,s_Hbp], legend_aves); 
      figure(Hfig_WbpsHbp)
      plot([-2.5;0],[-3;-0.5], 'k', 'Linewidth',2)
      xlabel('_{10}log rel weight at birth, W_w^b/W_w^p, -')
      ylabel('_{10}log procociality coeff s_H^{bp}, -')
      title(['\it aves @ ',datestr(datenum(date),'yyyy/mm/dd')], 'FontSize',15, 'FontWeight','normal'); 
      %saveas(gcf,'Wbp_sHbp_aves.png')

    case 5 % Fig 5: kapRA_sHbp
       
     shstat_options('default');

     data = read_allStat('s_s','s_Hbp','kap');
     s_s = data(:,1); s_Hbp = data(:,2); kap = data(:,3); kap_RA = 1 - kap - s_s./kap.^2;

     % lophotrochozoa
     Hfig_kapRA_sHbp_moll = shstat([kap_RA,s_Hbp], legend_moll);
     figure(Hfig_kapRA_sHbp_moll)
     hold on
     plot([-5.5;0],[-9;-3.5], 'k', 'LineWidth',2)
     xlabel('_{10}log frac of assim to reprod \kappa_R^A, -')
     ylabel('_{10}log precociality coeff s_H^{bp}, -')
     title(['\it lophotrochozoa @ ',datestr(datenum(date),'yyyy/mm/dd')], 'FontSize',15, 'FontWeight','normal'); 
     set(gca, 'FontSize', 15, 'Box', 'on')
     %saveas(gca,'kapRA_sHbp_moll.png')

     % custacea
     Hfig_kapRA_sHbp_crus = shstat([kap_RA,s_Hbp], legend_crus);
     figure(Hfig_kapRA_sHbp_crus)
     hold on
     plot([-4.1;0],[-6;-2.1], 'k', 'LineWidth',2)
     xlabel('_{10}log frac of assim to reprod \kappa_R^A, -')
     ylabel('_{10}log precociality coeff s_H^{bp}, -')
     title(['\it crustacea @ ',datestr(datenum(date),'yyyy/mm/dd')], 'FontSize',15, 'FontWeight','normal'); 
     set(gca, 'FontSize', 15, 'Box', 'on')
     %saveas(gca,'kapRA_sHbp_crus.png')
     
     % chondrichthyes
     Hfig_kapRA_sHbp_chon = shstat([kap_RA,s_Hbp], legend_chon);
     figure(Hfig_kapRA_sHbp_chon)
     hold on
     plot([-2.2;0],[-3;-0.8], 'k', 'LineWidth',2)
     xlabel('_{10}log frac of assim to reprod \kappa_R^A, -')
     ylabel('_{10}log precociality coeff s_H^{bp}, -')
     title(['\it chondrichthyes @ ',datestr(datenum(date),'yyyy/mm/dd')], 'FontSize',15, 'FontWeight','normal'); 
     set(gca, 'FontSize', 15, 'Box', 'on')
     %saveas(gca,'kapRA_sHbp_chon.png')

     % actinopterygii
     Hfig_kapRA_sHbp_acti = shstat([kap_RA,s_Hbp], legend_acti);
     figure(Hfig_kapRA_sHbp_acti)
     hold on
     plot([-4;0],[-7;-3], 'k', 'LineWidth',2) % slope in not 1 !!!
     xlabel('_{10}log frac of assim to reprod \kappa_R^A, -')
     ylabel('_{10}log precociality coeff s_H^{bp}, -')
     title(['\it actinopterygii @ ',datestr(datenum(date),'yyyy/mm/dd')], 'FontSize',15, 'FontWeight','normal'); 
     set(gca, 'FontSize', 15, 'Box', 'on')
     %saveas(gca,'kapRA_sHbp_acti.png')

     % amphibia
     Hfig_kapRA_sHbp_amph = shstat([kap_RA,s_Hbp], legend_amph);
     figure(Hfig_kapRA_sHbp_amph)
     hold on
     plot([-4;0],[-6;-2], 'k', 'LineWidth',2)
     xlabel('_{10}log frac of assim to reprod \kappa_R^A, -')
     ylabel('_{10}log precociality coeff s_H^{bp}, -')
     title(['\it amphibia @ ',datestr(datenum(date),'yyyy/mm/dd')], 'FontSize',15, 'FontWeight','normal'); 
     set(gca, 'FontSize', 15, 'Box', 'on')
     %saveas(gca,'kapRA_sHbp_amph.png')

     % reptilia
     Hfig_kapRA_sHbp_rept = shstat([kap_RA,s_Hbp], legend_rept);
     figure(Hfig_kapRA_sHbp_rept)
     hold on
     plot([-3.2;0],[-4;-0.8], 'k', 'LineWidth',2)
     xlabel('_{10}log frac of assim to reprod \kappa_R^A, -')
     ylabel('_{10}log precociality coeff s_H^{bp}, -')
     title(['\it reptilia @ ',datestr(datenum(date),'yyyy/mm/dd')], 'FontSize',15, 'FontWeight','normal'); 
     set(gca, 'FontSize', 15, 'Box', 'on')
     %saveas(gca,'kapRA_sHbp_rept.png')

     % aves
     Hfig_kapRA_sHbp_aves = shstat([kap_RA,s_Hbp], legend_aves);
     figure(Hfig_kapRA_sHbp_aves)
     hold on
     plot([-3.5;0],[-3;0.5], 'k', 'LineWidth',2)
     xlabel('_{10}log frac of assim to reprod \kappa_R^A, -')
     ylabel('_{10}log precociality coeff s_H^{bp}, -')
     title(['\it aves @ ',datestr(datenum(date),'yyyy/mm/dd')], 'FontSize',15, 'FontWeight','normal'); 
     set(gca, 'FontSize', 15, 'Box', 'on')
     %saveas(gca,'kapRA_sHbp_aves.png')

     % mammalia
     Hfig_kapRA_sHbp_mamm = shstat([kap_RA,s_Hbp], legend_mamm);
     figure(Hfig_kapRA_sHbp_mamm)
     hold on
     plot([-6;0],[-6.5;-0.5], 'k', 'LineWidth',2)
     xlabel('_{10}log frac of assim to reprod \kappa_R^A, -')
     ylabel('_{10}log precociality coeff s_H^{bp}, -')
     title(['\it mammalia @ ',datestr(datenum(date),'yyyy/mm/dd')], 'FontSize',15, 'FontWeight','normal'); 
     set(gca, 'FontSize', 15, 'Box', 'on')
     %saveas(gca,'kapRA_sHbp_mamm.png')
     
   case 6
      data = read_allStat({'N_i','Ww_b','Ww_i','a_m'});
      N_i = data(:,1); Ww_b = data(:,2); Ww_i = data(:,3); a_m = data(:,4); 

      shstat_options('default');
      Hfig_WwiNi_mamm = shstat([Ww_i, N_i.*Ww_b./Ww_i], legend_mamm); 
      figure(Hfig_WwiNi_mamm)
      xlabel('_{10}log ultimate weight, W_w^\infty, g')
      ylabel('_{10}log spec neonate mass prod, N_\infty W_w^b/ W_w^\infty, -')
      title(['\it mamm @ ',datestr(datenum(date),'yyyy/mm/dd')], 'FontSize',15, 'FontWeight','normal'); 
      %saveas(gcf,'Wwi_NiWbi_mamm.png')

      Hfig_amNi_mamm = shstat([a_m, N_i.*Ww_b./Ww_i], legend_mamm); 
      figure(Hfig_amNi_mamm)
      xlabel('_{10}log life span, d')
      ylabel('_{10}log spec neonate mass prod, N_\infty W_w^b/ W_w^\infty, -')
      title(['\it mamm @ ',datestr(datenum(date),'yyyy/mm/dd')], 'FontSize',15, 'FontWeight','normal'); 
      %saveas(gcf,'am_NiWbi_mamm.png')

      Hfig_WwiNi_aves = shstat([Ww_i, N_i.*Ww_b./Ww_i], legend_aves); 
      figure(Hfig_WwiNi_aves)
      xlabel('_{10}log ultimate weight, W_w^\infty, g')
      ylabel('_{10}log spec neonate mass prod, N_\infty W_w^b/ W_w^\infty, -')
      title(['\it aves @ ',datestr(datenum(date),'yyyy/mm/dd')], 'FontSize',15, 'FontWeight','normal'); 
      %saveas(gcf,'Wwi_NiWbi_aves.png')

      Hfig_WwiNi_moll = shstat([Ww_i, N_i.*Ww_b./Ww_i], legend_moll); 
      figure(Hfig_WwiNi_moll)
      xlabel('_{10}log ultimate weight, W_w^\infty, g')
      ylabel('_{10}log spec neonate mass prod, N_\infty W_w^b/ W_w^\infty, -')
      title(['\it mollusca @ ',datestr(datenum(date),'yyyy/mm/dd')], 'FontSize',15, 'FontWeight','normal'); 
      %saveas(gcf,'Wwi_NiWbi_moll.png')
      
    case 7
      data = read_allStat({'kap','s_s'});
      kap = data(:,1); s_s = data(:,2); 
      kap_RA = 1 - kap - s_s./kap.^2; 

      surv_kap_RA = surv(kap_RA); 
      kap_RA_med = median(kap_RA); kap_RA_min = min(kap_RA); kap_RA_max = max(kap_RA); 
      kapRA = linspace(kap_RA_min,kap_RA_max,500)'; 
      %AB = wblfit(kap_RA, 0.05); % gives MLEs and 100(1-ALPHA)% CI
      AB = wblML(kap_RA); % gives MLEs
      A = AB(1); B = AB(2);
      fprintf(['Pars Weibull for kap_RA: ', num2str(A), ' - ', num2str(B), '\n'])
      %[M, V] = wblstat(A,B); S = 1-wblcdf(PA, A, B);
      [M, V] = wblStat(A,B); S = exp(-(kapRA/A).^B);
      fprintf(['mean & var: ', num2str(M), ' , ', num2str(V),'\n'])
      plot(surv_kap_RA(:,1), surv_kap_RA(:,2), '-', 'color', [0.75 0.75 1], 'linewidth',8)
      set(gca, 'FontSize', 15, 'Box', 'on', 'YTick', 0:0.2:1)
       
      hold on
      plot([log10(pA_min); log10(pA_med); log10(pA_med)], [0.5;0.5;0], 'r', log10(surv_pA(:,1)), surv_pA(:,2), 'b', 'Linewidth', 2)
      xlabel('_{10}log max assimilation p_A^\infty, J/d') 
      ylabel('survivor function')
      %saveas(gca,'pAi.png')

end
end

