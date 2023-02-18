function AuguLika2022_SI(fig)
% Supporting Information for AuguLika2022
% Title: The comparative energetics of the chondrichthyans reveals universal links between respiration, reproduction and lifespan
% Authors: Augustine, Lika, Kooijman
% Journal: Journal of Sea Research 185  102228
% DOI: 10.1016/j.seares.2022.102228
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
% To run the code for a figure: type in the Matlab window e.g. AuguLika2022_SI(2)
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
   fig = 1:28;
end

 llegend = {... % Chondrichthyes
   {'-', 2, [0 0 0]}, 'Holocephali'; ....
   {'-', 2, [0 0 1]}, 'Galeomorphi'; ....
   {'-', 2, [1 0 1]}, 'Squalomorphi'; ....
   {'-', 2, [1 0 0]}, 'Batoidea'; ....
 };

 llegend_Batoidea = {... % Batoidea
   {'-', 2, [0 0 0]}, 'Rajiformes'; ....
   {'-', 2, [0 0 1]}, 'Rhinopristiformes'; ....
   {'-', 2, [1 0 1]}, 'Myliobatiformes'; ....
   {'-', 2, [1 0 0]}, 'Torpediniformes'; ....
 };

 %hlleg = shllegend(llegend);
 %saveas(hlleg, [path, 'llegend_Chondrichthyes.png'])

 legend_Pisces = {... % Chondrichthyes
   % Holocephali: edge black
   {'o', 8, 3, [0 0 0], [0 0 0]}, 'Chimaeriformes'; ...
   % Galeomorphi: edge blue
   {'o', 8, 3, [0 0 1], [0 0 0]}, 'Heterodontiformes'; .... 
   {'o', 8, 3, [0 0 1], [0 0 1]}, 'Orectolobiformes'; ....   
   {'o', 8, 3, [0 0 1], [1 0 1]}, 'Carcharhiniformes'; ....   
   {'o', 8, 3, [0 0 1], [1 0 0]}, 'Lamniformes'; ....   
   % Squalomorphi: edge magenta
   {'o', 8, 3, [1 0 1], [0 0 0]}, 'Squatiniformes'; ....   
   {'o', 8, 3, [1 0 1], [0 0 1]}, 'Pristiophoriformes'; ....   
   {'o', 8, 3, [1 0 1], [1 0 1]}, 'Squaliformes'; ....   
   {'o', 8, 3, [1 0 1], [1 0 0]}, 'Hexanchiformes'; ....   
   % Batoidea: edge red
   {'o', 8, 3, [1 0 0], [0 0 0]}, 'Rajiformes'; ....
   {'o', 8, 3, [1 0 0], [0 0 1]}, 'Rhinopristiformes'; ....
   {'o', 8, 3, [1 0 0], [1 0 1]}, 'Myliobatiformes'; ....
   {'o', 8, 3, [1 0 0], [1 1 1]}, 'Torpediniformes'; ....
   % other fish
   {'.', 8, 8, [0 0 0], [0 0 0]}, 'Cyclostomata'; ...
   {'.', 8, 8, [0 0 1], [0 0 0]}, 'Actinopterygii'; ...
   {'.', 8, 8, [1 0 1], [0 0 0]}, 'Actinistia'; ...
   {'.', 8, 8, [1 0 0], [0 0 0]}, 'Dipnoi'; ...
 };

 legend_raji = { ... % Rajiformes
   % Rajidae: edge black & blue
   {'o', 8, 3, [0 0 0], [0 0 0]}, 'Amblyraja'; ....
   {'o', 8, 3, [0 0 0], [0 0 1]}, 'Beringraja'; ....
   {'o', 8, 3, [0 0 0], [1 0 1]}, 'Dentiraja'; ....
   {'o', 8, 3, [0 0 0], [1 0 0]}, 'Dipturus'; ....
   {'o', 8, 3, [0 0 0], [1 1 1]}, 'Leucoraja'; ....
   {'o', 8, 3, [0 0 1], [0 0 0]}, 'Malacoraja'; ....
   {'o', 8, 3, [0 0 1], [0 0 1]}, 'Okamejei'; ....
   {'o', 8, 3, [0 0 1], [1 0 1]}, 'Raja'; ....
   {'o', 8, 3, [0 0 1], [1 0 0]}, 'Rostroraja'; ....
   {'o', 8, 3, [0 0 1], [1 1 1]}, 'Zearaja'; ....
   % Arhynchobatidae: edge red
   {'o', 8, 3, [1 0 0], [0 0 0]}, 'Bathyraja'; ....
   {'o', 8, 3, [1 0 0], [0 0 1]}, 'Sympterygia'; ....
   {'o', 8, 3, [1 0 0], [1 0 0]}, 'Rioraja'; ....
   {'o', 8, 3, [1 0 0], [0 0 1]}, 'Atlantoraja'; ....
 };

  legend_Amphibia = {... % Amphibia
    % Gymnophiona: edge black
    {'o', 8, 3, [0 0 0], [0 0 0]}, 'Gymnophiona'; ...
    % Caudata: edge blue
    {'o', 8, 3, [0 0 1], [0 0 1]}, 'Cryptobranchoidea'; .... 
    {'o', 8, 3, [1 0 1], [0 0 0]}, 'Salamandroidea'; ....   
    {'o', 8, 3, [1 0 1], [1 0 0]}, 'Sirenoidea'; ....   
    % Anura: edge red
    {'o', 8, 3, [1 0 0], [0 0 0]}, 'Archaeobatrachia'; ....   
    {'o', 8, 3, [1 0 0], [0 0 1]}, 'Mesobatrachia'; ....   
    {'o', 8, 3, [1 0 0], [1 0 0]}, 'Neobatrachia'; ....   
  };

  legend_Squamata = {... % Squamata
    % Gekkota: edge black
    {'o', 8, 3, [0 0 0], [0 0 0]}, 'Gekkota'; ...
    % Scinciformata: edge blue
    {'o', 8, 3, [0 0 1], [0 0 1]}, 'Scinciformata'; .... 
    % Laterata: edge magenta
    {'o', 8, 3, [1 0 1], [0 0 0]}, 'Teiformata'; ....   
    {'o', 8, 3, [1 0 1], [1 0 0]}, 'Lacertibaenia'; ....   
    % Toxifera: edge red
    {'o', 8, 3, [1 0 0], [0 0 0]}, 'Anguimorpha'; ....   
    {'o', 8, 3, [1 0 0], [0 0 1]}, 'Iguania'; ....   
    {'o', 8, 3, [1 0 0], [1 0 0]}, 'Serpentes'; ....   
  };

  legend_Aves = {... % Aves
    % Crocodilia
    {'o', 8, 3, [0 0 0], [1 1 1]}, 'Crocodilia'; ...
    % 
    {'o', 8, 3, [0 0 1], [0 0 0]}, 'Paleognathae'; ...
    {'o', 8, 3, [0 0 1], [1 0 0]}, 'Galloanserae'; ....
    % Neoaves: edge magenta or red
    {'o', 8, 3, [1 0 1], [0 0 1]}, 'Mirandornithes'; ....
    {'o', 8, 3, [1 0 1], [1 0 0]}, 'Protelluraves'; ....
    % Passerea: edge red
    {'o', 8, 3, [1 0 0], [0 0 1]}, 'Ardeae'; ....
    {'o', 8, 3, [1 0 0], [1 0 1]}, 'Afroaves'; ....
    {'o', 8, 3, [1 0 0], [1 1 1]}, 'Australaves'; ....
  };

  legend_Placentalia = {... % Placentalia
    {'o', 8, 3, [0 0 1], [0 0 1]}, 'Xenarthra'; ...
    {'o', 8, 3, [0 0 1], [1 0 1]}, 'Afrotheria'; ....
    {'o', 8, 3, [0 0 1], [1 0 0]}, 'Laurasiatheria'; ....
    {'o', 8, 3, [1 0 1], [1 0 1]}, 'Gliriformes'; ....
    {'o', 8, 3, [1 0 1], [1 0 0]}, 'Scandentia'; ....
    {'o', 8, 3, [1 0 0], [1 0 0]}, 'Dermoptera'; ....
    {'o', 8, 3, [1 0 0], [1 .5 .5]}, 'Primates'; ....
  };

 legend_Mollusca = {... % Cephalopoda
    % Nautiloidea: edge black
    {'o', 8, 3, [0 0 0], [0 0 0]}, 'Nautilida'; ...
    % Decapodiformes: edge blue
    {'o', 8, 3, [0 0 1], [0 0 0]}, 'Idiosepida'; ....   
    {'o', 8, 3, [0 0 1], [0 0 1]}, 'Myopsida'; ....
    {'o', 8, 3, [0 0 1], [1 0 1]}, 'Oegopsida'; ....
    {'o', 8, 3, [0 0 1], [1 0 0]}, 'Sepiida'; ....     
    {'o', 8, 3, [0 0 1], [1 1 1]}, 'Spirulida'; ....  
    % Octopodiformes: edge red
    {'o', 8, 3, [1 0 0], [1 0 0]}, 'Octopoda'; ....
    {'o', 8, 3, [1 0 0], [1 1 1]}, 'Vampyromorpha'; ....
    % other molluscs
    {'.', 8, 8, [0 0 0], [0 0 0]}, 'Polyplacophora'; ...
    {'.', 8, 8, [0 0 1], [0 0 1]}, 'Bivalvia'; ...
    {'.', 8, 8, [1 0 1], [1 0 1]}, 'Gastropoda'; ...
 };

 close all
 shstat_options('default');
 shstat_options('y_label', 'on'); 
 shstat_options('x_label', 'off'); 
 
 for i=1:length(fig)
 
 switch fig(i)
   case 1 % fig 2c
     shstat_options('x_transform', 'none');
     [hkap hllegend] = shstat({'kap'}, llegend);
     figure(hkap)
     xlabel('allocation fraction to soma, \kappa, -')
     %print -r300 -dpng kap.png

   case 2 % fig 2d
     shstat_options('x_transform', 'log10');
     hp_M = shstat({'p_M'}, llegend); 
     figure(hp_M)
     xlabel('_{10}log vol-spec somatic maint, [p_M], J/d.cm^3')
     %print -r300 -dpng pM.png
      
   case 3 % fig 2h
     shstat_options('x_transform', 'log10');
     hs_s = shstat({'s_s'}, llegend); 
     figure(hs_s)
     xlabel('_{10}log supply stress, s_s, -')
     %print -r300 -dpng ss.png

   case 4 % fig 2g
     shstat_options('x_transform', 'log10');
     hs_Hbp = shstat({'s_Hbp'}, llegend); 
     figure(hs_Hbp)
     xlabel('_{10}log precociality coeff, s_H^{bp}, -')
     %print -r300 -dpng sHbp.png

   case 5 % fig 2b
     shstat_options('x_transform', 'log10');
     hv = shstat({'v'}, llegend); 
     figure(hv)
     xlabel('_{10}log energy conductance, v, cm/d')
     %print -r300 -dpng v.png

   case 6 % fig 2a
     shstat_options('x_transform', 'log10');
     hp_Am = shstat({'p_Am'}, llegend); 
     figure(hp_Am)
     xlabel('_{10}log spec assimilation rate, \{p_{Am}\}, J/d.cm^2')
     %print -r300 -dpng pAm.png

   case 7 % fig 2i
     shstat_options('x_transform', 'log10');
   
     hWw_i = shstat({'Ww_i'}, llegend);
     shstat({'Ww_b'}, llegend, [], hWw_i);
     figure(hWw_i)
     xlabel('_{10}log wet weight at birth, death, W_b^w, W_\infty^w, g')
     %print -r300 -dpng Wwi.png

   case 8 % fig 2f
     shstat_options('x_transform', 'log10');
     hE_m = shstat({'E_m'}, llegend); 
     figure(hE_m)
     xlabel('_{10}log reserve capacity, [E_m], J/cm^3')
     %print -r300 -dpng Em.png

   case 9 % fig 2e
     shstat_options('x_transform', 'log10');
     ha_m = shstat({'a_m'}, llegend); 
     shstat({'a_b'}, llegend, [], ha_m);   
     figure(ha_m)
     xlabel('_{10}log age at birth, death, d')
     xlim([1.5 5.2]);
     %print -r300 -dpng am.png
     
   case 10 % fig 2j
     shstat_options('x_transform', 'log10');
     WdW_C = read_stat(select('Chimaeriformes'),{'W_dWm','dWm','c_T'}); WdW_C = WdW_C(:,2) ./ WdW_C(:,1) ./ WdW_C(:,3);
     WdW_S = read_stat(select('Squalomorphi'),{'W_dWm','dWm','c_T'});   WdW_S = WdW_S(:,2) ./ WdW_S(:,1) ./ WdW_S(:,3);
     WdW_G = read_stat(select('Galeomorphi'),{'W_dWm','dWm','c_T'});    WdW_G = WdW_G(:,2) ./ WdW_G(:,1) ./ WdW_G(:,3);
     WdW_B = read_stat(select('Batoidea'),{'W_dWm','dWm','c_T'});       WdW_B = WdW_B(:,2) ./ WdW_B(:,1) ./ WdW_B(:,3);
     hWdW = shstat(WdW_C, {'k', 'k'});   
     shstat(WdW_S, {'b', 'b'}, [], hWdW);   
     shstat(WdW_G, {'m', 'm'}, [], hWdW);   
     shstat(WdW_B, {'r', 'r'}, [], hWdW);   
     figure(hWdW)
     xlabel('_{10}log spec growth at max growth, r, g/d.g')
     %print -r300 -dpng WdW.png

   case 11 % fig 2k
     shstat_options('x_transform', 'log10');
     JOiW_C = read_stat(select('Chimaeriformes'),{'J_Oi','Ww_i','c_T'}); JOiW_C = JOiW_C(:,1) ./ JOiW_C(:,2) ./ JOiW_C(:,3);
     JOiW_S = read_stat(select('Squalomorphi'),{'J_Oi','Ww_i','c_T'});   JOiW_S = JOiW_S(:,1) ./ JOiW_S(:,2) ./ JOiW_S(:,3);
     JOiW_G = read_stat(select('Galeomorphi'),{'J_Oi','Ww_i','c_T'});    JOiW_G = JOiW_G(:,1) ./ JOiW_G(:,2) ./ JOiW_G(:,3);
     JOiW_B = read_stat(select('Batoidea'),{'J_Oi','Ww_i','c_T'});       JOiW_B = JOiW_B(:,1) ./ JOiW_B(:,2) ./ JOiW_B(:,3);
     hJOiW = shstat(JOiW_C, {'k', 'k'});   
     shstat(JOiW_S, {'b', 'b'}, [], hJOiW);   
     shstat(JOiW_G, {'m', 'm'}, [], hJOiW);   
     shstat(JOiW_B, {'r', 'r'}, [], hJOiW);   
     figure(hJOiW)
     xlabel('_{10}log ultimate specific O_2 consumption, J_O^m, mol/d.g')
     %print -r300 -dpng JOiW.png

   case 12 % fig 3
     shstat_options('x_transform', 'log10');
     shstat_options('y_transform', 'log10');
     WJO = read_allStat({'Ww_i', 'J_Oi','c_T'}); WJO(:,2) = WJO(:,2) ./ WJO(:,1) ./ WJO(:,3);
     [hWwi_JOiW, hC]= shstat(WJO, legend_Pisces);   
     figure(hWwi_JOiW)
     xlabel('_{10}log ultimate wet weigh, g')
     ylabel('_{10}log spec O_2 consumption, mol/d.g')
     print -r0 -dpng Wwi_JOiW.png
     figure(hC)     
     %print -r0 -dpng legend_Chondrichthyes.png

    case 13 % fig 4a
     shstat_options('x_transform', 'none');
     shstat_options('y_transform', 'log10');
