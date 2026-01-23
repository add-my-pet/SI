function LikaAugu2026_SI(fig)
% Supporting Information for LikaAugu2025
% Title: Relax-hurry spectra in animal kingdom
% Authors: Lika, Augustine, Kooijman
% Journal: Ecol. Mod
% DOI: 
% Date: 2025/12/07
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

 close all
 shstat_options('default');
 shstat_options('y_label', 'on'); 
 shstat_options('x_label', 'off'); 
  
for i=1:length(fig)
 
  switch fig(i)
      
    case 1 % Fig 1a & 1b: coral versus pelagic fish
      legend = { ... % blue edge: coral reefs, red edge pelagic * demersel
        {'o', 8, 3, [0 0 1], [0 0 1]}, 'Chaetodontiformes'; 
        {'o', 8, 3, [0 0 1], [0 1 1]}, 'Serranidae'; 
        {'o', 8, 3, [0 0 1], [1 0 0]}, 'Pomacentridae'; 
        {'o', 8, 3, [0 0 1], [1 1 1]}, 'Pomacanthiformes'; 
        {'o', 8, 3, [1 0 0], [0 0 0]}, 'Myctophiformes'; 
        {'o', 8, 3, [1 0 0], [0 1 1]}, 'Clupeiformes'; 
        {'o', 8, 3, [1 0 0], [1 0 0]}, 'Scombriformes'; 
        {'o', 8, 3, [1 0 0], [1 1 1]}, 'Pleuronectiformes'; 
      };
      shlegend(legend,[],[0.9 0.2]);
      %saveas(gcf,'legend_fish.png')

      % Wwi-pM
      shstat_options('default');
      Hfig_WpM = shstat({'Ww_i','p_M'}, legend); 
      figure(Hfig_WpM)
      xlabel('_{10}log weight W_w^\infty, g')
      ylabel('_{10}log spec som maint [p_M], J/d.cm^3')
      title(['\it fish @ ',datestr(datenum(date),'yyyy/mm/dd')], 'FontSize',15, 'FontWeight','normal'); 
      xlim([-1 6])
      %saveas(gcf,'Wwi_pM_fish.png')
      %
      WJc = read_allStat({'Ww_i','J_Oi','c_T'}); Ww_i = WJc(:,1); j_Oi = WJc(:,2)./WJc(:,1)./WJc(:,3); 
      Hfig_WjOi = shstat([Ww_i,j_Oi], legend); 
      figure(Hfig_WjOi)
      xlabel('_{10}log weight W_w^\infty, g')
      ylabel('_{10}log spec respiration, mol O_2/d.g')
      title(['\it fish @ ',datestr(datenum(date),'yyyy/mm/dd')], 'FontSize',15, 'FontWeight','normal'); 
      xlim([-1 6])
      %saveas(gcf,'Wwi_jOi_fish.png')
      
      % Wwi-s_Rb
      shstat_options('default');
      shstat_options('y_transform', 'none'); 
      %
      vars = read_allStat({'E_0','kap_R','L_b','E_m','mu_V','M_V','Ww_i','Ww_b','s_s'});
      E_0=vars(:,1); kap_R=vars(:,2); L_b=vars(:,3); E_m=vars(:,4); mu_V=vars(:,5); M_V=vars(:,6); Ww_i=vars(:,7); s_s=vars(:,9);
      kap_R = 0.95 + 0*kap_R; % remove simultaneous hermaphrodite allocation
      s_Rb = kap_R.*L_b.^3.*(M_V.*mu_V+E_m)./E_0; % overall reproduction efficiency
      %
      Hfig_WsRb = shstat([Ww_i s_Rb], legend); 
      figure(Hfig_WsRb)
      xlabel('_{10}log weight W_w^\infty, g')
      ylabel('overall reprod efficiency s_R^b, -')
      title(['\it fish @ ',datestr(datenum(date),'yyyy/mm/dd')], 'FontSize',15, 'FontWeight','normal'); 
      xlim([-1 6])
      %saveas(gcf,'Wwi_sRb_fish.png')

    case 2 % Fig 2a & 2b, mammalia 
      legend = { ... % colors: blue edge grass eaters, red edge carnivores
        {'o', 8, 3, [0 0 1], [0 0 1]}, 'Pecora'; % grass eaters
        {'o', 8, 3, [0 0 1], [0 1 1]}, 'Macropodiformes'; % grass eaters	
        {'o', 8, 3, [1 0 0], [1 0 0]}, 'Eulipotyphla'; % insect/worm eaters
        {'o', 8, 3, [1 0 0], [1 1 1]}, 'Feliformia'; % carnivores
      };
      %tax = 'Mammalia'; nm_mam = select(tax); prt_tab({nm_mam,read_stat(nm_mam,{'Ww_i','p_M'}),read_eco(nm_mam,'habitat')},[],tax)
      shlegend(legend,[],[0.9 0.2]);
      %saveas(gcf,'legend_mam.png')

      shstat_options('default');
      Hfig_WpM = shstat({'Ww_i','p_M'}, legend); 
      figure(Hfig_WpM)
      xlabel('_{10}log weight W_w^\infty, g')
      ylabel('_{10}log spec som maint [p_M], J/d.cm^3')
      title(['\it mammals @ ',datestr(datenum(date),'yyyy/mm/dd')], 'FontSize',15, 'FontWeight','normal'); 
      xlim([-1 6])
      %saveas(gcf,'Wwi_pM_mam.png')

      WJc = read_allStat({'Ww_i','J_Oi','c_T'}); Ww_i = WJc(:,1); j_Oi = WJc(:,2)./WJc(:,1)./WJc(:,3); 
      Hfig_WjOi = shstat([Ww_i,j_Oi], legend); 
      figure(Hfig_WjOi)
      xlabel('_{10}log weight W_w^\infty, g')
      ylabel('_{10}log spec respiration, mol O_2/d.g')
      title(['\it mammals @ ',datestr(datenum(date),'yyyy/mm/dd')], 'FontSize',15, 'FontWeight','normal'); 
      xlim([-1 6])
      %saveas(gcf,'Wwi_jOi_mam.png')

      % Wwi-s_Rb
      shstat_options('default');
      shstat_options('y_transform', 'none'); 
      %
      vars = read_allStat({'E_0','kap_R','L_b','E_m','mu_V','M_V','Ww_i','Ww_b','s_s'});
      E_0=vars(:,1); kap_R=vars(:,2); L_b=vars(:,3); E_m=vars(:,4); mu_V=vars(:,5); M_V=vars(:,6); Ww_i=vars(:,7); s_s=vars(:,9);
      kap_R = 0.95 + 0*kap_R; % remove simultaneous hermaphrodite allocation
      s_Rb = kap_R.*L_b.^3.*(M_V.*mu_V+E_m)./E_0; % overall reproduction efficiency
      %
      Hfig_WsRb = shstat([Ww_i, s_Rb], legend); 
      figure(Hfig_WsRb)
      xlabel('_{10}log weight W_w^\infty, g')
      ylabel('overall reprod efficiency s_R^b, -')
      title(['\it mammals @ ',datestr(datenum(date),'yyyy/mm/dd')], 'FontSize',15, 'FontWeight','normal'); 
      xlim([-1 6])
      %saveas(gcf,'Wwi_sRb_mam.png')

    case 3 % Fig 3: molluscs
      llegend_mol = {...
        {'-', 2, [0 0 0]}, 'Lophophorata'; ....
        {'-', 2, [0 0 1]}, 'Bivalvia'; ....
        {'-', 2, [0 1 1]}, 'Gastropoda'; ....
        {'-', 2, [1 0 1]}, 'Cephalopoda'; ....
        {'-', 2, [1 0 0]}, 'Annelida'; ....
      };
      shllegend(llegend_mol,[],[0.9 0.2]);
      %saveas(gcf,'llegend_mol.png')
      %get_n(llegend_mol(:,2));
      
      % p_M
      shstat_options('default');
      shstat_options('y_transform', 'none'); 
      %
      Hfig_pM = shstat({'p_M'}, llegend_mol); 
      figure(Hfig_pM)
      xlabel('_{10}log [p_M], J/d.cm^3')
      ylabel('survivor function')
      title(['\it Lophotrochozoa @ ',datestr(datenum(date),'yyyy/mm/dd')], 'FontSize',15, 'FontWeight','normal'); 
      %saveas(gcf,'pM_mol.png')

      % s_s
      shstat_options('default');
      %shstat_options('x_transform', 'none'); 
      shstat_options('y_transform', 'none'); 
      %
      Hfig_ss = shstat({'s_s'}, llegend_mol); 
      figure(Hfig_ss)
      xlabel('_{10}log supply stress s_s, -')
      ylabel('survivor function')
      title(['\it Lophotrochozoa @ ',datestr(datenum(date),'yyyy/mm/dd')], 'FontSize',15, 'FontWeight','normal'); 
      %saveas(gcf,'ss_mol.png')

    case 4 % Fig 4: chondrichthyes
      llegend_chon = {...
        {'-', 2, [0 0 0]}, 'Holocephali'; ...
        {'-', 2, [0 0 1]}, 'Selachii'; ....
        {'-', 2, [1 0 0]}, 'Rajiformes'; ....
        {'-', 2, [1 0 1]}, 'Batomorphi'; ....
      };
      shllegend(llegend_chon,[],[0.9 0.2]);
      %saveas(gcf,'llegend_chon.png')
      get_n(llegend_chon(:,2));
      
      % p_M
      shstat_options('default');
      shstat_options('y_transform', 'none'); 
      %
      Hfig_pM = shstat({'p_M'}, llegend_chon); 
      figure(Hfig_pM)
      xlabel('_{10}log [p_M], J/d.cm^3')
      ylabel('survivor function')
      title(['\it Chondrichthyes @ ',datestr(datenum(date),'yyyy/mm/dd')], 'FontSize',15, 'FontWeight','normal'); 
      %saveas(gcf,'pM_chon.png')

      % s_s
      shstat_options('default');
      %shstat_options('x_transform', 'none'); 
      shstat_options('y_transform', 'none'); 
      %
      Hfig_ss = shstat({'s_s'}, llegend_chon); 
      figure(Hfig_ss)
      xlabel('_{10}log supply stress s_s, -')
      ylabel('survivor function')
      title(['\it Chondrichthyes @ ',datestr(datenum(date),'yyyy/mm/dd')], 'FontSize',15, 'FontWeight','normal'); 
      %saveas(gcf,'ss_chon.png')
      
    case 5 % Fig 5: Amphibia
      llegend_amph = {...
        {'-', 2, [0 0 0]}, 'Gymnophiona'; ...
        {'-', 2, [0 0 1]}, 'Caudata'; ....
        {'-', 2, [1 0 0]}, 'Anura'; ....
      };
      shllegend(llegend_amph,[],[0.9 0.2]);
      %saveas(gcf,'llegend_amph.png')
      get_n(llegend_amph(:,2));
      
      % p_M
      shstat_options('default');
      shstat_options('y_transform', 'none'); 
      %
      Hfig_pM = shstat({'p_M'}, llegend_amph); 
      figure(Hfig_pM)
      xlabel('_{10}log [p_M], J/d.cm^3')
      ylabel('survivor function')
      title(['\it Amphibia @ ',datestr(datenum(date),'yyyy/mm/dd')], 'FontSize',15, 'FontWeight','normal'); 
      %saveas(gcf,'pM_amph.png')

      % s_s
      shstat_options('default');
      %shstat_options('x_transform', 'none'); 
      shstat_options('y_transform', 'none'); 
      %
      Hfig_ss = shstat({'s_s'}, llegend_amph); 
      figure(Hfig_ss)
      xlabel('_{10}log supply stress s_s, -')
      ylabel('survivor function')
      title(['\it Amphibia @ ',datestr(datenum(date),'yyyy/mm/dd')], 'FontSize',15, 'FontWeight','normal'); 
      %saveas(gcf,'ss_amph.png')
      
    case 6 % Fig 6: Squamata
      llegend_squa = {...
        {'-', 2, [0 0 0]}, 'Gekkota'; ...
        {'-', 2, [0 0 1]}, 'Scinciformata'; ....
        {'-', 2, [0 1 1]}, 'Laterata'; ....
        {'-', 2, [1 0 1]}, 'Anguimorpha'; ....
        {'-', 2, [1 0 0]}, 'Iguania'; ....
        {'-', 2, [1 1 0]}, 'Serpentes'; ....
      };
      shllegend(llegend_squa,[],[0.9 0.2]);
      %saveas(gcf,'llegend_squa.png')
      get_n(llegend_squa(:,2));
      
      % p_M
      shstat_options('default');
      shstat_options('y_transform', 'none'); 
      %
      Hfig_pM = shstat({'p_M'}, llegend_squa); 
      figure(Hfig_pM)
      xlabel('_{10}log [p_M], J/d.cm^3')
      ylabel('survivor function')
      title(['\it Squamata @ ',datestr(datenum(date),'yyyy/mm/dd')], 'FontSize',15, 'FontWeight','normal'); 
      %saveas(gcf,'pM_squa.png')

      % s_s
      shstat_options('default');
      %shstat_options('x_transform', 'none'); 
      shstat_options('y_transform', 'none'); 
      %
      Hfig_ss = shstat({'s_s'}, llegend_squa); 
      figure(Hfig_ss)
      xlabel('_{10}log supply stress s_s, -')
      ylabel('survivor function')
      title(['\it Squamata @ ',datestr(datenum(date),'yyyy/mm/dd')], 'FontSize',15, 'FontWeight','normal'); 
      %saveas(gcf,'ss_squa.png')

      nm=select('Iguania'); prt_tab({nm,read_stat(nm,'Ww_i','p_M')},{'species','weight','spec som main'},'Iguania',1)

    case 7 % Fig 7: Testudines
      llegend_test = {...
        {'-', 2, [0 0 0]}, 'Pleurodira'; ...
        {'-', 2, [0 0 1]}, 'Trionychia'; ....
        {'-', 2, [0 1 1]}, 'Americhelydia'; ....
        {'-', 2, [1 0 1]}, 'Emystemia'; ....
        {'-', 2, [1 0 0]}, 'Geoemydidae'; ....
        {'-', 2, [.8 0 0]}, 'Testudinidae'; ....
      };
      shllegend(llegend_test,[],[0.9 0.2]);
      %saveas(gcf,'llegend_test.png')
      get_n(llegend_test(:,2));
      
      % p_M
      shstat_options('default');
      shstat_options('y_transform', 'none'); 
      %
      Hfig_pM = shstat({'p_M'}, llegend_test); 
      figure(Hfig_pM)
      xlabel('_{10}log [p_M], J/d.cm^3')
      ylabel('survivor function')
      title(['\it Testudines @ ',datestr(datenum(date),'yyyy/mm/dd')], 'FontSize',15, 'FontWeight','normal'); 
      %saveas(gcf,'pM_test.png')

      % s_s
      shstat_options('default');
      %shstat_options('x_transform', 'none'); 
      shstat_options('y_transform', 'none'); 
      %
      Hfig_ss = shstat({'s_s'}, llegend_test); 
      figure(Hfig_ss)
      xlabel('_{10}log supply stress s_s, -')
      ylabel('survivor function')
      title(['\it Testudines @ ',datestr(datenum(date),'yyyy/mm/dd')], 'FontSize',15, 'FontWeight','normal'); 
      %saveas(gcf,'ss_test.png')

    case 8 % fig 8: surv for p_M
      % this case calls mydata_surv_pM, pars_init_surv_pM, predict_surv_pM
      close all; 
      global pets 

      pets = {'surv_pM'}; 

      estim_options('default'); 
      estim_options('max_step_number', 5e3); 
      estim_options('max_fun_evals', 5e3); 

      estim_options('pars_init_method', 2); 
      estim_options('results_output', 3); 
      estim_options('method', 'no'); 

      estim_pars; 
      
    case 9 % not in paper: echinoderms
      llegend_ech = {...
        {'-', 2, [1 0 0]}, 'Ophiuroidea'; ....
        {'-', 2, [1 0 1]}, 'Asteroidea'; ....
        {'-', 2, [0 0 1]}, 'Echinoidea'; ....
        {'-', 2, [0 0 0]}, 'Holothuroidea'; ....
      };
      shllegend(llegend_ech,[],[0.9 0.2]);
      %saveas(gcf,'llegend_ech.png')
      get_n(llegend_ech(:,2));
      
      % p_M
      shstat_options('default');
      shstat_options('y_transform', 'none'); 
      %
      Hfig_pM = shstat({'p_M'}, llegend_ech); 
      figure(Hfig_pM)
      xlabel('_{10}log [p_M], J/d.cm^3')
      ylabel('survivor function')
      title(['\it Echinodermata @ ',datestr(datenum(date),'yyyy/mm/dd')], 'FontSize',15, 'FontWeight','normal'); 
      %saveas(gcf,'pM_ech.png')

      % s_s
      shstat_options('default');
      %shstat_options('x_transform', 'none'); 
      shstat_options('y_transform', 'none'); 
      %
      Hfig_ss = shstat({'s_s'}, llegend_ech); 
      figure(Hfig_ss)
      xlabel('_{10}log supply stress s_s, -')
      ylabel('survivor function')
      title(['\it Echinodermata @ ',datestr(datenum(date),'yyyy/mm/dd')], 'FontSize',15, 'FontWeight','normal'); 
      %saveas(gcf,'ss_ech.png')    
      
    case 10 %  not in paper: birds Forests A, forests C & D
      legend = { ... % colors: blue edge tropical forests, red edge temperate forests
        {'o', 8, 3, [0 0 1], [0 0 1]}, 'Eurylaimides'; 
        {'o', 8, 3, [0 0 1], [0 1 1]}, 'Tyrannides'; 
        {'o', 8, 3, [0 0 1], [1 0 0]}, 'Meliphagides'; 
        {'o', 8, 3, [0 0 1], [1 1 1]}, 'Paradisaeidae'; 
        {'o', 8, 3, [1 0 0], [0 0 0]}, 'Sylviida'; 
        {'o', 8, 3, [1 0 0], [0 1 1]}, 'Corvidae'; 
        {'o', 8, 3, [1 0 0], [1 0 0]}, 'Sylviida'; 
        {'o', 8, 3, [1 0 0], [1 1 1]}, 'Passeroidea'; 
      };
      %tax = 'Aves'; nm_ave = select(tax); prt_tab({nm_ave,read_stat(nm_ave,{'Ww_i','p_M'}),read_eco(nm_ave,'habitat')},[],tax)
      shlegend(legend,[],[0.9 0.2]);
      %saveas(gcf,'legend_aves.png')

      shstat_options('default');
      Hfig_WpM = shstat({'Ww_i','p_M'}, legend); 
      figure(Hfig_WpM)
      xlabel('_{10}log weight W_w^\infty, g')
      ylabel('_{10}log spec som maint [p_M], J/d.cm^3')
      title(['\it aves @ ',datestr(datenum(date),'yyyy/mm/dd')], 'FontSize',15, 'FontWeight','normal'); 
      xlim([-1 6])
      %saveas(gcf,'Wwi_pM_aves.png')
      
      % Wwi-s_Rb
      shstat_options('default');
      shstat_options('y_transform', 'none'); 
      %
      vars = read_allStat({'E_0','kap_R','L_b','E_m','mu_V','M_V','Ww_i','Ww_b','s_s'});
      E_0=vars(:,1); kap_R=vars(:,2); L_b=vars(:,3); E_m=vars(:,4); mu_V=vars(:,5); M_V=vars(:,6); Ww_i=vars(:,7); s_s=vars(:,9);
      kap_R = 0.95 + 0*kap_R; % remove simultaneous hermaphrodite allocation
      s_Rb = kap_R.*L_b.^3.*(M_V.*mu_V+E_m)./E_0; % overall reproduction efficiency
      %
      Hfig_WsRb = shstat([Ww_i, s_Rb], legend); 
      figure(Hfig_WsRb)
      xlabel('_{10}log weight W_w^\infty, g')
      ylabel('overall reprod efficiency s_R^b, -')
      title(['\it aves @ ',datestr(datenum(date),'yyyy/mm/dd')], 'FontSize',15, 'FontWeight','normal'); 
      xlim([-1 6])
      %saveas(gcf,'Wwi_sRb_aves.png')

    case 11 %  not in paper: pM_ss
      legend = {...
        {'o', 8, 3, [0 0 0], [0 0 0]}, 'Gekkota'; ...
        {'o', 8, 3, [0 0 1], [0 0 0]}, 'Scinciformata'; ....
        {'o', 8, 3, [0 0 1], [0 1 1]}, 'Laterata'; ....
        {'o', 8, 3, [1 0 1], [0 0 0]}, 'Anguimorpha'; ....
        {'o', 8, 3, [1 0 1], [1 0 0]}, 'Iguania'; ....
        {'o', 8, 3, [1 0 0], [1 0 0]}, 'Serpentes'; ....
      };

      shstat_options('default');
      shstat_options('y_transform', 'none');

      [Hfig, Hleg] = shstat({'p_M','s_s'}, legend, datestr(datenum(date),'yyyy/mm/dd'));
      
      figure(Hfig)
      xlabel('_{10}log spec som maint [p_M], J/d.cm^3')
      ylabel('supply stress, s_s, -')
      %saveas(gca,'pM_ss.png')
      
    case 12 %   not in paper: Aves
      nm = select('Passeriformes'); n = length(nm); 
      climate = read_eco(nm, 'climate');
      data = read_stat(nm,{'Ww_i', 'p_M', 'J_Oi', 'c_T'}); 
      Ww_i = data(:,1); p_M = data(:,2); jO_i = data(:,3)./data(:,4)./Ww_i;
       
      %figure Wwi-pM Aves climate
      [color sel] = climate2color(climate);
      leg = cell(n,2); for j=1:n; leg{j,1} = {'o',3,1,color(j,:),color(j,:)}; leg{j,2} = strrep(nm{j},'_',' ');  end
      plot2i([log10(Ww_i(sel)), log10(p_M(sel))], leg(sel,:), ['Passeriformes @ ',datestr(datenum(date),'yyyy/mm/dd')]);
      xlabel('_{10}log ultimate weight W_w^\infty, g')
      ylabel('_{10}log spec somatic maint [p_M], J/d.cm^3')
      set(gca, 'FontSize', 15, 'Box', 'on')
      %saveas(gcf,'Wwi_pM_Aves.png')
       
      %figure Wwi-jOi Aves climate
      [color sel] = climate2color(climate);
      leg = cell(n,2); for j=1:n; leg{j,1} = {'o',3,1,color(j,:),color(j,:)}; leg{j,2} = strrep(nm{j},'_',' ');  end
      plot2i([log10(Ww_i(sel)), log10(jO_i(sel))], leg(sel,:), ['Passeriformes @ ',datestr(datenum(date),'yyyy/mm/dd')]);
      xlabel('_{10}log ultimate weight W_w^\infty, g')
      ylabel('_{10}log spec respiration at 20 C, j_O^\infty, mol/d.g')
      set(gca, 'FontSize', 15, 'Box', 'on')
      %saveas(gcf,'Wwi_jOi_Aves.png')
       
    case 13 %   not in paper: Mammalia
      nm = select('Mammalia'); n = length(nm); 
      climate = read_eco(nm, 'climate'); 
      data = read_stat(nm,{'Ww_i', 'p_M', 'J_Oi', 'c_T'}); 
      Ww_i = data(:,1); p_M = data(:,2); jO_i = data(:,3)./data(:,4)./Ww_i;
       
      %figure Wwi-pM Mammalia climate
      color = climate2color(climate);
      leg = cell(n,2); for j=1:n; leg{j,1} = {'o',8,3,color(j,:),color(j,:)}; leg{j,2} = strrep(nm{j},'_',' ');  end
      plot2i([log10(Ww_i), log10(p_M)], leg, ['Mammalia @ ',datestr(datenum(date),'yyyy/mm/dd')]);
      xlabel('_{10}log ultimate weight W_w^\infty, g')
      ylabel('_{10}log spec somatic maint [p_M], J/d.cm^3')
      set(gca, 'FontSize', 15, 'Box', 'on')
      %saveas(gcf,'Wwi_pM_Mamm.png')
       
      %figure Wwi-jOi Mammalia climate
      %color = climate2color(climate);
      leg = cell(n,2); for j=1:n; leg{j,1} = {'o',8,3,color(j,:),color(j,:)}; leg{j,2} = strrep(nm{j},'_',' ');  end
      plot2i([log10(Ww_i), log10(jO_i)], leg, ['Mammalia @ ',datestr(datenum(date),'yyyy/mm/dd')]);
      xlabel('_{10}log ultimate weight W_w^\infty, g')
      ylabel('_{10}log spec respiration at 20 C, j_O^\infty, mol/d.g')
      set(gca, 'FontSize', 15, 'Box', 'on')
      %saveas(gcf,'Wwi_jOi_Mamm.png')
       
    case 14 %  not in paper: Actinopterygii
      nm = [select('Arhynchobatidae');select('Rajidae')]; n = length(nm); 
      habitat = read_eco(nm, 'habitat');
      data = read_stat(nm,{'Ww_i', 'p_M', 'J_Oi', 'c_T'}); 
      Ww_i = data(:,1); p_M = data(:,2); jO_i = data(:,3)./data(:,4)./Ww_i;
       
      %figure Wwi-pM Pisces habitat
      [color, sel] = habitat2color(habitat);
      leg = cell(n,2); for j=1:n; leg{j,1} = {'o',8,3,color(j,:),color(j,:)}; leg{j,2} = strrep(nm{j},'_',' ');  end
      plot2i([log10(Ww_i(sel)), log10(p_M(sel))], leg(sel,:), ['Pisces @ ',datestr(datenum(date),'yyyy/mm/dd')]);
      xlabel('_{10}log ultimate weight W_w^\infty, g')
      ylabel('_{10}log spec somatic maint [p_M], J/d.cm^3')
      set(gca, 'FontSize', 15, 'Box', 'on')
      %saveas(gcf,'Wwi_pM_Pisc.png')
       
      %figure Wwi-jOi Pisces habitat
      %color = habitat2color(habitat);
      leg = cell(n,2); for j=1:n; leg{j,1} = {'o',6,2,color(j,:),color(j,:)}; leg{j,2} = strrep(nm{j},'_',' ');  end
      plot2i([log10(Ww_i(sel)), log10(jO_i(sel))], leg(sel,:), ['Pisces @ ',datestr(datenum(date),'yyyy/mm/dd')]);
      xlabel('_{10}log ultimate weight W_w^\infty, g')
      ylabel('_{10}log spec respiration at 20 C, j_O^\infty, mol/d.g')
      set(gca, 'FontSize', 15, 'Box', 'on')
      %saveas(gcf,'Wwi_jOi_Pisc.png')
 
    case 15 %  not in paper: glires: pika's vs voles 
      legend = { ... % colors: blue edge grass eaters, red edge carnivores
        {'o', 8, 3, [0 0 1], [0 0 1]}, 'Leporidae'; % grass eaters
        {'o', 8, 3, [0 0 1], [1 0 0]}, 'Ochotonidae'; % grass eaters
        {'o', 8, 3, [1 0 0], [0 0 1]}, 'Arvicolinae'; % seed eaters	
        {'o', 8, 3, [1 0 0], [0 1 1]}, 'Neotominae'; % seed eaters	
        {'o', 8, 3, [1 0 0], [1 0 0]}, 'Sigmodontinae'; % seed eaters	
        {'o', 8, 3, [1 0 0], [1 1 1]}, 'Tylomyinae'; % seed eaters	
      };
      shlegend(legend,[],[0.9 0.2]);
      %saveas(gcf,'legend_gli.png')

      shstat_options('default');
      Hfig_WpM = shstat({'Ww_i','p_M'}, legend); 
      figure(Hfig_WpM)
      xlabel('_{10}log weight W_w^\infty, g')
      ylabel('_{10}log spec som maint [p_M], J/d.cm^3')
      title(['\it glires @ ',datestr(datenum(date),'yyyy/mm/dd')], 'FontSize',15, 'FontWeight','normal'); 
      xlim([-1 6])
      %saveas(gcf,'Wwi_pM_gli.png')

      WJc = read_allStat({'Ww_i','J_Oi','c_T'}); Ww_i = WJc(:,1); j_Oi = WJc(:,2)./WJc(:,1)./WJc(:,3); 
      Hfig_WjOi = shstat([Ww_i,j_Oi], legend); 
      figure(Hfig_WjOi)
      xlabel('_{10}log weight W_w^\infty, g')
      ylabel('_{10}log spec respiration, mol O_2/d.g')
      title(['\it glires @ ',datestr(datenum(date),'yyyy/mm/dd')], 'FontSize',15, 'FontWeight','normal'); 
      xlim([-1 6])
      %saveas(gcf,'Wwi_jOi_gli.png')

      % Wwi-s_Rb
      shstat_options('default');
      shstat_options('y_transform', 'none'); 
      %
      vars = read_allStat({'E_0','kap_R','L_b','E_m','mu_V','M_V','Ww_i','Ww_b','s_s'});
      E_0=vars(:,1); kap_R=vars(:,2); L_b=vars(:,3); E_m=vars(:,4); mu_V=vars(:,5); M_V=vars(:,6); Ww_i=vars(:,7); s_s=vars(:,9);
      kap_R = 0.95 + 0*kap_R; % remove simultaneous hermaphrodite allocation
      s_Rb = kap_R.*L_b.^3.*(M_V.*mu_V+E_m)./E_0; % overall reproduction efficiency
      %
      Hfig_WsRb = shstat([Ww_i, s_Rb], legend); 
      figure(Hfig_WsRb)
      xlabel('_{10}log weight W_w^\infty, g')
      ylabel('overall reprod efficiency s_R^b, -')
      title(['\it glires @ ',datestr(datenum(date),'yyyy/mm/dd')], 'FontSize',15, 'FontWeight','normal'); 
      xlim([-1 6])
      %saveas(gcf,'Wwi_sRb_gli.png')

    case 16 %  not in paper: ducks
      legend = { ... % colors: blue edge grass eaters, red edge carnivores
        {'o', 8, 3, [0 0 0], [0 0 0]}, 'Dendrocygninae'; % plant eaters
        {'o', 8, 3, [0 0 0], [1 1 1]}, 'Tadorninae'; % plant eaters
        {'o', 8, 3, [0 0 1], [1 1 1]}, 'Anserinae'; % plant eaters
        {'o', 8, 3, [0 0 1], [0 0 1]}, 'Anas'; % plant eaters
        {'o', 8, 3, [0 0 1], [0 0 1]}, 'Mareca'; % plant eaters
        {'o', 8, 3, [0 0 1], [0 0 1]}, 'Spatula'; % plant eaters
        {'o', 8, 3, [1 0 0], [1 0 0]}, 'Oxyurini'; % fish eaters	
        {'o', 8, 3, [1 0 0], [1 0 0]}, 'Mergini'; % fish eaters	
        {'o', 8, 3, [1 0 0], [1 1 1]}, 'Aythya'; % insect/worm eaters
      };
      %tax = 'Anseriformes'; nm_ans = select(tax); prt_tab({nm_ans,read_stat(nm_ans,{'Ww_i','p_M'}),read_eco(nm_and,'habitat')},[],tax)
      shlegend(legend,[],[0.9 0.2]);
      %saveas(gcf,'legend_ans.png')

      shstat_options('default');
      Hfig_WpM = shstat({'Ww_i','p_M'}, legend); 
      figure(Hfig_WpM)
      xlabel('_{10}log weight W_w^\infty, g')
      ylabel('_{10}log spec som maintenance [p_M], J/d.cm^3')
      xlim([2 4.5])
      %saveas(gcf,'Wwi_pM_ans.png')

      WJc = read_allStat({'Ww_i','J_Oi','c_T'}); Ww_i = WJc(:,1); j_Oi = WJc(:,2)./WJc(:,1)./WJc(:,3); 
      Hfig_WjOi = shstat([Ww_i,j_Oi], legend); 
      figure(Hfig_WjOi)
      xlabel('_{10}log weight W_w^\infty, g')
      ylabel('_{10}log spec respiration, mol O_2/d.g')
      xlim([-1 6])
      %saveas(gcf,'Wwi_jOi_mam.png')
      
    end
  end
