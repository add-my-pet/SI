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
   {'-', 2, [0 0 1]}, 'Aves'; 
   {'-', 2, [1 0 0]}, 'Placentalia'; 
  };

 legend = { ... % 
   {'o', 8, 3, [0 0 0], [0 0 0]}, 'Mollusca';  
   {'o', 8, 3, [0 0 1], [0 0 1]}, 'Aves';
   {'o', 8, 3, [1 0 0], [1 0 0]}, 'Placentalia'; 
 };

 for i=1:length(fig)
 
 switch fig(i)
   case 1 % Fig 1
     vars = read_allStat({'E_0','kap_R','L_b','E_m','mu_V','M_V'});
     E_0=vars(:,1); kap_R=vars(:,2); L_b=vars(:,3); E_m=vars(:,4); mu_V=vars(:,5); M_V=vars(:,6); 
     
     effR = kap_R.*L_b.^3.*(M_V.*mu_V+E_m)./E_0; % total reproduction efficiency
     heffR = shstat(effR, llegend, 'Mollusca & Aves & Placentalia'); 
     figure(heffR)
     xlabel('total reproduction efficiency, -')
     print -r0 -dpng effR_Mol_Ave_Pla.png

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
      
 end
end
      
end

