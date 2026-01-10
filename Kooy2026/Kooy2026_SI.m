function Kooy2026_SI(fig)
% Supporting Information for Kooy2026
% Title: The ecofysiology of food chains
% Authors: Kooijman
% Journal: Ecol. Mod
% DOI: 
% Date: 2026/01/07
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
  
for i=1:length(fig)
 
  switch fig(i)
    case 1 % ss_sRb
      shstat_options('default');
      shstat_options('y_label', 'off'); 
      shstat_options('x_label', 'off'); 
      shstat_options('x_transform', 'none'); 
      shstat_options('y_transform', 'none'); 
        
     vars = read_allStat({'E_0','kap_R','L_b','E_m','mu_V','M_V','Ww_i','Ww_b','s_s'});
     E_0=vars(:,1); kap_R=vars(:,2); L_b=vars(:,3); E_m=vars(:,4); mu_V=vars(:,5); M_V=vars(:,6); s_s=vars(:,9);
     kap_R = 0.95 + 0*kap_R; % remove simultaneous hermaphrodite allocation
     s_Rb = kap_R.*L_b.^3.*(M_V.*mu_V+E_m)./E_0; % overall reproduction efficiency

     legend = legend_shark; %legend(end,:)=[];
     shlegend(legend,[],[0.9 0.2]);
     saveas(gcf,'legend_chon.png')
     hleg_ss_sRb = shstat([s_s,s_Rb], legend); 
     %
     figure(hleg_ss_sRb)
     xlabel('supply stress, s_s')
     ylabel('overall reprod efficiency, s_R^b')
     title(['\it chondrichthyes @ ',datestr(datenum(date),'yyyy/mm/dd')], 'FontSize',15, 'FontWeight','normal'); 
     set(gca, 'FontSize',15, 'Box','on')
     xlim([0,4/27]); ylim([0,1]);
     saveas(gcf,'ss_sRb_chon.png')

     legend = legend_aves; legend(end,:)=[];
     shlegend(legend,[],[0.9 0.2]);
     saveas(gcf,'legend_aves.png')
     hleg_ss_sRb = shstat([s_s,s_Rb], legend); 
     %
     figure(hleg_ss_sRb)
     xlabel('supply stress, s_s')
     ylabel('overall reprod efficiency, s_R^b')
     title(['\it aves @ ',datestr(datenum(date),'yyyy/mm/dd')], 'FontSize',15, 'FontWeight','normal'); 
     set(gca, 'FontSize', 15, 'Box', 'on')
     xlim([0,4/27]); ylim([0,1]);
     saveas(gcf,'ss_sRb_aves.png')
     
     legend = legend_mamm; legend(end,:)=[];
     shlegend(legend,[],[0.9 0.2]);
     saveas(gcf,'legend_mamm.png')
     hleg_ss_sRb = shstat([s_s,s_Rb], legend); 
     %
     figure(hleg_ss_sRb)
     xlabel('supply stress, s_s')
     ylabel('overall reprod efficiency, s_R^b')
     title(['\it mammalia @ ',datestr(datenum(date),'yyyy/mm/dd')], 'FontSize',15, 'FontWeight','normal'); 
     set(gca, 'FontSize', 15, 'Box', 'on')
     xlim([0,4/27]); ylim([0,1]);
     saveas(gcf,'ss_sRb_mamm.png')

     legend = legend_actino; legend(end,:)=[];
     shlegend(legend,[],[0.9 0.2]);
     saveas(gcf,'legend_actino.png')
     hleg_ss_sRb = shstat([s_s,s_Rb], legend); 
     %
     figure(hleg_ss_sRb)
     xlabel('supply stress, s_s')
     ylabel('overall reprod efficiency, s_R^b')
     title(['\it actinopterygii @ ',datestr(datenum(date),'yyyy/mm/dd')], 'FontSize',15, 'FontWeight','normal'); 
     set(gca, 'FontSize', 15, 'Box', 'on')
     xlim([0,4/27]); ylim([0,1]);
     saveas(gcf,'ss_sRb_actino.png')

     legend = legend_amphibia; legend(end,:)=[];
     shlegend(legend,[],[0.9 0.2]);
     saveas(gcf,'legend_amphibia.png')
     hleg_ss_sRb = shstat([s_s,s_Rb], legend); 
     %
     figure(hleg_ss_sRb)
     xlabel('supply stress, s_s')
     ylabel('overall reprod efficiency, s_R^b')
     title(['\it amphibia @ ',datestr(datenum(date),'yyyy/mm/dd')], 'FontSize',15, 'FontWeight','normal'); 
     set(gca, 'FontSize', 15, 'Box', 'on')
     xlim([0,4/27]); ylim([0,1]);
     saveas(gcf,'ss_sRb_amphibia.png')

     legend = legend_rept; legend(end,:)=[];
     shlegend(legend,[],[0.9 0.2]);
     saveas(gcf,'legend_rept.png')
     hleg_ss_sRb = shstat([s_s,s_Rb], legend); 
     %
     figure(hleg_ss_sRb)
     xlabel('supply stress, s_s')
     ylabel('overall reprod efficiency, s_R^b')
     title(['\it reptilia @ ',datestr(datenum(date),'yyyy/mm/dd')], 'FontSize',15, 'FontWeight','normal'); 
     set(gca, 'FontSize', 15, 'Box', 'on')
     xlim([0,4/27]); ylim([0,1]);
     saveas(gcf,'ss_sRb_rept.png')

   case 2 % Wwb_sRb
     shstat_options('default');
     shstat_options('y_label', 'off'); 
     shstat_options('x_label', 'off'); 
     shstat_options('x_transform', 'log10'); 
     shstat_options('y_transform', 'none'); 
        
     vars = read_allStat({'E_0','kap_R','L_b','E_m','mu_V','M_V','Ww_i','Ww_b','s_s'});
     E_0=vars(:,1); kap_R=vars(:,2); L_b=vars(:,3); E_m=vars(:,4); mu_V=vars(:,5); M_V=vars(:,6); Ww_b=vars(:,8);
     kap_R = 0.95 + 0*kap_R; % remove simultaneous hermaphrodite allocation
     s_Rb = kap_R.*L_b.^3.*(M_V.*mu_V+E_m)./E_0; % overall reproduction efficiency

     shlegend(legend_RSED,[],[0.9 0.2]);
     saveas(gcf,'legend_RSED.png')
     hleg_ss_sRb = shstat([Ww_b,s_Rb], legend_RSED); 
     %
     figure(hleg_ss_sRb)
     xlabel('weight at birth W_w^b, g')
     ylabel('overall reprod efficiency, s_R^b')
     title(['\it RSED @ ',datestr(datenum(date),'yyyy/mm/dd')], 'FontSize',15, 'FontWeight','normal'); 
     set(gca, 'FontSize',15, 'Box','on')
     %saveas(gcf,'Wwb_sRb_RSED.png')
     
   case 3 % ss distribution in food chains
     llegend = {...
       {'-', 2, [0 0 0]}, 'Crustacea'; ....
       {'-', 2, [0 0 1]}, 'Clupeiformes'; ....
       {'-', 2, [1 0 0]}, 'Selachii'; ....
     };
     shllegend(llegend,[],[0.9 0.2]);
     %saveas(gcf,'legend_CrusClupSela.png')
     
     shstat_options('default');
     shstat_options('x_transform', 'none');
     shstat_options('y_label', 'on'); % if 'off' (default), no `survivor function' shown on yaxis
     %
     Hfig_ss = shstat({'s_s'}, llegend); 
     figure(Hfig_ss)
     xlabel('supply stress, s_s')
     title(['\it aquatic chain @ ',datestr(datenum(date),'yyyy/mm/dd')], 'FontSize',15, 'FontWeight','normal'); 
     set(gca, 'FontSize', 15, 'Box', 'on')
     xlim([0,4/27]); ylim([0,1]);
     %saveas(gcf,'ss_CrusClupSela.png')

     llegend = {...
       {'-', 2, [0 0 0]}, 'Hexapoda'; ....
       {'-', 2, [0 0 1]}, 'Passeriformes'; ....
       {'-', 2, [1 0 0]}, 'Hieraves'; ....
     };
     shllegend(llegend,[],[0.9 0.2]);
     %saveas(gcf,'legend_HexaPassHier.png')

     Hfig_ss = shstat({'s_s'}, llegend);  
     figure(Hfig_ss)
     xlabel('supply stress, s_s')
     title(['\it terrestrial chain @ ',datestr(datenum(date),'yyyy/mm/dd')], 'FontSize',15, 'FontWeight','normal'); 
     set(gca, 'FontSize', 15, 'Box', 'on')
     xlim([0,4/27]); ylim([0,1]);
     %saveas(gcf,'ss_HexaPassHier.png')
     
   case 4
     nm = {'Asellus_aquaticus'; 'Alburnus_alburnus'; 'Perca_flavescens'; 'Esox_lucius'; 'Pandion_haliaetus'};
     vars = read_stat(nm,{'E_0','kap','kap_R','L_b','E_m','mu_V','M_V','Ww_i','Ww_b','s_s'});
     E_0=vars(:,1); kap=vars(:,2); kap_R=vars(:,3); L_b=vars(:,4); E_m=vars(:,5); mu_V=vars(:,6); M_V=vars(:,7); Ww_i=vars(:,8); Ww_b=vars(:,9); s_s=vars(:,10);
     kap_R = 0.95 + 0*kap_R; % remove simultaneous hermaphrodite allocation
     s_Rb = kap_R.*L_b.^3.*(M_V.*mu_V+E_m)./E_0; % overall reproduction efficiency
     kap_RA = 1 - kap - s_s./ kap.^2; % frac of assim to reprod

     prt_tab({nm,kap,kap_RA,s_s,s_Rb},{'species','kap','kap_RA','s_s','s_Rb'});
     
   case 5
     shstat_options('default');
     shlegend(legend_RSED, [0.7 0.2], [0.8 0.2]);
     saveas(gca,'legend_RSED.png')

     La = read_allStat({'L_i','a_m','c_T','N_i','Ww_b','Ww_i'}); L_i = La(:,1); a_m = La(:,2).*La(:,3); 
     N_i = La(:,4); Ww_b = La(:,5); Ww_i = La(:,6); Ww_ib = N_i .* Ww_b;
     Hfig_Liam = shstat([L_i, a_m], legend_RSED);  
     figure(Hfig_Liam)
     plot([-2.5; 2.5],[0.4; 5.4], 'k', 'LineWidth', 2)
     xlabel('_{10}log ultimate structural length L_\infty, cm')
     ylabel('_{10}log life span @ 20C, d')
     title(['\it 7325 species @ ',datestr(datenum(date),'yyyy/mm/dd')], 'FontSize',15, 'FontWeight','normal'); 
     set(gca, 'FontSize', 15, 'Box', 'on')
     saveas(gca,'Li_am_RSED.png')
 
     Hfig_WwiWwib = shstat([Ww_i, Ww_ib], legend_RSED);  
     figure(Hfig_WwiWwib)
     plot([-10; 10],[-10; 10], 'k', 'LineWidth', 2)
     xlabel('_{10}log ultimate weight W_w^\infty, g')
     ylabel('_{10}log life-time neonate mass, g')
     title(['\it 7325 species @ ',datestr(datenum(date),'yyyy/mm/dd')], 'FontSize',15, 'FontWeight','normal'); 
     xlim([-10 10]); ylim([-10 10]); 
     set(gca, 'FontSize', 15, 'Box', 'on')
     saveas(gca,'Wwi_Wwib_RSED.png')

end

end