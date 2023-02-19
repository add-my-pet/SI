function AuguLika2019a_SI(fig)
% Supporting Information for AuguLika2019a
% Title: Why big-bodied animal species cannot evolve a waste-to-hurry strategy
% Authors: Augustine, Lika, Kooijman
% Journal: J. Sea Res. 143: 18-26
% DOI: 10.1016/j.seares.2018.06.002
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
% To run the code for a figure: type in the Matlab window e.g. AuguLika2019a(2)
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
    fig = 1:30;
  end

        legend_invert = {...
          {'o', 8, 3, [0 0 0], [0 0 0]}, 'Parazoa'; ...
          {'o', 8, 3, [0 0 0], [0 0 1]}, 'Radiata'; ...
          {'o', 8, 3, [0 0 0], [1 0 0]}, 'Xenacoelomorpha'; ...
          {'o', 8, 3, [0 0 1], [0 0 1]}, 'Spiralia'; ...
          {'o', 8, 3, [0 0 1], [1 0 0]}, 'Ecdysozoa'; ....
          {'o', 8, 3, [1 0 0], [0 0 1]}, 'Echinodermata'; ....
          {'o', 8, 3, [1 0 0], [1 0 1]}, 'Cephalochordata'; ....
          {'o', 8, 3, [1 0 0], [1 0 0]}, 'Tunicata'; ....
        };
    
        legend_fish = {...
          {'o', 8, 3, [0 0 0], [0 0 0]}, 'Myxini'; ...
          {'o', 8, 3, [0 0 0], [0 0 1]}, 'Cyclostomata'; ...
          {'o', 8, 3, [0 0 1], [1 0 0]}, 'Chondrichthyes'; ....
          {'o', 8, 3, [0 0 1], [0 0 1]}, 'Actinopterygii'; ....
          {'o', 8, 3, [1 0 0], [0 0 1]}, 'Latimeria'; ....
          {'o', 8, 3, [1 0 0], [1 0 1]}, 'Dipnoi'; ....
          {'o', 8, 3, [1 0 0], [1 0 0]}, 'Amphibia'; ....
        };
    
        legend_sauropsida = {...
          {'o', 8, 3, [0 0 0], [0 0 0]}, 'Lepidosauria'; ...
          {'o', 8, 3, [0 0 1], [0 0 1]}, 'Testudines'; ...
          {'o', 8, 3, [0 0 1], [1 0 0]}, 'Crocodilia'; ...
          {'o', 8, 3, [1 0 1], [0 0 0]}, 'Pterosauria'; ...
          {'o', 8, 3, [1 0 1], [0 0 1]}, 'Saurischia'; ...
          {'o', 8, 3, [1 0 1], [1 0 1]}, 'Ornithischia'; ...
          {'o', 8, 3, [1 0 1], [1 0 0]}, 'Sauropodomorpha'; ....
          {'o', 8, 3, [1 0 0], [0 0 1]}, 'Tyrannosauridae'; ....
          {'o', 8, 3, [1 0 0], [1 0 1]}, 'Archaeopterygidae'; ...
          {'o', 8, 3, [1 0 0], [1 0 0]}, 'Aves'; ....
        };
    
        legend_mam = {...
          {'o', 8, 3, [0 0 0], [0 0 0]}, 'Prototheria'; ...
          {'o', 8, 3, [0 0 0], [0 0 1]}, 'Marsupialia'; ...
          {'o', 8, 3, [0 0 1], [0 0 0]}, 'Xenarthra'; ...
          {'o', 8, 3, [0 0 1], [0 0 1]}, 'Afrotheria'; ....
          {'o', 8, 3, [0 0 1], [1 0 0]}, 'Laurasiatheria'; ....
          {'o', 8, 3, [1 0 1], [0 0 1]}, 'Gliriformes'; ....
          {'o', 8, 3, [1 0 1], [1 0 0]}, 'Scandentia'; ....
          {'o', 8, 3, [1 0 0], [0 0 1]}, 'Dermoptera'; ....
          {'o', 8, 3, [1 0 0], [1 0 0]}, 'Primates'; ....
        };

  close all
  shstat_options('default');
  shstat_options('y_label', 'on'); 
  shstat_options('x_label', 'off'); 
 
  for i=1:length(fig)
    switch fig(i)
      case 1 % fig 1a: log L_i - log [E_m] for invert
        [Hfig1a, Hleg1a] = shstat({'L_i', 'E_m'}, legend_invert, ['Invertebrata ', datestr(datenum(date),'yyyy/mm/dd')]);
        close(Hleg1a); Hleg1a = shlegend(legend_invert, [], [], 'Invertebrata');
        set(gca, 'FontSize', 15, 'Box', 'on')

        figure(Hfig1a) 
        xlabel('_{10}log ultimate structural length L_\infty, cm')      
        ylabel('_{10}log reserve density [E_m], J/cm^3')

        %saveas(Hfig1a, 'logLi_logEm_invert.png')
        %saveas(Hleg1a, 'legend_logLi_logEm_invert.png')

      case 2 % fig 1b: log L_i - log [E_m] for fish & amph
       [Hfig1b, Hleg1b] = shstat({'L_i', 'E_m'}, legend_fish, ['Fish & Amph ', datestr(datenum(date),'yyyy/mm/dd')]);
       close(Hleg1b); Hleg1b = shlegend(legend_fish, [], [], 'Fish & Amph');
  
       figure(Hfig1b) 
       xlabel('_{10}log ultimate structural length L_\infty, cm')      
       ylabel('_{10}log reserve density [E_m], J/cm^3')

       %saveas(Hfig1b, 'logLi_logEm_fish.png')
       %saveas(Hleg1b, 'legend_logLi_logEm_fish.png')


      case 3 % fig 1c: log L_i - log [E_m] for sauropsida
        [Hfig1c, Hleg1c] = shstat({'L_i', 'E_m'}, legend_sauropsida, ['Sauropsida ', datestr(datenum(date),'yyyy/mm/dd')]);
        close(Hleg1c); Hleg1c = shlegend(legend_sauropsida, [], [], 'Sauropsida');
        set(gca, 'FontSize', 15, 'Box', 'on')

        figure(Hfig1c) 
        xlabel('_{10}log ultimate structural length L_\infty, cm')      
        ylabel('_{10}log reserve density [E_m], J/cm^3')

        %saveas(Hfig1c, 'logLi_logEm_sauropsida.png')
        %saveas(Hleg1c, 'legend_logLi_logEm_sauropsida.png')

      case 4 % fig 1d: log L_i - log [E_m] for mammals
        [Hfig1d, Hleg1d] = shstat({'L_i', 'E_m'}, legend_mam, ['Mammals ', datestr(datenum(date),'yyyy/mm/dd')]);
        close(Hleg1d); Hleg1d = shlegend(legend_mam, [], [], 'Mammals');
        set(gca, 'FontSize', 15, 'Box', 'on')

        figure(Hfig1d) 
        xlabel('_{10}log ultimate structural length L_\infty, cm')      
        ylabel('_{10}log reserve density [E_m], J/cm^3')

        %saveas(Hfig1d, 'logLi_logEm_mam.png')
        %saveas(Hleg1d, 'legend_logLi_logEm_mam.png')
        
      case 5 % fig 2a: log10 p_M - log10 p_Am for invert
        pMpAm = read_allStat({'p_M','p_Am','s_M'}); pMpAm = [pMpAm(:,1), prod(pMpAm(:,2:3),2)];

        [Hfig2a, Hleg2a, xy] = shstat(pMpAm, legend_invert, ['Invertebrata ', datestr(datenum(date),'yyyy/mm/dd')], 1);
        close(Hleg2a); Hleg2a = shlegend(legend_invert, [], [], 'Invertebrata');
        set(gca, 'FontSize', 15, 'Box', 'on')

        figure(Hfig2a) 
        %plot([-1; 5], [-1; 4], '-', 'color', [0.9 0.9 0.9], 'Linewidth', 8); 
        sel = (1 == max(select_01({'Parazoa','Radiata','Xenacoelomorpha','Spiralia','Ecdysozoa','Echinodermata','Cephalochordata','Tunicata'}),[],2));
        xy_all = log10(xy(sel,:)); 
        [coeff, score, latent, tsquared, explained, mu] = pca(xy_all); 
        pca_slope_invert = coeff(2,1)/coeff(1,1);
        plot([-1; 5], [mu(2) + pca_slope_invert * (-1 - mu(1)); mu(2) + pca_slope_invert * (5 - mu(1))], '-', 'color', [0.9 0.9 0.9], 'Linewidth', 4);
        xlabel('_{10}log spec somatic maintenance [p_M], J/d.cm^3')      
        ylabel('_{10}log spec assimilation \{p_{Am}\}, J/d.cm^2')

        %saveas(Hfig2a, 'pM_pAm_invert.png')
        %saveas(Hleg2a, 'legend_pM_pAm_invert.png')
        
        fprintf('slope [p_M]-{p_Am} for invert: %3.1f \n', pca_slope_invert)

      case 6 % fig 2b: log10 p_M - log10 p_Am for fish & amphibia
        pMpAm = read_allStat({'p_M','p_Am','s_M'}); pMpAm = [pMpAm(:,1), prod(pMpAm(:,2:3),2)];
        
        [Hfig2b, Hleg2b, xy] = shstat(pMpAm, legend_fish, ['Fish & Amph ', datestr(datenum(date),'yyyy/mm/dd')], 3);
        close(Hleg_fish); Hleg_fish = shlegend(legend_fish, [], [], 'Fish & Amph');
        set(gca, 'FontSize', 15, 'Box', 'on')
           
        figure(Hfig2b) 
        %plot([0; 4], [1; 4.5], '-', 'color', [0.9 0.9 0.9], 'Linewidth', 8);
        sel = (1 == max(select_01({'Myxini','Agnatha','Chondrichthyes','Actinopterygii','Latimeria','Dipnoi','Amphibia'}),[],2));
        xy_all = log10(xy(sel,:)); 
        [coeff, score, latent, tsquared, explained, mu] = pca(xy_all); 
        pca_slope_fish = coeff(2,1)/coeff(1,1);
        plot([0; 4], [mu(2) - mu(1) * pca_slope_fish; mu(2) + pca_slope_fish * (4 - mu(1))], '-', 'color', [0.9 0.9 0.9], 'Linewidth', 4);

        xlabel('_{10}log spec somatic maintenance [p_M], J/d.cm^3')      
        ylabel('_{10}log spec assimilation \{p_{Am}\}, J/d.cm^2')

        %saveas(Hfig2b, 'pM_pAm_fish.png')
        %saveas(Hleg2b, 'legend_pM_pAm_fish.png')
        
        fprintf('slope [p_M]-{p_Am} for fish: %3.1f \n', pca_slope_fish)

      case 7 % fig 2c: log10 p_M - log10 p_Am for sauropsida
        pMpAm = read_allStat({'p_M','p_Am','s_M'}); pMpAm = [pMpAm(:,1), prod(pMpAm(:,2:3),2)];

        [Hfig2c, Hleg2c, xy] = shstat(pMpAm, legend_sauropsida, ['Sauropsida ', datestr(datenum(date),'yyyy/mm/dd')], 5);
        close(Hleg2c); Hleg2c = shlegend(legend_sauropsida, [], [], 'Sauropsida');
        set(gca, 'FontSize', 15, 'Box', 'on')

        figure(Hfig2c) 
        %plot([0; 4], [1.5; 4.5], '-', 'color', [0.9 0.9 0.9], 'Linewidth', 8); 
        sel = select_01('Sauropsida');
        xy = log10(xy(sel,:)); 
        [coeff,score,latent,tsquared,explained,mu] = pca(xy);
        pca_slope_sauropsida = coeff(2,1)/coeff(1,1);
        plot([0; 4], [mu(2) - mu(1) * pca_slope_sauropsida; mu(2) + pca_slope_sauropsida * (4 - mu(1))], '-', 'color', [0.9 0.9 0.9], 'Linewidth', 4);
        xlabel('_{10}log spec somatic maintenance [p_M], J/d.cm^3')      
        ylabel('_{10}log spec assimilation \{p_{Am}\}, J/d.cm^2')

        %saveas(Hfig2c, 'pM_pAm_sauropsida.png')
        %saveas(Hleg2c, 'legend_pM_pAm_sauropsida.png')
        
        fprintf('slope [p_M]-{p_Am} for sauropsida: %3.1f \n', pca_slope_sauropsida)

      case 8 % fig 2d: log10 p_M - log10 p_Am for mammals
        pMpAm = read_allStat({'p_M','p_Am','s_M'}); pMpAm = [pMpAm(:,1), prod(pMpAm(:,2:3),2)];
        
        [Hfig2d, Hleg2d, xy] = shstat(pMpAm, legend_mam, ['Mammalia ', datestr(datenum(date),'yyyy/mm/dd')], 7);
        close(Hleg2d); Hleg2d = shlegend(legend_mam, [], [], 'Mammals');
        set(gca, 'FontSize', 15, 'Box', 'on')

        figure(Hfig2d) 
        %plot([0; 4], [1.5; 4], '-', 'color', [0.9 0.9 0.9], 'Linewidth', 8); 
        sel = select_01('Mammalia');
        xy = log10(xy(sel,:)); 
        [coeff,score,latent,tsquared,explained,mu] = pca(xy);
        pca_slope_mam = coeff(2,1)/coeff(1,1);
        plot([0; 4], [mu(2) - mu(1) * pca_slope_mam; mu(2) + pca_slope_mam * (4 - mu(1))], '-', 'color', [0.9 0.9 0.9], 'Linewidth', 4);
        xlabel('_{10}log spec somatic maintenance [p_M], J/d.cm^3')      
        ylabel('_{10}log spec assimilation \{p_{Am}\}, J/d.cm^2')

        %saveas(Hfig2d, 'pM_pAm_mam.png')
        %saveas(Hleg2d, 'legend_pM_pAm_mam.png')

        fprintf('slope [p_M]-{p_Am} for mammalia:  %3.1f \n', pca_slope_mam)

      case 9 % fig 3a: log10 p_M - log10 v for invertebrates
        pMvsM = read_allStat({'p_M','v','s_M'}); pMvsM = [pMvsM(:,1), prod(pMvsM(:,2:3),2)];

        [Hfig3a, Hleg3a, xy] = shstat(pMvsM, legend_invert, ['Invertebrata ', datestr(datenum(date),'yyyy/mm/dd')]);
        close(Hleg3a); Hleg3a = shlegend(legend_invert, [], [], 'Invertebrata');
        set(gca, 'FontSize', 15, 'Box', 'on')

        figure(Hfig3a)
        sel = (1 == max(select_01({'Parazoa','Radiata','Xenacoelomorpha','Spiralia','Ecdysozoa','Echinodermata','Cephalochordata','Tunicata'}),[],2));
        xy = log10(xy(sel,:));
        [coeff,score,latent,tsquared,explained,mu] = pca(xy);
        pca_slope_invert = coeff(2,1)/coeff(1,1);
        fprintf('pca slope [p_M]-v for inverts %3.1f \n', pca_slope_invert)

        xlabel('_{10}log spec somatic maintenance [p_M], J/d.cm^3')      
        ylabel('_{10}log energy conductance v, cm/d')

        %saveas(Hfig3a, 'pM_v_invert.png')
        %saveas(Hleg3a, 'legend_pM_v_invert.png')

      case 10 % fig 3b: log10 p_M - log10 v for fish & amph
        pMvsM = read_allStat({'p_M','v','s_M'}); pMvsM = [pMvsM(:,1), prod(pMvsM(:,2:3),2)];

        [Hfig3b, Hleg3b, xy] = shstat(pMvsM, legend_fish, ['Fish & Amph ', datestr(datenum(date),'yyyy/mm/dd')]);
        close(Hleg_fish); Hleg_fish = shlegend(legend_fish, [], [], 'Fish & Amph');
        set(gca, 'FontSize', 15, 'Box', 'on')

        figure(Hfig3b)
        sel = (1 == max(select_01({'Myxini','Agnatha','Chondrichthyes','Actinopterygii','Latimeria','Dipnoi','Amphibia'}),[],2));
        xy_all = log10(xy(sel,:));
        [coeff,score,latent,tsquared,explained,mu] = pca(xy_all);
        pca_slope_fish = coeff(2,1)/coeff(1,1);
        fprintf('pca slope [p_M]-v for fish: %3.1f \n', pca_slope_fish)


        sel = (1 == max(select_01({'Myxini','Agnatha','Chondrichthyes','Latimeria','Dipnoi','Amphibia'}),[],2));
        xy_no_actino = log10(xy(sel,:));
        [coeff, score, latent, tsquared, explained, mu] = pca(xy_no_actino);
        pca_slope_no_actino = coeff(2,1)/coeff(1,1);
        fprintf('pca slope [p_M]-v for fish without Actinopteringii: %3.1f \n', pca_slope_no_actino)

        sel = (1 == max(select_01('Actinopterygii'),[],2));
        xy_actino = log10(xy(sel,:));
        [coeff, score, latent, tsquared, explained, mu] = pca(xy_actino);
        pca_slope_actino = coeff(2,1)/coeff(1,1);
        fprintf('pca slope [p_M]-v for Actinopteringii: %3.1f \n', pca_slope_actino)

        xlabel('_{10}log spec somatic maintenance [p_M], J/d.cm^3')      
        ylabel('_{10}log energy conductance v, cm/d')

        %saveas(Hfig3b, 'pM_v_fish.png')
        %saveas(Hleg3b, 'legend_pM_v_fish.png')

      case 11 % fig 3c: log10 p_M - log10 v for sauropsida
        pMvsM = read_allStat({'p_M','v','s_M'}); pMvsM = [pMvsM(:,1), prod(pMvsM(:,2:3),2)];

        [Hfig3c, Hleg3c, xy] = shstat(pMvsM, legend_sauropsida, ['Sauropsida ', datestr(datenum(date),'yyyy/mm/dd')]);
        close(Hleg3c); Hleg3c = shlegend(legend_sauropsida, [], [], 'Sauropsida');
        set(gca, 'FontSize', 15, 'Box', 'on')

        figure(Hfig3c) 
        sel = select_01('Sauropsida'); xy = log10(xy(sel,:));
        [coeff,score,latent,tsquared,explained,mu] = pca(xy);
        pca_slope_sauropsida = coeff(2,1)/coeff(1,1);
        fprintf('pca slope [p_M]-v for Sauropsida: %3.1f \n', pca_slope_sauropsida)

        xlabel('_{10}log spec somatic maintenance [p_M], J/d.cm^3')      
        ylabel('_{10}log energy conductance v, cm/d')

        %saveas(Hfig3c, 'pM_v_sauropsida.png')
        %saveas(Hleg3c, 'legend_pM_v_sauropsida.png')

      case 12 % fig 3d: log10 p_M - log10 v for mammals
        pMvsM = read_allStat({'p_M','v','s_M'}); pMvsM = [pMvsM(:,1), prod(pMvsM(:,2:3),2)];

        [Hfig3d, Hleg3d, xy] = shstat(pMvsM, legend_mam, ['Mammals ', datestr(datenum(date),'yyyy/mm/dd')]);
        close(Hleg_mam); Hleg_mam = shlegend(legend_mam, [], [], 'Mammals');
        set(gca, 'FontSize', 15, 'Box', 'on')
 
        figure(Hfig3d)
        sel = select_01('Mammalia');xy = log10(xy(sel,:));
        [coeff,score,latent,tsquared,explained,mu] = pca(xy);
        pca_slope_mam = coeff(2,1)/coeff(1,1);
        fprintf('pca slope [p_M]-v for mammals: %3.1f \n', pca_slope_mam)

        xlabel('_{10}log spec somatic maintenance [p_M], J/d.cm^3')      
        ylabel('_{10}log energy conductance v, cm/d')

        %saveas(Hfig3d, 'pM_v_mam.png')
        %saveas(Hleg3d, 'legend_pM_v_mam.png')

      case 13 % fig 4a: log10 p_Am - log10 v for invertebrates
        pAmv = read_allStat({'p_Am','v','s_M'}); pAmv = [prod(pAmv(:,[1 3]),2), prod(pAmv(:,2:3),2)];

        [Hfig4a, Hleg4a, xy] = shstat(pAmv, legend_invert, ['Invertebrata ', datestr(datenum(date),'yyyy/mm/dd')]);
        close(Hleg4a); Hleg4a = shlegend(legend_invert, [], [], 'Invertebrata');
        set(gca, 'FontSize', 15, 'Box', 'on')

        figure(Hfig4a) 
        sel = (1 == max(select_01({'Parazoa', 'Radiata', 'Xenacoelomorpha', 'Spiralia', 'Ecdysozoa', 'Echinodermata','Cephalochordata','Tunicata'}),[],2));
        xy = log10(xy(sel,:));
        [coeff,score,latent,tsquared,explained,mu] = pca(xy);
        pca_slope_invert = coeff(2,1)/coeff(1,1);
        fprintf('pca slope {p_Am}-v for inverts %3.1f \n', pca_slope_invert)

        xlabel('_{10}log spec assimilation \{p_{Am}\}, J/d.cm^2')      
        ylabel('_{10}log energy conductance v, cm/d')

        %saveas(Hfig4a, 'pAm_v_invert.png')
        %saveas(Hleg4a, 'legend_pAm_v_invert.png')

      case 14 % fig 4b: log10 p_Am - log10 v for fish & amph
        pAmv = read_allStat({'p_Am','v','s_M'}); pAmv = [prod(pAmv(:,[1 3]),2), prod(pAmv(:,2:3),2)];

        [Hfig4b, Hleg4b, xy] = shstat(pAmv, legend_fish, ['Fish & Amph ', datestr(datenum(date),'yyyy/mm/dd')]);
        close(Hleg4b); Hleg4b = shlegend(legend_fish, [], [], 'Fish & Amph');
        set(gca, 'FontSize', 15, 'Box', 'on')

        figure(Hfig4b) 
        sel = (1 == max(select_01({'Myxini','Agnatha','Chondrichthyes','Actinopterygii','Latimeria','Dipnoi','Amphibia'}),[],2));
        xy_all = log10(xy(sel,:));
        [coeff,score,latent,tsquared,explained,mu] = pca(xy_all);
        pca_slope_fish = coeff(2,1)/coeff(1,1);
        fprintf('pca slope {p_Am}-v for fish %3.1f \n', pca_slope_fish);

        sel = (1 == max(select_01({'Myxini','Agnatha','Chondrichthyes','Latimeria','Dipnoi','Amphibia'}),[],2));
        xy_no_actino = log10(xy(sel,:));
        [coeff, score, latent, tsquared, explained, mu] = pca(xy_no_actino);
        pca_slope_no_actino = coeff(2,1)/coeff(1,1);
        fprintf('pca slope {p_Am}-v for fish without Actinopteringii: %3.1f \n', pca_slope_no_actino)

        xlabel('_{10}log spec assimilation \{p_{Am}\}, J/d.cm^2')      
        ylabel('_{10}log energy conductance v, cm/d')

        %saveas(Hfig4b, 'pAm_v_fish.png')
        %saveas(Hleg4b, 'legend_pAm_v_fish.png')

      case 15 % fig 4c: log10 p_Am - log10 v for sauropsida
        pAmv = read_allStat({'p_Am','v','s_M'}); pAmv = [prod(pAmv(:,[1 3]),2), prod(pAmv(:,2:3),2)];

        [Hfig4c, Hleg4c, xy] = shstat(pAmv, legend_sauropsida, ['Sauropsida ', datestr(datenum(date),'yyyy/mm/dd')]);
        close(Hleg4c); Hleg4c = shlegend(legend_sauropsida, [], [], 'Sauropsida');
        set(gca, 'FontSize', 15, 'Box', 'on')

        figure(Hfig4c) 
        sel = select_01('Sauropsida'); xy_all = log10(xy(sel,:));
        [coeff,score,latent,tsquared,explained,mu] = pca(xy_all);
        pca_slope_sauropsida = coeff(2,1)/coeff(1,1);
        fprintf('pca slope {p_Am}-v for Sauropsida: %3.1f \n', pca_slope_sauropsida)

        sel = select_01({'Lepidosauria','Testudines','Crocodilia','Pterosauria','Saurischia','Ornithischia','Sauropodomorpha','Tyrannosauridae','Archaeopterygidae'}); 
        xy_no_aves = log10(xy(sel,:));
        [coeff,score,latent,tsquared,explained,mu] = pca(xy_no_aves);
        pca_slope_no_aves = coeff(2,1)/coeff(1,1);
        fprintf('pca slope {p_Am}-v for Sauropsida without Aves: %3.1f \n', pca_slope_no_aves)

        xlabel('_{10}log spec assimilation \{p_{Am}\}, J/d.cm^2')      
        ylabel('_{10}log energy conductance v, cm/d')

        %saveas(Hfig4c, 'pAm_v_sauropsida.png')
        %saveas(Hleg4c, 'legend_pAm_v_sauropsida.png')

      case 16 % fig 4d: log10 p_Am - log10 v for mammals
        pAmv = read_allStat({'p_Am','v','s_M'}); pAmv = [prod(pAmv(:,[1 3]),2), prod(pAmv(:,2:3),2)];

        [Hfig4d, Hleg4d, xy] = shstat(pAmv, legend_mam, ['Mammals ', datestr(datenum(date),'yyyy/mm/dd')]);
        close(Hleg4d); Hleg4d = shlegend(legend_mam, [], [], 'Mammals');
        set(gca, 'FontSize', 15, 'Box', 'on')

        figure(Hfig4d) 
        sel = select_01('Mammalia');xy = log10(xy(sel,:));
        [coeff,score,latent,tsquared,explained,mu] = pca(xy);
        pca_slope_mam = coeff(2,1)/coeff(1,1);
        fprintf('pca slope {p_Am}-v for mammals: %3.1f \n', pca_slope_mam)

        xlabel('_{10}log spec assimilation \{p_{Am}\}, J/d.cm^2')      
        ylabel('_{10}log energy conductance v, cm/d')

        %saveas(Hfig4d, 'pAm_v_mam.png')
        %saveas(Hleg4d, 'legend_pAm_v_mam.png')

      case 17 % fig 5a: log10 p_Am - log10 L_i for invertebrates
        pAmLi = read_allStat({'L_i','p_Am','s_M'}); pAmLi = [prod(pAmLi(:,[2 3]),2), pAmLi(:,1)];

        [Hfig5a, Hleg5a, xy] = shstat(pAmLi, legend_invert, ['Invertebrata ', datestr(datenum(date),'yyyy/mm/dd')], 1);
        close(Hleg5a); Hleg5a = shlegend(legend_invert, [], [], 'Invertebrata');
        set(gca, 'FontSize', 15, 'Box', 'on')

        figure(Hfig5a) 
        % x = 0.6; 1-1/x =  -0.6667; 
        plot([-1; 5], [0.6667; -3.3335], ':', 'color', [0.9 0.6 0.6], 'Linewidth', 2); hold on
        plot([-1; 5], [-1-2; 5-2], '-', 'color', [0.9 0.9 0.9], 'Linewidth', 2); hold on

        sel = (1 == max(select_01({'Parazoa','Radiata','Xenacoelomorpha','Spiralia','Ecdysozoa','Echinodermata','Cephalochordata','Tunicata'}),[],2));
        xy = log10(xy(sel,:)); 
        [coeff, score, latent, tsquared, explained, mu] = pca(xy); 
 
        pca_slope_invert = coeff(2,1)/coeff(1,1);
        % plot([-3; 3], [mu(2) + pca_slope_invert * (-3 - mu(1)); mu(2) + pca_slope_invert * (3 - mu(1))], '-', 'color', [0.9 0.9 0.9], 'Linewidth', 4);

        xlabel('_{10}log spec assimilation \{p_{Am}\}, J/d.cm^2')      
        ylabel('_{10}log ultimate stuctural length L_\infty, cm')

        %saveas(Hfig5a, 'pAm_Li_invert.png')
        %saveas(Hleg5a, 'legend_invert.png')

        fprintf('pca slope {p_Am}-L_i for invert: %3.1f \n', pca_slope_invert)
       
      case 18 % fig 5b: log10 p_Am - log10 L_i for fish & amph
        pAmLi = read_allStat({'L_i','p_Am','s_M'}); pAmLi = [prod(pAmLi(:,[2 3]),2), pAmLi(:,1)];

        [Hfig5b, Hleg5b, xy] = shstat(pAmLi, legend_fish, ['Fish & Amph ', datestr(datenum(date),'yyyy/mm/dd')], 3);
        close(Hleg5b); Hleg5b = shlegend(legend_fish, [], [], 'Fish & Amph');
        set(gca, 'FontSize', 15, 'Box', 'on')

        figure(Hfig5b) 
        % x = 1.1; 1-1/x =  -0.09; 
        plot([1; 5], [-0.09+1;  -0.4500+1], ':', 'color', [0.9 0.6 0.6], 'Linewidth', 4); hold on
        plot([1; 5], [1-1.5; 5-1.5], '-', 'color', [0.9 0.9 0.9], 'Linewidth', 4);

        sel = (1 == max(select_01({'Myxini','Agnatha','Chondrichthyes','Actinopterygii','Latimeria','Dipnoi','Amphibia'}),[],2));
        xy = log10(xy(sel,:)); 
        [coeff, score, latent, tsquared, explained, mu] = pca(xy); 
        pca_slope_fish = coeff(2,1)/coeff(1,1);
        % plot([-0.5; 2.5], [mu(2) + pca_slope_invert * (-0.5 - mu(1)); mu(2) + pca_slope_invert * (2.5 - mu(1))], '-', 'color', [0.9 0.9 0.9], 'Linewidth', 4);

        xlabel('_{10}log spec assimilation \{p_{Am}\}, J/d.cm^2')      
        ylabel('_{10}log ultimate stuctural length L_\infty, cm')

        %saveas(Hfig5b, 'pAm_Li_fish.png')
        %saveas(Hleg5b, 'legend_fish.png')

        fprintf('pca slope {p_Am}-L_i for fish: %3.1f \n', pca_slope_fish);
       
      case 19 % fig 5c: log10 p_Am - log10 L_i for sauropsida
        pAmLi = read_allStat({'L_i','p_Am','s_M'}); pAmLi = [prod(pAmLi(:,[2 3]),2), pAmLi(:,1)];

        [Hfig5c, Hleg5c, xy] = shstat(pAmLi, legend_sauropsida, ['Sauropsida ', datestr(datenum(date),'yyyy/mm/dd')], 5);
        close(Hleg5c); Hleg5c = shlegend(legend_sauropsida, [], [], 'Sauropsida');
        set(gca, 'FontSize', 15, 'Box', 'on')

        figure(Hfig5c) 
        % x = 0.7; 1-1/x =  -0.4286; 
        plot([1; 4.5], [-0.4286+2; -1.9285+2], ':', 'color', [0.9 0.6 0.6], 'Linewidth', 4); hold on
        plot([1; 4.5], [1-1.5; 4.5-1.5], '-', 'color', [0.9 0.9 0.9], 'Linewidth', 4)

        sel = select_01('Sauropsida');
        xy = log10(xy(sel,:)); 
        [coeff, score, latent, tsquared, explained, mu] = pca(xy); 
        pca_slope_sauropsida = coeff(2,1)/coeff(1,1);
        % plot([0; 2.5], [mu(2) + pca_slope_sauropsida * ( - mu(1)); mu(2) + pca_slope_sauropsida * (2.5 - mu(1))], '-', 'color', [0.9 0.9 0.9], 'Linewidth', 4);

        xlabel('_{10}log spec assimilation \{p_{Am}\}, J/d.cm^2')      
        ylabel('_{10}log ultimate stuctural length L_\infty, cm')

        %saveas(Hfig5c, 'pAm_Li_sauropsida.png')
        %saveas(Hleg5c, 'legend_sauropsida.png')

        fprintf('pca slope {p_Am}_L_i for sauropsida: %3.1f \n', pca_slope_sauropsida);
       
      case 20 % fig 5d: log10 p_Am - log10 L_i for mammals
        pAmLi = read_allStat({'L_i','p_Am','s_M'}); pAmLi = [prod(pAmLi(:,[2 3]),2), pAmLi(:,1)];

        [Hfig5d, Hleg5d, xy] = shstat(pAmLi, legend_mam, ['Mammals ', datestr(datenum(date),'yyyy/mm/dd')], 7);
        close(Hleg5d); Hleg5d = shlegend(legend_mam, [], [], 'Mammals');
        set(gca, 'FontSize', 15, 'Box', 'on')

        figure(Hfig5d) 
        % x = 0.5; 1-1/x = -1; 
        plot([1.5; 4.5], [-1.5+3.3; -4.5+3.3], ':', 'color', [0.9 0.6 0.6], 'Linewidth', 4); hold on
        plot([1.5; 4.5], [1.5-1.3; 4.5-1.3], '-', 'color', [0.9 0.9 0.9], 'Linewidth', 4); hold on
        sel = select_01('Mammalia');
        xy = log10(xy(sel,:)); 
        [coeff, score, latent, tsquared, explained, mu] = pca(xy); 
        pca_slope_mam = coeff(2,1)/coeff(1,1);
        % plot([0; 2.5], [mu(2) + pca_slope_mam * (- mu(1)); mu(2) + pca_slope_mam * (2.5 - mu(1))], '-', 'color', [0.9 0.9 0.9], 'Linewidth', 4);
        xlabel('_{10}log spec assimilation \{p_{Am}\}, J/d.cm^2')      
        ylabel('_{10}log ultimate stuctural length L_\infty, cm')

        %saveas(Hfig5d, 'pAm_Li_mam.png')
        %saveas(Hleg5d, 'legend_mam.png')

        fprintf('pca slope {p_Am}-L_i for mam:  %3.1f \n', pca_slope_mam)
       
      case 21 % fig 6a: log10 p_M - log10 Li for invert
        pMLi = read_allStat({'p_M','L_i'}); 

        [Hfig6a, Hleg6a, xy] = shstat(pMLi, legend_invert, ['Invertebrata ', datestr(datenum(date),'yyyy/mm/dd')], 1);
        close(Hleg6a); Hleg6a = shlegend(legend_invert, [], [], 'Invertebrata');
        set(gca, 'FontSize', 15, 'Box', 'on')

        figure(Hfig6a) 
        % x = 0.6; log10(Li) = (x-1) * log10(p_M)
        % plot([-1; 5], [0.4; -2], ':', 'color', [0.9 0.6 0.6], 'Linewidth', 8); hold on
        sel = (1 == max(select_01({'Parazoa','Radiata','Xenacoelomorpha','Spiralia','Ecdysozoa','Echinodermata','Cephalochordata','Tunicata'}),[],2));
        xy_all = log10(xy(sel,:)); 
        [coeff, score, latent, tsquared, explained, mu] = pca(xy_all); 
        pca_slope_invert = coeff(2,1)/coeff(1,1);
        % plot([-1; 5], [mu(2) + pca_slope_invert * (-1 - mu(1)); mu(2) + pca_slope_invert * (5 - mu(1))], '-', 'color', [0.9 0.9 0.9], 'Linewidth', 4);

        xlabel('_{10}log spec somatic maintenance [p_M], J/d.cm^3')      
        ylabel('_{10}log ultimate struc. length L_\infty, cm')

        %saveas(Hfig6a, 'pM_Li_invert.png')
        %saveas(Hleg6a, 'legend_invert.png')

        fprintf('pca slope [p_M]-L_i for invert: %3.1f \n', pca_slope_invert);

      case 22 % fig 6b: log10 p_M - log10 Li for fish & amph
        pMLi = read_allStat({'p_M','L_i'}); 

        % x = 1.1; log10(Li) = (x - 1) * log10(p_M) + 0.85
        [Hfig6b, Hleg6b, xy] = shstat(pMLi, legend_fish, ['Fish & Amph ', datestr(datenum(date),'yyyy/mm/dd')], 3);
        close(Hleg6b); Hleg6b = shlegend(legend_fish, [], [], 'Fish & Amph');
        set(gca, 'FontSize', 15, 'Box', 'on')

        figure(Hfig6b) 
        % plot([0; 4], [0.85; 1.25], ':', 'color', [0.9 0.6 0.6], 'Linewidth', 8); hold on
        %plot([0; 4], [2; -1], '-', 'color', [0.9 0.9 0.9], 'Linewidth', 8); hold on
        sel = (1 == max(select_01({'Myxini','Agnatha','Chondrichthyes','Actinopterygii','Latimeria','Dipnoi','Amphibia'}),[],2));
        xy = log10(xy(sel,:)); 
        [coeff, score, latent, tsquared, explained, mu] = pca(xy); 
        pca_slope_fish = coeff(2,1)/coeff(1,1);
        % plot([0; 4], [mu(2) - mu(1) * pca_slope_fish; mu(2) + pca_slope_fish * (4 - mu(1))], '-', 'color', [0.9 0.9 0.9], 'Linewidth', 4);
        xlabel('_{10}log spec somatic maintenance [p_M], J/d.cm^3')      
        ylabel('_{10}log ultimate struc. length L_\infty, cm')

        %saveas(Hfig6b, 'pM_Li_fish.png')
        %saveas(Hleg6b, 'legend_fish.png')

        fprintf('pca slope [p_M]-L_i for fish %3.1f \n', pca_slope_fish)

      case 23 % fig 6c: log10 p_M - log10 Li for sauropsida
        pMLi = read_allStat({'p_M','L_i'}); 

        % x = 0.7; log10(Li) = (x - 1) * log10(p_M) + 1.5
        [Hfig6c, Hleg6c, xy] = shstat(pMLi, legend_sauropsida, ['Sauropsida ', datestr(datenum(date),'yyyy/mm/dd')], 5);
        close(Hleg6c); Hleg6c = shlegend(legend_sauropsida, [], [], 'Sauropsida');
        set(gca, 'FontSize', 15, 'Box', 'on')

        figure(Hfig6c) 
        % plot([0; 4], [1.5; 0.3], ':', 'color', [0.9 0.6 0.6], 'Linewidth', 8); hold on
        sel = select_01('Sauropsida');
        xy = log10(xy(sel,:));
        [coeff,score,latent,tsquared,explained,mu] = pca(xy);
        pca_slope_sauropsida = coeff(2,1)/coeff(1,1);
        % plot([0; 4], [mu(2) - mu(1) * pca_slope_sauropsida; mu(2) + pca_slope_sauropsida * (4 - mu(1))], '-', 'color', [0.9 0.9 0.9], 'Linewidth', 4);
        xlabel('_{10}log spec somatic maintenance [p_M], J/d.cm^3')      
        ylabel('_{10}log ultimate struc. length L_\infty, cm')

        %saveas(Hfig6c, 'pM_Li_sauropsida.png')
        %saveas(Hleg6c, 'legend_sauropsida.png')

        fprintf('pca slope [p_M]-L_i for sauropsida: %3.1f \n', pca_slope_sauropsida)

      case 24 % fig 6d: log10 p_M - log10 Li for mammals
        pMLi = read_allStat({'p_M','L_i'}); 

        [Hfig6d, Hleg6d, xy] = shstat(pMLi, legend_mam, ['Mammals ', datestr(datenum(date),'yyyy/mm/dd')], 7);
        close(Hleg6d); Hleg6d = shlegend(legend_mam, [], [], 'Mammals');
        set(gca, 'FontSize', 15, 'Box', 'on')

        figure(Hfig6b) 

        % x = 0.5; log10(Li) = (x - 1) * log10(p_M) + 1.5
        % plot([0; 4], [1.5; -0.5], ':', 'color', [0.9 0.6 0.6], 'Linewidth', 8); hold on
        xy = log10(xy(sel,:)); sel = select_01('Mammalia');
        [coeff,score,latent,tsquared,explained,mu] = pca(xy);
        pca_slope_mam = coeff(2,1)/coeff(1,1);
        % plot([0; 4], [mu(2) - mu(1) * pca_slope_mam; mu(2) + pca_slope_mam * (4 - mu(1))], '-', 'color', [0.9 0.9 0.9], 'Linewidth', 4);
        xlabel('_{10}log spec somatic maintenance [p_M], J/d.cm^3')      
        ylabel('_{10}log ultimate struc. length L_\infty, cm')

        %saveas(Hfig6d, 'pM_Li_mam.png')
        %saveas(Hleg6d, 'legend_mam.png')

        fprintf('pca slope [p_M]-L_i for mammals:  %3.1f \n', pca_slope_mam)


      case 25 % fig 7a: log10 p_M - log10 p_Am - log10 Li 
        pMpAmLi = read_allStat('p_M', 'p_Am', 'L_i', 's_M'); p_M = pMpAmLi(:,1); p_Am = pMpAmLi(:,2) .* pMpAmLi(:,4); L_i = pMpAmLi(:,3);

        shstat_options('default'); % log10 transform for all 3 variables
        [Hfig7a, Hleg7a] = shstat([p_M, p_Am, L_i], {{'o', 7, 2}, 'Animalia'}); % define colorless legend on the fly
        figure(Hfig7a) % add labels to figure, because this is not done by shstat in numerical mode
        xlabel('_{10}log [p_M], J/d.cm^3')      
        ylabel('_{10}log \{p_{Am}\}, J/d.cm^2')  
        zlabel('_{10}log L_\infty , cm')         

      case 26 % fig 7b: log10 p_M - log10 p_Am - log10 Li 
        pMpAmLi = read_allStat('p_M', 'p_Am', 'L_i', 's_M'); p_M = pMpAmLi(:,1); p_Am = pMpAmLi(:,2) .* pMpAmLi(:,4); L_i = pMpAmLi(:,3);
 
        shstat_options('default'); % log10 transform for all 3 variables
        pMpAmLi = read_allStat('p_M', 'p_Am', 'L_i', 's_M'); p_M = pMpAmLi(:,1); p_Am = pMpAmLi(:,2) .* pMpAmLi(:,4); L_i = pMpAmLi(:,3);
        pM = p_M .* L_i.^3; pAm = p_Am .* L_i.^2;
        [Hfig7b, Hleg7b] = shstat([pM, pAm, L_i], {{'o', 7, 2}, 'Animalia'}); % define colorless legend on the fly
        figure(Hfig7b) % add labels to figure, because this is not done by shstat in numerical mode
        xlabel('_{10}log p_M, J/d')      
        ylabel('_{10}log p_{Am}, J/d')  
        zlabel('_{10}log L_\infty , cm')         

      case 27 % log10 p_M - log10 p_Am - log10 Li for invertebrates
        pMpAmLi = read_allStat({'p_M','p_Am','s_M','L_i'}); pMpAmLi = [pMpAmLi(:,1), prod(pMpAmLi(:,2:3),2), pMpAmLi(:,4)];

        shstat_options('default');
        [Hfig8a, Hleg8a] = shstat(pMpAmLi, legend_invert, ['Invertebrata ', datestr(datenum(date),'yyyy/mm/dd')]);
        close(Hleg8a); Hleg8a = shlegend(legend_invert, [], [], 'Invertebrata');
        set(gca, 'FontSize', 15, 'Box', 'on')

        figure(Hfig8a) 
        xlabel('_{10}log spec somatic maintenance [p_M], J/d.cm^3')      
        ylabel('_{10}log spec assimilation \{p_{Am}\}, J/d.cm^2')
        zlabel('_{10}log ulitimate struc length L_\infty, cm')

        %saveas(Hfig8a, 'pM_pAm_Li_invert.png')
        %saveas(Hleg8a, 'legend_pM_pAm_Li_invert.png')

      case 28 % log10 p_M - log10 p_Am - log10 Li for fish & amph
        pMpAmLi = read_allStat({'p_M','p_Am','s_M','L_i'}); pMpAmLi = [pMpAmLi(:,1), prod(pMpAmLi(:,2:3),2), pMpAmLi(:,4)];
        
        [Hfig8b, Hleg8b] = shstat(pMpAmLi, legend_fish, ['Fish & Amph ', datestr(datenum(date),'yyyy/mm/dd')]);
        close(Hleg8b); Hleg8b = shlegend(legend_fish, [], [], 'Fish & Amph');
        set(gca, 'FontSize', 15, 'Box', 'on')

        figure(Hfig8b) 
        xlabel('_{10}log spec somatic maintenance [p_M], J/d.cm^3')      
        ylabel('_{10}log spec assimilation \{p_{Am}\}, J/d.cm^2')
        zlabel('_{10}log ulitimate struc length L_\infty, cm')

        %saveas(Hfig8b, 'pM_pAm_Li_fish.png')
        %saveas(Hleg8b, 'legend_pM_pAm_Li_fish.png')


      case 29 % log10 p_M - log10 p_Am - log10 Li for sauropsida
        pMpAmLi = read_allStat({'p_M','p_Am','s_M','L_i'}); pMpAmLi = [pMpAmLi(:,1), prod(pMpAmLi(:,2:3),2), pMpAmLi(:,4)];

        [Hfig8c, Hleg8c] = shstat(pMpAmLi, legend_sauropsida, ['Sauropsida ', datestr(datenum(date),'yyyy/mm/dd')]);
        close(Hleg8c); Hleg8c = shlegend(legend_sauropsida, [], [], 'Sauropsida');
        set(gca, 'FontSize', 15, 'Box', 'on')

        figure(Hfig8c) 
        xlabel('_{10}log spec somatic maintenance [p_M], J/d.cm^3')      
        ylabel('_{10}log spec assimilation \{p_{Am}\}, J/d.cm^2')
        zlabel('_{10}log ulitimate struc length L_\infty, cm')

        %saveas(Hfig8c, 'pM_pAm_Li_sauropsida.png')
        %saveas(Hleg8c, 'legend_pM_pAm_Li_sauropsida.png')

      case 30 % log10 p_M - log10 p_Am - log10 Li for mammals
        pMpAmLi = read_allStat({'p_M','p_Am','s_M','L_i'}); pMpAmLi = [pMpAmLi(:,1), prod(pMpAmLi(:,2:3),2), pMpAmLi(:,4)];

        [Hfig8d, Hleg8d] = shstat(pMpAmLi, legend_mam, ['Mammals ', datestr(datenum(date),'yyyy/mm/dd')]);
        close(Hleg8d); Hleg8d = shlegend(legend_mam, [], [], 'Mammals');
        set(gca, 'FontSize', 15, 'Box', 'on')

        figure(Hfig8d) 
        xlabel('_{10}log spec somatic maintenance [p_M], J/d.cm^3')      
        ylabel('_{10}log spec assimilation \{p_{Am}\}, J/d.cm^2')
        zlabel('_{10}log ulitimate struc length L_\infty, cm')

        %saveas(Hfig8d, 'pM_pAm_Li_mam.png')
        %saveas(Hleg8d, 'legend_pM_pAm_Li_mam.png')

    end
  end
end