%      kNWWa = read_allStat({'kap', 'N_i', 'Ww_b', 'Ww_i', 'a_m'}); 
%      kap = kNWWa(:,1); R = kNWWa(:,2) ./ kNWWa(:,5);
%      hkap_R = shstat([kap, R], legend_Pisces); 
     kR = read_allStat({'kap','R_i','c_T'}); kR = [kR(:,1), kR(:,2)./kR(:,3)];
     hkap_R = shstat(kR, legend_Pisces);   
     figure(hkap_R)
     xlabel('allocation fraction to soma, \kappa, -')
     ylabel('_{10}log max reproduction rate, #/d')
     %print -r300 -dpng kap_R.png
    
   case 14 % fig 4b
     shstat_options('x_transform', 'none');
     shstat_options('y_transform', 'log10');
%      kNWWa = read_allStat({'kap', 'N_i', 'Ww_b', 'Ww_i', 'a_m'}); 
%      kap = kNWWa(:,1); RWW = kNWWa(:,2) .* kNWWa(:,3) ./ kNWWa(:,5) ./ kNWWa(:,4);
%      hkap_RWW = shstat([kap, RWW], legend_Pisces);   
     kNWW = read_allStat({'kap', 'R_i', 'Ww_b', 'Ww_i', 'c_T'}); 
     kap = kNWW(:,1); RWW = kNWW(:,2) .* kNWW(:,3) ./ kNWW(:,4) ./ kNWW(:,5);
     hkap_RWW = shstat([kap, RWW], legend_Pisces);   
     figure(hkap_RWW)
     xlabel('allocation fraction to soma, \kappa, -')
     ylabel('_{10}log max neonate mass prod, 1/d')
     %print -r300 -dpng kap_RWW.png

   case 15 % fig 4b
     shstat_options('x_transform', 'none');
     shstat_options('y_transform', 'log10');
     kRWW = read_allStat({'kap', 'R_i', 'Ww_b', 'Ww_i', 'c_T'}); 
     kap = kRWW(:,1); RWW = kRWW(:,2) .* kRWW(:,3) ./ kRWW(:,4) ./ kRWW(:,5);
     hkap_RWW = shstat([kap, RWW], legend_Pisces);   
     figure(hkap_RWW)
     xlabel('allocation fraction to soma, \kappa, -')
     ylabel('_{10}log spec neonate mass prod, g/d')
     %print -r300 -dpng kap_RWW.png

   case 16 % fig 5b
     shstat_options('x_transform', 'log10');
     shstat_options('y_transform', 'log10');
     WdW = read_allStat({'W_dWm','dWm','c_T'}); WdW = WdW(:,2) ./ WdW(:,1) ./ WdW(:,3);
     r = read_popStat('f1.thin1.f.r') ./ read_popStat('c_T'); 
     
     hWdW_r = shstat([WdW, r], legend_Pisces);   
     figure(hWdW_r)
     plot([-6 -1.5], [-6 -1.5], 'k', 'LineWidth', 3)
     xlabel('_{10}log max spec growth, r_m, g/d.g')
     ylabel('_{10}log max spec pop growth, r_N, 1/d')
     %print -r300 -dpng WdW_r.png

   case 17 % fig 5a
     shstat_options('x_transform', 'log10');
     shstat_options('y_transform', 'log10');
     aJW = read_allStat({'a_m', 'J_Oi', 'Ww_i', 'Ww_b', 'R_i', 'c_T'});
     
     ham_jO = shstat([aJW(:,1).*aJW(:,6), aJW(:,2)./aJW(:,3)./aJW(:,6)], legend_Pisces, 'Pisces');   
     figure(ham_jO)
     plot([2; 5], [-3; -6], 'k', 'LineWidth', 3)
     xlabel('_{10}log life span, d')
     ylabel('_{10}log spec respiration, J_O^\infty/W_w^\infty, mol/d.g')
     xlim([1.5 5.3])
     %print -r300 -dpng am_jO.png
    
     hWi_amJWb = shstat([aJW(:,3), aJW(:,1).*aJW(:,4).*aJW(:,5)], legend_Pisces, 'Pisces'); 
     figure(hWi_amJWb)
     plot([-1; 7.5], [-1; 7.5], 'k', 'LineWidth', 3)
     xlabel('_{10}log ultimate weight, W_w^\infty, g')
     ylabel('_{10}log life span \times neonate mass prod, g')
     %print -r300 -dpng Wi_amJWb_Pisces.png

     [hWi_amJWb_Amphibia, hlegend_Amphibia] = shstat([aJW(:,3).*aJW(:,6), aJW(:,1).*aJW(:,4).*aJW(:,5)./aJW(:,6)], legend_Amphibia, 'Amphibia'); 
     figure(hWi_amJWb_Amphibia)
     plot([-0.5; 5], [-0.5; 5], 'k', 'LineWidth', 3)
     xlabel('_{10}log ultimate weight, W_w^\infty, g')
     ylabel('_{10}log life span \times neonate mass prod, g')
     print -r300 -dpng Wi_amJWb_Amphibia.png
     figure(hlegend_Amphibia)
     %print -r300 -dpng legend_Amphibia.png

     [hWi_amJWb_Squamata hlegend_Squamata] = shstat([aJW(:,3), aJW(:,1).*aJW(:,4).*aJW(:,5)], legend_Squamata, 'Squamata'); 
     figure(hWi_amJWb_Squamata)
     plot([-0.5; 6], [-0.5; 6], 'k', 'LineWidth', 3)
     xlabel('_{10}log ultimate weight, W_w^\infty, g')
     ylabel('_{10}log life span \times neonate mass prod, g')
     print -r0 -dpng Wi_amJWb_Squamata.png
     figure(hlegend_Squamata)
     %print -r300 -dpng legend_Squamata.png

     [hWi_amJWb_Aves hlegend_Aves] = shstat([aJW(:,3), aJW(:,1).*aJW(:,4).*aJW(:,5)], legend_Aves, 'Crocs & Aves'); 
     figure(hWi_amJWb_Aves)
     plot([0.5; 7], [0.5; 7], 'k', 'LineWidth', 3)
     plot([0.5; 7], [0.9; 7.4], ':k', 'LineWidth', 3)
     xlabel('_{10}log ultimate weight, W_w^\infty, g')
     ylabel('_{10}log life span \times neonate mass prod, g')
     print -r300 -dpng Wi_amJWb_Aves.png
     figure(hlegend_Aves)
     %print -r300 -dpng legend_Aves.png

     [hWi_amJWb_Placentalia, hlegend_Placentalia] = shstat([aJW(:,3), aJW(:,1).*aJW(:,4).*aJW(:,5)], legend_Placentalia, 'Placentalia'); 
     figure(hWi_amJWb_Placentalia)
     plot([0; 9], [0; 9], 'k', 'LineWidth', 3)
     xlabel('_{10}log ultimate weight, W_w^\infty, g')
     ylabel('_{10}log life span \times neonate mass prod, g')
     print -r300 -dpng Wi_amJWb_Placentalia.png
     figure(hlegend_Placentalia)
     %print -r300 -dpng legend_Placentalia.png

     [sel_C, nm] = select_01('Cephalopoda'); nm_C = nm(sel_C); n_C = length(nm_C); Wa = zeros(n_C,1); Ri = zeros(n_C,1); WD = cdCur;
     for i=1:n_C; cdEntr(nm_C{i}); 
       eval(['load(''results_',nm_C{i},''',''par'')']); 
       eval(['[data, auxData] = mydata_', nm_C{i},';']);
       cPar = parscomp_st(par); vars_pull(par); vars_pull(cPar); vars_pull(auxData);
       TC = tempcorr(temp.am, T_ref, T_A); kT_M = k_M * TC;
       pars_tj = [g; k; l_T; v_Hb; v_Hj; v_Hp];
       [t_j, t_p, t_b, l_j, l_p, l_b, l_i, rho_j, rho_B] = get_tj(pars_tj, f);
       pars_tm = [pars_tj; h_a/ k_M^2; s_G]; % compose parameter vector at T_ref
       aT_m = get_tm_j(pars_tm, f)/ kT_M;    % d, mean life span at T
       L_j = L_m *  l_j; L_i = L_m * l_i; rT_B = rho_B * kT_M; % cm, ultimate structural length at f
       L_am = L_i - (L_i - L_j) * exp(- rT_B * (aT_m  - t_j/ kT_M));  
       Wa(i) = L_am^3 * (1 + f * w);         % g, wet weight
       pars_R = [kap; kap_R; g; TC * k_J; TC * k_M; L_T; TC * v; U_Hb/ TC; U_Hj/ TC; U_Hp/ TC]; % compose parameter vector
       Ri(i) = reprod_rate_j(L_am, 1, pars_R); % #/d, cum no of eggs
     end
     aJW(sel_C,3) = Wa; aJW(sel_C,5) = Ri; cd(WD);
     
     [hWi_amJWb_Mollusca hlegend_Mollusca] = shstat([aJW(:,3), aJW(:,1).*aJW(:,4).*aJW(:,5)], legend_Mollusca, 'Mollusca'); 
     figure(hWi_amJWb_Mollusca)
     plot([-4; 7], [-4; 7], 'k', 'LineWidth', 3)
     xlabel('_{10}log ultimate weight, W_w^\infty, g')
     ylabel('_{10}log life span \times neonate mass prod, g')
     print -r300 -dpng Wi_amJWb_Mollusca.png
     figure(hlegend_Mollusca)
     %print -r300 -dpng legend_Mollusca.png

   case 18 % fig 1a, 1b
     shstat_options('x_transform', 'log10');
     shstat_options('y_transform', 'log10');
        
     WWRJp = read_allStat({'Ww_b', 'Ww_i', 'R_i', 'J_Oi', 'p_Ti', 'c_T'}); 
     Wwi = WWRJp(:,2); JR = WWRJp(:,3) .* WWRJp(:,1) ./ WWRJp(:,6); JO = WWRJp(:,4) ./ WWRJp(:,6); pT = WWRJp(:,5) ./ WWRJp(:,6);
     logJO_range = [-3.5 2]; logpT_range = [2.5 8];
     
     hJO_JR = shstat([JO, JR], legend_Pisces(1:13,:));   
     figure(hJO_JR)
     plot(logJO_range, 1+logJO_range, 'k', 'linewidth', 2)
     xlabel('_{10}log max respiration rate, mol/d')
     ylabel('_{10}log max neonate mass prod. rate, g/d')
     %print -r300 -dpng JO_JR.png

     hpT_JR = shstat([pT, JR], legend_Pisces(1:13,:));   
     figure(hpT_JR)
     plot(logpT_range, -4.7+logpT_range, 'k', 'linewidth', 2)
     xlabel('_{10}log max heat dissipation, J/d')
     ylabel('_{10}log max neonate mass prod. rate, g/d')
     %print -r0 -dpng pT_JR.png

     [hJO_JR_RSED hlegend_RSED] = shstat([JO, JR], legend_RSED);   
     figure(hJO_JR_RSED)
     logJO_range = [-10 4];
     plot(logJO_range, 1+logJO_range, 'k', 'linewidth', 2)
     xlabel('_{10}log max respiration rate, mol/d')
     ylabel('_{10}log max neonate mass prod. rate, g/d')
     %print -r300 -dpng JO_JR_RSED.png
     figure(hlegend_RSED)
     %print -r300 -dpng legend_RSED.png

   case 19 % fig 6a, 6b, 6c
     shstat_options('x_transform', 'log10');
     shstat_options('y_transform', 'log10');
     shstat_options('z_transform', 'log10');
     
%      hEm_sHbp = shstat({'E_m', 's_Hbp'}, legend_Pisces(1:13,:)); 
%      figure(hEm_sHbp)
%      plot([3.25 5.25],[-0.25 -3.25], 'k', 'LineWidth', 3)
%      xlabel('_{10}log reserve capacity, [E_m], J/cm^3')
%      ylabel('_{10}log precociality coeff, s_H^{bp}, - ')
%      saveas(hEm_sHbp, [path, 'Em_sHbp.png'])

     hLi_Em = shstat({'L_i','E_m'}, legend_Pisces(1:13,:)); 
     figure(hLi_Em)
     plot([0.25 2.25],[3.25 5.25], 'k', 'LineWidth', 3)
     xlabel('_{10}log ultimate structural length, L_\infty, cm ')
     ylabel('_{10}log reserve capacity, [E_m], J/cm^3')
     %print -r300 -dpng Li_Em.png
 
     hpM_Em = shstat({'p_M','E_m'}, legend_Pisces(1:13,:)); 
     figure(hpM_Em)
     %plot([0.25 2.25],[3.25 5.25], 'k', 'LineWidth', 3)
     xlabel('_{10}log spec somatic maint, [p_M], J/d.cm^3')
     ylabel('_{10}log reserve capacity, [E_m], J/cm^3')
     %print -r300 -dpng pM_Em.png
 
     hpAm_Em = shstat({'p_Am','E_m'}, legend_Pisces(1:13,:)); 
     figure(hpAm_Em)
     %plot([0.25 2.25],[3.25 5.25], 'k', 'LineWidth', 3)
     xlabel('_{10}log spec assimilation, \{p_{Am}\}, J/d.cm^2')
     ylabel('_{10}log reserve capacity, [E_m], J/cm^3')
     %print -r300 -dpng pAm_Em.png
    
     hv_Em = shstat({'v','E_m'}, legend_Pisces(1:13,:)); 
     figure(hv_Em)
     %plot([0.25 2.25],[3.25 5.25], 'k', 'LineWidth', 3)
     xlabel('_{10}log energy conductance, v, cm/d')
     ylabel('_{10}log reserve capacity, [E_m], J/cm^3')
     %print -r300 -dpng v_Em.png

     
%      hLi_Em_sHbp = shstat({'L_i','E_m','s_Hbp'}, legend_Pisces(1:13,:)); 
%      figure(hLi_Em_sHbp)
%      plot3([0.25 2.25],[3.25 5.25], [-0.25 -3.25], 'k', 'LineWidth', 3)
%      xlabel('_{10}log ultimate structural length, L_\infty, cm ')
%      ylabel('_{10}log reserve capacity, [E_m], J/cm^3')
%      zlabel('_{10}log precociality coeff, s_H^{bp}, - ')

%      hLi_Em_sHbp_raji = shstat({'L_i','E_m','s_Hbp'}, legend_raji); 
%      figure(hLi_Em_sHbp_Raja)
%      plot3([0.25 2.25],[3.25 5.25], [-0.25 -3.25], 'k', 'LineWidth', 3)
%      xlabel('_{10}log ultimate structural length, L_\infty, cm ')
%      ylabel('_{10}log reserve capacity, [E_m], J/cm^3')
%      zlabel('_{10}log precociality coeff, s_H^{bp}, - ')
 
%      hpM_Em_raji = shstat({'p_M','E_m'}, legend_raji); 
%      figure(hpM_Em_raji)
%      xlabel('_{10}log spec som maint, [p_M], J/d.cm^3')
%      ylabel('_{10}log reserve capacity, [E_m], J/cm^3')
%      saveas(hpM_Em_raji, [path, 'pM_Em_raji.png'])

   case 20
     shstat_options('x_transform', 'log10');
     shstat_options('y_transform', 'log10');
     
     WWs = read_stat('Chondrichthyes',{'Ww_b','Ww_p','s_Hbp'});
     data = NaN(length(select('Animalia')),2); 
     data(select_01('Chondrichthyes'),:) = [WWs(:,1)./WWs(:,2), WWs(:,3)];
     hWW_sHbp = shstat(data, legend_Pisces(1:13,:)); 
     figure(hWW_sHbp)
     % plot([0.25 2.25],[3.25 5.25], 'k', 'LineWidth', 3)
     xlabel('_{10}log birth over puberty weight, W_w^b/W_w^p, -')
     ylabel('_{10}log precociality coeff, s_H^{bp}, -')
     %print -r300 -dpng Ww_sHbp.png
     
   case 21
     shstat_options('x_transform', 'log10');
     shstat_options('y_transform', 'log10');
     
     hWwi_Wwb = shstat({'Ww_i','Ww_b'}, legend_Pisces); 
     figure(hWwi_Wwb)
     xlabel('_{10}log ultimate weight, g')
     ylabel('_{10}log weight at birth, g')
     %print -r300 -dpng Wwi_Wwb.png
     
     WR = read_allStat({'Ww_i','R_i','c_T'}); WR = [WR(:,1), WR(:,2)./WR(:,3)];
     hWwi_Ri = shstat(WR, legend_Pisces); 
     figure(hWwi_Ri)
     xlabel('_{10}log ultimate weight, g')
     ylabel('_{10}log ultimate reprod rate, #/d')
     %print -r0 -dpng Wwi_Ri.png

     WWR = read_stat('Pisces',{'Ww_b','Ww_i','R_i','c_T'});
     data = NaN(length(select('Animalia')),2); 
     data(select_01('Pisces'),:) = [WWR(:,2), WWR(:,3) .* WWR(:,1) ./ WWR(:,2) ./ WWR(:,4)];
     hWwi_RiWW = shstat(data, legend_Pisces); 
     figure(hWwi_RiWW)
     xlabel('_{10}log ultimate weight, W_w^\infty, g')
     ylabel('_{10}log reprod rate \times W^w_b/W^w_i, #/d')
     %print -r300 -dpng Wwi_RiWW.png
     
   case 22
     shstat_options('x_transform', 'log10');
     
     % Batoidea: edge red
     Wwi_Ra = read_stat(select('Rajiformes'),{'Ww_i'}); 
     Wwi_Rh = read_stat(select('Rhinopristiformes'),{'Ww_i'}); 
     Wwi_My = read_stat(select('Myliobatiformes'),{'Ww_i'}); 
     Wwi_To = read_stat(select('Torpediniformes'),{'Ww_i'});
     hWw_i_Bat= shstat(Wwi_Ra, {'k', 'k'});   
     shstat(Wwi_Rh, {'b', 'b'}, [], hWw_i_Bat);   
     shstat(Wwi_My, {'m', 'm'}, [], hWw_i_Bat);   
     shstat(Wwi_To, {'r', 'r'}, [], hWw_i_Bat);   
     
     shstat({'Ww_b'}, llegend_Batoidea, [], hWw_i_Bat);
     figure(hWw_i_Bat)
     xlabel('_{10}log wet weight at birth, death, W_b^w, W_\infty^w, g')
     %print -r300 -dpng Wwi.png

   case 23 
     shstat_options('x_transform', 'log10');
     shstat_options('y_transform', 'log10');
     
     hWwi_Wwb = shstat({'Ww_i','Ww_b'}, legend_Pisces); 
     figure(hWwi_Wwb)
     xlabel('_{10}log ultimate weight, g')
     ylabel('_{10}log weight at birth, g')
     %print -r300 -dpng Wwi_Wwb.png
     
     RW = read_allStat({'Ww_i','R_i','c_T'}); RW = [RW(:,1), RW(:,2) ./ RW(:,3)];
     hWwi_Ri = shstat(RW, legend_Pisces); 
     figure(hWwi_Ri)
     xlabel('_{10}log ultimate weight, g')
     ylabel('_{10}log ultimate reprod rate, #/d')
     %print -r300 -dpng Wwi_Ri.png

     WWR = read_stat('Pisces',{'Ww_b','Ww_i','R_i','c_T'});
     data = NaN(length(select('Animalia')),2); 
     data(select_01('Pisces'),:) = [WWR(:,2), WWR(:,3) .* WWR(:,1) ./ WWR(:,2) ./ WWR(:,4)];
     hWwi_RiWW = shstat(data, legend_Pisces); 
     figure(hWwi_RiWW)
     xlabel('_{10}log ultimate weight, g')
     ylabel('_{10}log reprod rate \times W^w_b/W^w_i, #/d')
     %print -r300 -dpng Wwi_RiWW.png

   case 24
     shstat_options('x_transform', 'log10');
     shstat_options('y_transform', 'log10');
     
     Wa = read_allStat({'Ww_b', 'a_b', 'c_T'}); Wa = [Wa(:,1), Wa(:,2) .* Wa(:,3)];
     hWwb_ab = shstat(Wa, legend_Pisces(1:13,:));   
     figure(hWwb_ab)
     xlabel('_{10}log wet weight at birth, g')
     ylabel('_{10}log incubation time, d')
     %print -r300 -dpng Wwb_ab.png
     
   case 25
     shstat_options('x_transform', 'log10');
     shstat_options('y_transform', 'log10');
     
     aa = read_allStat({'a_m', 'a_b', 'c_T'}); aa = [aa(:,1).*aa(:,3), aa(:,2).*aa(:,3)];
     ham_ab = shstat(aa, legend_Pisces(1:13,:));   
     figure(ham_ab)
     xlabel('_{10}log life span, d')
     ylabel('_{10}log incubation time, d')
     %print -r300 -dpng Wam_ab.png

   case 26 % fig C1, C2
     shstat_options('x_transform', 'log10');
     shstat_options('y_transform', 'log10');
     aJW = read_allStat({'a_m', 'J_Oi', 'Ww_i', 'Ww_b', 'R_i', 'c_T'});

     legend_CAP = {... 
       {'o', 8, 3, [1 0 0], [1 1 1]}, 'Crocodilia'; ...
       {'o', 8, 3, [1 0 0], [1 0 0]}, 'Aves'
       {'o', 8, 3, [0 0 1], [0 0 0]}, 'Placentalia'
     };

     Wa = read_allStat({'Ww_i','a_m','c_T'}); Wa = [Wa(:,1), Wa(:,2).*Wa(:,3)];
     hWi_am_CAP = shstat(Wa, legend_CAP, 'Crocs & Aves & Placentalia'); 
     figure(hWi_am_CAP)
     %plot([0.5; 7], [0.5; 7], 'r', 'LineWidth', 3)
     %plot([0.5; 7], [0.9; 7.4], 'b', 'LineWidth', 3)
     xlabel('_{10}log ultimate weight, W_w^\infty, g')
     ylabel('_{10}log life span, d')
     %print -r300 -dpng Wi_am_CAP.png

     
     hWi_JWb_CAP = shstat([aJW(:,3), aJW(:,5).*aJW(:,4)./aJW(:,6)], legend_CAP, 'Crocs & Aves & Placentalia'); 
     %plot([0; 9], [0; 9], 'k', 'LineWidth', 3)
     figure(hWi_JWb_CAP)
     xlabel('_{10}log ultimate weight, W_w^\infty, g')
     ylabel('_{10}log neonate mass prod, g/d')
     %print -r300 -dpng Wi_JWb_CAP.png

   case 27
     shstat_options('x_transform', 'log10');
     shstat_options('y_transform', 'log10');

     aa = read_allStat({'a_m','a_b','c_T'}); aa = [aa(:,1).*aa(:,3), aa(:,2).*aa(:,3)];
     ham_ab_Pisces = shstat(aa, legend_Pisces(1:13,:), 'Chondrichthyes'); 
     figure(ham_ab_Pisces)
     plot([3; 5], [3; 5] - log10(25), 'k', 'LineWidth', 3)
     xlabel('_{10}log age at death, d')
     ylabel('_{10}log age at birth, d')
     %print -r300 -dpng am_ab_Chondrichthyes.png
     
   case 28 % fig B1
     shstat_options('x_transform', 'log10');
     shstat_options('y_transform', 'log10');
     WWN = read_allStat({'Ww_i', 'Ww_b', 'N_i'});
     WiWR = [WWN(:,1), WWN(:,2) .* WWN(:,3)];
         
     hWi_WR = shstat(WiWR, legend_Pisces, 'Pisces'); 
     figure(hWi_WR)
     plot([-1; 7.5], [-1; 7.5], 'k', 'LineWidth', 3)
     xlabel('_{10}log ultimate weight, W_w^\infty, g')
     ylabel('_{10}log life time neonate mass, g')
     %print -r300 -dpng Wi_WR_Pisces.png

     [hWi_WR_Amphibia, hlegend_Amphibia] = shstat(WiWR, legend_Amphibia, 'Amphibia'); 
     figure(hWi_WR_Amphibia)
     plot([-0.5; 5], [-0.5; 5], 'k', 'LineWidth', 3)
     xlabel('_{10}log ultimate weight, W_w^\infty, g')
     ylabel('_{10}log life time neonate mass, g')
     print -r300 -dpng Wi_WR_Amphibia.png
     %figure(hlegend_Amphibia)
     %print -r300 -dpng legend_Amphibia.png

     [hWi_WR_Squamata hlegend_Squamata] = shstat(WiWR, legend_Squamata, 'Squamata'); 
     figure(hWi_WR_Squamata)
     plot([-0.5; 6], [-0.5; 6], 'k', 'LineWidth', 3)
     xlabel('_{10}log ultimate weight, W_w^\infty, g')
     ylabel('_{10}log life time neonate mass, g')
     print -r300 -dpng Wi_WR_Squamata.png
     %figure(hlegend_Squamata)
     %print -r300 -dpng legend_Squamata.png

     [hWi_WR_Aves hlegend_Aves] = shstat(WiWR, legend_Aves, 'Crocodilia & Aves'); 
     figure(hWi_WR_Aves)
     plot([0.5; 7], [0.5; 7], 'k', 'LineWidth', 3)
     plot([0.5; 7], [0.9; 7.4], ':k', 'LineWidth', 3)
     xlabel('_{10}log ultimate weight, W_w^\infty, g')
     ylabel('_{10}log life time neonate mass, g')
     print -r300 -dpng Wi_WR_Aves.png
     %figure(hlegend_Aves)
     %print -r0 -dpng legend_Aves.png

     [hWi_WR_Placentalia, hlegend_Placentalia] = shstat(WiWR, legend_Placentalia, 'Placentalia'); 
     figure(hWi_WR_Placentalia)
     plot([0; 8.5], [0; 8.5], 'k', 'LineWidth', 3)
     xlabel('_{10}log ultimate weight, W_w^\infty, g')
     ylabel('_{10}log life time neonate mass, g')
     print -r300 -dpng Wi_WR_Placentalia.png
     %figure(hlegend_Placentalia)
     %print -r300 -dpng legend_Placentalia.png

     [sel_C, nm] = select_01('Cephalopoda'); nm_C = nm(sel_C); n_C = length(nm_C); Wa = zeros(n_C,1); WR = zeros(n_C,1); WD = cdCur;
     for i=1:n_C; cdEntr(nm_C{i}); 
       eval(['load(''results_',nm_C{i},''',''par'')']); 
       eval(['[data, auxData] = mydata_', nm_C{i},';']);
       cPar = parscomp_st(par); vars_pull(par); vars_pull(cPar); vars_pull(auxData);
       TC = tempcorr(temp.am, T_ref, T_A); kT_M = k_M * TC;
       pars_tj = [g; k; l_T; v_Hb; v_Hj; v_Hp];
       [t_j, t_p, t_b, l_j, l_p, l_b, l_i, rho_j, rho_B] = get_tj(pars_tj, f);
       pars_tm = [pars_tj; h_a/ k_M^2; s_G]; % compose parameter vector at T_ref
       aT_m = get_tm_j(pars_tm, f)/ kT_M;    % d, mean life span at T
       L_b = L_m * l_b; L_j = L_m *  l_j; L_i = L_m * l_i; rT_B = rho_B * kT_M; % cm, ultimate structural length at f
       L_am = L_i - (L_i - L_j) * exp(- rT_B * (aT_m  - t_j/ kT_M));  
       Wa(i) = L_am^3 * (1 + f * w);         % g, wet weight
       pars_R = [kap; kap_R; g; TC * k_J; TC * k_M; L_T; TC * v; U_Hb/ TC; U_Hj/ TC; U_Hp/ TC]; % compose parameter vector
       WR(i) = L_b^3 * (1 + f * w) * cum_reprod_j(aT_m, 1, pars_R); % g, life time neonate mass
     end
     WiWR(sel_C,:) = [Wa, WR]; cd(WD);
     
     [hWi_WR_Mollusca hlegend_Mollusca] = shstat(WiWR, legend_Mollusca, 'Mollusca'); 
     figure(hWi_WR_Mollusca)
     plot([-3.8; 6], [-3.8; 6], 'k', 'LineWidth', 3)
     xlabel('_{10}log ultimate weight, W_w^\infty, g')
     ylabel('_{10}log life time neonate mass, g')
     print -r300 -dpng Wi_WR_Mollusca.png
     %figure(hlegend_Mollusca)
     %print -r300 -dpng legend_Mollusca.png

     [hWi_WR_RSED hlegend_RSED] = shstat(WiWR, legend_RSED, 'Animalia'); 
     figure(hWi_WR_RSED)
     plot([-8; 8.5], [-8; 8.5], 'k', 'LineWidth', 3)
     xlabel('_{10}log ultimate weight, W_w^\infty, g')
     ylabel('_{10}log life time neonate mass, g')
     %print -r300 -dpng Wi_WR_RSED.png
     %figure(hlegend_RSED)
     %print -r300 -dpng legend_RSED.png
     
 end
end
