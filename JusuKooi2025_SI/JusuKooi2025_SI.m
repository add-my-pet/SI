function JusuKooi2025_SI(fig)
% Supporting Information for JusuKooi2024
% Title: On the direct and indirect costs of reproduction
% Authors: Jusup, Kooijman and others
% Journal: Science
% DOI: 
% Date: 2024/06/27 | modified 2025/02/07 (RL, NM, DL)
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
%  The figures show current AmP data, which might change in time; the results might differ from the publication.
%  The scripts call functions read_popStat and read_allStat; the first call to these functions loads the .mat file, which can take some time.
%  Click on a marker in the Matlab-figure to see the species name.
%  Uncomment "%print" to save the Matlab-figure to a png-file.
%  Modify selection of taxa and markers by changing the legend, see https://add-my-pet.github.io/AmPtool/docs/index.html.
%  Allowed names of taxa match the names of the tree nodes at http://www.bio.vu.nl/thb/deb/deblab/add_my_pet/species_tree_Animalia.html.

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
      E_0 = vars(:,1); kap_R = vars(:,2); L_b = vars(:,3); E_m = vars(:,4); mu_V = vars(:,5); M_V = vars(:,6);
%       kap_R = 0.95 + 0 * kap_R; % remove simultaneous hermaphrodite allocation
      
      effR = kap_R .* L_b.^3 .* (M_V .* mu_V + E_m) ./ E_0; % total reproduction efficiency
      heffR = shstat(effR, llegend, 'Mollusca & Squamata & Aves & Placentalia');
      figure(heffR)
      xlabel('total reproduction efficiency, -')
%       print -r0 -dpng effR.png
      
    case 2 % Fig 2
      vars = read_allStat({'E_0','kap_R','L_b','E_m','mu_V','M_V'});
      E_0 = vars(:,1); kap_R = vars(:,2); L_b = vars(:,3); E_m = vars(:,4); mu_V = vars(:,5); M_V = vars(:,6);
      effR = kap_R .* L_b.^3 .* (M_V .* mu_V + E_m) ./ E_0; % total reproduction efficiency
      
      vars = read_allStat({'Ww_i','Ww_b','N_i'});
      Ww_i = vars(:,1); Ww_b = vars(:,2); N_i = vars(:,3);
      nR = Ww_b .* N_i ./ Ww_i; % spec cum reprod mass prod
      
      shstat_options('x_transform', 'log10');
      hnR = shstat([nR effR], legend, 'Mollusca & Aves & Placentalia');
      figure(hnR)
      xlabel('_{10}log spec cum reprod mass prod, -')
      ylabel('total reproduction efficiency, -')
