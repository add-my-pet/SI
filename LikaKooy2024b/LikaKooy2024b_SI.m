function LikaKooy2024b_SI(fig)
% Supporting Information for LikaKooy2024b
% Title: Investment in animal reproduction versus efficiency
% Authors: Lika, Kooijman
% Journal: Ecol. Mod
% DOI: 
% Date: 2024/07/17
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
% To run the code for a figure: type in the Matlab window e.g. LikaAugu2022_SI(2)
%
% Remarks: 
%  The figures show current AmP data, which might change in time; the results might differ from the publication
%  The scripts call functions read_popStat and read_allStat; the first call to these functions loads the .mat file, which can take some time
%  Click on a marker in the Matlab-figure to see the species name
%  Uncomment "print" to save the Matlab-figure to a png-file
%  Modify selection of taxa and markers by changing the legend, see https://add-my-pet.github.io/AmPtool/docs/index.html
%  Allowed names of taxa match the names of the tree nodes at http://www.bio.vu.nl/thb/deb/deblab/add_my_pet/species_tree_Animalia.html

close all
global fVec dataset Range
dataset = []; Range = [];

if ~exist('fig','var')
   fig = 1:31;
end

  % type, size, linewidth, edge color and face color of a marker, taxon
  legend_fish = {...
    {'o', 4, 2, [0 1 1], [0 1 1]}, 'Chondrichthyes'; ....
    {'o', 4, 2, [0 0 1], [0 0 1]}, 'Actinopterygii'; ....
  };

  legend_crus = {...
    {'o', 4, 2, [0 0 1], [0 0 1]}, 'Branchiopoda'; ....
    {'o', 4, 2, [1 0 1], [1 0 1]}, 'Multicrustacea'; ....
    {'o', 4, 2, [1 0 0], [1 0 0]}, 'Oligostraca'; ....
  };

  legend_moll = {...
    {'o', 4, 2, [0 0 1], [0 0 1]}, 'Bivalvia'; ....
    {'o', 4, 2, [1 0 1], [1 0 1]}, 'Gastropoda'; ....
    {'o', 4, 2, [1 0 0], [1 0 0]}, 'Cephalopoda'; ....
  };

  %legend=legend_aves; legend(end,:)=[]; % remove non-aves 
  %legend=legend_mamm; legend(end,:)=[]; % remove non-mammels
  legend=legend_vert; 

 close all
 shstat_options('default');
 shstat_options('y_label', 'on'); 
 shstat_options('x_label', 'off'); 
  
 for i=1:length(fig)
 
   switch fig(i)
     case 1 %  kapRtot_kapRA
       shstat_options('default');
       shstat_options('x_transform', 'none'); 
       shstat_options('y_transform', 'none'); 
       shstat_options('z_transform', 'none'); 

       kapRtot = get_kapRtot(read_allStat({'E_0','kap_R','L_b','E_m','mu_V','M_V'}));
       kapRA = get_kapRA(read_allStat({'p_Am','p_M','k_J','E_Hp','s_M','kap','L_i'})); 
       kap = read_allStat('kap');
       Hfig = shstat([kapRtot,kapRA(:,1),kap],legend,['vertebrates @ ',datestr(datenum(date),'yyyy/mm/dd')]);
       figure(Hfig) % add items to figure
       xlabel('\kappa_R^{tot}, -'); ylabel('\kappa_R^A, -'); zlabel('\kappa, -');
       % saveas(gcf,'kapRtot_kapRA_kap_vert.png')
       
     case 2 % kapRA_kap
       shstat_options('default');
       shstat_options('x_transform', 'none');
       shstat_options('y_transform', 'none');
       kapRA = get_kapRA(read_allStat({'p_Am','p_M','k_J','E_Hp','s_M','kap','L_i'})); 
       kap = read_allStat('kap');
       [Hfig, Hleg] = shstat([kapRA(:,1),kap], legend, ['vertebrates @ ',datestr(datenum(date),'yyyy/mm/dd')]); % set title, output handle for adding items
    
       figure(Hfig) % add items to figure
       xlabel('\kappa_R^A, -'); ylabel('\kappa, -');
       % saveas(gcf,'kapRA_kap_vert.png')

     case 3 % kapRtot_kap
       shstat_options('default');
       shstat_options('x_transform', 'none');
       shstat_options('y_transform', 'none');
       kapRtot = get_kapRtot(read_allStat({'E_0','kap_R','L_b','E_m','mu_V','M_V'}));
       kap = read_allStat('kap');
       [Hfig, Hleg] = shstat([kapRtot(:,1),kap], legend, ['vertebrates @ ',datestr(datenum(date),'yyyy/mm/dd')]); % set title, output handle for adding items
    
       figure(Hfig) % add items to figure
       xlabel('\kappa_R^{tot}, -'); ylabel('\kappa, -');
       % saveas(gcf,'kapRtot_kap_vert.png')

     case 4 % kap_ss_kapRA
       shstat_options('default');
       shstat_options('x_transform', 'none');
       shstat_options('y_transform', 'none');
       shstat_options('z_transform', 'none');
       kapRA = get_kapRA(read_allStat({'p_Am','p_M','k_J','E_Hp','s_M','kap','L_i'})); 
       kap_ss = read_allStat({'kap','s_s'});
       [Hfig, Hleg] = shstat([kap_ss,kapRA(:,1)], legend, ['vertebrates @ ',datestr(datenum(date),'yyyy/mm/dd')]); % set title, output handle for adding items
    
       figure(Hfig) % add items to figure
       xlabel('\kappa, -'); ylabel('s_s, -'); zlabel('\kappa_R^A, -');
       % saveas(gcf,'kap_ss_kapRA_vert.png')

     case 5 % Wwb_kapRtot
       shstat_options('default');
       shstat_options('y_transform', 'none');
       kapRtot = get_kapRtot(read_allStat({'E_0','kap_R','L_b','E_m','mu_V','M_V'}));
       Wwb = read_allStat('Ww_b');
       [Hfig, Hleg] = shstat([Wwb,kapRtot], legend, ['vertebrates @ ',datestr(datenum(date),'yyyy/mm/dd')]); % set title, output handle for adding items
    
       figure(Hfig) % add items to figure
       xlabel('_{10}log W_w^b, g'); ylabel('kap_R^{tot}, -'); 
       % saveas(gcf,'Wwb_kapRtot_vert.png')
  end
 end
end
