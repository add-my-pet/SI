function KooyLika2014a_SI(fig)
% Supporting Information for KooyLika2014
% Title: Comparative energetics of the 5 fish classes on the basis of dynamic energy budgets.
% Authors: Kooijman, Lika
% Journal: J. Sea Res. 94 (2014): 19-28
% DOI: 10.1016/j.seares.2014.01.015
% Date: 2023/02/27
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
    {'-', 2, [0 1 0]}, 'Chondrichthyes'; ....
    {'-', 2, [1 0 0]}, 'Actinopterygii'; ....
  };

  if ~exist('fig','var')
    fig = 1:32;
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
        ylabel('spec assim rate, _{10}log \{p_{Am}\}, J/d.cm^2')
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
        ylabel('energy conductance, _{10}log v, cm/d')
        %print -r0 -dpng Li_v.png
        figure(HlegLiv)
        %print -r0 -dpng legend.png
          
      case 3 % fig 1c: Li-kap
        shstat_options('x_transform','log10');
        shstat_options('y_transform','none');
        [HfigLikap HlegLikap] = shstat({'L_i', 'kap'}, legend, title); 
     
        figure(HfigLikap)
        xlabel('ultimate structural length, _{10}log L_{\infty}, cm')
        ylabel('allocation fraction to soma, \kappa, -')
        %print -r0 -dpng Li_kap.png
        figure(HlegLikap)
        %print -r0 -dpng legend.png
          
      case 4 % fig 1d: Li-pM  
        shstat_options('default');
        [HfigLipM, HlegLipM] = shstat({'L_i', 'p_M'}, legend, title); 
        
        figure(HfigLipM)
        xlabel('ultimate structural length, _{10}log L_{\infty}, cm')
        ylabel('spec somatic maint rate, _{10}log [p_M], J/d.cm^3')
        %print -r0 -dpng Li_pM.png
        figure(HlegLipM)
        %print -r0 -dpng legend.png

      case 5 % fig 1e: Li-kJ   
        shstat_options('default');
        [HfigLikJ, HlegLikJ] = shstat({'L_i', 'k_J'}, legend, title); 
        
        figure(HfigLikJ)
        xlabel('ultimate structural length, _{10}log L_{\infty}, cm')
        ylabel('maturity maint rate coeff, _{10}log k_J, 1/d')
        %print -r0 -dpng Li_kJ.png
        figure(HlegLikJ)
        %print -r0 -dpng legend.png

      case 6 % fig 1f: Li-EG
        shstat_options('default');
        [HfigLiEG, HlegLiEG] = shstat({'L_i', 'E_G'}, legend, title); 
        
        figure(HfigLiEG)
        xlabel('ultimate structural length, _{10}log L_{\infty}, cm')
        ylabel('spec cost for struct, _{10}log [E_G], J/cm^3')
        %print -r0 -dpng Li_EG.png
        figure(HlegLiEG)
        %print -r0 -dpng legend.png
          
      case 7 % fig 1g: Li-EHb
        shstat_options('default');
        [HfigLiEHb, HlegLiEHb] = shstat({'L_i', 'E_Hb'}, legend, title); 
        
        figure(HfigLiEHb)
        xlabel('ultimate structural length, _{10}log L_{\infty}, cm')
        ylabel('maturity at birth, _{10}log E_H^b, J')
        %print -r0 -dpng Li_EHb.png
        figure(HlegLiEHb)
        %print -r0 -dpng legend.png

      case 8 % fig 1h: Li-EHj
        shstat_options('default');
        [HfigLiEHj, HlegLiEHj] = shstat({'L_i', 'E_Hj'}, legend, title); 
        
        figure(HfigLiEHj)
        xlabel('ultimate structural length, _{10}log L_{\infty}, cm')
        ylabel('maturity at metam, _{10}log E_H^j, J')
        %print -r0 -dpng Li_EHj.png
        figure(HlegLiEHj)
        %print -r0 -dpng legend.png

      case 9 % fig 1i: Li-EHp
        shstat_options('default');
        [HfigLiEHp, HlegLiEHp] = shstat({'L_i', 'E_Hp'}, legend, title); 
        
        figure(HfigLiEHp)
        xlabel('ultimate structural length, _{10}log L_{\infty}, cm')
        ylabel('maturity at puberty, _{10}log E_H^p, J')
        %print -r0 -dpng Li_EHp.png
        figure(HlegLiEHp)
        %print -r0 -dpng legend.png
          
      case 10 % fig 1j: Li-ha 
        shstat_options('default');
        [HfigLiha, HlegLiha] = shstat({'L_i', 'h_a'}, legend, title); 
        
        figure(HfigLiha)
        xlabel('ultimate structural length, _{10}log L_{\infty}, cm')
        ylabel('ageing acceleration, _{10}log h_a, 1/d^2')
        %print -r0 -dpng Li_ha.png
        figure(HlegLiha)
        %print -r0 -dpng legend.png
          
      case 11 % fig 2a: surv kap
        shstat_options('x_transform', 'none');
        [hkap, hlegkap] = shstat({'kap'}, llegend_CAA, title);
        figure(hkap)
        xlabel('allocation fraction to soma, \kappa, -')
        %print -r0 -dpng kap.png
        figure(hlegkap)
        %print -r0 -dpng llegend.png

      case 12 % fig 2b: surv sR
        shstat_options('x_transform','none');
        par = read_allStat({'kap','kap_R','p_Am','v','p_M','k_J','E_G','E_Hb','E_Hj','E_Hp','s_M','s_s'}); 
        sel = isnan(par(:,9)); par(sel,9) = par(sel,8)+1e-3; % E_Hj=E_Hb+1e-3 for non-accelerating species 
        mod = read_allStat('model'); s_M = par(:,11);
        [kap_m, R_m, R_i] = get_kapm(mod,par); %sel = ~isnan(kap_m); 
        s_R = -log10(R_i./R_m);
        [hsR, hlegsR] = shstat(s_R, llegend_CAA, title);
        figure(hsR)
        xlabel('-_{10}log s_R = R_{\infty}/R_{max} , -')
        %print -r0 -dpng sR.png
        figure(hlegsR)
        %print -r0 -dpng llegend.png

      case 13 % fig 3a: Li-ab
        shstat_options('default');
        Liab = read_allStat({'L_i','a_b','c_T'}); Liab = [Liab(:,1), Liab(:,2) .* Liab(:,3)];
        [HfigLiab, HlegLiab] = shstat(Liab, legend, title); 
        
        figure(HfigLiab)
        xlabel('ultimate structural length, _{10}log L_{\infty}, cm')
        ylabel('age at birth, _{10}log a_b, d')
        %print -r0 -dpng Li_ab.png
        figure(HlegLiab)
        %print -r0 -dpng legend.png

      case 14 % fig 3b: Li-ap
        shstat_options('default');
        Liap = read_allStat({'L_i','a_p','c_T'}); Liap = [Liap(:,1), Liap(:,2) .* Liap(:,3)];
        [HfigLiap, HlegLiap] = shstat(Liap, legend, title); 
        
        figure(HfigLiap)
        xlabel('ultimate structural length, _{10}log L_{\infty}, cm')
        ylabel('age at puberty, _{10}log a_p, d')
        %print -r0 -dpng Li_ap.png
        figure(HlegLiap)
        %print -r0 -dpng legend.png

      case 15 % fig 3c: Li-am
        shstat_options('default');
        Liam = read_allStat({'L_i','a_m','c_T'}); Liam = [Liam(:,1), Liam(:,2) .* Liam(:,3)];
        [HfigLiam, HlegLiam] = shstat(Liam, legend, title); 
        
        figure(HfigLiam)
        xlabel('ultimate structural length, _{10}log L_{\infty}, cm')
        ylabel('age at death, _{10}log a_m, d')
        %print -r0 -dpng Li_am.png
        figure(HlegLiam)
        %print -r0 -dpng legend.png
          
      case 16 % fig 3d: Li-Lb
        shstat_options('default');
        [HfigLiLb, HlegLiLb] = shstat({'L_i', 'L_b'}, legend, title); 
        
        figure(HfigLiLb)
        xlabel('ultimate structural length, _{10}log L_{\infty}, cm')
        ylabel('structural length at birth, _{10}log L_b, cm')
        %print -r0 -dpng Li_Lb.png
        figure(HlegLiLb)
        %print -r0 -dpng legend.png
          
      case 17 % fig 3e: Li-Lj
        shstat_options('default');
        LiLjLb = read_allStat({'L_i','L_j','L_b'}); sel=isnan(LiLjLb(:,2)); LiLjLb(sel,2)=LiLjLb(sel,3)+1e-3;
        [HfigLiLj, HlegLiLj] = shstat(LiLjLb(:,[1 2]), legend, title); 
        
        figure(HfigLiLj)
        xlabel('ultimate structural length, _{10}log L_{\infty}, cm')
        ylabel('structural length at metam, _{10}log L_j, cm')
        %print -r0 -dpng Li_Lj.png
        figure(HlegLiLj)
        %print -r0 -dpng legend.png
          
      case 18 % fig 3f: Li-Lp
        shstat_options('default');
        [HfigLiLp, HlegLiLp] = shstat({'L_i', 'L_p'}, legend, title); 
        
        figure(HfigLiLp)
        xlabel('ultimate structural length, _{10}log L_{\infty}, cm')
        ylabel('structural length at puberty, _{10}log L_p, cm')
        %print -r0 -dpng Li_Lp.png
        figure(HlegLiLp)
        %print -r0 -dpng legend.png
          
      case 19 % fig 3g: Li-Wwm/Li^3
        shstat_options('default');
        LiWwi = read_allStat({'L_i','Ww_i'}); LiWwi(:,2)=LiWwi(:,2)./LiWwi(:,1).^3;
        [HfigLiWwi, HlegLiWwi] = shstat(LiWwi, legend, title); 
        
        figure(HfigLiWwi)
        xlabel('ultimate structural length, _{10}log L_{\infty}, cm')
        ylabel('ultimate weight per struct volume, _{10}log W_w^{\infty}/L_{\infty}^3, g/cm^3')
        %print -r0 -dpng Li_Wwi.png
        figure(HlegLiWwi)
        %print -r0 -dpng legend.png

      case 20 % fig 3g: Li-Em
        shstat_options('default');
        [HfigLiEm, HlegLiEm] = shstat({'L_i', 'E_m'}, legend, title); 
        
        figure(HfigLiEm)
        xlabel('ultimate structural length, _{10}log L_{\infty}, cm')
        ylabel('reserve capacity, _{10}log [E_m], J/cm^3')
        %print -r0 -dpng Li_Em.png
        figure(HlegLiEm)
        %print -r0 -dpng legend.png

      case 21 % fig 3i: Li-rB
        shstat_options('default');
        LirB = read_allStat({'L_i','r_B','c_T'}); LirB = [LirB(:,1), LirB(:,2) ./ LirB(:,3)];
        [HfigLirB, HlegLirB] = shstat(LirB, legend, title); 
        
        figure(HfigLirB)
        xlabel('ultimate structural length, _{10}log L_{\infty}, cm')
        ylabel('von Bert growth rate, _{10}log r_B, 1/d')
        %print -r0 -dpng Li_rB.png
        figure(HlegLirB)
        %print -r0 -dpng legend.png

      case 22 % fig 3j: Li-EHp/EHb
        shstat_options('default');
        LiEHbEHp = read_allStat({'L_i','E_Hb','E_Hp'});
        L_i = LiEHbEHp(:,1); s_H = LiEHbEHp(:,3)./LiEHbEHp(:,2);
        [HfigLisH, HlegLisH] = shstat([L_i, s_H], legend, title); 
        
        figure(HfigLisH)
        xlabel('ultimate structural length, _{10}log L_{\infty}, cm')
        ylabel('maturity ratio, _{10}log s_H, -')
        %print -r0 -dpng Li_sH.png
        figure(HlegLisH)
        %print -r0 -dpng legend.png

      case 23 % fig 3k: Li-pJp/Li^3
        shstat_options('default');
        LipJpTC = read_allStat({'L_i','p_Jp','c_T'});
        L_i = LipJpTC(:,1); p_J = LipJpTC(:,2) ./ LipJpTC(:,3) ./ L_i.^3;
        [HfigLipJ, HlegLipJ] = shstat([L_i, p_J], legend, title); 
        
        figure(HfigLipJ)
        xlabel('ultimate structural length, _{10}log L_{\infty}, cm')
        ylabel('spec allocation to maturation, _{10}log p_J/L_{\infty}^3, J/d.cm^3')
        %print -r0 -dpng Li_pJ.png
        figure(HlegLipJ)
        %print -r0 -dpng legend.png
        
      case 24 % fig 3l: Li-ME0
        shstat_options('default');
        [HfigLiME0, HlegLiME0] = shstat({'L_i', 'M_E0'}, legend, title); 
        
        figure(HfigLiME0)
        xlabel('ultimate structural length, _{10}log L_{\infty}, cm')
        ylabel('initial mass, _{10}log M_E^0, C-mol')
        %print -r0 -dpng Li_ME0.png
        figure(HlegLiME0)
        %print -r0 -dpng legend.png
          
      case 25 % fig 3m: Li-pRi/Li^3 
        shstat_options('default');
        LipRiTC = read_allStat({'L_i','p_Ri','c_T'});
        L_i = LipRiTC(:,1); p_Ri = LipRiTC(:,2) ./ LipRiTC(:,3) ./ L_i.^3;
        [HfigLipRi, HlegLipRi] = shstat([L_i, p_Ri], legend, title); 
        
        figure(HfigLipRi)
        xlabel('ultimate structural length, _{10}log L_{\infty}, cm')
        ylabel('spec allocation to reprod, _{10}log p_R^{\infty}/L_{\infty}^3, J/d.cm^3')
        %print -r0 -dpng Li_pR.png
        figure(HlegLipRi)
        %print -r0 -dpng legend.png

      case 26 % fig 3n: Li-Ri  
        shstat_options('default');
        LiRiTC = read_allStat({'L_i','R_i','c_T'});
        L_i = LiRiTC(:,1); R_i = LiRiTC(:,2) ./ LiRiTC(:,3);
        [HfigLiRi, HlegLiRi] = shstat([L_i, R_i], legend, title); 
        
        figure(HfigLiRi)
        xlabel('ultimate structural length, _{10}log L_{\infty}, cm')
        ylabel('ultimate reprod, _{10}log R_{\infty}, #/d')
        %print -r0 -dpng Li_Ri.png
        figure(HlegLiRi)
        %print -r0 -dpng legend.png

      case 27 % fig 3o: Li-rm
        shstat_options('default');
        LiTC = read_allStat({'L_i','c_T'}); r = read_popStat('f1.thin1.f.r');
        [HfigLirm, HlegLirm] = shstat([LiTC(:,1), r./LiTC(:,2)], legend, title); 
        
        figure(HfigLirm)
        xlabel('ultimate structural length, _{10}log L_{\infty}, cm')
        ylabel('max pop growth rate, _{10}log r_m, 1/d')
        %print -r0 -dpng Li_rm.png
        figure(HlegLirm)
        %print -r0 -dpng legend.png

      case 28 % fig 4: Wdi-jO
        shstat_options('default');
        WdJO = read_allStat({'Wd_i','J_Oi','c_T'}); WdJO(:,2) = WdJO(:,2)./WdJO(:,3) ./ WdJO(:,1) * 32 * 24;
        [HfigWdJO, HlegWdJO] = shstat(WdJO(:,1:2), legend, title); 
        
        figure(HfigWdJO)
        xlabel('ultimate dry weight, _{10}log W_d^{\infty}, g')
        ylabel('ultimate specific respiration rate, _{10}log -J_O^{\infty}/W_d^{\infty}, g/h.g')
        %print -r0 -dpng Wd_JO.png
        figure(HlegWdJO)
        %print -r0 -dpng legend.png

      case 29 % fig 5a: pM-rB
        shstat_options('default');
        pMrBTC = read_allStat({'p_M','r_B','c_T'});
        p_M = pMrBTC(:,1); r_B = pMrBTC(:,2) ./ pMrBTC(:,3);
        [HfigpMrB, HlegpMrB] = shstat([p_M, r_B], legend, title); 
        
        figure(HfigpMrB)
        xlabel('spec somatic maint, _{10}log [p_M], J/cm^3')
        ylabel('von Bert growth rate, _{10}log r_B, 1/d')
        %print -r0 -dpng pM_rB.png
        figure(HlegpMrB)
        %print -r0 -dpng legend.png

      case 30 % fig 5b: pM-pR/Li^3
        shstat_options('default');
        pMpRLiTC = read_allStat({'p_M','p_Ri','L_i','c_T'});
        p_M = pMpRLiTC(:,1); p_R = pMpRLiTC(:,2) ./ pMpRLiTC(:,3).^3 ./ pMpRLiTC(:,4);
        [HfigpMpR, HlegpMpR] = shstat([p_M, p_R], legend, title); 
        
        figure(HfigpMpR)
        xlabel('spec somatic maint, _{10}log [p_M], J/cm^3')
        ylabel('spec allocation to reprod, _{10}log p_R^{\infty}/L_{\infty}^3, J/d.cm^3')
        %print -r0 -dpng pM_pR.png
        figure(HlegpMpR)
        %print -r0 -dpng legend.png

      case 31 % fig 6: surv EHp/EHb
        shstat_options('default');
        EHbp = read_allStat({'E_Hb','E_Hp'}); s_H = EHbp(:,1)./EHbp(:,2);
        [hfigsH, hlegsH] = shstat(s_H, llegend_CAA, title);
        figure(hfigsH)
        xlabel('altriciality index, _{10}log s_H, -')
        %print -r0 -dpng sH.png
        figure(hlegsH)
        %print -r0 -dpng llegend.png

      case 32 % fig 7: Com-Fit
        shstat_options('x_transform','none');
        shstat_options('y_transform','none');
        ComFit = read_allStat({'COMPLETE','MRE'}); ComFit(:,2) = 10 * (1 - ComFit(:,2));
        [hfigComFit, hlegComFit] = shstat(ComFit, legend, title);
        figure(hfigComFit)
        xlabel('Completeness mark')
        ylabel('Fit mark')
        %print -r0 -dpng ComFit.png
        figure(hlegComFit)
        %print -r0 -dpng legend.png

    end
  end

end

function [kap_m, R_m, R_i] = get_kapm(mod, par)
  nm=select; 
  n=size(par,1); kap_m = NaN(n,1); R_m = NaN(n,1); R_i = NaN(n,1); dkap = 1e-4;
  get_kap = @(kap,mod,pari,dkap) (reprod_rate_max(mod,[kap, pari]) - reprod_rate_max(mod,[kap-dkap, pari]))/ dkap;
  
  for i=1:n
    R_i(i) = reprod_rate_max(mod{i}, par(i,:));
    if ~isnan(R_i(i))
      try
        kap_m(i) = fzero(@(kap) get_kap(kap,mod{i},par(i,2:end),dkap), 1e-3*[1; -1]+flip(roots3([1; -1; 0; par(i,end)],3)));
        R_m(i) = reprod_rate_max(mod{i},[kap_m(i), par(i,2:end)]);
        %if R_m(i) < R_i(i); keyboard; end
        %fprintf('%g %s %s %g %g & %g %g\n',i, nm{i}, mod{i}, par(i,1), R_i(i), kap_m(i), R_m(i));
      end
    end
  end
end