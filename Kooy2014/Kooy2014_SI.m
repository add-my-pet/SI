function Kooy2014_SI(figi)
% Supporting Information for Kooy2014
% Title:  Metabolic acceleration in animal ontogeny: An evolutionary perspective
% Authors: Kooijman
% Journal: Journal of Sea Research 94 (2014) 128–137
% DOI: 10.1016/j.seares.2014.06.005
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
% To run the code (here for section 3), open this file in the Matlab Editor and type in the Matlab window: Kooy2014_SI(3)
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
    figi = 1:19;
  end

  for i=1:length(figi)
 
    switch figi(i)
      case 1 % fig 1a,1b: a-Wd, a-JO for P. bibronii
        web('https://www.bio.vu.nl/thb/deb/deblab/add_my_pet/entries_web/Pseudophryne_bibronii/Pseudophryne_bibronii_res.html', '-browser')
        
      case 2 % fig 1a,1b: a-Wd, a-JO for C. georgiana
        web('https://www.bio.vu.nl/thb/deb/deblab/add_my_pet/entries_web/Crinia_georgiana/Crinia_georgiana_res.html', '-browser')
        
      case 3 % fig 2: t-L for Perca fluviatilis
        web('https://www.bio.vu.nl/thb/deb/deblab/add_my_pet/entries_web/Perca_fluviatilis/Perca_fluviatilis_res.html', '-browser')
        
      case 4 % fig 3: t-L for Doryteuthis pealei
        web('https://www.bio.vu.nl/thb/deb/deblab/add_my_pet/entries_web/Doryteuthis_pealeii/Doryteuthis_pealeii_res.html', '-browser')
        % notice the better fit in the paper. The fit on the site also depends on additional data, which is slightly inconsistent.
        
      case 5 % fig 4: t-Ww for Mirounga leonina
        web('https://www.bio.vu.nl/thb/deb/deblab/add_my_pet/entries_web/Mirounga_leonina/Mirounga_leonina_res.html', '-browser')
        
      case 6 % fig 5: t-Wd for Acyrthosiphon pisum
        web('https://www.bio.vu.nl/thb/deb/deblab/add_my_pet/entries_web/Acyrthosiphon_pisum/Acyrthosiphon_pisum_res.html', '-browser')
        
      case 7 % fig 6: type M acceleration in animal taxa
        web('https://www.bio.vu.nl/thb/deb/deblab/add_my_pet/phyla.html', '-browser')
        
      case 8 % fig 7: s_M-E_Hb/Li^3 for RSED 
        shstat_options('default');
        sMEHbLi = read_allStat({'s_M','E_Hb','L_i'}); sMEHb = [sMEHbLi(:,1), sMEHbLi(:,2)./sMEHbLi(:,3).^3];
        [HfigsM_EHb HlegsM_EHb] = shstat(sMEHb, legend_RSED, title); % set title, output handle for adding items
    
        figure(HfigsM_EHb) % add items to figure
        xlabel('acceleration factor, _{10}log s_M, -');
        ylabel('spec maturity at birth, _{10}log E_H^b/L_{\infty}^3, J/cm^3');
        %saveas(gca,'sM_EHb.png')
        
      case 9 % fig 8a: Li-v for RSED 
        shstat_options('default');
        LivsM = read_allStat({'L_i','v','s_M'});
        [HfigLiv, HlegLiv] = shstat({'L_i', 'v'}, legend_RSED); 
        HfigLiv = shstat([LivsM(:,1), LivsM(:,2).*LivsM(:,3)], legend_RSED, title, HfigLiv);
        
        figure(HfigLiv)
        sel = select_01('Actinopterygii') & LivsM(:,3) > 0;
        data = log10([LivsM(sel,[1 2 1]), LivsM(sel,2) .* LivsM(sel,3)]);
        for j=1:size(data,1); plot(data(j,[1 3]), data(j,[2 4]), '-k', 'linewidth',2); end
        xlabel('ultimate structural length, _{10}log L_{\infty}, cm')
        ylabel('energy conductance, _{10}log v, cm/d')
        %print -r0 -dpng Li_v.png
        figure(HlegLiv)
        %print -r0 -dpng legend_RSED.png
        
      case 10 % fig 8b: Li-EHb for RSED 
        shstat_options('default');
        [HfigLiEHb, HlegLiEHb] = shstat({'L_i', 'E_Hb'}, legend_RSED, title); 
        
        figure(HfigLiEHb)
        xlabel('ultimate structural length, _{10}log L_{\infty}, cm')
        ylabel('maturity at birth, _{10}log E_H^b, J')
        %print -r0 -dpng Li_EHb.png
        figure(HlegLiEHb)
        %print -r0 -dpng legend_RSED.png
        
      case 11 % fig 8c: Li-EHj for RSED 
        shstat_options('default');
        [HfigLiEHj, HlegLiEHj] = shstat({'L_i', 'E_Hj'}, legend_RSED, title); 
        
        figure(HfigLiEHj)
        xlabel('ultimate structural length, _{10}log L_{\infty}, cm')
        ylabel('maturity at metam, _{10}log E_H^j, J')
        %print -r0 -dpng Li_EHj.png
        figure(HlegLiEHj)
        %print -r0 -dpng legend_RSED.png
        
      case 12 % fig 8d: Li-EHp for RSED 
        shstat_options('default');
        [HfigLiEHp, HlegLiEHp] = shstat({'L_i', 'E_Hp'}, legend_RSED, title); 
        
        figure(HfigLiEHp)
        xlabel('ultimate structural length, _{10}log L_{\infty}, cm')
        ylabel('maturity at puberty, _{10}log E_H^p, J')
        %print -r0 -dpng Li_EHp.png
        figure(HlegLiEHp)
        %print -r0 -dpng legend_RSED.png
        
      case 13 % fig 9a: Li-d/dt Vb for RSED 
        shstat_options('default');
        LbLiLmsMvg = read_allStat({'L_b','L_i','L_m','s_M','v','g'}); 
        L_b = LbLiLmsMvg(:,1); L_i = LbLiLmsMvg(:,2); L_m = LbLiLmsMvg(:,3); 
        s_M = LbLiLmsMvg(:,4); v = LbLiLmsMvg(:,5); g = LbLiLmsMvg(:,6);
        dV_b = L_b.^3 .* v ./ (1 + g) .* (s_M - L_b ./ L_m) ./ L_b; % cm^3/d
        [HfigLidVb, HlegLidVb] = shstat([L_i, dV_b], legend_RSED, title); 
        
        figure(HfigLidVb)
        xlabel('ultimate structural length, _{10}log L_{\infty}, cm')
        ylabel('growth at birth, _{10}log d/dt V(a_b), cm^3/d')
        %print -r0 -dpng Li_dVb.png
        figure(HlegLidVb)
        %print -r0 -dpng legend_RSED.png
        
      case 14 % fig 9b: Li-d/dt Vj for RSED 
        shstat_options('default');
        vars = read_allStat({'L_b','L_j','L_i','L_m','s_M','v','g'}); 
        L_b = vars(:,1); L_j = vars(:,2); L_i = vars(:,3); L_m = vars(:,4); 
        s_M = vars(:,5); v = vars(:,6); g = vars(:,7); L_j(s_M==1) = L_b(s_M==1);
        dV_j = L_j.^3 .* v ./ (1 + g) .* (s_M - L_j ./ L_m) ./ L_j; % cm^3/d
        [HfigLidVj, HlegLidVj] = shstat([L_i, dV_j], legend_RSED, title); 
        
        figure(HfigLidVj)
        xlabel('ultimate structural length, _{10}log L_{\infty}, cm')
        ylabel('growth at metam, _{10}log d/dt V(a_j), cm^3/d')
        %print -r0 -dpng Li_dVj.png
        figure(HlegLidVj)
        %print -r0 -dpng legend_RSED.png
        
      case 15 % fig 9c: Li-d/dt Vp for RSED 
        shstat_options('default');
        LpLiLmsMvg = read_allStat({'L_p','L_i','L_m','s_M','v','g'}); 
        L_p = LpLiLmsMvg(:,1); L_i = LpLiLmsMvg(:,2); L_m = LpLiLmsMvg(:,3); 
        s_M = LpLiLmsMvg(:,4); v = LpLiLmsMvg(:,5); g = LpLiLmsMvg(:,6);
        dV_p = L_p.^3 .* v ./ (1 + g) .* (s_M - L_p ./ L_m) ./ L_p; % cm^3/d
        [HfigLidVp, HlegLidVp] = shstat([L_i, dV_p], legend_RSED, title); 
        
        figure(HfigLidVp)
        xlabel('ultimate structural length, _{10}log L_{\infty}, cm')
        ylabel('growth at puberty, _{10}log d/dt V(a_p), cm^3/d')
        %print -r0 -dpng Li_dVp.png
        figure(HlegLidVp)
        %print -r0 -dpng legend_RSED.png
       
      case 16 % fig 10: t-Ww-T for Uria aalge
        fig('4.28') % fig 4.28d of DEB3; DEBtool_M/fig_3 has all figs of DEB3
        
      case 17 % fig 11a: t-L for embryo Rhizoprionodon acutus
        web('https://www.bio.vu.nl/thb/deb/deblab/add_my_pet/entries_web/Rhizoprionodon_acutus/Rhizoprionodon_acutus_res.html', '-browser')
        
      case 18 % fig 11b: t-L for female/male Rhizoprionodon acutus
        web('https://www.bio.vu.nl/thb/deb/deblab/add_my_pet/entries_web/Rhizoprionodon_acutus/Rhizoprionodon_acutus_res.html', '-browser')
        
      case 19 % fig 11c: L-JO for Ensis directus
        web('https://www.bio.vu.nl/thb/deb/deblab/add_my_pet/entries_web/Ensis_directus/Ensis_directus_res.html', '-browser')
        % notice the better fit in the paper. The fit on the site also depends on additional data, which is slightly inconsistent.
        
      case 20 % 
        shstat_options('default');
        [HfigvsM, HlegvsM] = shstat({'v','s_M','L_m'}, legend_actino, 'Actinopterygii 2023/04/21'); 
        
        figure(HfigvsM)
        xlabel('energy conductance, v, cm/d')
        ylabel('acceleration factor, s_M, -')
        zlabel('max length, L_m, cm')
        
      case 21 % Eupercaria of Lika et al 2014
          sMT = [ ...
          6.7   19.2 % Demersal & Oct–Dec  & Sparus aurata       Sparidae   Eupercaria
          5.3   16.5 % Demersal & Apr–May  & Dentex  dentex      Sparidae   Eupercaria
         22.7   24.0 % Demersal & May–Sep  & Pagellus erythrinus Sparidae   Eupercaria
         10.9   23.9 % Demersal & Sep–Oct  & Diplodus puntazzo   Sparidae   Eupercaria
          7.6   17.1 % Demersal & Mar–May  & Argyrosomus  regius Sciaenidae Eupercaria
          3.7   17.1 % Demersal & Mar–May  & Sciaena umbra       Sciaenidae Eupercaria
          8.2   15.3 % Demersal & Jan–Mar  & Dicentrarchus labrax Moronidae  Eupercaria
        %  5.8   22.6 % Pelagic  & May–Jul  & Seriola  dumerili   Carangidae
        %  5.3   24.3 % Pelagic  & Jun–Jul  & Thunnus  thynnus    Scombridae
          ];
        plot(sMT(:,2), sMT(:,1), '.r', 'markersize', 8)
        xlabel('temp at spawning, C')
        ylabel('acceleration factor, s_M, -')
        
      case 22
          % type, size, linewidth, edge color and face color of a marker, taxon
          legend = {... % Sparidae
            {'o', 8, 3, [0 0 0], [0 0 1]}, 'Boopsinae'; ...
            {'o', 8, 3, [0 0 1], [1 0 1]}, 'Denticinae'; ....
            {'o', 8, 3, [0 0 1], [0 0 1]}, 'Pagellinae'; ....
            {'o', 8, 3, [1 0 0], [0 0 1]}, 'Sparinae'; ....
            {'o', 8, 3, [1 0 0], [1 0 0]}, 'Centracanthinae'; ....
          };
        shstat_options('x_transform','none');
        shstat_options('y_transform','none');
        [HfigTsM, HlegTsM] = shstat({'T_typical','s_M'}, legend, 'Sapridae 2023/04/21'); 

          
    end
  end
end
