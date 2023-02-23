function LikaAugu2014_SI(fig)
% Supporting Information for LikaAugu2014
% Title: The bijection from data to parameter space with the standard DEB model quantifies the supply-demand spectrum
% Authors: Lika, Augustine, Pecquerie, Kooijman
% Journal: J. Theor. Biol. 354 (2014): 35-47
% DOI: 10.1016/j.jtbi.2014.03.025
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
% To run the code for a figure: type in the Matlab window e.g. LikaAugu2014_SI(2)
%
% Remarks: 
%  This paper presents the physical boundaries of the data and parameter space for DEB models, as used in the estimation procedure;
%  The functions DEBtool_M/animal/get_pars_2-9 map data to parameters, iget_pars_2-9 do the reverse.
%  The figures show current AmP data, which might change in time; the results might differ from the publication;
%  The scripts call functions read_popStat and read_allStat; the first call to these functions loads the .mat file, which can take some time
%  Click on a marker in the Matlab-figure to see the species name
%  Uncomment "print" to save the Matlab-figure to a png-file
%  Modify selection of taxa and markers by changing the legend, see https://add-my-pet.github.io/AmPtool/docs/index.html
%  Allowed names of taxa match the names of the tree nodes at http://www.bio.vu.nl/thb/deb/deblab/add_my_pet/species_tree_Animalia.html

  close all

  if ~exist('fig','var')
    fig = 1:8;
  end
    
  date_txt = datestr(date,26);
  
  for i=1:length(fig)
    switch fig(i)
      case 1 % fig 1: ss-kap for RSED
        shstat_options('default');
        shstat_options('x_transform', 'none');
        shstat_options('y_transform', 'none');
        [Hfigss_kap Hlegss_kap] = shstat({'s_s', 'kap'}, legend_RSED, ['animals', date_txt]); % set title, output handle for adding items
    
        figure(Hfigss_kap) % add items to figure
        kap = linspace(0, 1, 100); ss = kap.^2 .* (1 - kap); 
        plot(ss, kap, 'k', 'Linewidth', 2)
        xlim([0 4/27]); ylim([0 1]);
        xlabel('supply stress, s_s, -');
        ylabel('allocation fraction to soma, \kappa, -');
        %saveas(gca,'ss_kap.png')
        
      case 2 % ss-kap for molluscs
        shstat_options('default');
        shstat_options('x_transform', 'none');
        shstat_options('y_transform', 'none');
        [Hfigss_kap_moll Hlegss_kap_moll] = shstat({'s_s', 'kap'}, legend_moll, ['molluscs ',date_txt]); % set title, output handle for adding items
    
        figure(Hfigss_kap_moll) % add items to figure
        kap = linspace(0, 1, 100); ss = kap.^2 .* (1 - kap); 
        plot(ss, kap, 'k', 'Linewidth', 2)
        xlim([0 4/27]); ylim([0 1]);
        xlabel('supply stress, s_s, -');
        ylabel('allocation fraction to soma, \kappa, -');
        %saveas(gca,'ss_kap_moll.png')

      case 3 % Li-ss
        shstat_options('default');
        shstat_options('x_transform', 'none');
        shstat_options('y_transform', 'none');
        [HfigLi_ss HlegLi_ss] = shstat({'L_i', 's_s'}, legend_RSED, ['animals ',date_txt]); % set title, output handle for adding items
    
        figure(HfigLi_ss) % add items to figure
        xlabel('ultimate structural length, L_{\infty}, cm');
        ylabel('supply stress, s_s, -');
        %saveas(gca,'Li_ss.png')

      case 4 % fig 2: f_min - ss
        shstat_options('default');
        shstat_options('x_transform', 'none');
        shstat_options('y_transform', 'none');
        
        var = read_allStat({'kap','p_Am','s_M','p_M','k_J','E_Hp','s_s'});
        fmin = (var(:,5).*var(:,6).*var(:,4).^2./(var(:,1).^2.*(1-var(:,1)).*var(:,3).^3.*var(:,2).^3)).^(1/3);
        [Hfigfmin_ss Hlegfmin_ss] = shstat([fmin, var(:,7)], legend_RSED, ['animals ',date_txt]); % set title, output handle for adding items
    
        figure(Hfigfmin_ss) % add items to figure
        f = linspace(0,1,100)';
        ss = f.^3 * 4/ 27;
        plot(f, ss, 'k', 'LineWidth', 2)
        xlabel('min scaled func resp, f_{min}, -');
        ylabel('supply stress, s_s, -');
        xlim([0; 1])
        ylim([0; 4/27])
        %saveas(gca,'fmin_ss.png')
        
      case 5 % fig 3: f_min - ss for endotherms
        shstat_options('default');
        shstat_options('x_transform', 'none');
        shstat_options('y_transform', 'none');
        
        var = read_allStat({'kap','p_Am','s_M','p_M','k_J','E_Hp','s_s'});
        fmin = (var(:,5).*var(:,6).*var(:,4).^2./(var(:,1).^2.*(1-var(:,1)).*var(:,3).^3.*var(:,2).^3)).^(1/3);
        [Hfigfmin_ss Hlegfmin_ss] = shstat([fmin, var(:,7)], legend_endo, ['endotherms ',date_txt]); % set title, output handle for adding items
    
        figure(Hfigfmin_ss) % add items to figure
        f = linspace(0,1,100)';
        ss = f.^3 * 4/ 27;
        plot(f, ss, 'k', 'LineWidth', 2)
        xlabel('min scaled func resp, f_{min}, -');
        ylabel('supply stress, s_s, -');
        xlim([0; 1])
        ylim([0; 4/27])
        %saveas(gca,'fmin_ss_endo.png')
        
      case 6 % Li-fmin
        shstat_options('default');
        shstat_options('x_transform', 'none');
        
        var = read_allStat({'kap','p_Am','s_M','p_M','k_J','E_Hp','L_i'});
        fmin = (var(:,5).*var(:,6).*var(:,4).^2./(var(:,1).^2.*(1-var(:,1)).*var(:,3).^3.*var(:,2).^3)).^(1/3);
        [Hfigfmin_Li Hlegfmin_Li] = shstat([fmin, var(:,7)], legend_endo, ['endotherms ',date_txt]); % set title, output handle for adding items

        figure(Hfigfmin_Li) % add items to figure
        f = linspace(0,1,100)';
        ss = f.^3 * 4/ 27;
        plot(f, ss, 'k', 'LineWidth', 2)
        xlabel('min scaled func resp, f_{min}, -');
        ylabel('ultimate struct length, _{10}log L_{\infty}, cm');
        %xlim([-.5; 2.5])
        %ylim([0; 4/27])
        %saveas(gca,'fmin_Li_endo.png')
        
      case 7 % fig 4: ss-kap for fish
        shstat_options('default');
        shstat_options('x_transform', 'none');
        shstat_options('y_transform', 'none');
        [Hfigss_kap_fish Hlegss_kap_fish] = shstat({'s_s', 'kap'}, legend_fish, ['fish ',date_txt]); % set title, output handle for adding items
    
        figure(Hfigss_kap_fish) % add items to figure
        kap = linspace(0, 1, 100); ss = kap.^2 .* (1 - kap); 
        plot(ss, kap, 'k', 'Linewidth', 2)
        xlim([0 4/27]); ylim([0 1]);
        xlabel('supply stress, s_s, -');
        ylabel('allocation fraction to soma, \kappa, -');
        %saveas(gca,'ss_kap_fish.png')

      case 8 % fig 4: ss-Li for RSED
        shstat_options('default');
        shstat_options('y_transform', 'none');
        [HfigLi_ss HlegLi_ss] = shstat({'L_i','s_s'}, legend_RSED, ['animals ',date_txt]); % set title, output handle for adding items
    
        figure(HfigLi_ss) % add items to figure
        ylim([0 4/27]); 
        xlabel('ultimate struc length, _{10}log L_{\infty}, cm');
        ylabel('supply stress, s_s, -');
        %saveas(gca,'Li_ss.png')

    end
  end
end

