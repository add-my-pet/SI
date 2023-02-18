function MarnKooy2022_SI(fig)
% Supporting Information for MarnKooy2022
% Title: The comparative energetics of the turtles and crocodiles
% Authors (Year): Marn, Kooijman (2022)  
% Journal: Ecology and Evolution 12(6): e8996; 
% DOI: 10.1002/ece3.8996
% Date: 2023/02/18

% Matlab scripts to generate Figures 1-5 and Figure 7 of the publication, and Figures A1-A3 of the Appendix (+ some extra plots not used in the publication)
% Input --> Figure 
%    1-12 --> Fig 1
%    13:18 --> Figures 2-5 and Fig 7
%    19:21 --> Figures A1-A3
%    50:59 --> some additional plots (see code for detai

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


species = {'Testudinidae','Chelonioidea','Testudines','Deinosuchus', 'Crocodilia',  'Lepidosauria',...
    'Pterosauria', 'Saurischia','Ornithischia', 'Tyrannosauridae'};

if ~exist('fig','var')
    fig = 1:21;
end

llegend = {... % Reptilia
    {'-', 2, [0 0 0]}, 'Lepidosauria';
    {'-', 2, [0 0 1]}, 'Testudines';
    {'-', 2, [1 0 0]}, 'Crocodilia';
    };

legend = { ... % Turtles
    % Land turtles (tortoises)
    {'o', 8, 3, [0 0 1], [1 1 1]}, 'Testudinidae'
    % Sea turtles
    {'o', 8, 3, [0 0 1], [0.55 0.55 0.55]}, 'Chelonioidea'
    % Other turtles
    {'o', 8, 3, [0 0 1], [0 0 1]}, 'Testudines'
    % Crocodilia
    {'x', 4, 4, [1 0 0], [1 0 0]}, 'Deinosuchus'; ... % extinct terror crocodile
    {'^', 8, 3, [1 0 0], [1 0 0]}, 'Crocodilia'; ...
    % other Reptilia (some extinct)
    {'x', 4, 4, [0 0 0], [0 0 0]}, 'Lepidosauria'; ...
    {'x', 3, 3, [0.4 0.4 0.4], [0.4 0.4 0.4]}, 'Pterosauria'; ...
    {'x', 3, 3, [0.4 0.4 0.4], [0.4 0.4 0.4]}, 'Saurischia'; ...
    {'x', 3, 3, [0.4 0.4 0.4], [0.4 0.4 0.4]}, 'Ornithischia'; ...
    {'x', 3, 3, [0.4 0.4 0.4], [0.4 0.4 0.4]}, 'Tyrannosauridae'; ...
    };

close all
shstat_options('default');
shstat_options('y_label', 'on');
shstat_options('x_label', 'off');

for i=1:length(fig)
    
    switch fig(i)           
        case 1 % Fig 1a
            shstat_options('x_transform', 'log10');
            hp_Am = shstat({'p_Am'}, llegend);
            figure(hp_Am)
            xlabel('_{10}log spec assimilation rate, \{p_{Am}\}, J/d.cm^2')
            print -r300 -dpng pAm.png
            
        case 2 % Fig 1b
            shstat_options('x_transform', 'log10');
            hv = shstat({'v'}, llegend);
            figure(hv)
            xlabel('_{10}log energy conductance, v, cm/d')
            print -r300 -dpng v.png
            
        case 3 % Fig 1c
            shstat_options('x_transform', 'none');
            [hkap, hleg] = shstat({'kap'}, llegend);
            figure(hkap)
            xlabel('allocation fraction to soma, \kappa, -')
            print -r300 -dpng kap.png
            figure(hleg)
            print -r0 -dpng llegend_Reptilia.png
        
        case 4 % Fig 1d
            shstat_options('x_transform', 'log10');
            hp_M = shstat({'p_M'}, llegend);
            figure(hp_M)
            xlabel('_{10}log vol-spec somatic maint, [p_M], J/d.cm^3')
            print -r300 -dpng pM.png
            
        case 5 % Fig 1e
            shstat_options('x_transform', 'log10');
            aaac = read_allStat({'a_b','a_p','a_m','c_T'});
            ha_m = shstat(aaac(:,3).*aaac(:,4), llegend);
            shstat(aaac(:,2).*aaac(:,4), llegend, [], ha_m);
            shstat(aaac(:,1).*aaac(:,4), llegend, [], ha_m);
            figure(ha_m)
            xlabel('_{10}log age at birth, puberty, death, a_b, a_p, a_m, d')
            print -r300 -dpng am.png

        case 6 % Fig 1f
            shstat_options('x_transform', 'log10');
            hE_m = shstat({'E_m'}, llegend);
            figure(hE_m)
            xlabel('_{10}log reserve capacity, [E_m], J/cm^3')
            print -r300 -dpng Em.png
      
        case 7 % Fig 1g
            shstat_options('x_transform', 'log10');
            hs_Hbp = shstat({'s_Hbp'}, llegend);
            figure(hs_Hbp)
            xlabel('_{10}log precociality coeff, s_H^{bp}, -')
            print -r300 -dpng sHbp.png
                   
        case 8 % Fig 1h
            shstat_options('x_transform', 'log10');
            hs_s = shstat({'s_s'}, llegend);
            figure(hs_s)
            xlabel('_{10}log supply stress, s_s, -')
            print -r300 -dpng ss.png
            
        case 9 % Fig 1i
            shstat_options('x_transform', 'log10');
            
            hWw_i = shstat({'Ww_i'}, llegend);
            shstat({'Ww_p'}, llegend, [], hWw_i);
            shstat({'Ww_b'}, llegend, [], hWw_i);
            figure(hWw_i)
            xlabel('_{10}log weight at birth, puberty, death, W_w^b, W_w^p, W_w^\infty, g')
            print -r300 -dpng Wwi.png
            
        case 10 % Fig 1j
            shstat_options('x_transform', 'log10');
            WdW_L = read_stat(select('Lepidosauria'),{'W_dWm','dWm','c_T'});   WdW_L = WdW_L(:,2) ./ WdW_L(:,1) ./ WdW_L(:,2);
            WdW_T = read_stat(select('Testudines'),{'W_dWm','dWm','c_T'}); WdW_T = WdW_T(:,2) ./ WdW_T(:,1) ./ WdW_T(:,2);
            WdW_C = read_stat(select('Crocodilia'),{'W_dWm','dWm','c_T'}); WdW_C = WdW_C(:,2) ./ WdW_C(:,1) ./ WdW_C(:,2);
            
            hWdW = shstat(WdW_L, {'k', 'k'});
            shstat(WdW_T, {'b', 'b'}, [], hWdW);
            shstat(WdW_C, {'r', 'r'}, [], hWdW);
            figure(hWdW)
            xlabel('_{10}log maximum spec growth, r, g/d.g')
            print -r300 -dpng WdW.png
            
        case 11 % Fig 1k
            shstat_options('x_transform', 'log10');
            JOiW_L = read_stat(select('Lepidosauria'),{'J_Oi','Ww_i','c_T'}); JOiW_L = JOiW_L(:,1) ./ JOiW_L(:,2) ./ JOiW_L(:,3);
            JOiW_T = read_stat(select('Testudines'),{'J_Oi','Ww_i','c_T'}); JOiW_T = JOiW_T(:,1) ./ JOiW_T(:,2) ./ JOiW_T(:,3);
            JOiW_C = read_stat(select('Crocodilia'),{'J_Oi','Ww_i','c_T'}); JOiW_C = JOiW_C(:,1) ./ JOiW_C(:,2) ./ JOiW_C(:,3);
            
            hJOiW = shstat(JOiW_L, {'k', 'k'});
            shstat(JOiW_T, {'b', 'b'}, [], hJOiW);
            shstat(JOiW_C, {'r', 'r'}, [], hJOiW);
            figure(hJOiW)
            xlabel('_{10}log ultimate spec O_2 consumption, j_O^\infty, mol/d.g')
            print -r300 -dpng jOi.png
            
        case 12 % Fig 1l
            shstat_options('x_transform', 'log10');
            JRWW = read_allStat({'R_i','Ww_b','Ww_i','c_T'});
            jWb = JRWW(:,1) .* JRWW(:,2) ./ JRWW(:,3) ./ JRWW(:,4);
            hjWb = shstat(jWb, llegend);
            figure(hjWb)
            xlabel('_{10}log ultimate spec neonate mass prod rate, j_{W_w^b}^\infty, 1/d')
            print -r300 -dpng jWb.png
            
        case 13 
            shstat_options('x_transform', 'log10');
            shstat_options('y_transform', 'log10');
            
            aJW = read_allStat({'a_m', 'J_Oi', 'Ww_i', 'Ww_b', 'R_i', 'c_T'}); % Fig 2a
            ham_jO = shstat([aJW(:,1).*aJW(:,6), aJW(:,2)./aJW(:,3)./aJW(:,6)], legend);
            figure(ham_jO)
            xlim([2.61; 5.4]); ylim([-6; -3.2])
            plot([2.5; 5.5], [-2.5; -5.5]-0.5, 'k', 'LineWidth', 3)
            xlabel('_{10}log life span, d')
            ylabel('_{10}log spec respiration, J_O^\infty/W_w^\infty, mol/d.g')
            print -r300 -dpng am_jO_leg.png        
            
            WJO = read_allStat({'Ww_i','J_Oi','c_T'}); WJO(:,2) = WJO(:,2) ./ WJO(:,1) ./ WJO(:,3); % Fig 2b
            [hWwi_JOiW, hC]= shstat(WJO, legend);
            figure(hWwi_JOiW)
            xlabel('_{10}log ultimate wet weight, g')
            ylabel('_{10}log spec O_2 consumption, mol/d.g')
            print -r300 -dpng Wwi_JOiW.png
            plot([-0.5 8],[-3.67 -5.8], 'k', 'LineWidth',2) % y = -x * 0.25 - 3.8;
            print -r300 -dpng Wwi_JOiWslope.png
            figure(hC)
            print -r300 -dpng legend_Reptilia.png
            
       case 14
            shstat_options('x_transform', 'log10');
            shstat_options('y_transform', 'log10');
            
            WwiE0W = [WwiE0(:,1), WwiE0(:,2) ./ WwiE0(:,1)]; % Fig 3a
            hWwi_E0W = shstat(WwiE0W, legend);
            figure(hWwi_E0W)
            xlim([-0.25 7.6]); ylim([-1 3.5]);
            xlabel('_{10}log ultimate weight, W_w^\infty, g')
            ylabel('_{10}log egg size as fraction, E_0/W_w^\infty, J/g')
            print -r300 -dpng Wwi_E0W.png
            plot([-0.5; 7.5], [3.8; -0.85], 'k', 'LineWidth', 3) % slope 0.6 (y = -0.58 * x + 3.5)
            print -r300 -dpng Wwi_E0Wslope.png
%             
            WWN = read_allStat({'Ww_i', 'Ww_b', 'N_i'}); % Fig 3b
            WiWR = [WWN(:,1), WWN(:,2) .* WWN(:,3)];
            hWi_WR = shstat(WiWR, legend);
            figure(hWi_WR)
            xlim([-0.25 7.6]); ylim([-0.4 7]);
            plot([-0.25; 7.5], [-0.25; 7.5], 'k', 'LineWidth', 3)
            xlabel('_{10}log ultimate weight, W_w^\infty, g')
            ylabel('_{10}log life time neonate mass, g')
            print -r300 -dpng Wwi_WR.png
     
        case 15
            shstat_options('x_transform', 'log10');
            shstat_options('y_transform', 'log10');
            
            hWwi_WwbWwp = shstat({'Ww_i', 'Ww_p'}, legend);  % Fig 4a
            shstat({'Ww_i', 'Ww_b'}, legend, [], hWwi_WwbWwp);
            figure(hWwi_WwbWwp)
            xlabel('_{10}log max weight, W_w^\infty, g')
            ylabel('_{10}log weight at birth, puberty, W_w^b, W_w^p, g')
            print -r300 -dpng Wwi_WwbWwp.png
            
            hWwi_sHbp = shstat({'Ww_i','s_Hbp'}, legend); % Fig 4b
            figure(hWwi_sHbp)
            plot([0 7.5],[0 -4.5], 'k', 'LineWidth', 2) % slope -0.6
            xlim([-0.5 8]); ylim([-4.5 0])
            xlabel('_{10}log max weight, W_w^\infty, g')
            ylabel('_{10}log precociality coeff, s_H^{bp}, - ')
            print -r300 -dpng Wwi_sHbp.png
            
        case 16
            shstat_options('x_transform', 'log10');
            shstat_options('y_transform', 'log10');
            
            hpAm_Em = shstat({'p_Am','E_m'}, legend);   % Fig 5a
            figure(hpAm_Em)
            plot([1.2 3.8],1.5+[1.2 3.8], 'k', 'LineWidth', 3)
            xlabel('_{10}log spec max assim rate, \{p_{Am}\}, J/d.cm^2')
            ylabel('_{10}log reserve capacity, [E_m], J/cm^3')
            print -r300 -dpng pAm_Em.png
            
            hWwi_Em = shstat({'Ww_i','E_m'}, legend); % Fig 5b
            figure(hWwi_Em)
            %plot([0.25 2.25],[3.25 5.25], 'k', 'LineWidth', 3)
            xlabel('_{10}log max weight, W_w^\infty, g')
            ylabel('_{10}log reserve capacity, [E_m], J/cm^3')
            print -r300 -dpng Wwi_Em.png
            
            hpM_Em = shstat({'p_M','E_m'}, legend); % Fig 5c
            figure(hpM_Em)
            %plot([0.25 2.25],[3.25 5.25], 'k', 'LineWidth', 3)
            xlabel('_{10}log spec somatic maint, [p_M], J/d.cm^3')
            ylabel('_{10}log reserve capacity, [E_m], J/cm^3')
            print -r300 -dpng pM_Em.png            
               
                      
            hsHbp_Em = shstat({'s_Hbp', 'E_m'}, legend); % Fig 5d
            figure(hsHbp_Em)
            %plot([3.25 5.25],[-0.25 -3.25], 'k', 'LineWidth', 3)
            xlabel('_{10}log precociality coeff, s_H^{bp}, - ')
            ylabel('_{10}log reserve capacity, [E_m], J/cm^3')
            print -r300 -dpng sHbp_Em.png                   
            
        case 18 %Fig 7
            legend_Wwb = { ...
                {'.', 8, 3, [0 0.6 0.3], [0 0.6 0.3]}, 'Amphibia'
                {'.', 8, 3, [0 0 1], [0 0 0]}, 'Reptilia'
                {'.', 8, 3, [0.9290, 0.6940, 0.1250], [0.9290, 0.6940, 0.1250]}, 'Aves'
                {'.', 8, 3, [1 0.2 0.2], [1 0.2 0.2]}, 'Placentalia'
                };
            
            [hWwi_Wwb, Hleg] = shstat({'Ww_i', 'Ww_b'}, legend_Wwb);
            figure(hWwi_Wwb)
            plot([-0.25 4.5],[-0.25 4.5]*0.5 - 2.5, 'k', 'LineWidth', 1); % slope 0.5 - amphibia
            plot([-0.25 8],[-1.2 3.6], 'k', 'LineWidth', 2); % slope 0.5818
            plot([-0.25 5.5],[-0.25 5.5]*0.8 - 0.8, 'yellow', 'LineWidth', 1); % slope 0.8 - birds
            plot([-0.25 8],[-0.25 8]*0.946 - 0.8, 'k', 'LineWidth', 1); % slope 0.946 - mammals
            xlim([-0.5 8.5]); ylim([-4 7]);
            xlabel('_{10}log max weight, W_w^\infty, g')
            ylabel('_{10}log weight at birth, W_w^b, g')
            
            figure(Hleg)
            print -r300 -dpng leg_amph_rept_aves_plac.png
            
        
        case 19
            shstat_options('x_transform', 'log10');
            shstat_options('y_transform', 'none');
            Wwi_ss = shstat({'Ww_i', 's_s'}, legend); %Fig A1a
            figure(Wwi_ss)
            %      xlim([2 7]); ylim([2 7]);
            xlabel('_{10}log ultimate weight, W_w^\infty, g')
            ylabel('supply stress, s_s, -')
            print -r300 -dpng Wi_ss2.png
            
            %----- change axis transformation
            shstat_options('y_transform', 'log10');
            Wwi_ss = shstat({'Ww_i', 's_s'}, legend); % Fig A1b
            figure(Wwi_ss)
            %      xlim([2 7]); ylim([2 7]);
            xlabel('_{10}log ultimate weight, W_w^\infty, g')
            ylabel('_{10}log supply stress, s_s, -')
            print -r300 -dpng Wi_ss.png
        
        case 20
            shstat_options('x_transform', 'log10');
            shstat_options('y_transform', 'log10');
            
            hpAm_v = shstat({'p_Am','p_M'}, legend); % Fig A2a
            figure(hpAm_v)
            %plot([1.2 3.8],[1.2 3.8], 'k', 'LineWidth', 3)
            xlabel('_{10}log spec max assim rate, \{p_{Am}\}, J/d.cm^2')
            ylabel('_{10}log spec somatic maint, [p_M], J/d.cm^3')
            print -r300 -dpng pAm_pM.png
            plot([1.2 3.8], 0.67*[1.2 3.8], 'k', 'LineWidth', 3) %slope 2/3
            print -r300 -dpng pAm_pMslope.png
            
            hWwi_v = shstat({'Ww_i','v'}, legend); % Fig A2b
            figure(hWwi_v)
            xlabel('_{10}log ultimate wet weight, W_w^\infty, g')
            ylabel('_{10}log energy conductance, v, cm/d')
            print -r300 -dpng Wwi_v.png
            
        case 21
            shstat_options('x_transform', 'log10');
            shstat_options('y_transform', 'log10');
            
            hspAm_Hbp = shstat({'p_Am','s_Hbp'}, legend); % Fig A3a
            figure(hspAm_Hbp)
            xlim([1 4]); ylim([-4.5 0])
            xlabel('_{10}log spec assim rate, \{p_{Am}\}, J/d.cm^2')
            ylabel('_{10}log precociality coeff, s_H^{bp}, - ')
            print -r300 -dpng pAm_sHbp.png
            
           %----- change axis transformation 
            shstat_options('x_transform', 'none');
            hkap_sHbp = shstat({'kap','s_Hbp'}, legend); % FIg A3b
            figure(hkap_sHbp)
            %plot([3.25 5.25],[-0.25 -3.25], 'k', 'LineWidth', 3)
            xlabel('allocation fraction to soma, \kappa, -')
            ylabel('_{10}log precociality coeff, s_H^{bp}, - ')
            print -r300 -dpng kap_sHbp.png
                        
        case 50 % not used (survivor function)
            shstat_options('x_transform', 'log10');
            NWbWi = read_allStat({'N_i','Ww_b','Ww_i'});
            hs_M = shstat(NWbWi(:,1).*NWbWi(:,2)./NWbWi(:,3), llegend);
            figure(hs_M)
            xlabel('_{10}log total neonate mass prod/ ultimate weight, -')
            print -r300 -dpng WRWi.png
            
        case 51 % not used (E_m vs v)  
            shstat_options('x_transform', 'log10');
            shstat_options('y_transform', 'log10');
            
            hEm_v = shstat({'E_m','v'}, legend); % not used
            figure(hEm_v)
            xlabel('_{10}log reserve capacity, [E_m], J/cm^3')
            ylabel('_{10}log energy conductance, v, cm/d')
            print -r300 -dpng Em_v.png
                        
         case 52  % not used (kappa vs...)
            shstat_options('x_transform', 'none');
            shstat_options('y_transform', 'log10');
            kRc = read_allStat({'kap','R_i','c_T'});
            hkap_R = shstat([kRc(:,1), kRc(:,2)./kRc(:,3)], legend);
            figure(hkap_R)
            xlabel('allocation fraction to soma, \kappa, -')
            ylabel('_{10}log max reprod rate, #/d')
            print -r300 -dpng kap_R.png
            
            kNWWa = read_allStat({'kap', 'R_i', 'Ww_b', 'Ww_i', 'c_T'});
            kap = kNWWa(:,1); RWW = kNWWa(:,2) .* kNWWa(:,3) ./ kNWWa(:,4) ./ kNWWa(:,5);
            hkap_RWW = shstat([kap, RWW], legend);
            figure(hkap_RWW)
            xlabel('allocation fraction to soma, \kappa, -')
            ylabel('_{10}log spec neonate mass prod rate, 1/d')
            print -r300 -dpng kap_RWW.png
        
        case 53 % not used (growth rates)
            shstat_options('x_transform', 'log10');
            shstat_options('y_transform', 'log10');
            WdW = read_allStat({'W_dWm','dWm','c_T'}); WdW = WdW(:,2) ./ WdW(:,1) ./ WdW(:,3);
            r = read_popStat('f1.thin1.f.r') ./ read_popStat('c_T');
            
            hWdW_r = shstat([WdW, r], legend);
            figure(hWdW_r)
            plot([-2 -4.5], [-2 -4.5], 'k', 'LineWidth', 2)
            xlabel('_{10}log max spec growth, r_m, g/d.g')
            ylabel('_{10}log max spec pop growth, r_N, 1/d')
            print -r300 -dpng WdW_r.png        
            
         case 54 % not used (p_Am vs...)
            shstat_options('x_transform', 'log10');
            shstat_options('y_transform', 'log10');
            
            hpAm_v = shstat({'p_Am','v'}, legend);  % not used
            figure(hpAm_v)
            %plot([1.2 3.8],1.5+[1.2 3.8], 'k', 'LineWidth', 3)
            xlabel('_{10}log spec max assim rate, \{p_{Am}\}, J/d.cm^2')
            ylabel('_{10}log energy conductance, v, cm/d')
            print -r300 -dpng pAm_v.png
            
            pAm_ss = shstat({'p_Am', 's_s'}, legend);    % not used
            figure(pAm_ss)
            xlabel('_{10}log \{p_{Am}\}, J/d.cm^2')
            ylabel('_{10}supply stress, s_s, -')
            print -r300 -dpng pAm_ss.png
            
        case 55 % not used (wet weights vs...)
            shstat_options('x_transform', 'log10');
            shstat_options('y_transform', 'log10');
            
            hWwb_Em = shstat({'Ww_b','E_m'}, legend);  % not used
            figure(hWwb_Em)
            %plot([0.25 2.25],[3.25 5.25], 'k', 'LineWidth', 3)
            xlabel('_{10}log weight at birth, W_w^b, g')
            ylabel('_{10}log reserve capacity, [E_m], J/cm^3')
            print -r300 -dpng Wwb_Em.png
            
              Wabp = read_allStat({'Ww_i','a_b','a_p','c_T'}); % not used
            hWwi_abap = shstat([Wabp(:,1), Wabp(:,3) .* Wabp(:,4)], legend);
            shstat([Wabp(:,1), Wabp(:,2) .* Wabp(:,4)], legend, [], hWwi_abap);
            figure(hWwi_abap)
            %plot([3.25 5.25],[-0.25 -3.25], 'k', 'LineWidth', 3)
            xlabel('_{10}log max weight, W_w^\infty, g')
            ylabel('_{10}log age at birth, puberty, a_b, a_p, d')
            print -r300 -dpng Wwi_abap.png
            
            WdW = read_allStat({'W_dWm','dWm','Ww_i','c_T'}); % not used
            WdW = [WdW(:,3), WdW(:,2) ./ WdW(:,1) ./ WdW(:,4)];
            hWwi_rm = shstat(WdW, legend);
            figure(hWwi_rm)
            xlabel('_{10}log max weight, W_w^\infty, g')
            ylabel('_{10}log max spec growth rate, 1/d')
            print -r300 -dpng Wwi_rm.png
            
            WwiE0 = read_allStat({'Ww_i', 'E_0'}); % not used
            hWwi_E0 = shstat(WwiE0, legend);
            figure(hWwi_E0)
            xlim([-0.25 7.6]); ylim([-0.4 8]);
            xlabel('_{10}log W_w^\infty, g')
            ylabel('_{10}log egg size, E_0, J')
            print -r300 -dpng Wwi_E0.png
            plot([-1; 8], [2.42; 7.64], 'k', 'LineWidth', 3) % slope 0.58 (y = 0.58 *x + 3)
            print -r300 -dpng Wwi_E0slope.png
            
            %----- change axis transformation
            shstat_options('x_transform', 'log10');
            shstat_options('y_transform', 'none');
            
            hWwi_kap = shstat({'Ww_i', 'kap'}, legend); % not used
            figure(hWwi_kap)
            %plot([3.25 5.25],[-0.25 -3.25], 'k', 'LineWidth', 3)
            xlabel('_{10}log max weight, W_w^\infty, g')
            ylabel('_{10}log allocation fraction to soma, \kappa, -')
            print -r300 -dpng Wwi_kap.png
            
        case 56 % not used (precociality coeff vs..)
            shstat_options('x_transform', 'log10');
            shstat_options('y_transform', 'log10');
            
             hsHbp_Em_RSED = shstat({'s_Hbp', 'E_m'}, legend_RSED);  %not used
            figure(hsHbp_Em_RSED)
            %plot([3.25 5.25],[-0.25 -3.25], 'k', 'LineWidth', 3)
            xlabel('_{10}log precociality coeff, s_H^{bp}, - ')
            ylabel('_{10}log reserve capacity, [E_m], J/cm^3')
            %print -r300 -dpng sHbp_Em_RSED.png
            
            hsHbp_Em_Lepido = shstat({'s_Hbp', 'E_m'}, legend(5:9,:));  %not used
            figure(hsHbp_Em_Lepido)
            %plot([3.25 5.25],[-0.25 -3.25], 'k', 'LineWidth', 3)
            xlabel('_{10}log precociality coeff, s_H^{bp}, - ')
            ylabel('_{10}log reserve capacity, [E_m], J/cm^3')
            %print -r300 -dpng sHbp_Em_Lepido.png
            
             hsHbp_pM = shstat({'s_Hbp', 'p_M'}, legend); %not used
            figure(hsHbp_pM)
            %plot([3.25 5.25],[-0.25 -3.25], 'k', 'LineWidth', 3)
            xlabel('_{10}log precociality coeff, s_H^{bp}, - ')
            ylabel('_{10}log spec somatic maint, [p_M], J/d.cm^3')
            print -r300 -dpng sHbp_pM.png
            
            hsHbp_pAm = shstat({'s_Hbp', 'p_Am'}, legend); % not used
            figure(hsHbp_pAm)
            xlim([-4.5 0]); ylim([1 4])
            xlabel('_{10}log precociality coeff, s_H^{bp}, - ')
            ylabel('_{10}log spec assim rate, \{p_{Am}\}, J/d.cm^2')
            print -r300 -dpng sHbp_pAm.png
            plot([-5 0],[4.15 1.25], 'k', 'LineWidth', 3) % slope -0.58
            print -r300 -dpng sHbp_pAm-slope.png
            
            hsHbp_v = shstat({'s_Hbp', 'v'}, legend); % not used
            figure(hsHbp_v)
            %plot([3.25 5.25],[-0.25 -3.25], 'k', 'LineWidth', 3)
            xlabel('_{10}log precociality coeff, s_H^{bp}, - ')
            ylabel('_{10}log energy conductance, v, cm/d')
            print -r300 -dpng sHbp_v.png
            
            
        case 57 % not used (... vs precociality coeff)
            shstat_options('x_transform', 'log10');
            shstat_options('y_transform', 'log10');
            
            hv_sHbp = shstat({'v','s_Hbp'}, legend);
            figure(hv_sHbp)
            xlabel('_{10}log energy conductance, v, cm/d')
            ylabel('_{10}log precociality coeff, s_H^{bp}, -')
            print -r300 -dpng v_sHbp.png
            
            hLi_sHbp = shstat({'L_i','s_Hbp'}, legend); %not used
            figure(hLi_sHbp)    
            plot([-0.25 2.25],[0 -4.5], 'k', 'LineWidth', 2)
            xlim([-0.25 2.25]); ylim([-4.5 0])
            xlabel('_{10}log max structural length, L_\infty, cm')
            ylabel('_{10}log precociality coeff, s_H^{bp}, - ')
            print -r300 -dpng Li_sHbp.png
            
            WbWp_s = read_allStat({'Ww_b','Ww_p','s_Hbp'}); % not used
            WbWp_s = [WbWp_s(:,1)./WbWp_s(:,2), WbWp_s(:,3)];
            hWbWp_s = shstat(WbWp_s, legend);
            figure(hWbWp_s)
            %plot([0 7.5],[0 -4.5], 'k', 'LineWidth', 2)
            %xlim([-0.5 8]); ylim([-4.5 0])
            xlabel('_{10}log W_w^b/ W_w^p, -')
            ylabel('_{10}log precociality coeff, s_H^{bp}, - ')
            print -r300 -dpng WbWp_s.png
            
            hWbWp_s_RSED = shstat(WbWp_s, legend_RSED);  %not used
            figure(hWbWp_s_RSED)
            %plot([0 7.5],[0 -4.5], 'k', 'LineWidth', 2)
            %xlim([-0.5 8]); ylim([-4.5 0])
            xlabel('_{10}log W_w^b/ W_w^p, -')
            ylabel('_{10}log precociality coeff, s_H^{bp}, - ')
            print -r300 -dpng WbWp_s_RSED.png
            
            hWwi_sHbp = shstat({'Ww_i','s_Hbp'}, legend);  % not used
            figure(hWwi_sHbp)
            xlabel('_{10}log ultimate wet weight, W_w^\infty, g')
            ylabel('_{10}log precociality coeff, s_H^{bp}, - ')
            print -r300 -dpng Wwi_sHbp.png
            
        case 58 % (respiration and ult.weight vs neonate prod)
            shstat_options('x_transform', 'log10');
            shstat_options('y_transform', 'log10');
            
            WWRJ = read_allStat({'Ww_b', 'Ww_i', 'R_i', 'J_Oi', 'N_i' , 'c_T'});
            Wwi = WWRJ(:,2); JR = WWRJ(:,3) .* WWRJ(:,1) ./ WWRJ(:,6); JO = WWRJ(:,4) ./ WWRJ(:,6);
            
            hJO_JR = shstat([JO, JR], legend);    %not used
            figure(hJO_JR)
            plot([-5 3], [-4 4], 'k', 'linewidth', 2)
            xlim([-5 3]); ylim([-4 4]);
            xlabel('_{10}log max respiration rate, mol/d')
            ylabel('_{10}log max neonate mass prod, g/d')
            print -r300 -dpng JO_JR.png
            
            NWb = WWRJ(:,5) .* WWRJ(:,1); % not used
            hWi_NWb = shstat([Wwi, NWb], legend);
            figure(hWi_NWb)
            plot([-1; 8], [-1; 8], 'k', 'linewidth', 2)
            xlim([-1 8]); ylim([-1 8]);
            xlabel('_{10}log max weight, g')
            ylabel('_{10}log cum neonate mass prod, g')
            print -r300 -dpng Wwi_NWb.png
            
        case 59 % (lengths)
            shstat_options('x_transform', 'log10');
            shstat_options('y_transform', 'log10');
            
            hLi_lb = shstat({'L_i', 'l_b'}, legend); % not used
            shstat({'L_i', 'l_p'}, legend,[], hLi_lb);
            figure(hLi_lb)
            %plot([3.25 5.25],[-0.25 -3.25], 'k', 'LineWidth', 3)
            xlabel('_{10}log max structural length, L_m, cm ')
            ylabel('_{10}log scaled struc length, l_b, l_p, -')
            print -r300 -dpng Li_lblp.png
            
            hLi_Lb = shstat({'L_i', 'L_b'}, legend); % not used
            shstat({'L_i', 'L_p'}, legend,[], hLi_Lb);
            figure(hLi_Lb)
            %plot([3.25 5.25],[-0.25 -3.25], 'k', 'LineWidth', 3)
            xlabel('_{10}log max structural length, L_m, cm ')
            ylabel('_{10}log struc length at birth, puberty, L_b, L_p, cm')
            print -r300 -dpng Li_LbLp.png
    end
    
end
end

function sel = STRcmp(array,txt)
n = length(array); sel = false(n,1);
for i=1:n
    sel(i) = strcmp(array{i},txt);
end
end