%       print -r0 -dpng nR_effR_Mol_Ave_Pla.png
      
    case 3 % Fig 3
      pars = read_stat('Ovis_aries', {'kap','kap_R','g','k_J','k_M','L_T','v','U_Hb','U_Hp'});
      vars = read_stat('Ovis_aries', {'L_m','c_T','l_b','l_p','t_g','t_0','p_Am','ome'});
      L_m = vars(1); c_T = vars(2); l_b = vars(3); l_p = vars(4); t_g = vars(5);
      t_0 = vars(6); p_Am = vars(7); ome = vars(8); v = pars(7);
      
      L = (50000 / (1 + ome))^(1/3); % cm, structural length of a 50 kg ewe
      pACSJGRD = c_T * p_Am * L_m^2 * scaled_power(L, 1, pars, l_b, l_p);
      p_Di_ref = pACSJGRD(7); % J/d, dissipation for a 50 kg ewe
      p_Di_ref = p_Di_ref / 24; % J/h, dissipation for a 50 kg ewe according to AmP, for an ewe with Wwi = 86 kg
      
      a = linspace(1e-3, t_g, 100)';
      L = c_T * v * a / 3;
      t = [1e-4; t_0 + a];
      L = [0; L];
      pACSJGRD = c_T * p_Am * L_m^2 * scaled_power(L, 1, pars, l_b, l_p);
      p_De = pACSJGRD(:,7); % J/d, dissipation for foetus
      t = t * 24; % convert d to h
      p_De = p_De / 24; % convert J/d to J/h
      
      % data from BrocMcDo1963 for a 50 kg ewe
      tpD = [ ... % time since copulation (d), heat of 50 kg ewe plus foetus (kcal/d)
         0.000	1704.565
        20.276	1676.306
        40.420	1757.429
        61.249	1588.653
        80.593	1627.990
       100.753	1750.782
       120.758	2144.384
       130.774	2375.041
       136.559	2474.860
       140.765	2543.195
       142.030	3105.883
       146.634	2856.568
       152.632	2831.419
       161.754	2780.693
       171.684	2792.587
       181.877	2809.729
       192.354	2884.205];
      tpD(:,1) = tpD(:,1) * 24; % convert d to h
      tpD(:,2) = tpD(:,2) * 4184 / 24; % convert kcal/d to J/h
      p_Di = tpD(1,2); % J/h
      
      % report about the ewe
      fprintf('heat prod of a 50 kg ewe (AmP; Wwi = 86 kg): %g MJ/h\n', p_Di_ref / 1e6)
      fprintf('heat prod of a 50 kg ewe (BrocMcDo1963): %g MJ/h\n\n', p_Di / 1e6)
      %
      ip_b_DEB = ispline1([0; (t_0 + t_g) * 24], [t, p_De]);
      fprintf('integr heat diff over gestation (DEB): %g MJ\n', ip_b_DEB(2) / 1e6)
      %
      ip_b_DEB = ispline1([0; (t_0 + t_g) * 24], [t, p_De * p_Di / p_Di_ref]);
      fprintf('integr heat diff over gestation (corr DEB): %g MJ\n', ip_b_DEB(2) / 1e6)
      %
      tp = tpD;
      tp(:,2) = tp(:,2) - tp(1,2);
      ip_b_BrocMcDo1963 = ispline1([0; 24 * 140], tp);
      fprintf('integr heat diff over gestation (BrocMcDo1963 data): %g MJ\n', ip_b_BrocMcDo1963(2) / 1e6)
      %
      ip_b_GintCame2024 = (4.3e5 - 2.9e5) * 24 * 140 / 2;
      fprintf('integr heat diff over gestation (GintCame2024): %g MJ\n', ip_b_GintCame2024 / 1e6)
      
      figure
      hold on
      t_b = 140 * 24;
      plot([t_b; t_b], [p_Di; 4.5e5], 'y', 'linewidth', 4) % line for birth
      plot(t, p_Di + p_De * 0, 'k', 'linewidth', 2) % baseline
      plot(tpD(:,1), tpD(:,2), '.b', 'Markersize', 15) % BrocMcDo1963 data points
      plot(tpD(:,1), tpD(:,2), 'b', 'linewidth', 2) % BrocMcDo1963 data points connections
      plot([0; 24 * 140], [2.9e5; 4.3e5], 'm', 'linewidth', 2) % GintCame2024 "data"
      plot(t, p_Di + p_De, 'r', 'linewidth', 2) % DEB predictions based on AmP pars
      plot(t, p_Di + p_De * p_Di / p_Di_ref, ':r', 'linewidth', 2) % DEB predictions based on AmP pars
      xlabel('time since start of foetal development, h')
      ylabel('heat of foetus + mother, J/h')
%       print -r0 -dpng t_pD_Ovis.png
      
    case 4
      % Epaulette shark: Hemiscyllium_ocellatum (ovipar.)
      % Whale shark: Rhincodon_typus (ovovivipar.)
      % Nurse shark: Ginglymostoma_cirratum (vivipar.)
      species = {'Hemiscyllium_ocellatum', 'Rhincodon_typus', 'Ginglymostoma_cirratum'};
      for j = 1:length(species)
         pars = read_stat(species(j), {'kap','kap_R','g','k_J','k_M','L_T','v','U_Hb','U_Hp','E_0'});   
         vars = read_stat(species(j), {'L_m','c_T','l_b','l_p','a_b','t_g','t_0','p_Am'});
         L_m = vars(1); c_T = vars(2); l_b = vars(3); l_p = vars(4); t_b = vars(5);
         t_g = vars(6); t_0 = vars(7); p_Am = vars(8); v = pars(7); E_0 = pars(10);
         
         if isnan(t_0); t_0 = 0; end
         if isnan(t_g); t_sim = t_b; else; t_sim = t_g; end
         
         pACSJGRD = c_T * p_Am * L_m^2 * scaled_power(L_m, 1, pars, l_b, l_p);
         p_Di_ref = pACSJGRD(7); % J/d, dissipation for a max sized shark
         p_Di_ref = p_Di_ref / 24; % J/h, dissipation for a max sized shark according to AmP
         
         a = linspace(1e-3, t_sim, 100)';
         L = c_T * v * a / 3;
         t = [1e-4; t_0 + a];
         L = [0; L];
         pACSJGRD = c_T * p_Am * L_m^2 * scaled_power(L, 1, pars, l_b, l_p);
         p_De = pACSJGRD(:,7); % J/d, dissipation for foetus
         t = t * 24; % convert d to h
         p_De = p_De / 24; % convert J/d to J/h
         
         % report about the shark
         fprintf([char(species(j)) ':\n'])
         fprintf('  heat production at L_m: %g kJ/h\n', p_Di_ref / 1e3)
         %
         ip_b_DEB = ispline1([0; t_sim * 24], [t, p_De]);
         fprintf('  integr heat diff over gestation: %g kJ\n', ip_b_DEB(2) / 1e3)
         %
         fprintf('  direct cost of an egg (E_0): %g kJ\n', E_0 / 1e3)
      end
  
  end
 end

end