end

function [color sel] = climate2color(climate)
   n = length(climate); color = ones(n,3); sel = false(n,1);
   for i = 1:n
%      A = any(contains(climate{i},'A')); 
%      B = any(contains(climate{i},'B')); 
%      C = any(contains(climate{i},'C')); 
%      D = any(contains(climate{i},'D')); 
%      E = any(contains(climate{i},'E')); 
%      val = (0.1*A + 0.3*B + 0.5*C + 0.7*D + 0.9*E)/ (A + B + C + D + E);
%      color(i,:) = color_lava(val); 
     if     any(contains(climate{i},'A'))&& ~any(contains(climate{i},{'B','C','D','E'})); color(i,:) = [0 0 0]; sel(i) = true;
     elseif any(contains(climate{i},'B'))&& ~any(contains(climate{i},{'A','C','D','E'})); color(i,:) = [0 0 1]; sel(i) = true;
     elseif any(contains(climate{i},'C'))&& ~any(contains(climate{i},{'A','B','D','E'})); color(i,:) = [1 0 1]; sel(i) = true;
     elseif any(contains(climate{i},'D'))&& ~any(contains(climate{i},{'A','B','C','E'})); color(i,:) = [1 0 0]; sel(i) = true; 
     elseif any(contains(climate{i},'E'))&& ~any(contains(climate{i},{'A','B','C','D'})); color(i,:) = [0 1 0]; sel(i) = true;
     end
     %val = (0.1*A + 0.3*B + 0.5*C + 0.7*D + 0.9*E)/ (A + B + C + D + E);
     %color(i,:) = color_lava(val); 
   end 
end

function [color, sel] = habitat2color(habitat)
   n = length(habitat); color = NaN(n,3); sel = false(n,1);
   for i = 1:n
     if any(contains(habitat{i},'Mr')); val = 0.0; sel(i)= true;
     elseif any(contains(habitat{i},'Mdb')); val = 0.3; sel(i)= true;
     elseif any(contains(habitat{i},'Mb')); val = 0.5; sel(i)= true;
     elseif any(contains(habitat{i},'Mc')); val = 0.7; sel(i)= true;
     elseif any(contains(habitat{i},'Mi'));  val = 0.9; sel(i)= true;
     else val = NaN; sel(i)= false;
     end
     color(i,:) = color_lava(val);
   end
    
end