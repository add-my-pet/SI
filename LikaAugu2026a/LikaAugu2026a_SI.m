function LikaAugu2026a_SI(fig)
% Supporting Information for LikaAugu2026a
% Title: DEB theory's equation of life
% Authors: Lika, Augustine, Kooijman
% Journal: Ecol. Mod
% DOI: 
% Date: 2026/02/22
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
      
    case 1 
      shstat_options('default');
      shstat_options('x_transform','none');
      
      data = read_allStat({'s_s','Ww_b','Ww_p','Ww_i','E_Hb','E_Hp'});
      s_s = data(:,1); Ww_bi = data(:,2)./data(:,4); Ww_bp = data(:,2)./data(:,3); s_Hbp = data(:,5)./data(:,6); 
      
%       Hfig_ssWbi = shstat([s_s,Ww_bi], legend_mamm); 
%       figure(Hfig_ssWbi)
%       xlabel('supply stress, s_s, -')
%       ylabel('_{10}log rel weight at birth, W_w^b/W_w^\infty, -')
%       title(['\it mammalia @ ',datestr(datenum(date),'yyyy/mm/dd')], 'FontSize',15, 'FontWeight','normal'); 
%       %saveas(gcf,'ss_Wbi_mamm.png')

%       Hfig_sssHbp = shstat([s_s,s_Hbp], legend_mamm); 
%       figure(Hfig_sssHbp)
%       xlabel('supply stress, s_s, -')
%       ylabel('_{10}log procociality coeff s_H^{bp}, -')
%       title(['\it mammalia @ ',datestr(datenum(date),'yyyy/mm/dd')], 'FontSize',15, 'FontWeight','normal'); 
%       %saveas(gcf,'ss_sHbp_mamm.png')

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

    case 2
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

    case 3
      data = read_allStat({'N_i','Ww_b','Ww_i','kap','s_s'});
      N_i = data(:,1); Ww_b = data(:,2); Ww_i = data(:,3); kap = data(:,4); s_s = data(:,5); 
      kap_RA = 1 - kap - s_s./kap.^2; NWW = N_i.*Ww_b./Ww_i;

      shstat_options('default');
 
      shlegend(legend_moll, [0.7 0.2], [0.8 0.2]);
      %saveas(gca,'legend_moll.png')
      Hfig_kapRANi_moll = shstat([kap_RA, NWW], legend_moll); 
      figure(Hfig_kapRANi_moll)
      plot([-6;0],[-5.5;0.5], 'k', 'Linewidth',2)
      xlabel('_{10}log \kappa_R^A, -')
      ylabel('_{10}log spec neonate mass prod, N_\infty W_w^b/ W_w^\infty, -')
      title(['\it mollusca @ ',datestr(datenum(date),'yyyy/mm/dd')], 'FontSize',15, 'FontWeight','normal'); 
      %saveas(gcf,'kapRA_Ni_moll.png')

      shlegend(legend_crus, [0.7 0.2], [0.8 0.2]);
      %saveas(gca,'legend_crus.png')
      Hfig_kapRANi_crus = shstat([kap_RA, NWW], legend_crus); 
      figure(Hfig_kapRANi_crus)
      plot([-4;0],[-3;1], 'k', 'Linewidth',2)
      xlabel('_{10}log \kappa_R^A, -')
      ylabel('_{10}log spec neonate mass prod, N_\infty W_w^b/ W_w^\infty, -')
      title(['\it crustacea @ ',datestr(datenum(date),'yyyy/mm/dd')], 'FontSize',15, 'FontWeight','normal'); 
      %saveas(gcf,'kapRA_Ni_crus.png')

      shlegend(legend_chon, [0.7 0.2], [0.8 0.2]);
      %saveas(gca,'legend_chon.png')
      Hfig_kapRANi_chon = shstat([kap_RA, NWW], legend_chon); 
      figure(Hfig_kapRANi_chon)
      plot([-2.5;0],[-1.8;0.7], 'k', 'Linewidth',2)
      xlabel('_{10}log \kappa_R^A, -')
      ylabel('_{10}log spec neonate mass prod, N_\infty W_w^b/ W_w^\infty, -')
      title(['\it chondrichthyes @ ',datestr(datenum(date),'yyyy/mm/dd')], 'FontSize',15, 'FontWeight','normal'); 
      %saveas(gcf,'kapRA_Ni_chon.png')
       
      shlegend(legend_acti, [0.7 0.2], [0.8 0.2]);
      %saveas(gca,'legend_acti.png')
      Hfig_kapRANi_acti = shstat([kap_RA, NWW], legend_acti); 
      figure(Hfig_kapRANi_acti)
      plot([-4;0],[-3.8;0.2], 'k', 'Linewidth',2)
      xlabel('_{10}log \kappa_R^A, -')
      ylabel('_{10}log spec neonate mass prod, N_\infty W_w^b/ W_w^\infty, -')
      title(['\it actinopterygii @ ',datestr(datenum(date),'yyyy/mm/dd')], 'FontSize',15, 'FontWeight','normal'); 
      %saveas(gcf,'kapRA_Ni_acti.png')

      shlegend(legend_amph, [0.7 0.2], [0.8 0.2]);
      %saveas(gca,'legend_amph.png')
      Hfig_kapRANi_amph = shstat([kap_RA, NWW], legend_amph); 
      figure(Hfig_kapRANi_amph)
      plot([-4;0],[-2.8;1.2], 'k', 'Linewidth',2)
      xlabel('_{10}log \kappa_R^A, -')
      ylabel('_{10}log spec neonate mass prod, N_\infty W_w^b/ W_w^\infty, -')
      title(['\it amphibia @ ',datestr(datenum(date),'yyyy/mm/dd')], 'FontSize',15, 'FontWeight','normal'); 
      %saveas(gcf,'kapRA_Ni_amph.png')

      shlegend(legend_rept, [0.7 0.2], [0.8 0.2]);
      %saveas(gca,'legend_rept.png')
      Hfig_kapRANi_rept = shstat([kap_RA, NWW], legend_rept); 
      figure(Hfig_kapRANi_rept)
      plot([-3.3;0],[-2;1.3], 'k', 'Linewidth',2)
      xlabel('_{10}log \kappa_R^A, -')
      ylabel('_{10}log spec neonate mass prod, N_\infty W_w^b/ W_w^\infty, -')
      title(['\it reptilia @ ',datestr(datenum(date),'yyyy/mm/dd')], 'FontSize',15, 'FontWeight','normal'); 
      %saveas(gcf,'kapRA_Ni_rept.png')

      shlegend(legend_aves, [0.7 0.2], [0.8 0.2]);
      %saveas(gca,'legend_aves.png')
      Hfig_kapRANi_aves = shstat([kap_RA, NWW], legend_aves); 
      figure(Hfig_kapRANi_aves)
      plot([-3.5;0],[-1;2.5], 'k', 'Linewidth',2)
      xlabel('_{10}log \kappa_R^A, -')
      ylabel('_{10}log spec neonate mass prod, N_\infty W_w^b/ W_w^\infty, -')
      title(['\it aves @ ',datestr(datenum(date),'yyyy/mm/dd')], 'FontSize',15, 'FontWeight','normal'); 
      %saveas(gcf,'kapRA_Ni_aves.png')

      shlegend(legend_mamm, [0.7 0.2], [0.8 0.2]);
      %saveas(gca,'legend_mamm.png')
      Hfig_kapRANi_mamm = shstat([kap_RA, NWW], legend_mamm); 
      figure(Hfig_kapRANi_mamm)
      plot([-5.8;-0.3],[-4;1.5], 'k', 'Linewidth',2)
      xlabel('_{10}log \kappa_R^A, -')
      ylabel('_{10}log spec neonate mass prod, N_\infty W_w^b/ W_w^\infty, -')
      title(['\it mammalia @ ',datestr(datenum(date),'yyyy/mm/dd')], 'FontSize',15, 'FontWeight','normal'); 
      %saveas(gcf,'kapRA_Ni_mamm.png')
      
    case 4
          
end
end

