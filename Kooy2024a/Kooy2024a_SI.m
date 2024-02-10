function Kooy2024a_SI(fig)
% Supporting Information for Kooy2024a
% Title: The comparative energetics of the branchiopods
% Authors: Kooijman
% Journal: Ecological Modelling
% DOI: 
% Date: 2024/02/04
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
% To run the code for a figure: type in the Matlab window e.g. KooyAugu2022_SI(4)
%
% Remarks: 
%  The figures show current AmP data, which might change in time; the results might differ from the publication
%  The scripts call functions read_popStat and read_allStat; the first call to these functions loads the .mat file, which can take some time
%  Click on a marker in the Matlab-figure to see the species name
%  Uncomment "print" to save the Matlab-figure to a png-file
%  Modify selection of taxa and markers by changing the legend, see https://add-my-pet.github.io/AmPtool/docs/index.html
%  Allowed names of taxa match the names of the tree nodes at http://www.bio.vu.nl/thb/deb/deblab/add_my_pet/species_tree_Animalia.html

if ~exist('fig','var')
   fig = 1:31;
end

 llegend = {... % Branchiopoda
   {'-', 2, [0 0 0]}, 'Artemiina'; 
   {'-', 2, [0 0 1]}, 'Anostracina'; 
   {'-', 2, [1 0 1]}, 'Cladocera'; 
   {'-', 2, [1 0 0]}, 'Conchostraca'; 
   {'-', 2, [0 1 0]}, 'Notostraca'; 
  };

 legend = { ... % 
   % Sarcostraca
   {'o', 8, 3, [0 0 0], [0 0 0]}, 'Artemiidae';        % Artemiina    brine shrimps
   {'o', 8, 3, [0 0 1], [0 0 0]}, 'Branchinectidae';   % Anostracina  fairy shrimps
   {'o', 8, 3, [0 0 1], [0 0 1]}, 'Branchipodidae';    % Anostracina  fairy shrimps
   {'o', 8, 3, [0 0 1], [1 0 1]}, 'Streptocephalidae'; % Anostracina  fairy shrimps
   {'o', 8, 3, [0 0 1], [1 0 0]}, 'Tanymastigidae';    % Anostracina  fairy shrimps
   {'o', 8, 3, [0 0 1], [1 1 1]}, 'Thamnocephalidae';  % Anostracina  fairy shrimps
   % Diplostraca
   {'o', 8, 3, [1 0 1], [0 0 0]}, 'Anomopoda';         % Cladocera    waterfleas
   {'o', 8, 3, [1 0 1], [0 0 1]}, 'Ctenopoda';         % Cladocera    waterfleas
   {'o', 8, 3, [1 0 1], [1 0 1]}, 'Haplopoda';         % Cladocera    waterfleas
   {'o', 8, 3, [1 0 1], [1 0 0]}, 'Onychopoda';        % Cladocera    waterfleas
   {'o', 8, 3, [1 0 1], [1 1 1]}, 'Conchostraca';      %              clam shrimps
   % Notostraca
   {'o', 8, 3, [1 0 0], [1 0 0]}, 'Notostraca';        %              tadpole shrimps
 };
 
 close all
 shstat_options('default');
 shstat_options('y_label', 'on'); 
 shstat_options('x_label', 'off'); 
 
 for i=1:length(fig)
 
 switch fig(i)
   case 1 % Fig 1a
     fprintf('case 1\n');
     shstat_options('x_transform', 'log10');
     
     pAmsM = read_allStat({'p_Am','s_M'}); p_Am = pAmsM(:,1).*pAmsM(:,2);
     hp_Am = shstat(p_Am, llegend, 'Branchiopoda'); 
     figure(hp_Am)
     xlabel('_{10}log spec assimilation rate, \{p_{Am}\}, J/d.cm^2')
    %print -r0 -dpng pAm.png

   case 2 % Fig 1b
     fprintf('case 2\n');
     shstat_options('x_transform', 'log10');
     
     vsM = read_allStat({'v','s_M'}); v = vsM(:,1).*vsM(:,2);
     hv = shstat(v, llegend, 'Branchiopoda'); 
     figure(hv)
     xlabel('_{10}log energy conductance, v, cm/d')
    %print -r0 -dpng v.png
     
   case 3 % fig 1c
     fprintf('case 3\n');
     shstat_options('x_transform', 'none');
     
     [hkap, hleg] = shstat({'kap'}, llegend, 'Branchiopoda');
     figure(hkap)
     xlabel('allocation fraction to soma, \kappa, -')
    %print -r0 -dpng kap.png
     
     figure(hleg)
    %print -r0 -dpng llegend.png
     
   case 4 % fig 1d
     fprintf('case 4\n');
     shstat_options('x_transform', 'log10');
     
     hp_M = shstat({'p_M'}, llegend, 'Branchiopoda'); 
     figure(hp_M)
     xlabel('_{10}log vol-spec somatic maint, [p_M], J/d.cm^3')
    %print -r0 -dpng pM.png

   case 5 % Fig 1e
     fprintf('case 5\n');
     shstat_options('x_transform', 'log10');
     
     aaac = read_allStat({'a_b','a_p','a_m','c_T'});
     ha_m = shstat(aaac(:,3).*aaac(:,4), llegend, 'Branchiopoda');
     shstat(aaac(:,2).*aaac(:,4), llegend, [], ha_m); 
     shstat(aaac(:,1).*aaac(:,4), llegend, [], ha_m); 
     figure(ha_m)
     xlabel('_{10}log age at birth, puberty, death, a_b, a_p, a_m, d')
    %print -r0 -dpng am.png

   case 6 % Fig 1f
     fprintf('case 6\n');
     shstat_options('x_transform', 'log10');
     
     hE_m = shstat({'E_m'}, llegend, 'Branchiopoda'); 
     figure(hE_m)
     xlabel('_{10}log reserve capacity, [E_m], J/cm^3')
    %print -r0 -dpng Em.png

   case 7 %  Fig 1g
     fprintf('case 7\n');
     shstat_options('x_transform', 'log10');
     
     hs_Hbp = shstat({'s_Hbp'}, llegend, 'Branchiopoda'); 
     figure(hs_Hbp)
     xlabel('_{10}log precociality coeff, s_H^{bp}, -')
    %print -r0 -dpng sHbp.png

   case 8 % Fig 1h
     fprintf('case 8\n');
     shstat_options('x_transform', 'log10');
     
     hs_s = shstat({'s_s'}, llegend, 'Branchiopoda'); 
     figure(hs_s)
     xlabel('_{10}log supply stress, s_s, -')
    %print -r0 -dpng ss.png
     
   case 9 % Fig 1i
     fprintf('case 9\n');
     shstat_options('x_transform', 'log10');
     
     hWw_i = shstat({'Ww_i'}, llegend, 'Branchiopoda');
     shstat({'Ww_p'}, llegend, [], hWw_i);
     shstat({'Ww_b'}, llegend, [], hWw_i);
     figure(hWw_i)
     xlabel('_{10}log weight at birth, puberty, death, W_w^b, W_w^p, W_w^\infty, g')
    %print -r0 -dpng Wwi.png

   case 10 % Fig 1j
     fprintf('case 10\n');
     shstat_options('x_transform', 'log10');

     WdW_M = read_stat(select('Artemiina'),{'W_dWm','dWm','c_T'});   WdW_M = WdW_M(:,2) ./ WdW_M(:,1) ./ WdW_M(:,2);
     WdW_A = read_stat(select('Anostracina'),{'W_dWm','dWm','c_T'}); WdW_A = WdW_A(:,2) ./ WdW_A(:,1) ./ WdW_A(:,2);
     WdW_L = read_stat(select('Cladocera'),{'W_dWm','dWm','c_T'}); WdW_L = WdW_L(:,2) ./ WdW_L(:,1) ./ WdW_L(:,2);
     WdW_G = read_stat(select('Conchostraca'),{'W_dWm','dWm','c_T'}); WdW_G = WdW_G(:,2) ./ WdW_G(:,1) ./ WdW_G(:,2);
     WdW_E = read_stat(select('Notostraca'),{'W_dWm','dWm','c_T'}); WdW_E = WdW_E(:,2) ./ WdW_E(:,1) ./ WdW_E(:,2);

     hWdW = shstat(WdW_M, {'k', 'k'}, 'Branchiopoda');   
     shstat(WdW_A, {'b', 'b'}, [], hWdW);   
     shstat(WdW_L, {'m', 'm'}, [], hWdW);   
     shstat(WdW_G, {'r', 'r'}, [], hWdW);   
     shstat(WdW_E, {'g', 'g'}, [], hWdW);   
     figure(hWdW)
     xlabel('_{10}log spec growth at max growth, r, g/d.g')
    %print -r0 -dpng WdW.png
     
     shllegend(llegend);

   case 11 % Fig 1k
     fprintf('case 11\n');
     shstat_options('x_transform', 'log10');
     JOiW_M = read_stat(select('Artemiina'),{'J_Oi','Ww_i','c_T'}); JOiW_M = JOiW_M(:,1) ./ JOiW_M(:,2) ./ JOiW_M(:,3);
     JOiW_A = read_stat(select('Anostracina'),{'J_Oi','Ww_i','c_T'}); JOiW_A = JOiW_A(:,1) ./ JOiW_A(:,2) ./ JOiW_A(:,3);
     JOiW_L = read_stat(select('Cladocera'),{'J_Oi','Ww_i','c_T'}); JOiW_L = JOiW_L(:,1) ./ JOiW_L(:,2) ./ JOiW_L(:,3);
     JOiW_G = read_stat(select('Conchostraca'),{'J_Oi','Ww_i','c_T'}); JOiW_G = JOiW_G(:,1) ./ JOiW_G(:,2) ./ JOiW_G(:,3);
     JOiW_E = read_stat(select('Notostraca'),{'J_Oi','Ww_i','c_T'}); JOiW_E = JOiW_E(:,1) ./ JOiW_E(:,2) ./ JOiW_E(:,3);
     
     hJOiW = shstat(JOiW_M, {'k', 'k'}, 'Branchiopoda');   
     shstat(JOiW_A, {'b', 'b'}, [], hJOiW);   
     shstat(JOiW_L, {'m', 'm'}, [], hJOiW);   
     shstat(JOiW_G, {'r', 'r'}, [], hJOiW);   
     shstat(JOiW_E, {'g', 'g'}, [], hJOiW);   
     figure(hJOiW)
     xlabel('_{10}log ultimate spec respiration, j_O^\infty, mol/d.g')
    %print -r0 -dpng jOi.png

     shllegend(llegend);

   case 12 % Fig 2
     fprintf('case 12\n');
     shstat_options('x_transform', 'log10');
     shstat_options('y_transform', 'log10');
     
     hWwi_Wwb = shstat({'Ww_i', 'Ww_b'}, legend); 
     figure(hWwi_Wwb)
     plot([-7 -1],-1.3+[-7 -1],'k', 'LineWidth',3) % slope 1
     xlim([-7 2]);
     ylim([-9 -3]);
     xlabel('_{10}log max weight, W_w^\infty, g')
     ylabel('_{10}log weight at birth, W_w^b, g')
    %print -r0 -dpng Wwi_Wwb.png

     hWwi_Wwp = shstat({'Ww_i', 'Ww_p'}, legend); 
     figure(hWwi_Wwp)
     plot([-7 0], -0.6 + [-7 0],'k', 'LineWidth',3) % slope 1
     xlim([-7 2]);
     ylim([-8 0]);
     xlabel('_{10}log max weight, W_w^\infty, g')
     ylabel('_{10}log weight at puberty, W_w^p, g')
    %print -r0 -dpng Wwi_Wwp.png
        
   case 13 % Fig 3a,b
     fprintf('case 13\n');
     shstat_options('x_transform', 'none');
     shstat_options('y_transform', 'log10');
     
     kNWWa = read_allStat({'kap', 'R_i', 'Ww_b', 'Ww_i', 'c_T'}); 
     kap = kNWWa(:,1); RWW = kNWWa(:,2) .* kNWWa(:,3) ./ kNWWa(:,4) ./ kNWWa(:,5);
     hkap_RWW = shstat([kap, RWW], legend);   
     figure(hkap_RWW)
     kap=linspace(.2,1-1e-8,100); plot(kap, log10(0.2*(1-kap)),'k', 'linewidth',2)
     xlabel('allocation fraction to soma, \kappa, -')
     ylabel('_{10}log spec neonate mass prod rate, 1/d')
     title('Branchiopoda')
     xlim([.2 1]); ylim([-5 0]);
    %print -r0 -dpng kap_RWW.png
 
     hkap_R = shstat([kNWWa(:,1), kNWWa(:,2)./kNWWa(:,5)], legend);   
     figure(hkap_R)
     xlabel('allocation fraction to soma, \kappa, -')
     ylabel('_{10}log max reprod rate, #/d')
     title('Branchiopoda')
    %print -r0 -dpng kap_R.png
    
   case 16 % Fig 3, c,d
     fprintf('case 16\n');
     shstat_options('x_transform', 'log10');
     shstat_options('y_transform', 'log10');
        
     WWRJ = read_allStat({'Ww_b', 'Ww_i', 'R_i', 'J_Oi', 'N_i' , 'c_T'});
     Wwi = WWRJ(:,2); JR = WWRJ(:,3) .* WWRJ(:,1) ./ WWRJ(:,6); JO = WWRJ(:,4) ./ WWRJ(:,6);
     
     hJO_JR = shstat([JO, JR], legend, 'Branchiopoda');   
     figure(hJO_JR)
     plot([-9 -2], 1+[-9 -2], 'k', 'linewidth', 2) % slope 1
     xlim([-9 -2]); ylim([-9 -2]);
     xlabel('_{10}log max respiration rate, mol/d')
     ylabel('_{10}log max neonate mass prod, g/d')
    %print -r0 -dpng JO_JR.png
     
     NWb = WWRJ(:,5) .* WWRJ(:,1);
     hWi_NWb = shstat([Wwi, NWb], legend, 'Branchiopoda');
     figure(hWi_NWb)
     plot([-6 2], [-6 2], 'k', 'linewidth', 2) % slope 1
     xlim([-7 2]); ylim([-7 0]);
     xlabel('_{10}log max weight, g')
     ylabel('_{10}log cum neonate mass prod, g')
    %print -r0 -dpng Wwi_NWb.png

   case 17 % Fig 4a
     fprintf('case 17\n');
     shstat_options('x_transform', 'log10');
     shstat_options('y_transform', 'log10');
     
     WJO = read_allStat({'Ww_i','J_Oi','c_T'}); WJO(:,2) = WJO(:,2) ./ WJO(:,1) ./ WJO(:,3);
     [hWwi_JOiW, hC]= shstat(WJO, legend, 'Branchiopoda');   
     figure(hWwi_JOiW)
     xlim([-8; 2]); ylim([-4; -2]);
     plot([-6; 2], [-2; -4], '-k', 'Linewidth', 2) % slope -0.25
     xlabel('_{10}log ultimate wet weight, g')
     ylabel('_{10}log spec respiration, mol/d.g')     
    %print -r0 -dpng Wwi_JOiW.png
     
     figure(hC)
    %print -r1200 -dpng legend_Branchiopoda.png
     
   case 18 % Fig 4b
     fprintf('case 18\n');
     shstat_options('x_transform', 'log10');
     shstat_options('y_transform', 'log10');
       
     aJW = read_allStat({'a_m', 'J_Oi', 'Ww_i', 'Ww_b', 'R_i', 'c_T'});
     ham_jO = shstat([aJW(:,1).*aJW(:,6), aJW(:,2)./aJW(:,3)./aJW(:,6)], legend, 'Branchiopoda');   
     figure(ham_jO)
     xlim([1; 2.5]); ylim([-4; -2])
     plot([1; 2.5], [-2; -3.5], 'k', 'LineWidth', 3) % slope -1
     xlabel('_{10}log life span, d')
     ylabel('_{10}log spec respiration, J_O^\infty/W_w^\infty, mol/d.g')
    %print -r0 -dpng am_jO.png
     
   case 19 % Fig 5: mds
     fprintf('case 19\n');
     species = select('Branchiopoda');
     traits = {'a_m'; 'a_p'; 'a_b'; 'Ww_i'; 'Ww_p'; 'Ww_b'; 'R_i'; 's_s'; 's_Hbp'; 'p_M'; 'v'; 'kap'; 'E_Hb'; 'E_Hp'};
     % traits = {'a_m'; 'a_p'; 'a_b'; 'Ww_i'; 'Ww_p'; 'Ww_b'; 'R_i'; 's_s'; 's_Hbp'; 'p_M'};
     % traits = {'Ww_i'; 'Ww_p'; 'Ww_b'};

     %[y, e] = cMDScale(dist_traits(species, traits)); % configuration matrix, eigenvalues
     [y, e] = cmdscale(dist_traits(species, traits)); % configuration matrix, eigenvalues
     n_traits = length(traits); E = e(n_traits)/e(1);
     fprintf(['With ', num2str(n_traits), ' traits the ', num2str(n_traits), '-th eigenvalue as fraction of the first one is ', num2str(E), '\n'])
     data = NaN(length(select),3); data(select_01('Branchiopoda'),:) = y(:,1:3);

     % plot with legend in second figure
     shstat_options('default');
     shstat_options('x_transform', 'none');
     shstat_options('y_transform', 'none');
     shstat_options('z_transform', 'none');
     Hfig = shstat(data, legend, ['Branchiopoda: ', num2str(length(species)), ' @ ', datestr(date,26)]);

    %print -r300 -dpng mds_Branchiopoda.png
     
     prt_tab({traits,corr(read_stat(species, traits),y(:,1:2))},{'trait', 'axis 1', 'axis 2'},'Branchiopoda');
     
     figure % eigenvalues
     n_e = length(e); n_t = length(traits);
     plot(1:n_t, e(1:n_t), '*b', n_t+1:n_e, e(n_t+1:n_e), '*r')
     xlabel('rank');
     ylabel('eigenvalue');
     title('cMDS for Branchiopoda');
     set(gca, 'FontSize', 15, 'Box', 'on');
    %print -r0 -dpng eigen_Branchiopoda.png
     
     fprintf('%g \n', e(1:8));
     
   case 20
     fprintf('case 20\n');
     shstat_options('x_transform', 'log10');
     shstat_options('y_transform', 'log10');
     
     hv_sHbp = shstat({'v','s_Hbp'}, legend);   
     figure(hv_sHbp)
     xlabel('_{10}log energy conductance, v, cm/d')
     ylabel('_{10}log precociality coeff, s_H^{bp}, -')
    %print -r0 -dpng v_sHbp.png

   case 21
     fprintf('case 21\n');
     shstat_options('x_transform', 'log10');
     shstat_options('y_transform', 'log10');
     
     WdW = read_allStat({'W_dWm','dWm','c_T'}); WdW = WdW(:,2) ./ WdW(:,1) ./ WdW(:,3);
     r = read_popStat('f1.thin1.f.r') ./ read_popStat('c_T'); 
     
     hWdW_r = shstat([WdW, r], legend);   
     figure(hWdW_r)
     %plot([-2 -4.5], [-2 -4.5], 'k', 'LineWidth', 2)
     xlabel('_{10}log max spec growth, r_m, g/d.g')
     ylabel('_{10}log max spec pop growth, r_N, 1/d')
    %print -r0 -dpng WdW_r.png
      
   case 22 
     fprintf('case 22\n');
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
     %plot([2.2 4.8],1.5+[2.2 4.8], 'k', 'LineWidth', 3) % slope 1
     %xlim([2.15 4.85])
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

   case 23 
     fprintf('case 23\n');
     shstat_options('x_transform', 'log10');
     shstat_options('y_transform', 'log10');
     
     hsHbp_Em = shstat({'s_Hbp', 'E_m'}, legend); 
     figure(hsHbp_Em)
     %plot([3.25 5.25],[-0.25 -3.25], 'k', 'LineWidth', 3)
     xlabel('_{10}log precociality coeff, s_H^{bp}, - ')
     ylabel('_{10}log reserve capacity, [E_m], J/cm^3')
    %print -r0 -dpng sHbp_Em.png
 
     hpM_sHbp = shstat({'p_M', 's_Hbp'}, legend); 
     figure(hpM_sHbp)
     %plot([3.25 5.25],[-0.25 -3.25], 'k', 'LineWidth', 3)
     xlabel('_{10}log spec som maint, [p_M], J/d.cm^3')
     ylabel('_{10}log precociality coeff, s_H^{bp}, - ')
    %print -r0 -dpng hpM_sHbp.png
     
  case 24
     fprintf('case 24\n');
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
     %plot([-5 0],0.75+[3.75 1.25], 'k', 'LineWidth', 3)
     %xlim([-4.5 0]); ylim([1.5 4.5])
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
     %xlim([-0.25 2.25]); ylim([-4.5 0])
     xlabel('_{10}log max structural length, L_\infty, cm')
     ylabel('_{10}log precociality coeff, s_H^{bp}, - ')
    %print -r0 -dpng Li_sHbp.png

     hWwi_sHbp = shstat({'Ww_i','s_Hbp'}, legend); 
     figure(hWwi_sHbp)
     %plot([0 7.5],[0 -4.5], 'k', 'LineWidth', 2)
     %xlim([-0.5 8]); ylim([-4.5 0])
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
     
   case 25
     fprintf('case 25\n');
     shstat_options('x_transform', 'log10');
     shstat_options('y_transform', 'log10');
     
     LiLp = read_allStat({'L_i','L_p'});
     hLi_lp = shstat([LiLp(:,1), LiLp(:,2)./LiLp(:,1)], legend); 
     figure(hLi_lp)
     %plot([3.25 5.25],[-0.25 -3.25], 'k', 'LineWidth', 3)
     xlabel('_{10}log ultimate structural length, L_\infty, cm ')
     ylabel('_{10}log scaled length at puberty, L_p/L_\infty, -')
    %print -r0 -dpng Li_lp.png

     hLi_Lp = shstat(LiLp, legend); 
     figure(hLi_Lp)
     %plot([3.25 5.25],[-0.25 -3.25], 'k', 'LineWidth', 3)
     xlabel('_{10}log ultimate structural length, L_\infty, cm ')
     ylabel('_{10}log struc length at puberty, L_p, cm')
    %print -r0 -dpng Li_Lp.png
          
   case 26
     fprintf('case 26\n');
     shstat_options('x_transform', 'log10');
     shstat_options('y_transform', 'none');
     
     hWwi_kap = shstat({'Ww_i', 'kap'}, legend); 
     figure(hWwi_kap)
     %plot([3.25 5.25],[-0.25 -3.25], 'k', 'LineWidth', 3)
     xlabel('_{10}log max weight, W_w^\infty, g')
     ylabel('_{10}log allocation fraction to soma, \kappa, -')
    %print -r0 -dpng Wwi_kap.png
     
   case 27 
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

     WdW = read_allStat({'W_dWm','dWm','Ww_i','c_T'}); 
     WdW = [WdW(:,3), WdW(:,2) ./ WdW(:,1) ./ WdW(:,4)];
     hWwi_rm = shstat(WdW, legend); 
     figure(hWwi_rm)
     xlabel('_{10}log max weight, W_w^\infty, g')
     ylabel('_{10}log spec growth at max growth, 1/d')
    %print -r0 -dpng Wwi_rm.png
      
     WdW = read_allStat({'W_dWm','dWm','Ww_i','c_T'}); 
     WdW = [WdW(:,1), WdW(:,2) ./ WdW(:,1) ./ WdW(:,4)];
     hWwi_rm = shstat(WdW, legend, 'Branchiopoda'); 
     figure(hWwi_rm)
     xlabel('_{10}log weight at max growth, g')
     ylabel('_{10}log spec growth at max growth, 1/d')
    %print -r0 -dpng WdWm_rm.png
     
   case 28 
     fprintf('case 28\n');
     shstat_options('x_transform', 'log10');
     shstat_options('y_transform', 'log10');
     
     hWwi_pM = shstat({'Ww_i','p_M'}, legend, 'Branchiopoda'); 
     figure(hWwi_pM)
     xlabel('_{10}log ultimate wet weight, g')
     ylabel('_{10}log spec somatic maint., J/d.cm^3')
    %print -r0 -dpng Wwi_pM.png

     hLi_pM = shstat({'L_i','p_M'}, legend, 'Branchiopoda'); 
     figure(hLi_pM)
     xlabel('_{10}log ultimate struc length, cm')
     ylabel('_{10}log spec somatic maint., J/d.cm^3')
    %print -r0 -dpng Li_pM.png
    
   case 29 
     fprintf('case 29\n');
     shstat_options('x_transform', 'none');
     
     [hsM, hleg] = shstat({'s_M'}, llegend, 'Branchiopoda');
     figure(hsM)
     xlabel('acceleration factor, s_M, -')
    %print -r0 -dpng sM.png
     
     figure(hleg)
    %print -r0 -dpng llegend.png

   case 30 
     fprintf('case 30\n');
     shstat_options('x_transform', 'log10');
     shstat_options('y_transform', 'log10');
     
     abpmcT = read_allStat({'a_b','a_p','a_m','c_T'}); abpm = abpmcT(:,1:3).*abpmcT(:,[4 4 4]);
     [hapam, hleg] = shstat(abpm(:,2:3), legend, 'Branchiopoda');
     figure(hapam)
     xlabel('age at puberty, a_p, d')
     ylabel('life span, a_m, d')
     %plot([1 4.5],[1.5 5],'k', 'LineWidth',3) % slope 1
     %xlim([1 4.5]);
     %ylim([1.5 5]);

    %print -r0 -dpng ap_am.png
 
     hapab = shstat(abpm(:,[2 1]), legend, 'Branchiopoda');
     figure(hapab)
     xlabel('age at puberty, a_p, d')
     ylabel('age at birth, a_b, d')
     %plot([1 4.5],[1.5 5],'k', 'LineWidth',3) % slope 1
     %xlim([1 4.5]);
     %ylim([1.5 5]);

    %print -r0 -dpng ap_ab.png

     figure(hleg)
    %print -r0 -dpng llegend.png

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
