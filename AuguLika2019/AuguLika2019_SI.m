function AuguLika2019_SI(fig)
% Supporting Information for AuguLika2019
% Title: Altricial-precocial spectra in animal kingdom
% Authors: Augustine, Lika, Kooijman
% Journal: J. of Sea Res. 143: 27–34
% DOI: 10.1016/j.seares.2018.03.006
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
% To run the code for a figure: type in the Matlab window e.g. AuguLika2019(2)
%
% Remarks: 
%  The figures show current AmP data, which might change in time; the results might differ from the publication
%  The scripts call functions read_popStat and read_allStat; the first call to these functions loads the .mat file, which can take some time
%  Click on a marker in the Matlab-figure to see the species name
%  Uncomment "saveas" to save the Matlab-figure to a png-file
%  Modify selection of taxa and markers by changing the legend, see https://add-my-pet.github.io/AmPtool/docs/index.html
%  Allowed names of taxa match the names of the tree nodes at http://www.bio.vu.nl/thb/deb/deblab/add_my_pet/species_tree_Animalia.html

  close all

      legend_RXSE = {...
        {'o', 8, 3, [1 0 0], [1 0 0]}, 'Echinodermata'; ....
        {'o', 8, 3, [0 0 0], [0 0 0]}, 'Radiata'; ...
        {'o', 8, 3, [0 0 0], [0 0 1]}, 'Xenacoelomorpha'; ...
        {'o', 8, 3, [0 0 1], [0 0 1]}, 'Spiralia'; ...
        {'o', 8, 3, [1 0 1], [1 0 1]}, 'Ecdysozoa'; ....
      };
  
      legend_fish = {...
        {'o', 8, 3, [0 0 0], [0 0 0]}, 'Cyclostomata'; ...
        {'o', 8, 3, [1 0 0], [1 0 0]}, 'Chondrichthyes'; ...
        {'o', 8, 3, [0 0 1], [0 0 1]}, 'Actinopterygii'; ...
        {'o', 8, 3, [1 0 1], [0 0 1]}, 'Latimeria'; ....
        {'o', 8, 3, [1 0 1], [1 0 0]}, 'Dipnoi'; ....
        {'o', 8, 3, [1 0 1], [1 0 1]}, 'Amphibia'; ....
      };

      legend_aves = {...
        {'o', 8, 3, [0 0 0], [0 0 0]}, 'Lepidosauria'; ....
        {'o', 8, 3, [1 0 0], [1 0 0]}, 'Aves'; ....
        {'o', 8, 3, [0 0 1], [0 0 1]}, 'Testudines'; ....
        {'o', 8, 3, [1 0 1], [0 0 1]}, 'Crocodilia'; ....
        {'o', 8, 3, [1 0 1], [1 0 1]}, 'Avemetatarsalia'; ....
      };

      legend_mamm = {...
       {'o', 8, 3, [0 0 0], [0 0 0]}, 'Prototheria'; ...  
       {'o', 8, 3, [0 0 1], [0 0 0]}, 'Marsupialia'; ...
       {'o', 8, 3, [0 0 1], [0 0 1]}, 'Xenarthra'; ...
       {'o', 8, 3, [0 0 1], [1 0 1]}, 'Afrotheria'; ....
       {'o', 8, 3, [0 0 1], [1 0 0]}, 'Laurasiatheria'; ....
       {'o', 8, 3, [1 0 1], [1 0 1]}, 'Gliriformes'; ....
       {'o', 8, 3, [1 0 1], [1 0 0]}, 'Scandentia'; ....
       {'o', 8, 3, [1 0 0], [1 0 0]}, 'Dermoptera'; ....
       {'o', 8, 3, [1 0 0], [1 .5 .5]}, 'Primates'; ....
     };

  if ~exist('fig','var')
    fig = 1:30;
  end

  close all
  shstat_options('default');
  shstat_options('y_label', 'on'); 
  shstat_options('x_label', 'off'); 
 
  for i=1:length(fig)
    switch fig(i)
      case 1 % fig 1
    
        shstat_options('y_label', 'on');

        figure % E_Hb, E_Hp
        EHb = read_allStat('E_Hb'); 
        EHb_med = median(EHb); EHb_min = min(EHb); EHb_max = max(EHb); EHb_m = mean(EHb); EHb_v = mean(EHb.^2) - mean(EHb)^2;
        EHb_x = 10.^linspace(log10(EHb_min),log10(EHb_max),500); 
        AB = wblfit(EHb, 0.05); % gives MLEs and 100(1-ALPHA)% CI
        A = AB(1); B = AB(2); S = 1-wblcdf(EHb,A,B);
        fprintf(['pars wbl for EHb: ', num2str(A), ' , ', num2str(B),'\n'])
        S = 1-wblcdf(EHb_x,A,B);
        plot(log10(EHb_x), S, '-', 'color', [0.75 0.75 1], 'linewidth', 8)
        
        hold on
        fprintf(['mean and variance for EHb: ', num2str(EHb_m), ' , ', num2str(EHb_v),'\n'])
        surv_EHb = surv(EHb);
        shstat_options('x_transform', 'log10')
        Hfig = shstat(EHb, {'b', 'b'}, [], 1);
        set(gca, 'FontSize', 15, 'Box', 'on')
        %xlabel('_{10}log E_H^b, J') 
        %saveas(gca, 'EHb.png')
        %
        EHp = read_allStat('E_Hp'); 
        EHp_med = median(EHp); EHp_min = min(EHp); EHp_max = max(EHp); EHp_m = mean(EHp); EHp_v = mean(EHp.^2) - mean(EHp)^2;
        surv_EHp = surv(EHp); 
        EHp_x = 10.^linspace(log10(EHp_min),log10(EHp_max),500); 
        AB = wblfit(EHp, 0.05); % gives MLEs and 100(1-ALPHA)% CI
        A = AB(1); B = AB(2); S = 1-wblcdf(EHp,A,B);
        fprintf(['pars wbl for EHp: ', num2str(A), ' , ', num2str(B),'\n'])
        S = 1-wblcdf(EHp_x,A,B);
        plot(log10(EHp_x), S, '-', 'color', [1 0.75 0.75], 'linewidth', 8)
        
        hold on
        fprintf(['mean and variance for EHp: ', num2str(EHp_m), ' , ', num2str(EHp_v),'\n'])
        surv_EHp = surv(EHp); 
        Hfig = shstat(EHp, {'r', 'r'}, [], 1);
        set(gca, 'FontSize', 15, 'Box', 'on')
        xlabel('_{10}log E_H^b, E_H^p, J') 
        %saveas(gca, 'EHbp.png')

        figure % s_H, s_HL
        shstat_options('x_transform', 'none');
        sH = log10(EHb ./ EHp); 
        sH_med = median(sH); sH_min = min(sH); sH_max = max(sH); sH_m = mean(sH); sH_v = mean(sH.^2) - mean(sH)^2;
        sH_x = linspace(sH_min,sH_max,500); 
        AB = wblfit(10.^sH, 0.05); % gives MLEs and 100(1-ALPHA)% CI
        A = AB(1); B = AB(2); S = 1-wblcdf(EHb,A,B);
        fprintf(['pars wbl for 10^sH: ', num2str(A), ' , ', num2str(B),'\n'])
        S = 1-wblcdf(10.^sH_x,A,B);
        plot(sH_x, S, '-', 'color', [0.75 0.75 1], 'linewidth', 8)
        [Hfig Hleg] = shstat(sH,  {'b', 'b'}, [], 2);
        %xlabel('s_H^{bp}, -') 
        %saveas(gca, 'sH.png')
        %
        LL = read_allStat('L_b','L_p'); sHL = sH + 3*log10(LL(:,2)./LL(:,1));
        sHL_med = median(sHL); sHL_min = min(sHL); sHL_max = max(sHL); sHL_m = mean(sHL); sHL_v = mean(sHL.^2) - mean(sHL)^2;
        sHL_x = linspace(sHL_min,sHL_max,500); 
        AB = wblfit(10.^sHL, 0.05); % gives MLEs and 100(1-ALPHA)% CI
        A = AB(1); B = AB(2); S = 1-wblcdf(sHL,A,B);
        fprintf(['pars wbl for 10^sHL: ', num2str(A), ' , ', num2str(B),'\n'])
        S = 1-wblcdf(10.^sHL_x,A,B);
        plot(sHL_x, S, '-', 'color', [1 0.75 0.75], 'linewidth', 8)
        [Hfig Hleg] = shstat(sHL,  {'r', 'r'}, [], 2);
        set(gca, 'FontSize', 15, 'Box', 'on')
        xlabel('_{10}log s_H^{bp}, s_{HL}^{bp}, -') 
        %saveas(gca, 'sHL.png')

      case 2 % fig 2
        shstat_options('x_transform', 'log10');
        shstat_options('y_transform', 'log10');
        shstat_options('x_label', 'on');
        shstat_options('y_label', 'on');

        figure % E_Hb, E_Hp
        [Hfig Hleg] = shstat({'E_Hb','E_Hp'}, legend_RSED, '(A) maturity', 1);
        set(gca, 'FontSize', 15, 'Box', 'on')
        figure(Hfig)
        set(gca, 'FontSize', 15, 'Box', 'on')
        xlabel('maturity at birth, _{10}log E_H^b, J')
        ylabel('maturity at puberty, _{10}log E_H^p, J')
        %saveas(gca, 'EHb_EHp.png')
        %saveas(Hleg, 'legend_EHb_EHp.png')

        figure % E_Hb/Lb^3, E_Hp/Lp^3
        vars = read_allStat('L_b','L_p','E_Hb','E_Hp');
        eHb = vars(:,3)./vars(:,1).^3; eHp = vars(:,4)./vars(:,2).^3;
        [Hfig Hleg] = shstat([eHb, eHp], legend_RSED, '(B) maturity density', 3);
        close(Hleg)
        figure(Hfig)
        set(gca, 'FontSize', 15, 'Box', 'on')
        xlabel('maturity density at birth E_H^b/ L_b^3, J/cm^3')
        ylabel('maturity density at puberty E_H^p/ L_p^3, J/cm^3')
        %saveas(gca, 'EHLb_EHLp.png')
    
        figure % E_Hb/z^3, E_Hp/z^3
        vars = read_allStat('z','s_M','E_Hb','E_Hp');
        eHb = vars(:,3)./(vars(:,1) .* vars(:,2)).^3; eHp = vars(:,4)./(vars(:,1) .* vars(:,2)).^3;
        [Hfig Hleg] = shstat([eHb, eHp], legend_RSED, '(C) maturity per ultimate volume', 4);
        close(Hleg)
        figure(Hfig)
        set(gca, 'FontSize', 15, 'Box', 'on')
        xlabel('maturity density at birth E_H^b/ L_\infty^3, J/cm^3')
        ylabel('maturity density at puberty E_H^p/ L_\infty^3, J/cm^3')
        %saveas(gca, 'EHbz_EHpz.png')

      case 3 % fig 3   
        shstat_options('default');
        shstat_options('x_transform', 'log10');
        shstat_options('y_transform', 'none');
        
        vars = read_allStat('E_Hb', 'E_Hp', 'L_b', 'L_p', 's_M'); 
        sH = vars(:,1) ./ vars(:,2); sHL = sH .* (vars(:,4)./vars(:,3)).^3;
        xtxt = '_{10}log s_H^{bp}, -';
        ytxt = 's_{HL}^{bp}, -';
        v1 = sH; v2 = sHL; vtxt = 'sH_sHL';

        figure
        [Hfig Hleg] = shstat([v1, v2], legend_RXSE, 'invertebrates', 1); 
        figure(Hfig)
        xlabel(xtxt)      
        ylabel(ytxt)
        %saveas(gca,[vtxt, '_RXSE.png'])
        %saveas(Hleg,['legend_', vtxt, '_RXSE.png'])
    
        figure
        [Hfig Hleg] = shstat([v1, v2], legend_fish, 'fish & amphibia', 3); 
        figure(Hfig)
        xlabel(xtxt)      
        ylabel(ytxt)
        %saveas(gca,[vtxt, '_fish.png'])
        %saveas(Hleg,['legend_', vtxt, '_fish.png'])

        figure
        [Hfig Hleg] = shstat([v1, v2], legend_aves, 'sauropsids', 5); 
        figure(Hfig) 
        figure(Hfig)
        xlabel(xtxt)      
        ylabel(ytxt)
        %saveas(gca,[vtxt, '_aves.png'])
        %saveas(Hleg,['legend_', vtxt, '_aves.png'])

        figure
        [Hfig Hleg] = shstat([v1, v2], legend_mamm, 'mammals', 7); 
        figure(Hfig)
        xlabel(xtxt)      
        ylabel(ytxt)
        %saveas(gca,[vtxt, '_mamm.png'])
        %saveas(Hleg,['legend_', vtxt, '_mamm.png'])

      case 4 % fig 4   
        % StarRick1998: 
        %   M_n = neonate mass in g
        %   LDF = lipid-free dry mass/lipid-free wet mass
        %   I_p = log10(LDF) + 0.1 * log10(M_n) + 0.8
        %   alt/prec: score, see AuguLika2018 tab 1, based on Nice1962
        %   
        % species                     M_n LDF   I_p   alt/prec

        data = { ...
        'Turnix_suscitator'           3.8 0.185 0.125 5 
        'Alectura lathami'           87.2 0.281 0.443 8 
        'Leipoa ocellata'            89.4 0.254 0.400 8 
        'Coturnix coturnix'           5.8 0.192 0.160 7 
        'Colinus virginianus'        6.12 0.211 0.203 7 
        'Phasianus colchicus'        17.5 0.290 0.387 7 
        'Gallus gallus'              NaN  NaN   0.27  7 
        'Meleagris gallipavo'        NaN  NaN   0.31  6 
        'Aythya valisineria'         55.7 0.240 0.355 7 
        'Somateria molissima'        43.1 0.269 0.393 7 
        'Somateria molissima'        22.0 0.257 0.344 7 
        'Clangula hyemalis'          26.6 0.249 0.339 7 
        'Anas discors'               10.5 0.340 0.434 7 
        'Anas acuta'                 23.3 0.253 0.340 7 
        'Aythya americana'           20.9 0.277 0.375 7 
        'Mergus cucullatus'          24.7 0.307 0.426 7 
        'Anas platyrhynchos'         18.5 0.246 0.318 7 
        'domestic duck'              NaN  NaN   0.31  7 
        'Branta canadensis'          59.6 0.241 0.360 7 
        'domestic goose'             NaN  NaN   0.34  7 
        'Agapornis roseicollis'       2.6 0.148 0.012 1 
        'Podiceps nigricollis'        9.3 0.235 0.268 5 
        'Fulica atra'                10.0 0.252 0.301 5 
        'Pygoscelis adeliae'         63.1 0.146 0.144 2 
        'Phalacrocorax auritus'      33.7 0.113 0.006 1 
        'Sula sula'                  27.7 0.124 0.038 1 
        'Phaethon rubricauda'        46.1 0.164 0.181 2 
        'Pelecanus occidentalis'     61.7 0.147 0.146 1 
        'Cepphus grylle'              9.7 0.208 0.217 4 
        'Aethia pusilla'             58.9 0.221 0.321 4 
        'Fratercula arctica'         36.8 0.225 0.309 4 
        'Uria aalge'                 21.4 0.194 0.221 4 
        'Larus atricilla'            51.5 0.200 0.272 4 
        'Sterna hirundo'             31.7 0.200 0.251 4 
        'Rissa tridactyla'           19.3 0.197 0.223 4 
        'Catharacta skua'            15.9 0.176 0.166 4 
        'Sterna fuscata'             26.0 0.222 0.288 4 
        'Gygis alba'                 13.2 0.212 0.238 4 
        'Larus philadelphia'         12.4 0.226 0.264 4 
        'Larus argentatus'           41.9 0.204 0.272 4 
        'Sterna paradisaea'          16.4 0.219 0.262 4 
        'Anous tenuirostris'         21.3 0.204 0.243 4 
        'Anous stolidus'              8.5 0.202 0.198 4 
        'Micropalma himantopus'       6.1 0.215 0.211 4 
        'Calidris minutilla'         25.3 0.236 0.313 7 
        'Numenius phaeopus'           2.3 0.202 0.142 7 
        'Phalaropus lobatus'          4.6 0.281 0.315 7 
        'Calidris alpina'             2.8 0.260 0.260 7 
        'Charadrius semipalmatus'    12.3 0.232 0.275 7 
        'Pluvialis dominica'          4.3 0.219 0.204 7 
        'Procellaria aequinoctialis' 11.6 0.195 0.196 4 
        'Oceanodroma leucorhoa'       5.1 0.250 0.269 4 
        'Pelecanoides urinatrix'     94.0 0.196 0.290 3 
        'Pelecanoides georgicus'     12.9 0.234 0.280 3 
        'Macronectes giganteus'      85.3 0.149 0.166 3 
        'Aimophila carpalis'          1.9 0.148 0.002 1 
        'Poephila guttata'            0.6 0.134 0.095 1 
        'Parus caeruleus'             1.2 0.150 0.016 1 
        'Delichon urbica'             1.7 0.100 0.177 1 
        'Passer domesticus'           3.5 0.110 0.104 1 
        'Sturnus vulgaris'            8.7 0.134 0.021 1 
        };

        figure
        plot(cell2mat(data(:,5)), cell2mat(data(:,4)), 'om')
        xlabel('altrical/precocial score according to Nice1962')
        ylabel('I_p of StarRick1998')


        [nm sH] = prtStat('Aves', 's_Hbp', 0); n_Aves = length(nm); score = zeros(n_Aves,1);
        ordFam = read_stat(select('Aves'),{'order','family'});
        for i=1:n_Aves
          [x score(i)] = get_s_Hbp(ordFam{i,1}, ordFam{i,2});
        end

        figure
        plot(score, log10(sH), 'o', 'MarkerSize', 2, 'LineWidth', 4, 'MarkerEdgeColor', [0 0 1])
        xlabel('altrical/precocial score')
        ylabel('_{10}log s_H^{bp}')
        h = datacursormode(2);
        h.UpdateFcn = @(obj, event_obj)xylabels(obj, event_obj, nm, [score, logsH]);
        datacursormode on % mouse click on plot
        %saveas(gca,'score_sH.png')

        figure
        EHbx = read_allStat({'E_Hb','E_Hx'}); s_Hbx = EHbx(:,1)./EHbx(:,2); s_Hbx = s_Hbx(select_01('Aves'));
        plot(score, log10(s_Hbx), 'o', 'MarkerSize', 2, 'LineWidth', 4, 'MarkerEdgeColor', [0 0 1])
        xlabel('altrical/precocial score')
        ylabel('_{10}log s_H^{bx}')
        h = datacursormode(2);
        h.UpdateFcn = @(obj, event_obj)xylabels(obj, event_obj, nm, [score, logsH]);
        datacursormode on % mouse click on plot
        %saveas(gca,'score_sHbx.png')

      case 5 % fig 5   
        shstat_options('default');
        shstat_options('y_transform', 'log10');
        shstat_options('x_transform', 'log10');
        
        vars = read_allStat('E_Hb', 'E_Hp', 'L_b', 'L_p', 'Ww_i'); 
        EHLb = vars(:,1) ./ vars(:,3).^3; EHLp = vars(:,2) ./ vars(:,4).^3;  Wwi = vars(:,5);
        sH = vars(:,1) ./ vars(:,2); sHL = EHLb ./ EHLp;
        ytxt = '_{10}log s_H^{bp}, -';
        xtxt = '_{10}log W_w^\infty, g';
        v1 = Wwi; v2 = sH; vtxt = 'Wwi_sH';

        figure
        [Hfig Hleg] = shstat([v1, v2], legend_RXSE, 'invertebrates', 1); 
        figure(Hfig)
        xlabel(xtxt)      
        ylabel(ytxt)
        %saveas(gca,[vtxt, '_RXSE.png'])
        %saveas(Hleg,['legend_', vtxt, '_RXSE.png'])
    
        figure
        [Hfig Hleg] = shstat([v1, v2], legend_fish, 'fish & amphibia', 3); 
        figure(Hfig)
        xlabel(xtxt)      
        ylabel(ytxt)
        %saveas(gca,[vtxt, '_fish.png'])
        %saveas(Hleg,['legend_', vtxt, '_fish.png'])

        figure
        [Hfig Hleg] = shstat([v1, v2], legend_aves, 'sauropsids', 5); 
        figure(Hfig) 
        figure(Hfig)
        xlabel(xtxt)      
        ylabel(ytxt)
        %saveas(gca,[vtxt, '_aves.png'])
        %saveas(Hleg,['legend_', vtxt, '_aves.png'])

        figure
        [Hfig Hleg] = shstat([v1, v2], legend_mamm, 'mammals', 7); 
        figure(Hfig)
        xlabel(xtxt)      
        ylabel(ytxt)
        %saveas(gca,[vtxt, '_mamm.png'])
        %saveas(Hleg,['legend_', vtxt, '_mamm.png'])

      case 6 % not numbered 
        shstat_options('default');
        shstat_options('y_transform', 'none');
        shstat_options('x_transform', 'log10');
        vars = read_allStat('E_Hb', 'E_Hp', 'L_b', 'L_p', 'Ww_i'); 
        EHLb = vars(:,1) ./ vars(:,3).^3; EHLp = vars(:,2) ./ vars(:,4).^3;  Wwi = vars(:,5);
        sH = vars(:,1) ./ vars(:,2); sHL = EHLb ./ EHLp;
        ytxt = 's_{HL}^{bp}, -';
        xtxt = '_{10}log W_w^\infty, g';
        v1 = Wwi; v2 = sHL; vtxt = 'Wwi_sHL';

        figure
        [Hfig Hleg] = shstat([v1, v2], legend_RXSE, 'invertebrates', 1); 
        figure(Hfig)
        xlabel(xtxt)      
        ylabel(ytxt)
        %saveas(gca,[vtxt, '_RXSE.png'])
        %saveas(Hleg,['legend_', vtxt, '_RXSE.png'])
    
        figure
        [Hfig Hleg] = shstat([v1, v2], legend_fish, 'fish & amphibia', 3); 
        figure(Hfig)
        xlabel(xtxt)      
        ylabel(ytxt)
        %saveas(gca,[vtxt, '_fish.png'])
        %saveas(Hleg,['legend_', vtxt, '_fish.png'])

        figure
        [Hfig Hleg] = shstat([v1, v2], legend_aves, 'sauropsids', 5); 
        figure(Hfig) 
        figure(Hfig)
        xlabel(xtxt)      
        ylabel(ytxt)
        %saveas(gca,[vtxt, '_aves.png'])
        %saveas(Hleg,['legend_', vtxt, '_aves.png'])

        figure
        [Hfig Hleg] = shstat([v1, v2], legend_mamm, 'mammals', 7); 
        figure(Hfig)
        xlabel(xtxt)      
        ylabel(ytxt)
        %saveas(gca,[vtxt, '_mamm.png'])
        %saveas(Hleg,['legend_', vtxt, '_mamm.png'])

      case 7 % fig 6
        shstat_options('default');
        shstat_options('y_transform', 'log10');
        shstat_options('x_transform', 'log10');
        
        vars = read_allStat('E_Hb', 'E_Hp', 'L_b', 'L_p', 'p_Ri', 'c_T'); 
        EHLb = vars(:,1) ./ vars(:,3).^3; EHLp = vars(:,2) ./ vars(:,4).^3;  Ri = vars(:,5) ./ vars(:,6);
        sH = vars(:,1) ./ vars(:,2); sHL = EHLb ./ EHLp;
        ytxt = '_{10}log s_H^{bp}, -';
        xtxt = '_{10}log p_R^\infty, J/d';
        v1 = Ri; v2 = sH; vtxt = 'pRi_sH';

        figure
        [Hfig Hleg] = shstat([v1, v2], legend_RXSE, 'invertebrates', 1); 
        figure(Hfig)
        xlabel(xtxt)      
        ylabel(ytxt)
        %saveas(gca,[vtxt, '_RXSE.png'])
        %saveas(Hleg,['legend_', vtxt, '_RXSE.png'])
    
        figure
        [Hfig Hleg] = shstat([v1, v2], legend_fish, 'fish & amphibia', 3); 
        figure(Hfig)
        xlabel(xtxt)      
        ylabel(ytxt)
        %saveas(gca,[vtxt, '_fish.png'])
        %saveas(Hleg,['legend_', vtxt, '_fish.png'])

        figure
        [Hfig Hleg] = shstat([v1, v2], legend_aves, 'sauropsids', 5); 
        figure(Hfig) 
        figure(Hfig)
        xlabel(xtxt)      
        ylabel(ytxt)
        %saveas(gca,[vtxt, '_aves.png'])
        %saveas(Hleg,['legend_', vtxt, '_aves.png'])

        figure
        [Hfig Hleg] = shstat([v1, v2], legend_mamm, 'mammals', 7); 
        figure(Hfig)
        xlabel(xtxt)      
        ylabel(ytxt)
        %saveas(gca,[vtxt, '_mamm.png'])
        %saveas(Hleg,['legend_', vtxt, '_mamm.png'])

    end
  end
