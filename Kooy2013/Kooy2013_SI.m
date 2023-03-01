function Kooy2013_SI(figi)
% Supporting Information for Kooy2013
% Title:  Waste to hurry: Dynamic Energy Budgets explain the need of wasting to fully exploit blooming resources.
% Authors: Kooijman
% Journal: Oikos 122 (2013): 348–357
% DOI: 10.1111/j.1600-0706.2012.00098.x
% Date: 2023/03/01
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
%
% To run the code (here for section 3), open this file in the Matlab Editor and type in the Matlab window: Kooy2013_SI(3)
%
% Remarks: 
%  The figures show current AmP data, which might change in time; the results might differ from the publication
%  The scripts call functions read_allStat; the first call to these functions loads the allStat.mat file, which can take some time
%  Click on a marker in the Matlab-figure to see the species name
%  Uncomment "print" to save the Matlab-figure to a png-file
%  Modify selection of taxa and markers by changing the legend (e.g. legend_RSED), see https://add-my-pet.github.io/AmPtool/docs/index.html
%  Allowed names of taxa match the names of the tree nodes at http://www.bio.vu.nl/thb/deb/deblab/add_my_pet/species_tree_Animalia.html

  close all
  
  title = ['animals ', datestr(date,26)];

  if ~exist('figi','var')
    figi = 1:11;
  end

  for i=1:length(figi)
 
    switch figi(i)
      case 1 % fig 1: surv COMPLETE mark
        shstat_options('x_transform','none');
        [HfigCOM, HlegCOM] = shstat({'COMPLETE'}, [], title); 
        
        figure(HfigCOM)
        xlabel('COMPLETE mark, -')
        %print -r0 -dpng COMPLETE.png
         
      case 2 % fig 2: surv Fit mark
        shstat_options('x_transform','none');
        FIT = 10 * (1 - read_allStat('MRE'));
        [HfigFIT, HlegFIT] = shstat(FIT, [], title); 
        
        figure(HfigFIT)
        xlim([0 10])
        xlabel('FIT mark, -')
        %print -r0 -dpng FIT.png
          
      case 3 % fig 3: Wwd-spec resp  for RSED 
        shstat_options('default');
        WJ = read_allStat({'Wd_i','J_Oi','c_T'}); 
        WJ(:,2) = WJ(:,3).*WJ(:,2)./WJ(:,1)*24.4/24; % L/h.g
        [HfigWdJO, HlegWdJO] = shstat(WJ, legend_RSED, title); 
        
        figure(HfigWdJO)
        xlabel('ultimate structural length, _{10}log L_{\infty}, cm')
        ylabel('spec respiration rate _{10}log J_O^{\infty}/W_d^{\infty}, L/h.g')
        %print -r0 -dpng Wd_JO.png
        figure(HlegWdJO)
        %print -r0 -dpng legend_RSED.png
         
      case 4 % fig 4a: Li-pAm for RSED 
        shstat_options('default');
        LipAmsM = read_allStat({'L_i','p_Am','s_M'});
        HfigLipAm = shstat({'L_i', 'p_Am'}, legend_RSED); 
        [HfigLipAm, HlegLipAm] = shstat([LipAmsM(:,1), LipAmsM(:,2).*LipAmsM(:,3)], legend_RSED, title, HfigLipAm);
        
        figure(HfigLipAm)
        sel = LipAmsM(:,3) > 0;
        data = log10([LipAmsM(sel,[1 2 1]), LipAmsM(sel,2) .* LipAmsM(sel,3)]);
        for j=1:size(data,1); plot(data(j,[1 3]), data(j,[2 4]), '-k', 'linewidth',2); end
        xlabel('ultimate structural length, _{10}log L_{\infty}, cm')
        ylabel('spec assim rate, _{10}log \{p_{Am}\}, J/d.cm^2')
        %print -r0 -dpng Li_pAm.png
        figure(HlegLipAm)
        %print -r0 -dpng legend_RSED.png
         
      case 5 % fig 4b: Li_pM for RSED 
        shstat_options('default');
        [HfigLipM, HlegLipM] = shstat({'L_i', 'p_M'}, legend_RSED, title); 
        
        figure(HfigLipM)
        xlabel('ultimate structural length, _{10}log L_{\infty}, cm')
        ylabel('spec somatic maint rate, _{10}log [p_M], J/d.cm^3')
        %print -r0 -dpng Li_pM.png
        figure(HlegLipM)
        %print -r0 -dpng legend_RSED.png
          
      case 6 % fig 4c: Li-kap for RSED 
        shstat_options('default');
        shstat_options('y_transform','none');
        [HfigLikap, HlegLikap] = shstat({'L_i', 'kap'}, legend_RSED, title); 
        
        figure(HfigLikap)
        ylim([0 1])
        xlabel('ultimate structural length, _{10}log L_{\infty}, cm')
        ylabel('allocation fraction to soma, \kappa, -')
        %print -r0 -dpng Li_kap.png
        figure(HlegLikap)
        %print -r0 -dpng legend_RSED.png
         
      case 7 % fig 4d: Li-v for RSED 
        shstat_options('default');
        LivsM = read_allStat({'L_i','v','s_M'});
        [HfigLiv, HlegLiv] = shstat({'L_i', 'v'}, legend_RSED); 
        HfigLiv = shstat([LivsM(:,1), LivsM(:,2).*LivsM(:,3)], legend_RSED, title, HfigLiv);
        
        figure(HfigLiv)
        sel = LivsM(:,3) > 1;
        data = log10([LivsM(sel,[1 2 1]), LivsM(sel,2) .* LivsM(sel,3)]);
        for j=1:size(data,1); plot(data(j,[1 3]), data(j,[2 4]), '-k', 'linewidth',2); end
        xlabel('ultimate structural length, _{10}log L_{\infty}, cm')
        ylabel('energy conductance, _{10}log v, cm/d')
        %print -r0 -dpng Li_v.png
        figure(HlegLiv)
        %print -r0 -dpng legend_RSED.png
          
      case 8 % fig 4e: Li-EG for RSED 
        shstat_options('default');
        [HfigLiEG, HlegLiEG] = shstat({'L_i', 'E_G'}, legend_RSED, title); 
        
        figure(HfigLiEG)
        xlabel('ultimate structural length, _{10}log L_{\infty}, cm')
        ylabel('spec costs for structure _{10}log [E_G], 1/cm^3')
        %print -r0 -dpng Li_EG.png
        figure(HlegLiEG)
        %print -r0 -dpng legend_RSED.png
          
      case 9 % fig 4f: Li-kJ for RSED 
        shstat_options('default');
        [HfigLikJ, HlegLikJ] = shstat({'L_i', 'k_J'}, legend_RSED, title); 
        
        figure(HfigLikJ)
        xlabel('ultimate structural length, _{10}log L_{\infty}, cm')
        ylabel('maturity maint rate coeff _{10}log k_J, 1/d')
        %print -r0 -dpng Li_kJ.png
        figure(HlegLikJ)
        %print -r0 -dpng legend_RSED.png
          
      case 10 % fig 4g: Li-EHb for RSED 
        shstat_options('default');
        [HfigLiEHb, HlegLiEHb] = shstat({'L_i', 'E_Hb'}, legend_RSED, title); 
        
        figure(HfigLiEHb)
        xlabel('ultimate structural length, _{10}log L_{\infty}, cm')
        ylabel('maturity at birth, _{10}log E_H^b, J')
        %print -r0 -dpng Li_EHb.png
        figure(HlegLiEHb)
        %print -r0 -dpng legend_RSED.png
          
      case 11 % fig 4h: Li-EHp for RSED 
        shstat_options('default');
        [HfigLiEHp, HlegLiEHp] = shstat({'L_i', 'E_Hp'}, legend_RSED, title); 
        
        figure(HfigLiEHp)
        xlabel('ultimate structural length, _{10}log L_{\infty}, cm')
        ylabel('maturity at puberty, _{10}log E_H^p, J')
        %print -r0 -dpng Li_EHp.png
        figure(HlegLiEHp)
        %print -r0 -dpng legend_RSED.png
          
    end
  end
end
