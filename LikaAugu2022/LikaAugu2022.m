function LikaAugu2022_SI(fig)
% Supporting Information for LikaAugu2022
% Title: The comparative energetics of the ray-finned fish in an evolutionary context
% Authors: Lika, Augustine, Kooijman
% Journal: Conserv Physiol 10(1): coac039
% DOI: 10.1093/conphys/coac039
% Date: 2023/02/18
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

 llegend = {... % Pisces 
   {'-', 2, [0 0 0]}, 'Cyclostomata'; ....
   {'-', 2, [0 0 1]}, 'Chondrichthyes'; ....
   {'-', 2, [1 0 1]}, 'Actinopterygii'; ....
   {'-', 2, [1 0 0]}, 'CL-group'; ....
   {'-', 2, [0 1 0]}, 'Tetrapoda'; ....
 };

 legend = { ... % Actinopterygii
   {'o', 8, 3, [0 0 0], [0 0 0]}, 'Cladistii'
   {'o', 8, 3, [0 0 0], [0 0 1]}, 'Chondrostei'
   {'o', 8, 3, [0 0 0], [1 0 1]}, 'Holostei'
   {'o', 8, 3, [0 0 0], [1 0 0]}, 'Elopocephalai'
   {'o', 8, 3, [0 0 0], [1 1 1]}, 'Osteoglossocephala'
   % Clupeocephala
   {'o', 8, 3, [0 0 1], [0 0 0]}, 'Otomorpha'
   {'o', 8, 3, [0 0 1], [0 0 1]}, 'Lepidogalaxii'
   {'o', 8, 3, [0 0 1], [1 0 0]}, 'Protacanthopterygii'
   {'o', 8, 3, [0 0 1], [1 1 1]}, 'Stomiati'
   % Neoteleostei
   {'o', 8, 3, [1 0 1], [0 0 0]}, 'Aulopa'
   {'o', 8, 3, [1 0 1], [0 0 1]}, 'Myctophata'
   {'o', 8, 3, [1 0 1], [1 0 1]}, 'Paracanthomorphacea'
   {'o', 8, 3, [1 0 1], [1 0 0]}, 'Polymixiacea'
   % Euacanthomorphscea
   {'o', 8, 3, [1 0 1], [1 1 1]}, 'Berycimorphaceae'
   {'o', 8, 3, [1 0 1], [1 1 1]}, 'Holocentrimorphaceae'
   % Percomorphaceaei
   {'o', 8, 3, [1 0 0], [0 0 0]}, 'Ophidiimopharia'
   {'o', 8, 3, [1 0 0], [0 0 1]}, 'Batrachoidimopharia'
   {'o', 8, 3, [1 0 0], [1 0 1]}, 'Gobiomopharia'
   {'o', 8, 3, [1 0 0], [1 0 0]}, 'Scombrimopharia'
   {'o', 8, 3, [1 0 0], [1 1 1]}, 'Carangimopharia'
   {'o', 8, 3, [1 0 0], [1 1 1]}, 'Eupercaria'   
   % other Pisces
   {'.', 5, 5, [0 0 0], [0 0 0]}, 'Cyclostomata'; ...
   {'.', 5, 5, [0 0 1], [0 0 0]}, 'Chondrichthyes'; ...
   {'.', 5, 5, [1 0 0], [0 0 0]}, 'CL-group'; ...
   {'.', 5, 5, [0 1 0], [0 0 0]}, 'Tetrapoda'; ...
 };
 
 legend_Cyprinodontiformes = { ... % Cyprinodontiformes
   % Aplocheiloidei
   {'o', 8, 3, [0 0 1], [0 0 0]}, 'Nothobranchiidae'
   {'o', 8, 3, [0 0 1], [1 1 1]}, 'Rivulidae'
   % Cyprinodontoidei
   {'o', 8, 3, [1 0 0], [0 0 0]}, 'Fundulidae'
   {'o', 8, 3, [1 0 0], [0 0 1]}, 'Goodeidae'
   {'o', 8, 3, [1 0 0], [1 0 1]}, 'Valenciidae'
   {'o', 8, 3, [1 0 0], [1 0 0]}, 'Cyprinodontidae'
   {'o', 8, 3, [1 0 0], [1 1 1]}, 'Poeciliidae'
 };

 legend_Leuciscinae = { ... % Leuciscinae
   {'o', 8, 3, [0 0 0], [0 0 0]}, 'Phoxinini'
   {'o', 8, 3, [0 0 0], [1 1 1]}, 'Laviniini'
   {'o', 8, 3, [0 0 1], [0 0 0]}, 'Leuciscini'
   {'o', 8, 3, [0 0 1], [0 0 1]}, 'Plagiopterini'
   % Pogonichthyini
   {'o', 8, 3, [1 0 0], [0 0 0]}, 'Pogonichthyina'
   {'o', 8, 3, [1 0 0], [0 0 1]}, 'Exoglossina'
   {'o', 8, 3, [1 0 0], [1 0 1]}, 'Campostomina'
   {'o', 8, 3, [1 0 0], [1 1 1]}, 'Notropis'
   {'o', 8, 3, [1 0 0], [1 0 0]}, 'Hybognathina'
 };

 legend_Etheostomatinae = { ... % Etheostomatinae
   {'o', 8, 3, [0 0 0], [0 0 0]}, 'Percina'
   {'o', 8, 3, [0 0 1], [0 0 0]}, 'Ammocrypta'
   {'o', 8, 3, [0 0 1], [1 1 1]}, 'Crystallaria'
   {'o', 8, 3, [1 0 0], [0 0 0]}, 'Nothonotus'
   {'o', 8, 3, [1 0 0], [1 1 1]}, 'Etheostoma'
 };

 legend_Pisces = {... % Pisces
   % Cyclostomata: edge black
   {'o', 8, 3, [0 0 0], [0 0 0]}, 'Cyclostomata'; ...
   % Chondrichthyes: edge blue
   {'o', 8, 3, [0 0 1], [0 0 0]}, 'Holocephali'; .... 
   {'o', 8, 3, [0 0 1], [0 0 1]}, 'Galeomorphi'; ....   
   {'o', 8, 3, [0 0 1], [1 0 0]}, 'Squalomorphi'; ....   
   {'o', 8, 3, [0 0 1], [0 0 0]}, 'Batoidea'; ....   
   % Actinopterygii: edge magenta
   {'o', 8, 3, [1 0 1], [0 0 0]}, 'Cladistii'; ....   
   {'o', 8, 3, [1 0 1], [0 0 1]}, 'Chondrostei'; ....   
   {'o', 8, 3, [1 0 1], [1 0 0]}, 'Holostei'; ....   
   {'o', 8, 3, [1 0 1], [0 0 0]}, 'Teleostei'; ....   
   % Sarcopterygii: edge red
   {'o', 8, 3, [1 0 0], [0 0 0]}, 'Actinistia'; ....   
   {'o', 8, 3, [1 0 0], [1 1 1]}, 'Dipnoi'; ....
 };

 close all
 shstat_options('default');
 shstat_options('y_label', 'on'); 
 shstat_options('x_label', 'off'); 
 
 for i=1:length(fig)
 
 switch fig(i)
   case 1 % fig 1c
     shstat_options('x_transform', 'none');
     [hkap, hleg] = shstat({'kap'}, llegend);
     figure(hkap)
     xlabel('allocation fraction to soma, \kappa, -')
     %print -r300 -dpng kap.png
     figure(hleg)
     %print -r300 -dpng llegend_Actinopterygii.png


   case 2 % fig 1d
     shstat_options('x_transform', 'log10');
     hp_M = shstat({'p_M'}, llegend); 
     figure(hp_M)
     xlabel('_{10}log vol-spec somatic maint, [p_M], J/d.cm^3')
     %print -r300 -dpng pM.png
     
   case 3 
     shstat_options('x_transform', 'log10');
     hs_M = shstat({'s_M'}, llegend); 
     figure(hs_M)
     xlabel('_{10}log acceleration factor, s_M, -')
     %print -r300 -dpng sM.png
 
   case 4 % fig 1g
     shstat_options('x_transform', 'log10');
     hs_s = shstat({'s_s'}, llegend); 
     figure(hs_s)
     xlim([-6 -0.5])
     xlabel('_{10}log supply stress, s_s, -')
     %print -r300 -dpng ss.png

   case 5  % fig 1f
     shstat_options('x_transform', 'log10');
     hs_Hbp = shstat({'s_Hbp'}, llegend); 
     figure(hs_Hbp)
     xlim([-8.2 0])
     xlabel('_{10}log precociality coeff, s_H^{bp}, -')
     %print -r300 -dpng sHbp.png

   case 6 % fig 1b
     shstat_options('x_transform', 'log10');
     hv = shstat({'v'}, llegend); 
     figure(hv)
     xlabel('_{10}log energy conductance, v, cm/d')
     %print -r300 -dpng v.png

   case 7  % fig 1a
     shstat_options('x_transform', 'log10');
     hp_Am = shstat({'p_Am'}, llegend); 
     figure(hp_Am)
     xlabel('_{10}log spec assimilation rate, \{p_{Am}\}, J/d.cm^2')
     %print -r300 -dpng pAm.png

   case 8
     shstat_options('x_transform', 'log10');
     
     hWw_i = shstat({'Ww_i'}, llegend);
     shstat({'Ww_p'}, llegend, [], hWw_i);
     shstat({'Ww_b'}, llegend, [], hWw_i);
     figure(hWw_i)
     xlabel('_{10}log weight at birth, puberty, death, W_w^b, W_w^p, W_w^\infty, g')
     %print -r300 -dpng Wwi.png
     
     Wbpi = read_allStat({'Ww_b','Ww_p','Ww_i'});
     sel_Cy = select_01('Cyclostomata'); sel_Ch = select_01('Chondrichthyes');
     sel_Ac = select_01('Actinopterygii'); sel_CL = select_01('CL-group'); sel_Te = select_01('Tetrapoda');
     Wbpi = [ ...
         median(Wbpi(sel_Cy,1)) median(Wbpi(sel_Ch,1)) median(Wbpi(sel_Ac,1)) median(Wbpi(sel_CL,1)) median(Wbpi(sel_Te,1));
         median(Wbpi(sel_Cy,2)) median(Wbpi(sel_Ch,2)) median(Wbpi(sel_Ac,2)) median(Wbpi(sel_CL,2)) median(Wbpi(sel_Te,2));
         median(Wbpi(sel_Cy,3)) median(Wbpi(sel_Ch,3)) median(Wbpi(sel_Ac,3)) median(Wbpi(sel_CL,3)) median(Wbpi(sel_Te,3))];
     prt_tab({{'Ww_b';'Ww_p';'Ww_i'}, Wbpi},{'Weight','Cyclo','Chond','Actino','CL','Tetra'});
     
   case 9  % fig 1e
     shstat_options('x_transform', 'log10');
     hE_m = shstat({'E_m'}, llegend); 
     figure(hE_m)
     xlabel('_{10}log reserve capacity, [E_m], J/cm^3')
     %print -r300 -dpng Em.png

   case 10
     shstat_options('x_transform', 'log10');
     aaac = read_allStat({'a_m','a_p','a_b','c_T'}); 
     am = aaac(:,1).*aaac(:,4);  ap = aaac(:,2).*aaac(:,4); ab = aaac(:,3).*aaac(:,4);
     ha_m = shstat(am, llegend); 
     shstat(ap, llegend, [], ha_m); 
     shstat(ab, llegend, [], ha_m); 
     figure(ha_m)
     xlabel('_{10}log age at birth, puberty, death, a_b, a_p, a_m, d')
     %print -r300 -dpng am.png
     
   case 11
     shstat_options('x_transform', 'log10');
     WdW_Cy = read_stat(select('Cyclostomata'),{'W_dWm','dWm','c_T'});   WdW_Cy = WdW_Cy(:,2) ./ WdW_Cy(:,1) ./ WdW_Cy(:,3);
     WdW_Ch = read_stat(select('Chondrichthyes'),{'W_dWm','dWm','c_T'}); WdW_Ch = WdW_Ch(:,2) ./ WdW_Ch(:,1) ./ WdW_Ch(:,3);
     WdW_Ai = read_stat(select('Actinopterygii'),{'W_dWm','dWm','c_T'}); WdW_Ai = WdW_Ai(:,2) ./ WdW_Ai(:,1) ./ WdW_Ai(:,3);
     WdW_CL = read_stat(select('CL-group'),{'W_dWm','dWm','c_T'});       WdW_CL = WdW_CL(:,2) ./ WdW_CL(:,1) ./ WdW_CL(:,3);
     WdW_T = read_stat(select('Tetrapoda'),{'W_dWm','dWm','c_T'});       WdW_T  = WdW_T (:,2) ./ WdW_T (:,1) ./ WdW_T (:,3);
     hWdW = shstat(WdW_Cy, {'k', 'k'});   
     shstat(WdW_Ch, {'b', 'b'}, [], hWdW);   
     shstat(WdW_Ai, {'m', 'm'}, [], hWdW);   
     shstat(WdW_CL, {'r', 'r'}, [], hWdW);   
     shstat(WdW_T, {'g', 'g'}, [], hWdW);   
     figure(hWdW)
     xlabel('_{10}log maximum spec growth, r_m, g/d.g')
     %print -r300 -dpng WdW.png

   case 12
     shstat_options('x_transform', 'log10');
     JOiW_Cy = read_stat(select('Cyclostomata'),{'J_Oi','Ww_i','c_T'});   JOiW_Cy = JOiW_Cy(:,1) ./ JOiW_Cy(:,2) ./ JOiW_Cy(:,3);
     JOiW_Ch = read_stat(select('Chondrichthyes'),{'J_Oi','Ww_i','c_T'}); JOiW_Ch = JOiW_Ch(:,1) ./ JOiW_Ch(:,2) ./ JOiW_Ch(:,3);
     JOiW_Ai = read_stat(select('Actinopterygii'),{'J_Oi','Ww_i','c_T'}); JOiW_Ai = JOiW_Ai(:,1) ./ JOiW_Ai(:,2) ./ JOiW_Ai(:,3);
     JOiW_CL = read_stat(select('CL-group'),{'J_Oi','Ww_i','c_T'});       JOiW_CL = JOiW_CL(:,1) ./ JOiW_CL(:,2) ./ JOiW_CL(:,3);
     JOiW_T = read_stat(select('Tetrapoda'),{'J_Oi','Ww_i','c_T'});       JOiW_T  = JOiW_T (:,1) ./ JOiW_T (:,2) ./ JOiW_T (:,3);
     hJOiW = shstat(JOiW_Cy, {'k', 'k'});   
     shstat(JOiW_Ch, {'b', 'b'}, [], hJOiW);   
     shstat(JOiW_Ai, {'m', 'm'}, [], hJOiW);   
     shstat(JOiW_CL, {'r', 'r'}, [], hJOiW);   
     shstat(JOiW_T,  {'g', 'g'}, [], hJOiW);   
     figure(hJOiW)
     xlabel('_{10}log ultimate spec O_2 consumption, j_O^\infty, mol/d.g')
     %print -r300 -dpng jOi.png

   case 13
     shstat_options('x_transform', 'log10');
     JRWW = read_allStat({'R_i','Ww_b','Ww_i','c_T'}); jWb = JRWW(:,1) .* JRWW(:,2) ./ JRWW(:,3) ./ JRWW(:,4);
     
     hjWb = shstat(jWb, llegend);   
     figure(hjWb)
     xlim([-6.7 -1.5])
     xlabel('_{10}log ultimate spec neonate mass prod rate, j_{W_w^b}^\infty, 1/d')
     %print -r300 -dpng jWb.png

   case 14  % fig 4
     shstat_options('x_transform', 'log10');
     shstat_options('y_transform', 'log10');
     WJO = read_allStat({'Ww_i', 'J_Oi','c_T'}); WJO(:,2) = WJO(:,2) ./ WJO(:,1) ./ WJO(:,3);
     [hWwi_JOiW, hC]= shstat(WJO(:,1:2), legend);   
     figure(hWwi_JOiW)
     xlabel('_{10}log ultimate wet weight, g')
     ylabel('_{10}log spec O_2 consumption, mol/d.g')
     %print -r300 -dpng Wwi_JOiW.png
     figure(hC)
     %print -r300 -dpng legend_Actinopterygii.png
     
   case 15
     shstat_options('x_transform', 'log10');
     shstat_options('y_transform', 'log10');
     vsEE = read_allStat({'v', 's_M', 'E_Hb', 'E_Hj', 'E_Hp'}); 
     vs = vsEE(:,1) .* vsEE(:,2); 
     s_Hbp = vsEE(:,3) ./ vsEE(:,5); s_Hjp = vsEE(:,4) ./ vsEE(:,5);
     s_Hjp(isnan(s_Hjp)) = s_Hbp(isnan(s_Hjp));
     hvs_s_Hjp = shstat([vs, s_Hjp], legend);   
     figure(hvs_s_Hjp)
     xlabel('_{10}log post-accel energy cond., v s_M, cm/d')
     ylabel('_{10}log maturity ratio, s_H^{jp}, -')
     %print -r300 -dpng vsM_sHjp.png

   case 16
     shstat_options('x_transform', 'log10');
     shstat_options('y_transform', 'log10');
     vs = read_allStat({'v', 's_M'}); 
     v = vs(:,1); vs = vs(:,1) .* vs(:,2); 
     hv_vs = shstat([v, vs], legend);   
     figure(hv_vs)
     xlabel('_{10}log energy conductance, v, cm/d')
     ylabel('_{10}log post-accel energy cond., v s_M, cm/d')
     %print -r300 -dpng v_vsM.png

   case 17  % fig 6a
     shstat_options('x_transform', 'none');
     shstat_options('y_transform', 'log10');
     kapR = read_allStat({'kap', 'R_i','c_T'}); kapR(:,2) = kapR(:,2) ./ kapR(:,3);
     hkap_R = shstat(kapR(:,1:2), legend);   
     figure(hkap_R)
     xlabel('allocation fraction to soma, \kappa, -')
     ylabel('_{10}log max reprod rate, #/d')
     %print -r300 -dpng kap_R.png
    
   case 18 % fig 6b
     shstat_options('x_transform', 'none');
     shstat_options('y_transform', 'log10');
     kNWWa = read_allStat({'kap', 'R_i', 'Ww_b', 'Ww_i', 'c_T'}); 
     kap = kNWWa(:,1); RWW = kNWWa(:,2) .* kNWWa(:,3) ./ kNWWa(:,4) ./ kNWWa(:,5);
     hkap_RWW = shstat([kap, RWW], legend);   
     figure(hkap_RWW)
     xlabel('allocation fraction to soma, \kappa, -')
     ylabel('_{10}log spec neonate mass prod rate, 1/d')
     %print -r300 -dpng kap_RWW.png

   case 19 % fig 7a
     shstat_options('x_transform', 'log10');
     shstat_options('y_transform', 'log10');
     shstat_options('z_transform', 'log10');
     
     WdWs = read_allStat({'W_dWm','dWm','c_T', 's_M'}); 
     WdW = WdWs(:,2) ./ WdWs(:,1) ./ WdWs(:,3); sM = WdWs(:,4);
     r = read_popStat('f1.thin1.f.r') ./ read_popStat('c_T') ; 
     
     hWdW_r = shstat([WdW, r], legend);   
     figure(hWdW_r)
     plot([-1 -4.5], [-1 -4.5], 'k')
     xlabel('_{10}log max spec growth, r_m, g/d.g')
     ylabel('_{10}log max spec pop growth, r_N, 1/d')
     %print -r300 -dpng WdW_r.png

     hWdW_r_sM = shstat([WdW, r, sM], legend);    
     figure(hWdW_r_sM)
     plot([-1 -4.5 0], [-1 -4.5 0], 'k')
     xlabel('_{10}log max spec growth, r_m, g/d.g')
     ylabel('_{10}log max spec pop growth, r_N, 1/d')
     zlabel('_{10}log acceleration fator, s_M, -')
     %print -r300 -dpng hWdW_r_sM.png
     
   case 20
     shstat_options('x_transform', 'log10');
     shstat_options('y_transform', 'log10');
     
     hsM_sHbp = shstat({'s_M','s_Hbp'}, legend);   
     figure(hsM_sHbp)
     xlabel('_{10}log acceleration factor, s_M, -')
     ylabel('_{10}log procociality coeff, s_H^{bp}, -')
     %print -r300 -dpng sM_sHbp.png
     
   case 21
     n = 21; n_spec = NaN(n,1); sM_min = NaN(n,1); sM_max = NaN(n,1); sM_med = NaN(n,1); sM_geo = NaN(n,1); sM_char = NaN(n,1); sM_ave = NaN(n,1);
     for i=1:n 
       n_spec(i) = length(select(legend{i,2}));
       sM = read_stat(select(legend{i,2}),{'s_M'}); sM_min(i) = min(sM); sM_max(i) = max(sM); 
       sM_ave(i) = mean(sM); sM_med(i) = median(sM); sM_geo(i) = exp(sum(log(sM)))/n; sM_char(i) = char_su(sM);
     end
     prt_tab({legend{:,2},n_spec, sM_min, sM_max, sM_ave, sM_med, sM_char},{'Actinopterygii', '# spec', 's_M min', 's_M max', 's_M ave', 's_M med', 's_M geo', 's_M char'});

     shstat_options('x_transform', 'log10');
     llegend_sel = {... % some Actinopterygii taxa
       {'-', 2, [0 0 0]}, 'Otomorpha'; ....
       {'-', 2, [0 0 1]}, 'Protacanthopterygii'; ....
       {'-', 2, [1 0 1]}, 'Paracanthomorphacea'; ....
       {'-', 2, [0 1 0]}, 'Scombrimopharia'; ....
       {'-', 2, [0 1 1]}, 'Carangimopharia'; ....
       {'-', 2, [1 1 0]}, 'Eupercaria'; ....
     };
     hs_M = shstat({'s_M'}, llegend_sel); 
     figure(hs_M)
     xlabel('_{10}log acceleration factor, s_M, - ')
     
   case 22  % fig 3
     shstat_options('x_transform', 'log10');
     shstat_options('y_transform', 'log10');
     shstat_options('z_transform', 'log10');
     
     hsHbp_Em = shstat({'s_Hbp', 'E_m'}, legend); 
     figure(hsHbp_Em)
     %plot([3.25 5.25],[-0.25 -3.25], 'k', 'LineWidth', 3)
     xlabel('_{10}log precociality coeff, s_H^{bp}, - ')
     ylabel('_{10}log reserve capacity, [E_m], J/cm^3')
     %print -r300 -dpng sHbp_Em.png

     hLi_Em = shstat({'L_i','E_m'}, legend); 
     figure(hLi_Em)
     %plot([0.25 2.25],[3.25 5.25], 'k', 'LineWidth', 3)
     xlabel('_{10}log ultimate structural length, L_\infty, cm ')
     ylabel('_{10}log reserve capacity, [E_m], J/cm^3')
     %print -r300 -dpng Li_Em.png
 
     hpM_Em = shstat({'p_M','E_m'}, legend); 
     figure(hpM_Em)
     %plot([0.25 2.25],[3.25 5.25], 'k', 'LineWidth', 3)
     xlabel('_{10}log spec somatic maint, [p_M], J/d.cm^3')
     ylabel('_{10}log reserve capacity, [E_m], J/cm^3')
     %print -r300 -dpng pM_Em.png
 
     hpAm_Em = shstat({'p_Am','E_m'}, legend); 
     figure(hpAm_Em)
     plot([0.25 4.5],1.5+[0.25 4.5], 'k', 'LineWidth', 3)
     xlabel('_{10}log spec max assim rate, \{p_{Am}\}, J/d.cm^2')
     ylabel('_{10}log reserve capacity, [E_m], J/cm^3')
     %print -r300 -dpng pAm_Em.png


     hWwi_Em = shstat({'Ww_i','E_m'}, legend); 
     figure(hWwi_Em)
     %plot([0.25 2.25],[3.25 5.25], 'k', 'LineWidth', 3)
     xlabel('_{10}log max weight, W_w^\infty, g')
     ylabel('_{10}log reserve capacity, [E_m], J/cm^3')
     %print -r300 -dpng Wwi_Em.png

   case 23
     shstat_options('x_transform', 'log10');
     shstat_options('y_transform', 'log10');
        
     WWRJ = read_allStat({'Ww_b', 'Ww_i', 'R_i', 'J_Oi', 'c_T'});
     Wwi = WWRJ(:,2); JR = WWRJ(:,3) .* WWRJ(:,1)  ./ WWRJ(:,5); JO = WWRJ(:,4) ./ WWRJ(:,5);
     logJO_range = [-5 2];
     
     hJO_JR = shstat([JO, JR], legend(1:21,:));   
     figure(hJO_JR)
     plot(logJO_range, 1+1*logJO_range, 'k', 'linewidth', 2)
     xlabel('_{10}log max respiration rate, mol/d')
     ylabel('_{10}log max neonate mass prod. rate, g/d')
     %print -r300 -dpng JO_JR.png
     
   case 24
     shstat_options('x_transform', 'log10');
     shstat_options('y_transform', 'log10');
     
     ampM = read_allStat({'a_m', 'p_M', 'c_T'}); ampM(:,1) = ampM(:,1) ./ ampM(:,3);
     [ham_pM, hlegend] = shstat(ampM(:,1:2), legend_Cyprinodontiformes);   
     figure(ham_pM)
     plot([1.7; 3.7], [3.4; 1.0], 'k', 'LineWidth', 3)
     xlabel('_{10}log life span, a_m, d')
     ylabel('_{10}log spec somatic maint, [p_M], J/d.cm^3')
     %print -r300 -dpng am_pM_Cyprinodontiformes.png
     figure(hlegend)
     %print -r300 -dpng legend_Cyprinodontiformes.png

     jWbpM = read_allStat({'N_i','Ww_i','Ww_b','p_M'});   jWbpM = [jWbpM(:,1) .* jWbpM(:,3) ./ jWbpM(:,2), jWbpM(:,4)];
     hjWbpM = shstat(jWbpM, legend_Cyprinodontiformes);   
     figure(hjWbpM)
     %plot([1.7; 3.7], [3.4; 1.0], 'k', 'LineWidth', 3)
     xlabel('_{10}log spec total neonate mass prod, N_\infty W_w^b/ W_w^\infty, -')
     ylabel('_{10}log spec somatic maint, [p_M], J/d.cm^3')
     %print -r300 -dpng NiWbWi_pM_Cyprinodontiformes.png
     
     WdW = read_allStat({'W_dWm','dWm','p_M','c_T'});   WdW = [WdW(:,2) ./ WdW(:,1) ./ WdW(:,4), WdW(:,3)];
     hWdW_pM = shstat(WdW, legend_Cyprinodontiformes);   
     figure(hWdW_pM)
     %plot([1.7; 3.7], [3.4; 1.0], 'k', 'LineWidth', 3)
     xlabel('_{10}log max spec growth rate, 1/d')
     ylabel('_{10}log spec somatic maint, [p_M], J/d.cm^3')
     %print -r300 -dpng WdW_pM_Cyprinodontiformes.png
     
     hv_pM = shstat({'v','p_M'}, legend_Cyprinodontiformes);   
     figure(hv_pM)
     %plot([1.7; 3.7], [3.4; 1.0], 'k', 'LineWidth', 3)
     xlabel('_{10}log energy conductance, v, cm/d')
     ylabel('_{10}log spec somatic maint, [p_M], J/d.cm^3')
     %print -r300 -dpng v_pM_Cyprinodontiformes.png

     
   case 25
     shstat_options('x_transform', 'log10');
     shstat_options('y_transform', 'log10');
     
     ampM = read_allStat({'a_m', 'p_M', 'c_T'}); ampM(:,1) = ampM(:,1) ./ ampM(:,3);
     [ham_pM, hlegend] = shstat(ampM(:,1:2), legend_Leuciscinae);   
     figure(ham_pM)
     %plot([1.7; 3.7], [3.4; 1.0], 'k', 'LineWidth', 3) % slope -1.2
     plot([2.1; 4.3], [2.92; 0.28], 'k', 'LineWidth', 3) % slope -1.2
     xlabel('_{10}log life span, a_m, d')
     ylabel('_{10}log spec somatic maint, [p_M], J/d.cm^3')
     %print -r300 -dpng am_pM_Leuciscinae.png
     figure(hlegend)
     %print -r300 -dpng legend_Leuciscinae.png

     jWbpM = read_allStat({'N_i','Ww_i','Ww_b','p_M'});   jWbpM = [jWbpM(:,1) .* jWbpM(:,3) ./ jWbpM(:,2), jWbpM(:,4)];
     hjWbpM = shstat(jWbpM, legend_Leuciscinae);   
     figure(hjWbpM)
     %plot([1.7; 3.7], [3.4; 1.0], 'k', 'LineWidth', 3)
     xlabel('_{10}log spec total neonate mass prod, N_\infty W_w^b/ W_w^\infty, -')
     ylabel('_{10}log spec somatic maint, [p_M], J/d.cm^3')
     %print -r300 -dpng NiWbWi_pM_Leuciscinae.png
     
     WdW = read_allStat({'W_dWm','dWm','p_M','c_T'});   WdW = [WdW(:,2) ./ WdW(:,1) ./ WdW(:,4), WdW(:,3)];
     hWdW_pM = shstat(WdW, legend_Leuciscinae);   
     figure(hWdW_pM)
     %plot([1.7; 3.7], [3.4; 1.0], 'k', 'LineWidth', 3)
     xlabel('_{10}log max spec growth rate, 1/d')
     ylabel('_{10}log spec somatic maint, [p_M], J/d.cm^3')
     %print -r300 -dpng WdW_pM_Leuciscinae.png

     hv_pM = shstat({'v','p_M'}, legend_Leuciscinae);   
     figure(hv_pM)
     %plot([1.7; 3.7], [3.4; 1.0], 'k', 'LineWidth', 3)
     xlabel('_{10}log energy conductance, v, cm/d')
     ylabel('_{10}log spec somatic maint, [p_M], J/d.cm^3')
     %print -r300 -dpng v_pM_Leuciscinae.png

   case 26  % fig 9
     shstat_options('x_transform', 'log10');
     shstat_options('y_transform', 'log10');
     
     ampM = read_allStat({'a_m', 'p_M', 'c_T'}); ampM(:,1) = ampM(:,1) ./ ampM(:,3);
     [ham_pM, hlegend] = shstat(ampM(:,1:2), legend_Etheostomatinae);   
     figure(ham_pM)
     %plot([1.7; 3.7], [3.4; 1.0], 'k', 'LineWidth', 3)
     plot([2.2; 4.0], [2.8; 0.64], 'k', 'LineWidth', 3) % slope -1.2
     xlabel('_{10}log life span, a_m, d')
     ylabel('_{10}log spec somatic maint, [p_M], J/d.cm^3')
     %print -r300 -dpng am_pM_Etheostomatinae.png
     figure(hlegend)
     %print -r300 -dpng legend_Etheostomatinae.png

     jWbpM = read_allStat({'N_i','Ww_i','Ww_b','p_M'});   jWbpM = [jWbpM(:,1) .* jWbpM(:,3) ./ jWbpM(:,2), jWbpM(:,4)];
     hjWbpM = shstat(jWbpM, legend_Etheostomatinae);   
     figure(hjWbpM)
     %plot([1.7; 3.7], [3.4; 1.0], 'k', 'LineWidth', 3)
     xlabel('_{10}log spec total neonate mass prod, N_\infty W_w^b/ W_w^\infty, -')
     ylabel('_{10}log spec somatic maint, [p_M], J/d.cm^3')
     %print -r300 -dpng NiWbWi_pM_Etheostomatinae.png
     
     WdW = read_allStat({'W_dWm','dWm','p_M','c_T'});   WdW = [WdW(:,2) ./ WdW(:,1) ./ WdW(:,4), WdW(:,3)];
     hWdW_pM = shstat(WdW, legend_Etheostomatinae);   
     figure(hWdW_pM)
     %plot([1.7; 3.7], [3.4; 1.0], 'k', 'LineWidth', 3)
     xlabel('_{10}log max spec growth rate, 1/d')
     ylabel('_{10}log spec somatic maint, [p_M], J/d.cm^3')
     %print -r300 -dpng WdW_pM_Etheostomatinae.png

     hv_pM = shstat({'v','p_M'}, legend_Etheostomatinae);   
     figure(hv_pM)
     %plot([1.7; 3.7], [3.4; 1.0], 'k', 'LineWidth', 3)
     xlabel('_{10}log energy conductance, v, cm/d')
     ylabel('_{10}log spec somatic maint, [p_M], J/d.cm^3')
     %print -r300 -dpng v_pM_Etheostomatinae.png


   case 27
     shstat_options('x_transform', 'log10');
     shstat_options('y_transform', 'log10');
     
     amap = read_allStat({'a_m', 'a_p', 'c_T'}); 
     amap = [amap(:,1) .* amap(:,3), amap(:,2) .* amap(:,3)];
     [ham_ap, ~] = shstat(amap, legend_RSED);   
     figure(ham_ap)
     %plot([1.7; 3.7], [3.4; 1.0], 'k', 'LineWidth', 3)
     xlabel('_{10}log life span, a_m, d')
     ylabel('_{10}log age at puberty, d')
     %print -r300 -dpng am_ap_RSED.png
     
   case 28  % fig 8
     shstat_options('x_transform', 'none');
     shstat_options('y_transform', 'none');
     
     traits = {'a_m'; 'a_p'; 'a_b'; 'L_i'; 'L_p'; 'L_b'; 'E_m'; 'R_i'; 's_s'; 's_Hbp'; 'p_M'; 'v'; 'kap'; 'E_Hb'; 'E_Hp'};
     distances = dist_traits(select('Pisces'), traits);
     y = cMDScale(distances); % configuration matrix, eigenvalues

     data = NaN(length(select),3); data(select_01('Pisces'),:) = y(:,1:3);

     % plot with legend in second figure
     [Hfig Hleg] = shstat(data, legend_Pisces, 'MDS for Pisces');
     xlabel(''); ylabel('')
     %print -r300 -dpng mds_Pisces.png % too big for -r300 when full-screen
     
     figure(Hleg)
     %print -r300 -dpng legend_Pisces.png

   case 29
     shstat_options('x_transform', 'log10');
     shstat_options('y_transform', 'log10');
     
     hpM_ha = shstat({'p_M','h_a'}, legend_Cyprinodontiformes);   
     figure(hpM_ha)
     xlabel('_{10}log spec somatic maintenance, [p_M], J/d.cm^3')
     ylabel('_{10}log ageing acceleration, 1/d^2')
     %print -r300 -dpng pM_ha_Cyprinodontiformes.png

   case 30 % fig 7b
     shstat_options('x_transform', 'log10');
     shstat_options('y_transform', 'log10');
     
     WdW = read_allStat({'W_dWm','dWm','c_T'}); 
     WdW = [WdW(:,1), WdW(:,2) ./ WdW(:,1) ./ WdW(:,3)];

     hWdWm_rm = shstat(WdW, legend);   
     figure(hWdWm_rm)
     plot([-5; 7], [0.3; -4.3], 'k', 'LineWidth', 2)
     xlabel('_{10}log weight at max growth, g')
     ylabel('_{10}log spec growth at max growth, 1/d')
     %print -r300 -dpng WdWm_rm.png
     
   case 31 % fig 5
     shstat_options('x_transform', 'log10');
     shstat_options('y_transform', 'log10');
       
     aJW = read_allStat({'a_m', 'J_Oi', 'Ww_i', 'Ww_b', 'R_i', 'c_T'});
     ham_jO = shstat([aJW(:,1).*aJW(:,6), aJW(:,2)./aJW(:,3)./aJW(:,6)], legend, 'Actinopterygii');   
     figure(ham_jO)
     xlim([1.7 5.3])
     plot([2; 5], [-3; -6], 'k', 'LineWidth', 3)
     xlabel('_{10}log life span, d')
     ylabel('_{10}log spec respiration, J_O^\infty/W_w^\infty, mol/d.g')
     xlim([1.5 5.3])
     %print -r300 -dpng am_jO.png
     
     WWN = read_allStat({'Ww_i', 'Ww_b', 'N_i'});
     WiWR = [WWN(:,1), WWN(:,2) .* WWN(:,3)];
         
     hWi_WR = shstat(WiWR, legend, 'Actinopterygii'); 
     figure(hWi_WR)
     xlim([-1 8])
     plot([-1; 7.5], [-1; 7.5], 'k', 'LineWidth', 3)
     xlabel('_{10}log ultimate weight, W_w^\infty, g')
     ylabel('_{10}log life time neonate mass, g')
     %print -r300 -dpng Wi_WR.png

end
end
