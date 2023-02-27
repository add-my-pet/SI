function KooyLika2014a_SI(fig)
% Supporting Information for KooyLika2014
% Title: Comparative energetics of the 5 fish classes on the basis of dynamic energy budgets.
% Authors: Kooijman, Lika
% Journal: J. Sea Res. 94 (2014): 19-28
% DOI: 10.1016/j.seares.2014.01.015
% Date: 2023/02/26
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
% To run the code for a figure: type in the Matlab window e.g. KooyLika2014a_SI(2)
%
% Remarks: 
%  The figures show current AmP data, which might change in time; the results might differ from the publication
%  The scripts call functions read_popStat and read_allStat; the first call to these functions loads the .mat file, which can take some time
%  Case 12 involves the optimasation of kap, which takes substantial computer time
%  Click on a marker in the Matlab-figure to see the species name
%  Uncomment "print" to save the Matlab-figure to a png-file
%  Modify selection of taxa and markers by changing the legend, see https://add-my-pet.github.io/AmPtool/docs/index.html
%  Allowed names of taxa match the names of the tree nodes at http://www.bio.vu.nl/thb/deb/deblab/add_my_pet/species_tree_Animalia.html

  close all

  title = ['fish ', datestr(date,26)];
  
  legend = {...
    {'o', 8, 3, [0 0 0], [1 1 1]}, 'Cyclostomata'; ...
    {'o', 8, 3, [0 0 1], [1 1 1]}, 'Chondrichthyes'; ....
    {'o', 8, 3, [1 0 0], [1 1 1]}, 'Actinopterygii'; ....
    {'o', 8, 3, [1 0 1], [1 1 1]}, 'Latimeria'; ....
    {'o', 8, 3, [0.5 0 0.5], [1 1 1]}, 'Dipnoi'; ....
    {'.', 8, 3, [0 0 0], [1 1 1]}, 'vertebrata'; ....
  };

  llegend = {...
    {'-', 2, [0 0 0]}, 'Cyclostomata'; ....
    {'-', 2, [0 0 1]}, 'Chondrichthyes'; ....
    {'-', 2, [1 0 0]}, 'Actinopterygii'; ....
    {'-', 2, [1 0 1]}, 'Latimeria'; ....
    {'-', 2, [0.5 0 0.5]}, 'Dipnoi'; ....
  };

  llegend_CAA = {...
    {'-', 2, [0 0 0]}, 'Animalia'; ....
    {'-', 2, [0 0 1]}, 'Chondrichthyes'; ....
    {'-', 2, [1 0 0]}, 'Actinopterygii'; ....
  };

  if ~exist('fig','var')
    fig = 1:28;
  end

  close all
  
  shstat_options('default');
  shstat_options('y_label', 'on'); 
  shstat_options('x_label', 'off'); 
  
  for i=1:length(fig)
    switch fig(i)
      case 1 % fig 1a: Li-pAm  
        shstat_options('default');
        LipAmsM = read_allStat({'L_i','p_Am','s_M'});
        [HfigLipAm, HlegLipAm] = shstat({'L_i', 'p_Am'}, legend); 
        HfigLipAm = shstat([LipAmsM(:,1), LipAmsM(:,2).*LipAmsM(:,3)], legend, title, HfigLipAm);
        
        figure(HfigLipAm)
        sel = select_01('Actinopterygii') & LipAmsM(:,3) > 0;
        data = log10([LipAmsM(sel,[1 2 1]), LipAmsM(sel,2) .* LipAmsM(sel,3)]);
        for j=1:size(data,1); plot(data(j,[1 3]), data(j,[2 4]), '-k', 'linewidth',2); end
        xlabel('ultimate structural length, _{10}log L_{\infty}, cm')
        ylabel('spec assim rate, \{p_{Am}\}, J/d.cm^2')
        %print -r0 -dpng Li_p_Am.png
        figure(HlegLipAm)
        %print -r0 -dpng legend.png
          
      case 2 % fig 1b: Li-v
        shstat_options('default');
        LivsM = read_allStat({'L_i','v','s_M'});
        [HfigLiv, HlegLiv] = shstat({'L_i', 'v'}, legend); 
        HfigLiv = shstat([LivsM(:,1), LivsM(:,2).*LivsM(:,3)], legend, title, HfigLiv);
        
        figure(HfigLiv)
        sel = select_01('Actinopterygii') & LivsM(:,3) > 0;
        data = log10([LivsM(sel,[1 2 1]), LivsM(sel,2) .* LivsM(sel,3)]);
        for j=1:size(data,1); plot(data(j,[1 3]), data(j,[2 4]), '-k', 'linewidth',2); end
        xlabel('ultimate structural length, _{10}log L_{\infty}, cm')
        ylabel('energy conductance, v, cm/d')
        %print -r0 -dpng Li_v.png
        figure(HlegLiv)
        %print -r0 -dpng legend.png
          
      case 3 % fig 1c: Li-kap
        shstat_options('x_transform','log10');
        shstat_options('y_transform','none');
        [HfigLikap HlegLikap] = shstat({'L_i', 'kap'}, legend); 
     
        figure(HfigLikap)
        xlabel('ultimate structural length, _{10}log L_{\infty}, cm')
        ylabel('allocation fraction to soma, \kappa, -')
        %print -r0 -dpng Li_kap.png
        figure(HlegLikap)
        %print -r0 -dpng legend.png
          
      case 4 % fig 1d: Li-pM  
        shstat_options('default');
        [HfigLipM, HlegLipM] = shstat({'L_i', 'p_M'}, legend); 
        
        figure(HfigLipM)
        xlabel('ultimate structural length, _{10}log L_{\infty}, cm')
        ylabel('spec somatic maint rate, [p_M], J/d.cm^3')
        %print -r0 -dpng Li_pM.png
        figure(HlegLipM)
        %print -r0 -dpng legend.png

      case 5 % fig 1e: Li-kJ   
        shstat_options('default');
        [HfigLikJ, HlegLikJ] = shstat({'L_i', 'k_J'}, legend); 
        
        figure(HfigLikJ)
        xlabel('ultimate structural length, _{10}log L_{\infty}, cm')
        ylabel('maturity maint rate coeff, k_J, 1/d')
        %print -r0 -dpng Li_kJ.png
        figure(HlegLikJ)
        %print -r0 -dpng legend.png

      case 6 % fig 1f: Li-EG
        shstat_options('default');
        [HfigLiEG, HlegLiEG] = shstat({'L_i', 'E_G'}, legend); 
        
        figure(HfigLiEG)
        xlabel('ultimate structural length, _{10}log L_{\infty}, cm')
        ylabel('spec cost for struct, [E_G], J/cm^3')
        %print -r0 -dpng Li_EG.png
        figure(HlegLiEG)
        %print -r0 -dpng legend.png
          
      case 7 % fig 1g: Li-EHb
        shstat_options('default');
        [HfigLiEHb, HlegLiEHb] = shstat({'L_i', 'E_Hb'}, legend); 
        
        figure(HfigLiEHb)
        xlabel('ultimate structural length, _{10}log L_{\infty}, cm')
        ylabel('maturity at birth, E_H^b, J')
        %print -r0 -dpng Li_EHb.png
        figure(HlegLiEHb)
        %print -r0 -dpng legend.png

      case 8 % fig 1h: Li-EHj
        shstat_options('default');
        [HfigLiEHj, HlegLiEHj] = shstat({'L_i', 'E_Hj'}, legend); 
        
        figure(HfigLiEHj)
        xlabel('ultimate structural length, _{10}log L_{\infty}, cm')
        ylabel('maturity at metam, E_H^j, J')
        %print -r0 -dpng Li_EHj.png
        figure(HlegLiEHj)
        %print -r0 -dpng legend.png

      case 9 % fig 1i: Li-EHp
        shstat_options('default');
        [HfigLiEHp, HlegLiEHp] = shstat({'L_i', 'E_Hp'}, legend); 
        
        figure(HfigLiEHp)
        xlabel('ultimate structural length, _{10}log L_{\infty}, cm')
        ylabel('maturity at puberty, E_H^p, J')
        %print -r0 -dpng Li_EHp.png
        figure(HlegLiEHp)
        %print -r0 -dpng legend.png
          
      case 10 % fig 1j: Li-ha 
        shstat_options('default');
        [HfigLiha, HlegLiha] = shstat({'L_i', 'h_a'}, legend); 
        
        figure(HfigLiha)
        xlabel('ultimate structural length, _{10}log L_{\infty}, cm')
        ylabel('ageing acceleration, h_a, 1/d^2')
        %print -r0 -dpng Li_ha.png
        figure(HlegLiha)
        %print -r0 -dpng legend.png
          
      case 11 % fig 2a: surv kap
        shstat_options('x_transform', 'none');
        [hkap, hlegkap] = shstat({'kap'}, llegend_CAA, 'Fish');
        figure(hkap)
        xlabel('allocation fraction to soma, \kappa, -')
        %print -r0 -dpng kap.png
        figure(hlegkap)
        %print -r0 -dpng llegend.png

      case 12 % fig 2b: surv sR
        shstat_options('x_transform','none');
        par = read_allStat({'kap','kap_R','p_Am','v','p_M','k_J','E_G','E_Hb','E_Hj','E_Hp','s_M'}); 
        sel = isnan(par(:,9)); par(sel,9) = par(sel,8)+1e-3; % E_Hj=E_Hb+1e-3 for non-accelerating species 
        mod = read_allStat('model'); s_M = par(:,11);
        [kap_m, R_m, R_i] = get_kapm(mod,par); %sel = ~isnan(kap_m); 
        s_R = R_i./R_m;
        [hsR, hlegsR] = shstat(s_R, llegend_CAA, 'Fish');
        figure(hsR)
        xlabel('s_R = R_{\infty}/R_{max} , -')
        %print -r0 -dpng sR.png
        figure(hlegsR)
        %print -r0 -dpng llegend.png

      case 13 % fig 3a: Li-EHp/EHb
        shstat_options('default');
        LiEHbEHp = read_allStat({'L_i','E_Hb','E_Hp'});
        L_i = LiEHbEHp(:,1); s_R = LiEHbEHp(:,3)./LiEHbEHp(:,2);
        [HfigLisR, HlegLisR] = shstat([L_i, s_R], legend); 
        
        figure(HfigLisR)
        xlabel('ultimate structural length, _{10}log L_{\infty}, cm')
        ylabel('maturity ratio, s_R, -')
        %print -r0 -dpng Li_sR.png
        figure(HlegLisR)
        %print -r0 -dpng legend.png

      case 14 % fig 3b: Li-pJp/Li^3
        shstat_options('default');
        LipJpTC = read_allStat({'L_i','p_Jp','TC'});
        L_i = LipJpTC(:,1); p_J = LipJpTC(:,2)./ LipJpTC(:,3) ./ L_i.^3;
        [HfigLipJ, HlegLipJ] = shstat([L_i, p_J], legend); 
        
        figure(HfigLipJ)
        xlabel('ultimate structural length, _{10}log L_{\infty}, cm')
        ylabel('spec allocation to maturation, p_J/L_{\infty}^3, J/d.cm^3')
        %print -r0 -dpng Li_pJ.png
        figure(HlegLipJ)
        %print -r0 -dpng legend.png
        
      case 15 % fig 3c: Li-ME0
        shstat_options('default');
        [HfigLiME0, HlegLiME0] = shstat({'L_i', 'M_E0'}, legend); 
        
        figure(HfigLiME0)
        xlabel('ultimate structural length, _{10}log L_{\infty}, cm')
        ylabel('initial mass, M_E^0, mol')
        %print -r0 -dpng Li_ME0.png
        figure(HlegLiME0)
        %print -r0 -dpng legend.png
          
      case 16 % fig 3d: Li-pJp/Li^3 
      case 17 % fig 3e: Li-Ri  
      case 18 % fig 3f: Li-rm
          
      case 19 % fig 3g: Li-EHb
      case 20 % fig 3h: Li-EHj
      case 21 % fig 3i: Li-EHp
          
      case 22 % fig 3k: Li-ha 
      case 23 % fig 3l: Li-ha 
      case 24 % fig 3m: Li-ha 
          
      case 25 % fig 4a: pM-rB
      case 26 % fig 4b: pM-pR/Li^3

      case 27 % fig 5: Wdm-JO/Wd

      case 28 % fig 6: surv EHp/EHb

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
        %if R_m(i) < R_i(i); keyboard; end
        %fprintf('%g %s %s %g %g & %g %g\n',i, nm{i}, mod{i}, par(i,1), R_i(i), kap_m(i), R_m(i));
      end
    end
  end
end