function KooyAugu2022_SI(fig)
% Supporting Information for KooyAugu2022
% Title: The comparative energetics of the carnivorans and pangolins
% Authors: Kooijman, Augustine
% Journal: Conservation Physiology 10
% DOI: 10.1093/conphys/coac057
% Date: 2020/02/11
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
% To run the code for a figure: type in the Matlab window e.g. KooyLika2020_SI(4)
%
% Remarks: 
%  The figures show current AmP data, which might change in time; the results might differ from the publication
%  The scripts call functions read_popStat and read_allStat; the first call to these functions loads the .mat file, which can take some time
%  Click on a marker in the Matlab-figure to see the species name
%  Uncomment "print" to save the Matlab-figure to a png-file
%  Modify selection of taxa and markers by changing the legend, see https://add-my-pet.github.io/AmPtool/docs/index.html
%  Allowed names of taxa match the names of the tree nodes at http://www.bio.vu.nl/thb/deb/deblab/add_my_pet/species_tree_Animalia.html

if ~exist('fig','var')
   fig = 1:32;
end

 llegend = {... % Mammalia
   {'-', 2, [0 0 0]}, 'Marsupialia'; 
   {'-', 2, [0 0 1]}, 'Atlantogenata'; 
   {'-', 2, [1 0 1]}, 'Laurasiatheria'; 
   {'-', 2, [1 0 0]}, 'Gliriformes'; 
   {'-', 2, [0 1 0]}, 'Euarchonta'; 
%   {'-', 2, [1 0 0]}, 'Euarchontoglires'; 
 };

 llegend_Laurasiatheria = {... % Laurasiatheria
   {'-', 2, [0 0 0]}, 'Eulipotyphla'; 
   {'-', 2, [0 0 1]}, 'Chiroptera'; 
   {'-', 2, [1 0 1]}, 'Ferae'; 
   {'-', 2, [1 0 0]}, 'Euungulata'; 
 };

 llegend_Carnivora = {... % Carnivora
   {'-', 2, [0 0 0]}, 'Pinnipedia'; 
   {'-', 2, [0 0 1]}, 'Caniformia'; 
   {'-', 2, [1 0 0]}, 'Feliformia'; 
 };

 llegend_Euungulata = {... % Euungulata
   {'-', 2, [0 0 0]}, 'Perissodactyla'; 
   {'-', 2, [0 0 1]}, 'Tylopoda'; 
   {'-', 2, [1 0 1]}, 'Suina'; 
   {'-', 2, [1 0 0]}, 'Cetancodontamorpha'; 
   {'-', 2, [0 1 0]}, 'Ruminantiamorpha'; 
 };

 legend = { ... % 
   % Pholidota
   {'^', 8, 3, [1 0 1], [1 0 1]}, 'Manidae'; 
   % Feliformia
   {'o', 8, 3, [1 0 0], [0 0 0]}, 'Nandiniidae';
   {'o', 8, 3, [1 0 0], [0 0 1]}, 'Feloidea';
   {'o', 8, 3, [1 0 0], [1 0 1]}, 'Viverroidea';
   {'o', 8, 3, [1 0 0], [1 0 0]}, 'Eupleridae';
   % Caniformia
   {'o', 8, 3, [0 0 1], [0 0 0]}, 'Canidae';
   {'o', 8, 3, [0 0 1], [0 0 1]}, 'Ursidae';
   {'o', 8, 3, [0 0 1], [1 0 0]}, 'Musteloidea'; 
   {'o', 8, 3, [0 0 1], [1 1 1]}, 'Pinnipedia'; 
   % other Scrotifera
   {'x', 3, 3, [0 0 1], [0 0 0]}, 'Chiroptera'; 
   {'+', 3, 3, [1 0 0], [0 0 0]}, 'Euungulata'; 
   {'.', 6, 6, [0 0 0], [0 0 0]}, 'Mammalia'; 
 };
 
 legend_Euungulata = { ... % Euungulata
   % Feliformia
   {'o', 8, 3, [0 0 0], [1 1 1]}, 'Perissodactyla';
   {'o', 8, 3, [0 0 1], [0 0 1]}, 'Tylopoda';
   {'o', 8, 3, [0 0 1], [1 0 0]}, 'Suina';
   % Cetancodontamorpha
   {'o', 8, 3, [1 0 0], [0 0 0]}, 'Odontoceti';
   {'o', 8, 3, [1 0 0], [0 0 1]}, 'Mysticeti';
   % Ruminantiamorpha
   {'o', 8, 3, [0 1 0], [0 0 1]}, 'Giraffoidea';
   {'o', 8, 3, [0 1 0], [1 0 0]}, 'Cervidae';
   {'o', 8, 3, [0 1 0], [1 1 1]}, 'Bovidae';
 };

 close all
 shstat_options('default');
 shstat_options('y_label', 'on'); 
 shstat_options('x_label', 'off'); 
 
 for i=1:length(fig)
 
 switch fig(i)
   case 1 % fig 1c, 2c
     fprintf('case 1\n');
     shstat_options('x_transform', 'none');
     
     [hkap, hleg] = shstat({'kap'}, llegend, 'Mammalia');
     figure(hkap)
     xlabel('allocation fraction to soma, \kappa, -')
     %print -r0 -dpng kap.png
     figure(hleg)
     %print -r0 -dpng llegend_Mammalia.png
     
     % Laurasiatheria
     [hkap, hleg] = shstat({'kap'}, llegend_Laurasiatheria, 'Laurasiatheria');
     figure(hkap)
     xlabel('allocation fraction to soma, \kappa, -')
     %print -r0 -dpng kap_Laurasiatheria.png
     figure(hleg)
     %print -r0 -dpng llegend_Laurasiatheria.png

     % Carnivora
     [hkap, hleg] = shstat({'kap'}, llegend_Carnivora, 'Carnivora');
     figure(hkap)
     xlabel('allocation fraction to soma, \kappa, -')
     %print -r0 -dpng kap_Carnivora.png
     %figure(hleg)
     %print -r0 -dpng llegend_Carnivora.png

   case 2 % fig 1d, 2d
     fprintf('case 2\n');
     shstat_options('x_transform', 'log10');
     
     hp_M = shstat({'p_M'}, llegend, 'Mammalia'); 
     figure(hp_M)
     xlabel('_{10}log vol-spec somatic maint, [p_M], J/d.cm^3')
     %print -r0 -dpng pM.png

     % Laurasiatheria
     hp_M = shstat({'p_M'}, llegend_Laurasiatheria, 'Laurasiatheria'); 
     figure(hp_M)
     xlabel('_{10}log vol-spec somatic maint, [p_M], J/d.cm^3')
     %print -r0 -dpng pM_Laurasiatheria.png
     
     % Carnivora
     hp_M = shstat({'p_M'}, llegend_Carnivora, 'Carnivora'); 
     figure(hp_M)
     xlabel('_{10}log vol-spec somatic maint, [p_M], J/d.cm^3')
     %print -r0 -dpng pM_Carnivora.png
     
     % Euungulata
     hp_M = shstat({'p_M'}, llegend_Euungulata, 'Euungulata'); 
     figure(hp_M)
     xlabel('_{10}log vol-spec somatic maint, [p_M], J/d.cm^3')

   case 3 
     fprintf('case 3\n');
     shstat_options('x_transform', 'log10');
     
     NWbWi = read_allStat({'N_i','Ww_b','Ww_i'});
     hs_M = shstat(NWbWi(:,1).*NWbWi(:,2)./NWbWi(:,3), llegend, 'Mammalia'); 
     figure(hs_M)
     xlabel('_{10}log total neonate mass prod/ ultimate weight, -')
     %print -r0 -dpng WRWi.png
     
     % Laurasiatheria
     NWbWi = read_allStat({'N_i','Ww_b','Ww_i'});
     hs_M = shstat(NWbWi(:,1).*NWbWi(:,2)./NWbWi(:,3), llegend_Laurasiatheria, 'Laurasiatheria'); 
     figure(hs_M)
     xlabel('_{10}log total neonate mass prod/ ultimate weight, -')
     %print -r0 -dpng WRWi_Laurasiatheria.png

     % Carnivora
     NWbWi = read_allStat({'N_i','Ww_b','Ww_i'});
     hs_M = shstat(NWbWi(:,1).*NWbWi(:,2)./NWbWi(:,3), llegend_Carnivora, 'Carnivora'); 
     figure(hs_M)
     xlabel('_{10}log total neonate mass prod/ ultimate weight, -')
     %print -r0 -dpng WRWi_Carnivora.png

   case 4 % fig 1h, 2h
     fprintf('case 4\n');
     shstat_options('x_transform', 'log10');
     
     hs_s = shstat({'s_s'}, llegend, 'Mammalia'); 
     figure(hs_s)
     xlabel('_{10}log supply stress, s_s, -')
     %print -r0 -dpng ss.png

     % Laurasiatheria
     hs_s = shstat({'s_s'}, llegend_Laurasiatheria, 'Laurasiatheria'); 
     figure(hs_s)
     xlabel('_{10}log supply stress, s_s, -')
     print -r0 -dpng ss_Laurasiatheria.png
     
     % Carnivora
     hs_s = shstat({'s_s'}, llegend_Carnivora, 'Carnivora'); 
     figure(hs_s)
     xlabel('_{10}log supply stress, s_s, -')
     %print -r0 -dpng ss_Carnivora.png

     
   case 5 % fig 1g, 2g
     fprintf('case 5\n');
     shstat_options('x_transform', 'log10');
     
     hs_Hbp = shstat({'s_Hbp'}, llegend, 'Mammalia'); 
     figure(hs_Hbp)
     xlabel('_{10}log precociality coeff, s_H^{bp}, -')
     %print -r0 -dpng sHbp.png

     % Laurasiatheria
     hs_Hbp = shstat({'s_Hbp'}, llegend_Laurasiatheria, 'Laurasiatheria'); 
     figure(hs_Hbp)
     xlabel('_{10}log precociality coeff, s_H^{bp}, -')
     %print -r0 -dpng sHbp_Laurasiatheria.png
     
     % Carnivora
     hs_Hbp = shstat({'s_Hbp'}, llegend_Carnivora, 'Carnivora'); 
     figure(hs_Hbp)
     xlabel('_{10}log precociality coeff, s_H^{bp}, -')
     %print -r0 -dpng sHbp_Carnivora.png
     
   case 6 % fig 1b, 2b
     fprintf('case 6\n');
     shstat_options('x_transform', 'log10');
     
     hv = shstat({'v'}, llegend, 'Mammalia'); 
     figure(hv)
     xlabel('_{10}log energy conductance, v, cm/d')
     %print -r0 -dpng v.png

     % Laurasiatheria
     hv = shstat({'v'}, llegend_Laurasiatheria, 'Laurasiatheria'); 
     figure(hv)
     xlabel('_{10}log energy conductance, v, cm/d')
     %print -r0 -dpng v_Laurasiatheria.png
     
     % Carnivora
     hv = shstat({'v'}, llegend_Carnivora, 'Carnivora'); 
     figure(hv)
     xlabel('_{10}log energy conductance, v, cm/d')
     %print -r0 -dpng v_Carnivora.png
     
   case 7 % fig 1a, 2a
     fprintf('case 7\n');
     shstat_options('x_transform', 'log10');
     
     hp_Am = shstat({'p_Am'}, llegend, 'Mammalia'); 
     figure(hp_Am)
     xlabel('_{10}log spec assimilation rate, \{p_{Am}\}, J/d.cm^2')
     %print -r0 -dpng pAm.png

     % Laurasiatheria
     hp_Am = shstat({'p_Am'}, llegend_Laurasiatheria, 'Laurasiatheria'); 
     figure(hp_Am)
     xlabel('_{10}log spec assimilation rate, \{p_{Am}\}, J/d.cm^2')
     %print -r0 -dpng pAm_Laurasiatheria.png

     % Carnivora
     hp_Am = shstat({'p_Am'}, llegend_Carnivora, 'Carnivora'); 
     figure(hp_Am)
     xlabel('_{10}log spec assimilation rate, \{p_{Am}\}, J/d.cm^2')
     %print -r0 -dpng pAm_Carnivora.png

   case 8 % fig 1i, 2i
     fprintf('case 8\n');
     shstat_options('x_transform', 'log10');
     
     hWw_i = shstat({'Ww_i'}, llegend, 'Mammalia');
     shstat({'Ww_p'}, llegend, [], hWw_i);
     shstat({'Ww_b'}, llegend, [], hWw_i);
     figure(hWw_i)
     xlabel('_{10}log weight at birth, puberty, death, W_w^b, W_w^p, W_w^\infty, g')
     %print -r0 -dpng Wwi.png

     % Laurasiatheria
     hWw_i = shstat({'Ww_i'}, llegend_Laurasiatheria);
     shstat({'Ww_p'}, llegend_Laurasiatheria, [], hWw_i);
     shstat({'Ww_b'}, llegend_Laurasiatheria, 'Laurasiatheria', hWw_i);
     figure(hWw_i)
     xlabel('_{10}log weight at birth, puberty, death, W_w^b, W_w^p, W_w^\infty, g')
     %print -r0 -dpng Wwi_Laurasiatheria.png

     % Carnivora
     hWw_i = shstat({'Ww_i'}, llegend_Carnivora);
     shstat({'Ww_p'}, llegend_Carnivora, [], hWw_i);
     shstat({'Ww_b'}, llegend_Carnivora, 'Carnivora', hWw_i);
     figure(hWw_i)
     xlabel('_{10}log weight at birth, puberty, death, W_w^b, W_w^p, W_w^\infty, g')
     %print -r0 -dpng Wwi_Carnivora.png

  case 9 % 1f, 2f
     fprintf('case 6\n');
     shstat_options('x_transform', 'log10');
     
     hE_m = shstat({'E_m'}, llegend, 'Mammalia'); 
     figure(hE_m)
     xlabel('_{10}log reserve capacity, [E_m], J/cm^3')
     %print -r0 -dpng Em.png

     % Laurasiatheria
     hE_m = shstat({'E_m'}, llegend_Laurasiatheria, 'Laurasiatheria'); 
     figure(hE_m)
     xlabel('_{10}log reserve capacity, [E_m], J/cm^3')
     %print -r0 -dpng Em_Laurasiatheria.png

     % Carnivora
     hE_m = shstat({'E_m'}, llegend_Carnivora, 'Carnivora'); 
     figure(hE_m)
     xlabel('_{10}log reserve capacity, [E_m], J/cm^3')
     %print -r0 -dpng Em_Carnivora.png

   case 10 % fig 1e, 2e
     fprintf('case 10\n');
     shstat_options('x_transform', 'log10');
     
     aaac = read_allStat({'a_b','a_p','a_m','c_T'});
     ha_m = shstat(aaac(:,3).*aaac(:,4), llegend, 'Mammalia');
     shstat(aaac(:,2).*aaac(:,4), llegend, [], ha_m); 
     shstat(aaac(:,1).*aaac(:,4), llegend, [], ha_m); 
     figure(ha_m)
     xlabel('_{10}log age at birth, puberty, death, a_b, a_p, a_m, d')
     %print -r0 -dpng am.png

     % Laurasiatheria
     ha_m = shstat(aaac(:,3).*aaac(:,4), llegend_Laurasiatheria);
     shstat(aaac(:,2).*aaac(:,4), llegend_Laurasiatheria, [], ha_m); 
     shstat(aaac(:,1).*aaac(:,4), llegend_Laurasiatheria, 'Laurasiatheria', ha_m); 
     figure(ha_m)
     xlabel('_{10}log age at birth, puberty, death, a_b, a_p, a_m, d')
     %print -r0 -dpng am_Laurasiatheria.png

     % Carnivora
     ha_m = shstat(aaac(:,3).*aaac(:,4), llegend_Carnivora);
     shstat(aaac(:,2).*aaac(:,4), llegend_Carnivora, [], ha_m); 
     shstat(aaac(:,1).*aaac(:,4), llegend_Carnivora, 'Carnivora', ha_m); 
     figure(ha_m)
     xlabel('_{10}log age at birth, puberty, death, a_b, a_p, a_m, d')
     %print -r0 -dpng am_Carnivora.png

   case 11 % fig 1j, 2j
     fprintf('case 11\n');
     shstat_options('x_transform', 'log10');
     
     WdW_M = read_stat(select('Marsupialia'),{'W_dWm','dWm','c_T'});   WdW_M = WdW_M(:,2) ./ WdW_M(:,1) ./ WdW_M(:,2);
     WdW_A = read_stat(select('Atlantogenata'),{'W_dWm','dWm','c_T'}); WdW_A = WdW_A(:,2) ./ WdW_A(:,1) ./ WdW_A(:,2);
     WdW_L = read_stat(select('Laurasiatheria'),{'W_dWm','dWm','c_T'}); WdW_L = WdW_L(:,2) ./ WdW_L(:,1) ./ WdW_L(:,2);
     WdW_G = read_stat(select('Gliriformes'),{'W_dWm','dWm','c_T'}); WdW_G = WdW_G(:,2) ./ WdW_G(:,1) ./ WdW_G(:,2);
     WdW_E = read_stat(select('Euarchonta'),{'W_dWm','dWm','c_T'}); WdW_E = WdW_E(:,2) ./ WdW_E(:,1) ./ WdW_E(:,2);
     %WdW_E = read_stat(select('Euarchontoglires'),{'W_dWm','dWm','c_T'}); WdW_E = WdW_E(:,2) ./ WdW_E(:,1) ./ WdW_E(:,2);

     hWdW = shstat(WdW_M, {'k', 'k'}, 'Mammalia');   
     shstat(WdW_A, {'b', 'b'}, [], hWdW);   
     shstat(WdW_L, {'m', 'm'}, [], hWdW);   
     shstat(WdW_G, {'r', 'r'}, [], hWdW);   
     shstat(WdW_E, {'g', 'g'}, [], hWdW);   
     %shstat(WdW_E, {'r', 'r'}, [], hWdW);   
     figure(hWdW)
     xlim([-8 0])
     xlabel('_{10}log maximum spec growth, r, g/d.g')
     %print -r0 -dpng WdW.png

     % Laurasiatheria
     WdW_L = read_stat(select('Eulipotyphla'),{'W_dWm','dWm','c_T'});   WdW_L = WdW_L(:,2) ./ WdW_L(:,1) ./ WdW_L(:,2);
     WdW_C = read_stat(select('Chiroptera'),{'W_dWm','dWm','c_T'}); WdW_C = WdW_C(:,2) ./ WdW_C(:,1) ./ WdW_C(:,2);
     WdW_F = read_stat(select('Ferae'),{'W_dWm','dWm','c_T'}); WdW_F = WdW_F(:,2) ./ WdW_F(:,1) ./ WdW_F(:,2);
     WdW_U = read_stat(select('Euungulata'),{'W_dWm','dWm','c_T'}); WdW_U = WdW_U(:,2) ./ WdW_U(:,1) ./ WdW_U(:,2);

     hWdW_Laurasiatheria = shstat(WdW_L, {'k', 'k'}, 'Laurasiatheria'); % black Eulipotyphla
     shstat(WdW_C, {'b', 'b'}, [], hWdW_Laurasiatheria); % blue Chiroptera
     shstat(WdW_F, {'m', 'm'}, [], hWdW_Laurasiatheria); % magenta Ferae
     shstat(WdW_U, {'r', 'r'}, [], hWdW_Laurasiatheria); % red Euungulata
     figure(hWdW_Laurasiatheria)
     xlim([-8 0.2])
     xlabel('_{10}log maximum spec growth, r, g/d.g')
     %print -r0 -dpng WdW_Laurasiatheria.png
     %
     shllegend(llegend_Laurasiatheria, [], [], 'Laurasiatheria');
     %print -r0 -dpng llegend_Laurasiatheria.png

     % Carnivora
     WdW_P = read_stat(select('Pinnipedia'),{'W_dWm','dWm','c_T'});   WdW_P = WdW_P(:,2) ./ WdW_P(:,1) ./ WdW_P(:,2);
     WdW_C = read_stat(select('Caniformia'),{'W_dWm','dWm','c_T'}); WdW_C = WdW_C(:,2) ./ WdW_C(:,1) ./ WdW_C(:,2);
     WdW_F = read_stat(select('Feliformia'),{'W_dWm','dWm','c_T'}); WdW_F = WdW_F(:,2) ./ WdW_F(:,1) ./ WdW_F(:,2);

     hWdW_Carnivora = shstat(WdW_P, {'k', 'k'}, 'Carnivora'); % black pinnipeds
     shstat(WdW_C, {'b', 'b'}, [], hWdW_Carnivora); % blue Caniformia
     shstat(WdW_F, {'r', 'r'}, [], hWdW_Carnivora); % red Feliformia
     figure(hWdW_Carnivora)
     xlim([-8 0.2])
     xlabel('_{10}log maximum spec growth, r, g/d.g')
     % print -r0 -dpng WdW_Carnivora.png
     %
     shllegend(llegend_Carnivora, [], [], 'Carnivora');
     %print -r0 -dpng llegend_Carnivora.png
     
   case 12 % fig 1k, 2k
     fprintf('case 12\n');
     shstat_options('x_transform', 'log10');
     JOiW_M = read_stat(select('Marsupialia'),{'J_Oi','Ww_i','c_T'}); JOiW_M = JOiW_M(:,1) ./ JOiW_M(:,2) ./ JOiW_M(:,3);
     JOiW_A = read_stat(select('Atlantogenata'),{'J_Oi','Ww_i','c_T'}); JOiW_A = JOiW_A(:,1) ./ JOiW_A(:,2) ./ JOiW_A(:,3);
     JOiW_L = read_stat(select('Laurasiatheria'),{'J_Oi','Ww_i','c_T'}); JOiW_L = JOiW_L(:,1) ./ JOiW_L(:,2) ./ JOiW_L(:,3);
     JOiW_G = read_stat(select('Gliriformes'),{'J_Oi','Ww_i','c_T'}); JOiW_G = JOiW_G(:,1) ./ JOiW_G(:,2) ./ JOiW_G(:,3);
     JOiW_E = read_stat(select('Euarchonta'),{'J_Oi','Ww_i','c_T'}); JOiW_E = JOiW_E(:,1) ./ JOiW_E(:,2) ./ JOiW_E(:,3);
     %JOiW_E = read_stat(select('Euarchontoglires'),{'J_Oi','Ww_i','c_T'}); JOiW_E = JOiW_E(:,1) ./ JOiW_E(:,2) ./ JOiW_E(:,3);
     
     hJOiW = shstat(JOiW_M, {'k', 'k'}, 'Mammalia');   
     shstat(JOiW_A, {'b', 'b'}, [], hJOiW);   
     shstat(JOiW_L, {'m', 'm'}, [], hJOiW);   
     shstat(JOiW_G, {'r', 'r'}, [], hJOiW);   
     shstat(JOiW_E, {'g', 'g'}, [], hJOiW);   
     %shstat(JOiW_E, {'r', 'r'}, [], hJOiW);   
     figure(hJOiW)
     xlabel('_{10}log ultimate spec O_2 consumption, j_O^\infty, mol/d.g')
     %print -r0 -dpng jOi.png

     % Laurasiatheria
     JOiW_L = read_stat(select('Eulipotyphla'),{'J_Oi','Ww_i','c_T'}); JOiW_L = JOiW_L(:,1) ./ JOiW_L(:,2) ./ JOiW_L(:,3);
     JOiW_C = read_stat(select('Chiroptera'),{'J_Oi','Ww_i','c_T'}); JOiW_C = JOiW_C(:,1) ./ JOiW_C(:,2) ./ JOiW_C(:,3);
     JOiW_F = read_stat(select('Ferae'),{'J_Oi','Ww_i','c_T'}); JOiW_F = JOiW_F(:,1) ./ JOiW_F(:,2) ./ JOiW_F(:,3);
     JOiW_U = read_stat(select('Euungulata'),{'J_Oi','Ww_i','c_T'}); JOiW_U = JOiW_U(:,1) ./ JOiW_U(:,2) ./ JOiW_U(:,3);
     
     hJOiW_Laurasiatheria = shstat(JOiW_L, {'k', 'k'});   
     shstat(JOiW_C, {'b', 'b'}, [], hJOiW_Laurasiatheria);   
     shstat(JOiW_F, {'m', 'm'}, [], hJOiW_Laurasiatheria);   
     shstat(JOiW_U, {'r', 'r'}, 'Laurasiatheria', hJOiW_Laurasiatheria);   
     figure(hJOiW_Laurasiatheria)
     xlabel('_{10}log ultimate spec O_2 consumption, j_O^\infty, mol/d.g')
     %print -r0 -dpng jOi_Laurasiatheria.png

     % Carnivora
     JOiW_P = read_stat(select('Pinnipedia'),{'J_Oi','Ww_i','c_T'}); JOiW_P = JOiW_P(:,1) ./ JOiW_P(:,2) ./ JOiW_P(:,3);
     JOiW_C = read_stat(select('Caniformia'),{'J_Oi','Ww_i','c_T'}); JOiW_C = JOiW_C(:,1) ./ JOiW_C(:,2) ./ JOiW_C(:,3);
     JOiW_F = read_stat(select('Feliformia'),{'J_Oi','Ww_i','c_T'}); JOiW_F = JOiW_F(:,1) ./ JOiW_F(:,2) ./ JOiW_F(:,3);
     
     hJOiW_Carnivora = shstat(JOiW_L, {'k', 'k'});   
     shstat(JOiW_P, {'k', 'k'}, [], hJOiW_Carnivora);   
     shstat(JOiW_C, {'b', 'b'}, [], hJOiW_Carnivora);   
     shstat(JOiW_F, {'r', 'r'}, [], hJOiW_Carnivora);   
     figure(hJOiW_Carnivora)
     xlabel('_{10}log ultimate spec O_2 consumption, j_O^\infty, mol/d.g')
     %print -r0 -dpng jOi_Carnivora.png

   case 13 % fig 1l, 2l
     fprintf('case 13\n');
     shstat_options('x_transform', 'log10');
     JRWW = read_allStat({'R_i','Ww_b','Ww_i','c_T'}); jWb = JRWW(:,1) .* JRWW(:,2) ./ JRWW(:,3) ./ JRWW(:,4);
     
     hjWb = shstat(jWb, llegend, 'Mammalia');   
     figure(hjWb)
     xlabel('_{10}log ultimate spec neonate mass prod rate, j_{W_w^b}^\infty, 1/d')
     %print -r0 -dpng jWb.png

     % Laurasiatheria
     hjWb = shstat(jWb, llegend_Laurasiatheria, 'Laurasiatheria');   
     figure(hjWb)
     xlabel('_{10}log ultimate spec neonate mass prod rate, j_{W_w^b}^\infty, 1/d')
     %print -r0 -dpng jWb_Laurasiatheria.png

     % Carnivora
     hjWb = shstat(jWb, llegend_Carnivora, 'Carnivora');   
     figure(hjWb)
     xlabel('_{10}log ultimate spec neonate mass prod rate, j_{W_w^b}^\infty, 1/d')
     %print -r0 -dpng jWb_Carnivora.png

   case 14 % fig 6
     fprintf('case 14\n');
     shstat_options('x_transform', 'log10');
     shstat_options('y_transform', 'log10');
     
     WJO = read_allStat({'Ww_i','J_Oi','c_T'}); WJO(:,2) = WJO(:,2) ./ WJO(:,1) ./ WJO(:,3);
     [hWwi_JOiW, hC]= shstat(WJO, legend, 'Ferae');   
     figure(hWwi_JOiW)
     plot([3 7], [-3,-5.8], '-b', 'Linewidth', 2) % slope -0.7
     plot([2 7], [-3.4,-5.05], '-r', 'Linewidth', 2) % slope -0.33
     xlabel('_{10}log ultimate wet weight, g')
     ylabel('_{10}log spec O_2 consumption, mol/d.g')
     
     %print -r300 -dpng Wwi_JOiW.png
     figure(hC)
     %print -r1200 -dpng legend_Carnivora.png
     
   case 15
     fprintf('case 15\n');
     shstat_options('x_transform', 'log10');
     shstat_options('y_transform', 'log10');
     
     hv_sHbp = shstat({'v','s_Hbp'}, legend);   
     figure(hv_sHbp)
     xlabel('_{10}log energy conductance, v, cm/d')
     ylabel('_{10}log precociality coeff, s_H^{bp}, -')
     %print -r0 -dpng v_sHbp.png

   case 16
     fprintf('case 16\n');
     shstat_options('x_transform', 'none');
     shstat_options('y_transform', 'log10');
     kRc = read_allStat({'kap','R_i','c_T'});
     hkap_R = shstat([kRc(:,1), kRc(:,2)./kRc(:,3)], legend);   
     figure(hkap_R)
     xlabel('allocation fraction to soma, \kappa, -')
     ylabel('_{10}log max reprod rate, #/d')
     %print -r0 -dpng kap_R.png
    
   case 17
     fprintf('case 17\n');
     shstat_options('x_transform', 'none');
     shstat_options('y_transform', 'log10');
     
     kNWWa = read_allStat({'kap', 'R_i', 'Ww_b', 'Ww_i', 'c_T'}); 
     kap = kNWWa(:,1); RWW = kNWWa(:,2) .* kNWWa(:,3) ./ kNWWa(:,4) ./ kNWWa(:,5);
     hkap_RWW = shstat([kap, RWW], legend);   
     figure(hkap_RWW)
     xlabel('allocation fraction to soma, \kappa, -')
     ylabel('_{10}log spec neonate mass prod rate, 1/d')
     %print -r0 -dpng kap_RWW.png

   case 18
     fprintf('case 18\n');
     shstat_options('x_transform', 'log10');
     shstat_options('y_transform', 'log10');
     
     WdW = read_allStat({'W_dWm','dWm','c_T'}); WdW = WdW(:,2) ./ WdW(:,1) ./ WdW(:,3);
     r = read_popStat('f1.thin1.f.r') ./ read_popStat('c_T'); 
     
     hWdW_r = shstat([WdW, r], legend);   
     figure(hWdW_r)
     plot([-2 -4.5], [-2 -4.5], 'k', 'LineWidth', 2)
     xlabel('_{10}log max spec growth, r_m, g/d.g')
     ylabel('_{10}log max spec pop growth, r_N, 1/d')
     %print -r0 -dpng WdW_r.png
      
   case 19 % fig 3a, 3b, 3c
     fprintf('case 19\n');
     shstat_options('x_transform', 'log10');
     shstat_options('y_transform', 'log10');
     
     hpM_Em = shstat({'p_M','E_m'}, legend); 
     figure(hpM_Em)
     %plot([0.25 2.25],[3.25 5.25], 'k', 'LineWidth', 3)
     xlabel('_{10}log spec somatic maint, [p_M], J/d.cm^3')
     ylabel('_{10}log reserve capacity, [E_m], J/cm^3')
     %print -r0 -dpng pM_Em.png
 
     hpAm_Em = shstat({'p_Am','E_m'}, legend); 
     figure(hpAm_Em)
     plot([2.2 4.8],1.5+[2.2 4.8], 'k', 'LineWidth', 3) % slope 1
     xlim([2.15 4.85])
     xlabel('_{10}log spec max assim rate, \{p_{Am}\}, J/d.cm^2')
     ylabel('_{10}log reserve capacity, [E_m], J/cm^3')
     %print -r0 -dpng pAm_Em.png

     hpAm_v = shstat({'p_Am','v'}, legend); 
     figure(hpAm_v)
     %plot([1.2 3.8],1.5+[1.2 3.8], 'k', 'LineWidth', 3)
     xlabel('_{10}log spec max assim rate, \{p_{Am}\}, J/d.cm^2')
     ylabel('_{10}log energy conductance, v, cm/d')
     %print -r0 -dpng pAm_v.png

     hLi_Em = shstat({'L_i','E_m'}, legend); 
     figure(hLi_Em)
     %plot([0.25 2.25],[3.25 5.25], 'k', 'LineWidth', 3)
     xlabel('_{10}log max structural length, L_\infty, cm')
     ylabel('_{10}log reserve capacity, [E_m], J/cm^3')
     %print -r0 -dpng Li_Em.png

     hWwi_Em = shstat({'Ww_i','E_m'}, legend); 
     figure(hWwi_Em)
     %plot([0.25 2.25],[3.25 5.25], 'k', 'LineWidth', 3)
     xlabel('_{10}log max weight, W_w^\infty, g')
     ylabel('_{10}log reserve capacity, [E_m], J/cm^3')
     %print -r0 -dpng Wwi_Em.png
     
     hWwb_Em = shstat({'Ww_b','E_m'}, legend); 
     figure(hWwb_Em)
     %plot([0.25 2.25],[3.25 5.25], 'k', 'LineWidth', 3)
     xlabel('_{10}log weight at birth, W_w^b, g')
     ylabel('_{10}log reserve capacity, [E_m], J/cm^3')
     %print -r0 -dpng Wwb_Em.png

   case 20 % fig 3d
     fprintf('case 20\n');
     shstat_options('x_transform', 'log10');
     shstat_options('y_transform', 'log10');
     
     hsHbp_Em = shstat({'s_Hbp', 'E_m'}, legend); 
     figure(hsHbp_Em)
     %plot([3.25 5.25],[-0.25 -3.25], 'k', 'LineWidth', 3)
     xlabel('_{10}log precociality coeff, s_H^{bp}, - ')
     ylabel('_{10}log reserve capacity, [E_m], J/cm^3')
     %print -r0 -dpng sHbp_Em.png
 
     hsHbp_Em_Lepido = shstat({'s_Hbp', 'E_m'}, legend); 
     figure(hsHbp_Em_Lepido)
     %plot([3.25 5.25],[-0.25 -3.25], 'k', 'LineWidth', 3)
     xlabel('_{10}log precociality coeff, s_H^{bp}, - ')
     ylabel('_{10}log reserve capacity, [E_m], J/cm^3')
     %print -r0 -dpng sHbp_Em_Lepido.png

   case 21 % fig 7b
     fprintf('case 21\n');
     shstat_options('x_transform', 'log10');
     shstat_options('y_transform', 'log10');
        
     WWRJ = read_allStat({'Ww_b', 'Ww_i', 'R_i', 'J_Oi', 'N_i' , 'c_T'});
     Wwi = WWRJ(:,2); JR = WWRJ(:,3) .* WWRJ(:,1) ./ WWRJ(:,6); JO = WWRJ(:,4) ./ WWRJ(:,6);
     
     hJO_JR = shstat([JO, JR], legend, 'Ferae');   
     figure(hJO_JR)
     plot([-4 3], -0.45+[-4 3], 'k', 'linewidth', 2) % slope 1
     xlim([-4 3]); ylim([-3.5 3.5]);
     xlabel('_{10}log max respiration rate, mol/d')
     ylabel('_{10}log max neonate mass prod, g/d')
     %print -r0 -dpng JO_JR.png
     
     NWb = WWRJ(:,5) .* WWRJ(:,1);
     hWi_NWb = shstat([Wwi, NWb], legend, 'Ferae');
     figure(hWi_NWb)
     plot([0.5; 8], [0.5; 8], 'k', 'linewidth', 2) % equality
     xlim([0.5 8]); ylim([0.5 8]);
     xlabel('_{10}log max weight, g')
     ylabel('_{10}log cum neonate mass prod, g')
     %print -r1200 -dpng Wwi_NWb.png
     
   case 22
     fprintf('case 22\n');
     shstat_options('x_transform', 'log10');
     shstat_options('y_transform', 'log10');
     
     hsHbp_pM = shstat({'s_Hbp', 'p_M'}, legend); 
     figure(hsHbp_pM)
     %plot([3.25 5.25],[-0.25 -3.25], 'k', 'LineWidth', 3)
     xlabel('_{10}log precociality coeff, s_H^{bp}, - ')
     ylabel('_{10}log spec somatic maint, [p_M], J/d.cm^3')
     %print -r0 -dpng sHbp_pM.png

     hsHbp_pAm = shstat({'s_Hbp', 'p_Am'}, legend); 
     figure(hsHbp_pAm)
     plot([-5 0],0.75+[3.75 1.25], 'k', 'LineWidth', 3)
     xlim([-4.5 0]); ylim([1.5 4.5])
     xlabel('_{10}log precociality coeff, s_H^{bp}, - ')
     ylabel('_{10}log spec assim rate, \{p_{Am}\}, J/d.cm^2')
     %print -r0 -dpng sHbp_pAm.png
     
     hsHbp_v = shstat({'s_Hbp', 'v'}, legend); 
     figure(hsHbp_v)
     %plot([3.25 5.25],[-0.25 -3.25], 'k', 'LineWidth', 3)
     xlabel('_{10}log precociality coeff, s_H^{bp}, - ')
     ylabel('_{10}log energy conductance, v, cm/d')
     %print -r0 -dpng sHbp_v.png
     
     hLi_sHbp = shstat({'L_i','s_Hbp'}, legend); 
     figure(hLi_sHbp)
     %plot([-0.25 2.25],[0 -4.5], 'k', 'LineWidth', 2)
     xlim([-0.25 2.25]); ylim([-4.5 0])
     xlabel('_{10}log max structural length, L_\infty, cm')
     ylabel('_{10}log precociality coeff, s_H^{bp}, - ')
     %print -r0 -dpng Li_sHbp.png

     hWwi_sHbp = shstat({'Ww_i','s_Hbp'}, legend); 
     figure(hWwi_sHbp)
     %plot([0 7.5],[0 -4.5], 'k', 'LineWidth', 2)
     xlim([-0.5 8]); ylim([-4.5 0])
     xlabel('_{10}log max weight, W_w^\infty, g')
     ylabel('_{10}log precociality coeff, s_H^{bp}, - ')
     %print -r0 -dpng Wwi_sHbp.png
     
     WbWp_s = read_allStat({'Ww_b','Ww_p','s_Hbp'});
     WbWp_s = [WbWp_s(:,1)./WbWp_s(:,2), WbWp_s(:,3)];
     hWbWp_s = shstat(WbWp_s, legend); 
     figure(hWbWp_s)
     %plot([0 7.5],[0 -4.5], 'k', 'LineWidth', 2)
     %xlim([-0.5 8]); ylim([-4.5 0])
     xlabel('_{10}log W_w^b/ W_w^p, -')
     ylabel('_{10}log precociality coeff, s_H^{bp}, - ')
     %print -r0 -dpng WbWp_sHbp.png
     
   case 23
     fprintf('case 23\n');
     shstat_options('x_transform', 'log10');
     shstat_options('y_transform', 'log10');
     
     hLi_lb = shstat({'L_i', 'l_b'}, legend); 
     shstat({'L_i', 'l_p'}, legend,[], hLi_lb); 
     figure(hLi_lb)
     %plot([3.25 5.25],[-0.25 -3.25], 'k', 'LineWidth', 3)
     xlabel('_{10}log max structural length, L_m, cm ')
     ylabel('_{10}log scaled struc length, l_b, l_p, -')
     %print -r0 -dpng Li_lblp.png

     hLi_Lb = shstat({'L_i', 'L_b'}, legend); 
     shstat({'L_i', 'L_p'}, legend,[], hLi_Lb); 
     figure(hLi_Lb)
     %plot([3.25 5.25],[-0.25 -3.25], 'k', 'LineWidth', 3)
     xlabel('_{10}log max structural length, L_m, cm ')
     ylabel('_{10}log struc length at birth, puberty, L_b, L_p, cm')
     %print -r0 -dpng Li_LbLp.png
     
   case 24 % fig 3a, 3b
     fprintf('case 24\n');
     shstat_options('x_transform', 'log10');
     shstat_options('y_transform', 'log10');
     
     hWwi_Wwb = shstat({'Ww_i', 'Ww_b'}, legend); 
     figure(hWwi_Wwb)
     plot([0.5 6],-1.9+[0.5 6], 'k', 'LineWidth', 3) % slope 1
     plot([0.5 6],-0.9+[0.5 6], ':b', 'LineWidth', 3) % slope 1
     xlim([0.5 6]);
     xlabel('_{10}log max weight, W_w^\infty, g')
     ylabel('_{10}log weight at birth, W_w^b, g')
     %print -r0 -dpng Wwi_Wwb.png

     hWwi_Wwp = shstat({'Ww_i', 'Ww_p'}, legend); 
     figure(hWwi_Wwp)
     plot([0.5 8], -0.18+[0.5 8], 'k', 'LineWidth', 3) % slope 1
     xlim([0.5 8]);
     ylim([-1.2 8]);
     xlabel('_{10}log max weight, W_w^\infty, g')
     ylabel('_{10}log weight at puberty, W_w^p, g')
     %print -r0 -dpng Wwi_Wwp.png
     
   case 25
     fprintf('case 25\n');
     shstat_options('x_transform', 'log10');
     shstat_options('y_transform', 'none');
     
     hWwi_kap = shstat({'Ww_i', 'kap'}, legend); 
     figure(hWwi_kap)
     %plot([3.25 5.25],[-0.25 -3.25], 'k', 'LineWidth', 3)
     xlabel('_{10}log max weight, W_w^\infty, g')
     ylabel('_{10}log allocation fraction to soma, \kappa, -')
     %print -r0 -dpng Wwi_kap.png
     
   case 26 % fig 8
     fprintf('case 26\n');
     species = select('Mammalia');
     traits = {'a_m'; 'a_p'; 'a_b'; 'Ww_i'; 'Ww_p'; 'Ww_b'; 'R_i'; 's_s'; 's_Hbp'; 'p_M'; 'v'; 'kap'; 'E_Hb'; 'E_Hp'};
     % traits = {'a_m'; 'a_p'; 'a_b'; 'Ww_i'; 'Ww_p'; 'Ww_b'; 'R_i'; 's_s'; 's_Hbp'; 'p_M'};
     % traits = {'Ww_i'; 'Ww_p'; 'Ww_b'};

     %[y, e] = cMDScale(dist_traits(species, traits)); % configuration matrix, eigenvalues
     [y, e] = cmdscale(dist_traits(species, traits)); % configuration matrix, eigenvalues
     n_traits = length(traits); E = e(n_traits)/e(1);
     fprintf(['With ', num2str(n_traits), ' traits the ', num2str(n_traits), '-th eigenvalue as fraction of the first one is ', num2str(E), '\n'])
     data = NaN(length(select),3); data(select_01('Mammalia'),:) = y(:,1:3);

     % plot with legend in second figure
     shstat_options('default');
     shstat_options('x_transform', 'none');
     shstat_options('y_transform', 'none');
     shstat_options('z_transform', 'none');
     Hfig = shstat(data, legend, ['Mammalia: ', num2str(length(species)), ' @ ', datestr(date,26)]);


     %print -r300 -dpng mds_Carnivora.png
     
     
     prt_tab({traits,corr(read_stat(species, traits),y(:,1:2))},{'trait', 'axis 1', 'axis 2'},'Mammalia');
     
     figure % plot eigenvalues
     n_e = length(e); n_t = length(traits);
     plot(1:n_t, e(1:n_t), '*b', n_t+1:n_e, e(n_t+1:n_e), '*r')
     xlabel('rank');
     ylabel('eigenvalue');
     title('cMDS for Carnivora');
     set(gca, 'FontSize', 15, 'Box', 'on');
     %print -r0 -dpng eigen_Carnivora.png
     
     fprintf('%g \n', e(1:8));
     
   case 27 % fig 5b
     fprintf('case 27\n');
     shstat_options('x_transform', 'log10');
     shstat_options('y_transform', 'log10');
     
     Wabp = read_allStat({'Ww_i','a_b','a_p','c_T'}); 
     hWwi_abap = shstat([Wabp(:,1), Wabp(:,3) .* Wabp(:,4)], legend); 
     shstat([Wabp(:,1), Wabp(:,2) .* Wabp(:,4)], legend, [], hWwi_abap); 
     figure(hWwi_abap)
     %plot([3.25 5.25],[-0.25 -3.25], 'k', 'LineWidth', 3)
     xlabel('_{10}log max weight, W_w^\infty, g')
     ylabel('_{10}log age at birth, puberty, a_b, a_p, d')
     %print -r0 -dpng Wwi_abap.png

     hWwi_WwbWwp = shstat({'Ww_i', 'Ww_p'}, legend); 
     shstat({'Ww_i', 'Ww_b'}, legend, [], hWwi_WwbWwp); 
     figure(hWwi_WwbWwp)
     xlabel('_{10}log max weight, W_w^\infty, g')
     ylabel('_{10}log weight at birth, puberty, W_w^b, W_w^p, g')
     %print -r0 -dpng Wwi_WwbWwp.png

     WdW = read_allStat({'W_dWm','dWm','Ww_i','c_T'}); 
     WdW = [WdW(:,3), WdW(:,2) ./ WdW(:,1) ./ WdW(:,4)];
     hWwi_rm = shstat(WdW, legend); 
     figure(hWwi_rm)
     xlabel('_{10}log max weight, W_w^\infty, g')
     ylabel('_{10}log spec growth at max growth, 1/d')
     %print -r0 -dpng Wwi_rm.png
      
     WdW = read_allStat({'W_dWm','dWm','Ww_i','c_T'}); 
     WdW = [WdW(:,1), WdW(:,2) ./ WdW(:,1) ./ WdW(:,4)];
     hWwi_rm = shstat(WdW, legend, 'Ferae'); 
     figure(hWwi_rm)
     xlabel('_{10}log weight at max growth, g')
     ylabel('_{10}log spec growth at max growth, 1/d')
     %print -r0 -dpng WdWm_rm.png
     
   case 28 % fig 7a
     fprintf('case 28\n');
     shstat_options('x_transform', 'log10');
     shstat_options('y_transform', 'log10');
       
     aJW = read_allStat({'a_m', 'J_Oi', 'Ww_i', 'Ww_b', 'R_i', 'c_T'});
     ham_jO = shstat([aJW(:,1).*aJW(:,6), aJW(:,2)./aJW(:,3)./aJW(:,6)], legend, 'Ferae');   
     figure(ham_jO)
     xlim([4.3; 5.3]); ylim([-5.54; -3])
     plot([4.3; 5], [-3.2; -5.5], 'k', 'LineWidth', 3) % slope -1.77
     xlabel('_{10}log life span, d')
     ylabel('_{10}log spec respiration, J_O^\infty/W_w^\infty, mol/d.g')
     %print -r1200 -dpng am_jO.png
     
   case 29
     fprintf('case 29\n');
     shstat_options('x_transform', 'log10');
     shstat_options('y_transform', 'log10');
       
     hLp_Lx = shstat({'L_p','L_x'}, legend, 'Carnivora');   
     figure(hLp_Lx)
     xlim([0; 2.4]); ylim([0; 2.4])
     plot([0; 2.4], -0.2 + [0; 2.4], 'k', 'LineWidth', 3) % slope 1
     xlabel('_{10}log length at puberty, L_p, cm')
     ylabel('_{10}log length at weaning, L_x, cm')
     %print -r0 -dpng Lp_Lx.png

     hWwb_Wwx = shstat({'Ww_b','Ww_x'}, legend, 'Carnivora');   
     figure(hWwb_Wwx)
     xlim([-0.4; 2]); ylim([-0.4; 2])
     plot([-0.4; 2], 0.4 + [-0.4; 2], 'k', 'LineWidth', 3) % slope 1
     xlabel('_{10}log weight at birth, W_w^b, cm')
     ylabel('_{10}log weight at weaning, W_w^x, cm')
     %print -r0 -dpng Wwb_Wwx.png

     hWwp_Wwx = shstat({'Ww_p','Ww_x'}, legend, 'Carnivora');   
     figure(hWwp_Wwx)
     %xlim([0; 2.4]); ylim([0; 2.4])
     plot([0; 8], -0.2 + [0; 8], 'k', 'LineWidth', 3) % slope 1
     xlabel('_{10}log weight at puberty, W_w^p, g')
     ylabel('_{10}log weight at weaning, W_w^x, g')
     %print -r0 -dpng Wwp_Wwx.png

     hWwb_Wwx = shstat({'Ww_b','Ww_x'}, legend, 'Carnivora');   
     figure(hWwb_Wwx)
     %xlim([-0.4; 2]); ylim([-0.4; 2])
     plot([-0.4; 7], 0.4 + [-0.4; 7], 'k', 'LineWidth', 3) % slope 1
     xlabel('_{10}log weight at birth, W_w^b, g')
     ylabel('_{10}log weight at weaning, W_w^x, g')
     %print -r0 -dpng Wwb_Wwx.png

   case 30 % fig 3c
     fprintf('case 30\n');
     shstat_options('x_transform', 'log10');
     shstat_options('y_transform', 'log10');
     
     hWwi_Em = shstat({'Ww_i','E_m'}, legend_Euungulata, 'Euungulata'); 
     figure(hWwi_Em)
     xlabel('_{10}log ultimate weight, W_w^\infty, g')
     ylabel('_{10}log reserve capacity, [E_m], J/cm^3')
     %print -r0 -dpng Wwi_Em_Euungulata.png

   case 31 % McNa2006
     fprintf('case 31\n');
     shstat_options('x_transform', 'log10');
     shstat_options('y_transform', 'log10');
     
     legend_CM = { ... % Carnivora
       % Feliformia
       {'o', 8, 3, [1 0 0], [0 0 0]}, 'Feloidea';
       {'o', 8, 3, [1 0 0], [0 0 1]}, 'Viverroidea';
       {'o', 8, 3, [1 0 0], [1 0 0]}, 'Eupleridae';
       % Caniformia
       {'o', 8, 3, [0 0 1], [0 0 0]}, 'Canidae';
       {'o', 8, 3, [0 0 1], [0 0 1]}, 'Ursidae';
       {'o', 8, 3, [0 0 1], [1 0 0]}, 'Musteloidea'; 
       {'o', 8, 3, [0 0 1], [1 1 1]}, 'Pinnipedia'; 
       % Marsupial carnivores
       {'^', 8, 3, [0 0 1], [0 0 1]}, 'Didelphimorphia'; 
       {'^', 8, 3, [1 0 0], [1 0 0]}, 'Dasyuromorphia'; 
     };

     WJR = read_allStat({'Ww_i', 'J_Oi','R_i'}); data = [WJR(:,2)./WJR(:,1), WJR(:,3)];
     [hJOi_Ri hleg_CM] = shstat(data, legend_CM, 'Carnivora/Marsupialia'); 
     figure(hJOi_Ri)
     xlabel('_{10}log ultimate spec respiration, j_O^\infty, mol O_2/g.d')
     ylabel('_{10}log ultimate reproduction rate, R_\infty, #/d')
     %print -r0 -dpng jOi_Ri_CM.png

     figure(hleg_CM)
     %print -r0 -dpng legend_CM.png

   case 32 % fig 5a
     fprintf('case 32\n');
     shstat_options('x_transform', 'none');
     shstat_options('y_transform', 'none');
     
     hss_kap = shstat({'s_s','kap'}, legend, 'Ferae'); 
     figure(hss_kap)
     kap = linspace(1e-6,1,100); ss = kap.^2 .* (1 - kap); 
     plot(ss, kap, 'k', 'Linewidth', 2)
     xlim([0 4/27]); ylim([0 1]);
     xlabel('supply stress, s_s, -')
     ylabel('_{10}log allocation fraction, \kappa, -')
     %print -r0 -dpng ss_kap.png

   case 33 
     fprintf('case 33\n');
     shstat_options('x_transform', 'none');
     shstat_options('y_transform', 'log10');
     
     Data = read_allStat({'s_s','R_i','Ww_b','a_m','c_T'}); data = [Data(:,1), Data(:,2).*Data(:,3)./Data(:,5)];
     hss_RiWwb = shstat(data, legend, 'Ferae'); 
     figure(hss_RiWwb)
     xlim([0 4/27]); 
     xlabel('supply stress, s_s, -')
     ylabel('_{10}log neonate mass production, g/d')
     %print -r0 -dpng ss_RiWwb.png

     data = [Data(:,1), Data(:,4).*Data(:,5)];
     hss_am = shstat(data, legend, 'Ferae'); 
     figure(hss_am)
     xlim([0 4/27]); 
     xlabel('supply stress, s_s, -')
     ylabel('_{10}log life span, d')
     %print -r0 -dpng ss_am.png

   case 34 
     fprintf('case 34\n');
     shstat_options('x_transform', 'log10');
     shstat_options('y_transform', 'log10');
     
     hWwi_pM = shstat({'Ww_i','p_M'}, legend, 'Ferae'); 
     figure(hWwi_pM)
     xlabel('_{10}log ultimate wet weight, g, -')
     ylabel('_{10}log spec somatic maint., J/d.cm^3')
     %print -r0 -dpng Wwi_pM.png

 end
      
  end
