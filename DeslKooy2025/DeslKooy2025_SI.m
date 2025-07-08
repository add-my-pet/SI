function DeslKooy2025_SI(fig)
% Supporting Information for DeslKooy2025
% Title: The comparatice energetics of rockfish Sebastes
% Authors: Deslauriers, Kooijman
% Journal: Ecol. Mod
% DOI: 
% Date: 2025/06/17
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
%
% Example of use
% DeslKooy2025_SI(4)

close all

if ~exist('fig','var')
   fig = 1:31;
end

  % type, size, linewidth, edge color and face color of a marker, taxon
  legend_Scor = {... % Scorpaenoidei
    {'<', 4, 1, [0 1 1], [0 1 1]}, 'Scorpaenidae'; ....
    {'>', 4, 1, [0 0 0], [1 0 1]}, 'Synanceiidae'; ....
    {'o', 4, 1, [1 0 0], [0 0 0]}, 'Sebastolobus'; .... % Sebastidae
    {'o', 4, 1, [1 0 0], [0 0 1]}, 'Sebastiscus'; ....  % Sebastidae
    {'o', 4, 1, [1 0 0], [0 1 0]}, 'Helicolenus'; ....  % Sebastidae
    {'o', 4, 1, [1 0 0], [1 0 0]}, 'Sebastes'; ....     % Sebastidae
  };

  llegend_Scor = {... 
    {'-', 2, [1 0 0]}, 'Sebastidae'; ....
    {'-', 2, [0 0 0]}, 'Scorpaenoidei'; ....
    {'-', 2, [0 0 1]}, 'Actinopterygii'; ....
  };

  close all

  for i=1:length(fig)
 
    switch fig(i)
      case 1 % kapRtot_kapRA: overall reproduction efficiency-fraction of assimilation allocated to reproduction
        shstat_options('default');
        shstat_options('x_transform', 'none'); 
        shstat_options('y_transform', 'none'); 
        shstat_options('z_transform', 'none'); 

        kapRtot = get_kapRtot(read_allStat({'E_0','kap_R','L_b','E_m','mu_V','M_V'}));
        kapRA = get_kapRA(read_allStat({'p_Am','p_M','k_J','E_Hp','s_M','kap','L_i'})); 
        kap = read_allStat('kap');
        Hfig = shstat([kapRtot,kapRA(:,1),kap],legend_Scor,['Scorpaenoidei @ ',datestr(datenum(date),'yyyy/mm/dd')]);
        figure(Hfig) % add items to figure
        xlabel('\kappa_R^{tot}, -'); ylabel('\kappa_R^A, -'); zlabel('\kappa, -');
        % saveas(gcf,'kapRtot_kapRA_kap_scor.png')
       
      case 2 % kapRA_kap
        shstat_options('default');
        shstat_options('x_transform', 'none');
        shstat_options('y_transform', 'none');
        kapRA = get_kapRA(read_allStat({'p_Am','p_M','k_J','E_Hp','s_M','kap','L_i'})); 
        kap = read_allStat('kap');
        [Hfig, Hleg] = shstat([kapRA(:,1),kap], legend_Scor, ['vertebrates @ ',datestr(datenum(date),'yyyy/mm/dd')]); % set title, output handle for adding items
    
        figure(Hfig) % add items to figure
        xlabel('\kappa_R^A, -'); ylabel('\kappa, -');
        % saveas(gcf,'kapRA_kap_vert.png')

      case 3 % kapRtot_kap
        shstat_options('default');
        shstat_options('x_transform', 'none');
        shstat_options('y_transform', 'none');
        kapRtot = get_kapRtot(read_allStat({'E_0','kap_R','L_b','E_m','mu_V','M_V'}));
        kap = read_allStat('kap');
        [Hfig, Hleg] = shstat([kapRtot(:,1),kap], legend_Scor, ['vertebrates @ ',datestr(datenum(date),'yyyy/mm/dd')]); % set title, output handle for adding items
    
        figure(Hfig) % add items to figure
        xlabel('\kappa_R^{tot}, -'); ylabel('\kappa, -');
        % saveas(gcf,'kapRtot_kap_vert.png')

      case 4 % kap_ss_kapRA
        shstat_options('default');
        shstat_options('x_transform', 'none');
        shstat_options('y_transform', 'none');
        shstat_options('z_transform', 'none');
        Colmap = [0 0 0; 0 0 .5; 0 0 1; .5 0 1; 1 0 1; 1 0 .5; 1 0 0; 1 .25 .25; 1 .5 .5; 1 .75 .75]; % define colormap for mesh: k->b->m->r->white
        kapRA = get_kapRA(read_allStat({'p_Am','p_M','k_J','E_Hp','s_M','kap','L_i'})); 
        kap_ss = read_allStat({'kap','s_s'});
        kap_mesh = linspace(.005,1,50)'; ss_mesh = linspace(1e-8, 4/27, 50); kapRA_mesh = 1 - kap_mesh*ones(1,50) - kap_mesh.^-2*ss_mesh; % set x,y,z values
        kap = linspace(0,1,100)'; ss= kap.^2.*(1-kap);
        n_Scor = length(select('Scorpaenoidei'));

        [Hfig, Hleg] = shstat([kap_ss,kapRA(:,1)], legend_Scor, [num2str(n_Scor),' Scorpaenoidei @ ',datestr(datenum(date),'yyyy/mm/dd')]); 
        %
        figure(Hfig)
        xlabel('\kappa, -'); ylabel('s_s, -'); zlabel('\kappa_R^A, -');
        mesh(kap_mesh,ss_mesh,kapRA_mesh'); % add surface to figure
        plot3(kap,ss,0*kap, 'color','k');
        xlim([0 1]); ylim([0 4/27]); zlim([0 1]);
        colormap(Hfig, Colmap) % set color map to add_my_pet colors 
        caxis([0 1])
        %
        set(Hfig,'units','centimeters', 'position',[2,2,20,20])        
        view([60 20])
        rotate3D(Hfig, 'kap_ss_kapRA_Scor', 20);
        %saveas(gcf,'kap_ss_kapRA_Scor.png')
        %
        figure(Hleg)
        %saveas(gcf,'legend_kap_ss_kapRA_Scor.png')

        [Hfigi, Hlegi] = shstat([kap_ss,kapRA(:,1)], legend_Scor, [num2str(n_Scor), ' Scorpaenoidei @ ',datestr(datenum(date),'yyyy/mm/dd')]); 
        %
        figure(Hfigi)
        xlabel('\kappa, -'); ylabel('s_s, -'); zlabel('\kappa_R^A, -'); 
        mesh(kap_mesh,ss_mesh,kapRA_mesh'); % add surface to figure
        plot3(kap,ss,0*kap, 'color','k');
        xlim([0 1]); ylim([0 4/27]); zlim([0 1]);
        colormap(Hfigi, Colmap) % set color map to add_my_pet colors 
        caxis([0 1])
        %
        set(Hfigi,'units','centimeters', 'position',[2,2,20,20])        
        view([60 20])
        rotate3D(Hfigi, 'kap_ss_kapRA_Scor', 20);
        %saveas(gcf,'kap_ss_kapRA_Scor.png')
        %
        figure(Hlegi)
        saveas(gcf,'legend_kap_ss_kapRA_Scor.png')

      case 5 % Wwb_kapRtot
        shstat_options('default');
        shstat_options('y_transform', 'none');
        kapRtot = get_kapRtot(read_allStat({'E_0','kap_R','L_b','E_m','mu_V','M_V'}));
        Wwb = read_allStat('Ww_b');
        [Hfig, Hleg] = shstat([Wwb,kapRtot], legend_Scor, ['Scorpaenoidei @ ',datestr(datenum(date),'yyyy/mm/dd')]); % set title, output handle for adding items
    
        figure(Hfig) % add items to figure
        xlabel('_{10}log W_w^b, g'); ylabel('kap_R^{tot}, -'); 
        % saveas(gcf,'Wwb_kapRtot_Scor.png')
        
      case 6 % pM
        shstat_options('default');
        shstat_options('x_transform', 'log10');
        shstat_options('y_transform', 'none');
        [Hfig, Hleg] = shstat({'p_M'}, llegend_Scor, ['Scorpaenoidei @ ',datestr(datenum(date),'yyyy/mm/dd')]); % set title, output handle for adding items
    
        figure(Hfig) % add items to figure
        xlabel('_{10}log [p_M], J/d.cm^3'); 
        % saveas(gcf,'pM.png')
        
      case 7 % Ttypical-pM
        shstat_options('default');
        [Hfig, Hleg] = shstat({'T_typical','p_M'}, legend_Scor, ['Scorpaenoidei @ ',datestr(datenum(date),'yyyy/mm/dd')]); % set title, output handle for adding items
    
        figure(Hfig) % add items to figure
        xlabel('_{10}log T_{typical}, K')
        ylabel('_{10}log [p_M], J/d.cm^3');
        % saveas(gcf,'T_typical_pM.png')

    end
       
end
