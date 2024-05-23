function JusuKooy2024_SI(fig)
% Supporting Information for JusuKooy2024
% Title: Comment on "Metabolic loads and the costs of metazoan reproduction"
% Authors: Jusup, Kooijman
% Journal: Science
% DOI: 
% Date: 2024/05/20
% 
% Matlab scripts to generate the figures in the publication
%
% To run the scripts you need
% 1) Matlab (the student version will suffice)
% 2) Download AmPdata from http://www.bio.vu.nl/thb/deb/deblab/add_my_pet/
%    Goto AmPdata in dropdown "COLLECTION", unpack the zip-file, save the 2 .mat-files in a directory, set the path in Matlab to this directory.
% 3) Copy DEBtool from http://www.github.com/add-my-pet/DEBtool_M/ in a directory, set the path in Matlab to this directory.
% 4) Copy AmPtool from http://www.github.com/add-my-pet/AmPtool/ in a directory, set the path in Matlab to this directory.
%
% Set Path in Matlab is in the toolbar of the Command Window of Matlab if full-screen
% Load this script-file in the Matlab Editor
% To run the code for a figure: type in the Matlab window e.g. Kooy2024_SI(4)
%
% Remarks: 
%  The figures show current AmP data, which might change in time; the results might differ from the publication
%  The scripts call functions read_popStat and read_allStat; the first call to these functions loads the .mat file, which can take some time
%  Click on a marker in the Matlab-figure to see the species name
%  Uncomment "%print" to save the Matlab-figure to a png-file
%  Modify selection of taxa and markers by changing the legend, see https://add-my-pet.github.io/AmPtool/docs/index.html
%  Allowed names of taxa match the names of the tree nodes at http://www.bio.vu.nl/thb/deb/deblab/add_my_pet/species_tree_Animalia.html

if ~exist('fig','var')
   fig = 1:1;
end

 close all
 shstat_options('default');
 shstat_options('y_label', 'on'); 
 shstat_options('x_label', 'on'); 
 shstat_options('x_transform', 'none'); 
 shstat_options('y_transform', 'none'); 
 
 llegend = {... % taxa
   {'-', 2, [0 0 0]}, 'Mollusca'; 
   {'-', 2, [0 0 1]}, 'Squamata'; 
   {'-', 2, [1 0 1]}, 'Aves'; 
   {'-', 2, [1 0 0]}, 'Placentalia'; 
  };

 legend = { ... % 
   {'o', 4, 2, [0 0 0], [1 1 1]}, 'Cephalopoda';  
   {'o', 4, 2, [0 0 0], [1 0 0]}, 'Gastropoda';  
   {'o', 4, 2, [0 0 0], [0 0 0]}, 'Mollusca';  
   {'o', 4, 2, [0 0 1], [0 0 1]}, 'Aves';
   {'o', 4, 2, [1 0 0], [1 0 0]}, 'Placentalia'; 
 };

 for i=1:length(fig)
 
 switch fig(i)
   case 1 % Fig 1
     vars = read_allStat({'E_0','kap_R','L_b','E_m','mu_V','M_V'});
     E_0=vars(:,1); kap_R=vars(:,2); L_b=vars(:,3); E_m=vars(:,4); mu_V=vars(:,5); M_V=vars(:,6);
     %kap_R = 0.95 + 0*kap_R; % remove simultaneous hermaphrodite allocation
     
     effR = kap_R.*L_b.^3.*(M_V.*mu_V+E_m)./E_0; % total reproduction efficiency
     heffR = shstat(effR, llegend, 'Mollusca & Squamata & Aves & Placentalia'); 
     figure(heffR)
     xlabel('total reproduction efficiency, -')
     print -r0 -dpng effR.png

   case 2  
     vars = read_allStat({'E_0','kap_R','L_b','E_m','mu_V','M_V'});
     E_0=vars(:,1); kap_R=vars(:,2); L_b=vars(:,3); E_m=vars(:,4); mu_V=vars(:,5); M_V=vars(:,6);  
     effR = kap_R.*L_b.^3.*(M_V.*mu_V+E_m)./E_0; % total reproduction efficiency

     vars = read_allStat({'Ww_i','Ww_b','N_i'});
     Ww_i=vars(:,1); Ww_b=vars(:,2); N_i=vars(:,3);
     nR = Ww_b .* N_i ./ Ww_i; % spec cum reprod mass prod 
     
     shstat_options('x_transform', 'log10'); 
     hnR = shstat([nR effR], legend, 'Mollusca & Aves & Placentalia'); 
     figure(hnR)
     xlabel('_{10}log spec cum reprod mass prod, -')
     ylabel('total reproduction efficiency, -')
     %print -r0 -dpng nR_effR_Mol_Ave_Pla.png
      
   case 3
     pars = read_stat('Ovis_aries', {'kap','kap_R','g','k_J','k_M','L_T','v','U_Hb','U_Hp'});    
     vars = read_stat('Ovis_aries', {'L_m','c_T','l_b','l_p','t_g','t_0','p_Am'});
     L_m=vars(1); c_T=vars(2); l_b=vars(3); l_p=vars(4); t_g=vars(5); t_0=vars(6); p_Am=vars(7); v=pars(7); 
     
     pACSJGRD = c_T*p_Am*L_m^2*scaled_power(L_m, 1, pars, l_b, l_p); p_Di = pACSJGRD(7); % J/d, dissipation for adult female
     
     a = linspace(1e-3,t_g,100)'; L = c_T * v * a/ 3; t=[1e-4; t_0 + a]; L = [0; L];
     pACSJGRD = c_T*p_Am*L_m^2*scaled_power(L, 1, pars, l_b, l_p); p_De = pACSJGRD(:,7); % J/d, dissipation for foetus
     
     figure
     plot(t*24,p_Di*ones(101,1)/24,'k','linewidth',2); hold on
     plot(t*24,(p_Di+p_De)/24,'r','linewidth',2);
     xlabel('time since start of foetal development, h')
     ylabel('heat of foetus + mother, J/h')
     print -r0 -dpng t_pD_Ovis.png
     
     % integrated foetal heat: estimate by GintCame2024 3600*(4.3e5-2.9e5)/2=252 MJ
     ip_b = ispline1([0;t_g], [t,p_De]);
     fprintf('integrated heat difference over gestation period: %d J\n',ip_b(2))
     % this is 16.5 MJ, so a fraction of 0.0655 of the value of GintCame2024

 end
end
      
end