end

function sel = STRcmp(array,txt)
  n = length(array); sel = false(n,1);
  for i=1:n
    sel(i) = strcmp(array{i},txt);
  end
end
    
function [Y, e] = cMDScale(D,p)
%CMDSCALE Classical Multidimensional Scaling.
%   Y = CMDSCALE(D) takes an n-by-n distance matrix D, and returns an n-by-p 
%   configuration matrix Y.  Rows of Y are the coordinates of n points in
%   p-dimensional space for some p < n.  When D is a Euclidean distance matrix,
%   the distances between those points are given by D.  p is the dimension of
%   the smallest space in which the n points whose interpoint distances are
%   given by D can be embedded.
% 
%   [Y,E] = CMDSCALE(D) also returns the eigenvalues of Y*Y'.  When D is 
%   Euclidean, the first p elements of E are positive, the rest zero.  If the 
%   first k elements of E are much larger than the remaining (n-k), then you 
%   can use the first k columns of Y as k-dimensional points, whose interpoint 
%   distances approximate D.  This can provide a useful dimension reduction for 
%   visualization, e.g., for k==2.
% 
%   D need not be a Euclidean distance matrix.  If it is non-Euclidean, or is
%   a more general dissimilarity matrix, then some elements of E are negative,
%   and CMDSCALE chooses p as the number of positive eigenvalues.  In this case,
%   the reduction to p or fewer dimensions provides a reasonable approximation
%   to D only if the negative elements of E are small in magnitude.
% 
%   [Y,E] = CMDSCALE(D,p) also accepts a positive integer between 1 and n
%   that specifies the dimensionality of the desired embedding Y. If a p
%   dimensional embedding is possible, then Y will be of size n-by-p and E
%   will be of size p-by-1. If only a q dimensional embedding with q < p is
%   possible then Y will be of size n-by-q and E will be of size p-by-1.
%   Specifying p may reduce the computational burden when n is very large.
%
%   You can specify D as either a full dissimilarity matrix, or in upper 
%   triangle vector form such as is output by PDIST.  A full dissimilarity
%   matrix must be real and symmetric, and have zeros along the diagonal and
%   positive elements everywhere else.  A dissimilarity matrix in upper
%   triangle form must have real, positive entries.  You can also specify D
%   as a full similarity matrix, with ones along the diagonal and all other
%   elements less than one.  CMDSCALE transforms a similarity matrix to a
%   dissimilarity matrix in such a way that distances between the points
%   returned in Y equal or approximate sqrt(1-D).  If you want to use a
%   different transformation, you can transform the similarities prior to
%   calling CMDSCALE.
%
%   Example:
%
%      % some points in 4D, but "close" to 3D, reduce them to distances only
%      X = [ normrnd(0,1,10,3) normrnd(0,.1,10,1) ];
%      D = pdist(X, 'euclidean');
%
%      % find a configuration with those inter-point distances
%      [Y e] = cmdscale(D);
%      dim = sum(e > eps^(3/4)) % four, but fourth one small
%      maxerr2 = max(abs(pdist(X) - pdist(Y(:,1:2)))) % poor reconstruction
%      maxerr3 = max(abs(pdist(X) - pdist(Y(:,1:3)))) % good reconstruction
%      maxerr4 = max(abs(pdist(X) - pdist(Y))) % exact reconstruction
%
%      D = pdist(X, 'cityblock'); % D is now non-Euclidean
%      [Y e] = cmdscale(D);
%      min(e) % one is large negative
%      maxerr = max(abs(pdist(X) - pdist(Y))) % poor reconstruction
%
%   See also MDSCALE, PDIST, PROCRUSTES.