end

function [s_Hbp,  score, info] = get_s_Hbp(order, family)
  % created 2017/11/24 by Bas Kooijman
  
  %% Syntax
  % [s_Hbp  score info] = <../get_s_Hbp.m *get_s_Hbp*> (order, family)
  
  %% Description
  % Sets maturity ratio at birth over puberty for birds according to
  % taxonomic classification via the altricial-precocial score of Nice 1962:
  %  1 altricial
  %  2 semialtrical 2
  %  3 semialtrical 1
  %  4 semiprecocial
  %  5 precocial 4
  %  6 precocial 3
  %  7 precocial 2
  %  8 precocial 1 
  %
  % Input
  %
  % * order: name of bird order
  % * family: name of bird family
  %  
  % Output
  %
  % * s_Hbp: scalar with specific maturity ratio
  % * score: integer in range 1 till 8 of altricial-precocial score
  % * info: 1 if taxon could be identified, 0 otherwise
  
  %% Remarks
  % Check spelling if info = 0
  
info = 1;

switch order        
  case 'Struthioniformes'
    score = 6;
  case 'Rheiformes'
    score = 6;
  case 'Tinamiformes'
    score = 6;
  case 'Casuariiformes'
    score = 6;
  case 'Apterygiformes'
    score = 8;
  case 'Galliformes'
      switch family
        case 'Megapodiidae'
          score = 8;
        case 'Cracidae'
          score = 5;
        otherwise
          score = 7;
      end
  case 'Anseriformes'
    score = 7;
  case 'Phoenicopteriformes'
    score = 5;
  case 'Podicipediformes'
    score = 5;
  case 'Columbiformes'
    score = 2;
  case 'Mesitornithiformes'
    score = 5;
  case 'Pteroclidiformes'
    score = 7;
  case 'Apodiformes'
    score = 1;
  case {'Caprimulgiformes','Nyctibiiformes','Steatornithiformes','Podargiformes'}
    score = 3;
  case 'Aegotheliformes'
    score = 3;
  case 'Cuculiformes'
    score = 1;
  case 'Otidiformes'
    score = 5;
  case 'Musophagiformes'
    score = 2;
  case 'Opisthocomiformes'
    score = 5;
  case 'Gruiformes'
    score = 5;
  case 'Charadriiformes'
    switch family
      case {'Alcidae','Laridae','Sternidae','Stercorariidae'}
        score = 4;
      case 'Turnicidae'
        score = 5; 
      otherwise
        score = 7;
    end
  case 'Gaviiformes'
    score = 5;
  case 'Procellariiformes'
    score = 3;
  case 'Sphenisciformes'
    score = 2;
  case 'Ciconiiformes'
    score = 3;
  case 'Suliformes'
    switch family
      case 'Phalacrocoracidae'
        score = 4;
      otherwise
        score = 1;
    end
  case 'Pelecaniformes'
    score = 1;
  case 'Eurypygiformes'
    score = 4;
  case 'Phaethontiformes'
    score = 2;
  case 'Cathartiformes'
    score = 2;
  case 'Accipitriformes'
    score = 2;
  case 'Strigiformes'
    score = 2;
  case 'Coliiformes'
    score = 3;
  case 'Leptosomiformes'
    score = 3;
  case 'Trogoniformes'
    score = 1;
  case 'Bucerotiformes'
    score = 1;
  case 'Coraciiformes'
    score = 1;
  case 'Piciformes'
    score = 1;
  case 'Cariamiformes'
    score = 3;
  case 'Falconiformes'
    score = 3;
  case 'Psittaciformes'
    score = 1;
  case 'Passeriformes'
    score = 1;
  otherwise
    fprintf(['warning from get_s_Hbp: order ', order , ' could not be identified: score = 1\n'])
    score = 1; info = 0;
end

s_Hbp = 10^(-3 + score * 2.7/8);
end
