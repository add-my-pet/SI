function LikaKooy2024b_SI(fig)
% Supporting Information for LikaKooy2024b
% Title: Resource allocation to reproduction in animal reproduction revisited
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

  legend_homo = {...
    {'o', 4, 2, [1 0 0], [1 0 0]}, 'Aves'; ....
    {'o', 4, 2, [0 0 1], [0 0 1]}, 'Mammalia'; ....
  };

  % type, size, linewidth, edge color and face color of a marker, taxon
  legend_vert = {...
        {'o', 5, 2, [0 0 0], [0 0 0]}, 'Cyclostomata'
        {'o', 5, 2, [0 0 1], [0 1 1]}, 'Chondrichthyes'
        {'o', 5, 2, [0 0 1], [0 0 0]}, 'Actinopterygii'
        {'o', 5, 2, [0 0 1], [1 0 1]}, 'Latimeria'
        {'o', 5, 2, [0 0 1], [1 0 0]}, 'Dipnoi'
        {'o', 5, 2, [1 0 1], [0 1 1]}, 'Amphibia'
        {'o', 5, 2, [1 0 1], [1 0 1]}, 'Lepidosauria'
        {'o', 5, 2, [1 0 0], [1 0 0]}, 'Aves'
        {'o', 5, 2, [1 0 0], [0 0 1]}, 'Archelosauria'
        {'o', 5, 2, [1 .5 .5], [1 .5 .5]}, 'Mammalia'
  };

  legend_invert = {...
        {'o', 5, 2, [0 0 0], [0 0 0]}, 'Radiata'
        {'o', 5, 2, [0 0 0], [0 0 1]}, 'Xenacoelomorpha'
        {'o', 5, 2, [0 0 1], [0 0 1]}, 'Spiralia'
        {'o', 5, 2, [1 0 1], [1 0 1]}, 'Ecdysozoa'
        {'o', 5, 2, [1 0 0], [1 0 0]}, 'Echinodermata'
        {'o', 5, 2, [1 0 0], [1 0 1]}, 'Cephalochordata'
        {'o', 5, 2, [1 0 0], [0 0 1]}, 'Tunicata'
  };

  %legend=legend_aves; legend(end,:)=[]; % remove non-aves 
  %legend=legend_mamm; legend(end,:)=[]; % remove non-mammels
  legend=legend_vert; 

  close all

  for i=1:length(fig)
 
    switch fig(i)
      case 1 % kapRtot_kapRA
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
        Colmap = [0 0 0; 0 0 .5; 0 0 1; .5 0 1; 1 0 1; 1 0 .5; 1 0 0; 1 .25 .25; 1 .5 .5; 1 .75 .75]; % define colormap for mesh: k->b->m->r->white
        kapRA = get_kapRA(read_allStat({'p_Am','p_M','k_J','E_Hp','s_M','kap','L_i'})); 
        kap_ss = read_allStat({'kap','s_s'});
        kap_mesh = linspace(.005,1,50)'; ss_mesh = linspace(1e-8, 4/27, 50); kapRA_mesh = 1 - kap_mesh*ones(1,50) - kap_mesh.^-2*ss_mesh; % set x,y,z values
        kap = linspace(0,1,100)'; ss= kap.^2.*(1-kap);
        n_vert = length(select('Vertebrata')); n_invert = length(select) - n_vert;

        [Hfig, Hleg] = shstat([kap_ss,kapRA(:,1)], legend_vert, [num2str(n_vert),' vertebrates @ ',datestr(datenum(date),'yyyy/mm/dd')]); 
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
        rotate3D(Hfig, 'kap_ss_kapRA_vert', 20);
        %saveas(gcf,'kap_ss_kapRA_vert.png')
        %
        figure(Hleg)
        saveas(gcf,'legend_kap_ss_kapRA_vert.png')

        [Hfigi, Hlegi] = shstat([kap_ss,kapRA(:,1)], legend_invert, [num2str(n_invert), ' invertebrates @ ',datestr(datenum(date),'yyyy/mm/dd')]); 
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
        rotate3D(Hfigi, 'kap_ss_kapRA_invert', 20);
        %saveas(gcf,'kap_ss_kapRA_invert.png')
        %
        figure(Hlegi)
        saveas(gcf,'legend_kap_ss_kapRA_invert.png')

      case 5 % Wwb_kapRtot
        shstat_options('default');
        shstat_options('y_transform', 'none');
        kapRtot = get_kapRtot(read_allStat({'E_0','kap_R','L_b','E_m','mu_V','M_V'}));
        Wwb = read_allStat('Ww_b');
        [Hfig, Hleg] = shstat([Wwb,kapRtot], legend, ['vertebrates @ ',datestr(datenum(date),'yyyy/mm/dd')]); % set title, output handle for adding items
    
        figure(Hfig) % add items to figure
        xlabel('_{10}log W_w^b, g'); ylabel('kap_R^{tot}, -'); 
        % saveas(gcf,'Wwb_kapRtot_vert.png')
       
      case 6 % kapRAopt_kap_m: kappa that maximizes p_R/p_A or R_i
        shstat_options('default');
        shstat_options('x_transform', 'none');
        shstat_options('y_transform', 'none');
       
        par = read_stat('Vertebrata',{'kap','kap_R','p_Am','v','p_M','k_J','E_G','E_Hb','E_Hj','E_Hp','s_M'}); 
        mod = read_stat('Vertebrata',{'model'}); 
        [kap_m, R_m, R_i] = get_kapm(mod,par); 
        
        res = get_max_kapRA(par(:,[3 5 6 10 11 1])); kap_opt = res(:,1); kapRA_opt = res(:,2);
        % shstat wants to have data-values for all entries, to make selections as specified in legend
        load ('n_entries.mat'); data = NaN(n_entries,2); data(select_01('Vertebrata'),:) = [kap_opt,kap_m];

        [Hfig, Hleg] = shstat(data, legend, ['vertebrates @ ',datestr(datenum(date),'yyyy/mm/dd')]); 

        figure(Hfig) % add items to figure
        xlabel('\kappa that maximizes \kappa_R^A'); ylabel('\kappa that maximizes R_\infty'); 
        % saveas(gcf,'kapRAopt_kap_m_vert.png')
       
        % actual R_i/ max R_m - actual \kappa_R^A/ max \kappa_R^A
        res = get_kapRA(read_stat('Vertebrata',{'p_Am','p_M','k_J','E_Hp','s_M','kap','L_i'})); s_RA = res(:,1)./kapRA_opt; 
        s_R = R_i./R_m; data(select_01('Vertebrata'),:) = [s_RA,s_R];
       
        [Hfig1, Hleg1] = shstat(data, legend, ['vertebrates @ ',datestr(datenum(date),'yyyy/mm/dd')]); 
        figure(Hfig1) % add items to figure
        xlabel('\kappa_R^A/ max \kappa_R^A'); ylabel('R_\infty/ max R_\infty'); 
        % saveas(gcf,'sRA_sR.png')
       
        shstat_options('x_transform', 'none');
        shstat_options('y_label', 'on'); % if 'off' (default), no `survivor function' shown on yaxis
        Hfigkap = shstat(data(:,1), {'b', 'b'}, ['vertebrates @ ', datestr(datenum(date), 'yyyy/mm/dd')]);
        shstat(data(:,2), {'r', 'r'}, '', Hfigkap);
        figure(Hfigkap)
        xlabel('\color{blue}{R_\infty/max R_\infty}, \color{red}{\kappa_R^A/max \kappa_R^A}');      
        % saveas(gcf,'surv_sRA_sR.png')

        % kap_Wwb
        shstat_options('y_transform', 'log10');
        [Hfig2, Hleg2] = shstat({'kap','Ww_b'}, legend, ['vertebrates @ ', datestr(datenum(date), 'yyyy/mm/dd')]); 
        figure(Hfig2) % add items to figure
        xlabel('\kappa'); ylabel('_{10}log W_w^b, g'); xlim([0 1]);
        % saveas(gcf,'kap_Wwb.png')
        
      case 7 % rB_am: am = 3/r_B for fish... 
        shstat_options('default') 
        rB_am = read_allStat({'r_B','a_m'}); am = rB_am(:,2); am_pred = 3./rB_am(:,1);
        Hfig = shstat([am,am_pred], legend_fish, ['fish @ ', datestr(datenum(date), 'yyyy/mm/dd')]);
        
        figure(Hfig)
        xlabel('life span, a_m, d'); ylabel('predicted life span, 3/r_B, d');
        plot([1;5], [1;5], 'k', 'linewidth',1)
        
        Hfigh = shstat([am,am_pred*10], legend_homo, ['homeotherms @ ', datestr(datenum(date), 'yyyy/mm/dd')]);
        
        figure(Hfigh)
        xlabel('life span, a_m, d'); ylabel('predicted life span, 30/r_B, d');
        plot([2;5.5], [2;5.5], 'k', 'linewidth',1)

   
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
        if R_m(i) < R_i(i); keyboard; end
        fprintf('%g %s %s %g %g & %g %g\n',i, nm{i}, mod{i}, par(i,1), R_i(i), kap_m(i), R_m(i));
      end
    end
  end
end