%   References:
%     [1] Seber, G.A.F., Multivariate Observations, Wiley, 1984

%   Copyright 1993-2010 The MathWorks, Inc. 

[n,m] = size(D);
del = 10*eps(class(D));

% lower triangle form for D, make sure it's a valid dissimilarity matrix
if n == 1
    n = ceil(sqrt(2*m)); % (1+sqrt(1+8*m))/2, but works for large m
    if n*(n-1)/2 == m && all(D >= 0)
        D = squareform(D); % assumes zero diagonal, similarity not allowed
    else
        error(message('stats:cmdscale:BadDistance'));
    end
    
% full matrix form, make sure it's valid similarity/dissimilarity matrix
elseif n == m && all(all(D >= 0 & abs(D - D') <= del*max(max(D))))
    
    % it's a dissimilarity matrix
    if all(diag(D) < del)
        % nothing to do
        
    % it's a similarity matrix -- transform to dissimilarity matrix.
    % the sqrt is not entirely arbitrary, see Seber, eqn. 5.73
    elseif all(abs(diag(D) - 1) < del) && all(all(D < 1+del))
        D = sqrt(1 - D);
    else
        error(message('stats:cmdscale:BadDistanceOrSim'));
    end
else
    error(message('stats:cmdscale:BadDistance'));
end

% check if p is supplied and if so, make sure it is sensible
p = n;
% if ( nargin < 2 )
%    % only D is supplied
%    p = n;
% else
%    % p is supplied
%    if ( ~isscalar(p) || ~(internal.stats.isIntegerVals(p,1,n)) )
%        error(message('stats:cmdscale:BadDimP',n));
%    end 
% end

% P = eye(n) - repmat(1/n,n,n);
% B = P * (-.5 * D .* D) * P;
% A more efficient way of doing the same thing.
D = D.*D; % square elements of D
B = bsxfun(@plus, bsxfun(@minus, bsxfun(@minus, D, sum(D,1)/n),sum(D,2)/n), sum(D(:))/(n^2))*(-0.5);

if (p == n)
    % compute full eigen-decomposition
    [V,E] = eig((B+B')./2); % guard against spurious complex e-vals from roundoff
else
    % compute only p eigenvectors and eigenvalues.
    [V,E] = eigs((B+B')./2,p,'LA'); % guard against spurious complex e-vals from roundoff
end
[e,i] = sort(diag(E)); e = flipud(e); i = flipud(i); % sort descending

% keep only positive e-vals (beyond roundoff)
keep = find(e > max(abs(e)) * eps(class(e))^(3/4));
if isempty(keep)
    Y = zeros(n,1);
else
    % The following line does the same thing as: Y = V(:,i(keep)) * diag(sqrt(e(keep)));
    Y = bsxfun(@times, V(:,i(keep)), sqrt(e(keep))');
end

% Enforce a sign convention on the solution -- the largest element
% in each coordinate will have a positive sign.
[~,maxind] = max(abs(Y),[],1);
d = size(Y,2);
colsign = sign(Y(maxind + (0:n:(d-1)*n)));
Y = bsxfun(@times,Y,colsign);

end
