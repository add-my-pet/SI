function LikaAugu2019_SI(fig)
% Supporting Information for LikaAugu2019
% Title: Body size as emergent property of metabolism
% Authors: Lika, Augustine, Kooijman
% Journal: J. of Sea Res. 43 (2019) 8–17
% DOI: 10.1016/j.seares.2018.04.005
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
% To run the code for a figure: type in the Matlab window e.g. LikaAugu2019_SI(2)
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
    fig = 1:20;
  end


  close all
  shstat_options('default');
  shstat_options('y_label', 'on'); 
  shstat_options('x_label', 'off'); 
  
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

  for i=1:length(fig)
    switch fig(i)
      case 1 % fig 1a kap
        figure % kappa
        kap = read_allStat('kap'); 
        kap_med = median(kap); kap_min = min(kap);  m = mean(kap); v = mean(kap.^2) - mean(kap)^2;
        surv_kap = surv(kap); 
        a = m*(m*(1-m)/v-1); b = a*(1-m)/m;
        fprintf(['pars beta for kap: ', num2str(a), ' , ', num2str(b),'\n'])
        fprintf(['mean and variance for kap: ', num2str(m), ' , ', num2str(v),'\n'])
        
        AB = betaML(kap); % gives MLEs 
        A =AB(1); B = AB(2);
        fprintf(['ML est for scale, shape pars of beta distr for kap: ', num2str(A), ' , ', num2str(B),'\n'])
        [M, V] = betaStat(A,B); 
        fprintf(['mean & var of beta distr: ', num2str(M), ' , ', num2str(V),'\n'])
        
        kap =linspace(0,1,100);  S = 1 - betainc(kap,a,b);  
        plot(kap, S, '-', 'color', [0.75 0.75 1], 'linewidth',8)
        set(gca, 'FontSize', 15, 'Box', 'on', 'YTick', 0:0.2:1)
        
        hold on
        plot([0; kap_med; kap_med], [0.5;0.5;0], 'r', surv_kap(:,1), surv_kap(:,2), 'b', 'Linewidth', 2)
        xlabel('\kappa, -') 
        ylabel('survivor function')
        %saveas(gca,'kap.png')

      case 2 % fig 1b {p_Am}          
        figure % p_Am, scaled specific assimilation
        shstat_options('x_transform', 'log10');
        pAmsM = read_allStat('p_Am','s_M'); pAm = pAmsM(:,1); pAmj = prod(pAmsM,2);
        pAm_min = min(pAm); pAm_max = max(pAmj); pAm_med = median(pAm); pAmj_med  = median(pAmj);
        pAmj_m = mean(pAmj); pAmj_v = mean(pAmj.^2) - mean(pAmj)^2;
        fprintf(['mean and variance for pAmj: ', num2str(pAmj_m), ' , ', num2str(pAmj_v),'\n'])
        surv_pAmj = surv(pAmj); 
        Hfig = shstat(pAmj, {'r', 'r'}, '\{p_{Am}\} at T_{ref}, before and after acceleration', 2);
        shstat(pAm,  {'b', 'b'}, [], Hfig);
        set(gca, 'FontSize', 15, 'Box', 'on')
        xlabel('_{10}log \{p_{Am}\}, J/d.cm^2') 
        xlim([log10(pAm_min),log10(pAm_max)])
        %saveas(gca, 'pAm.png')

      case 3 % fig 1c [p_M]       
        shstat_options('x_transform', 'log10');
        [Hfig, Hleg, pM] = shstat({'p_M'}, [], '[p_M] at T_{ref}', 3);
        pM_min = min(pM); pM_max = max(pM); pM_med = median(pM);
        set(gca, 'FontSize', 15, 'Box', 'on')
        xlabel('_{10}log [p_M], J/d.cm^3') 
        xlim([log10(min(pM)),log10(max(pM))])
        %saveas(gca, 'pM.png')

      case 4 % fig 1d v     
        shstat_options('x_transform', 'log10');
        vsM = read_allStat('v', 's_M'); v = vsM(:,1); vj = prod(vsM,2);
        v_min = min(v); v_max = max(vj); v_med = median(v); vj_med = median(vj);
        Hfig = shstat(vj, {'r', 'r'}, 'v at T_{ref}, before and after acceleration', 4);
        shstat(v,  {'b', 'b'}, [], Hfig);
        set(gca, 'FontSize', 15, 'Box', 'on')
        xlabel('_{10} log v, cm/d') 
        xlim([log10(v_min),log10(v_max)])
        %saveas(gca, 'v.png')
        
      case 5 % fig 2a: 
        % field metabolic rates
        WpT_rep = [ ... % body weight (g), field metabolic rate (kJ/d)
          1.10396501	0.31430734
          2.53384537	0.23178187
          3.14979080	0.71531488
          3.14979080	1.39798574
          3.27690514	0.54381335
          3.76358160	0.76024233
          4.07348064	0.59584367
          4.23787181	1.12956217
          4.58682268	0.22482872
          4.96450864	0.83298096
          6.42037236	1.03092644
          7.22947086	1.09567679
          7.22947086	1.44121858
          7.82475649	1.95436414
          7.98108284	0.71531488
          8.98686665	1.16449399
          10.32157005	2.99357878
          11.39465214	1.39798574
          11.62229942	1.78370265
          16.26823077	1.89573579
          16.26823077	2.20757293
          16.59324450	4.05943655
          19.05762510	2.73216965
          22.32530587	5.33965439
          22.77133045	2.65021161
          24.64635643	5.85053540
          26.15326248	1.95436414
          26.15326248	4.31440137
          29.44910956	3.18159927
          36.60782729	9.81891004
          46.41587526	7.93360690
          52.26527100	6.21800353
          54.37448826	17.51403863
          56.56887291	2.81666592
          60.02755764	3.81953422
          64.97026312	6.41029587
          64.97026312	7.69561916
          106.53476329	4.72718946
          122.35699770	12.15222730
          129.83804263	5.17947179
          129.83804263	12.91550038
          164.62466995	15.50515684
          644.58235659	52.42965436
          817.28094134	59.22247717
          1121.57489904	212.83457841
          1166.83816148	99.39270753
          1213.92708196	143.24671047
          1340.13358489	240.40988856
          1422.07086481	188.42231288
          1569.91580768	90.71346901
          2154.43620741	45.02349233
          2523.84053111	403.47812753
          7344.79483583	838.06995097
          7344.79483583	975.92868928
          44439.21417444	2586.41585803];
        %
        WpT_aves = [ ... % body weight (g), field metabolic rate (kJ/d)
          3.61758861	30.30272251
          4.40889723	32.20597387
          5.06369387	39.85924234
          6.67947573	31.23983706
          7.22947086	61.05401729
          8.14053580	31.23983706
          8.30317093	36.37864977
          8.63825734	32.20597387
          8.63825734	87.99224163
          8.81083617	75.56259225
          9.16641015	38.66351756
          9.16641015	45.02349233
          9.16641015	54.05104635
          9.92118630	62.94220042
          9.92118630	35.28733818
          10.95264249	41.09194663
          10.95264249	36.37864977
          11.17146383	50.85683377
          11.39465214	66.89546991
          11.85449973	50.85683377
          12.57929723	43.67284685
          14.16455247	50.85683377
          14.16455247	59.22247717
          14.16455247	75.56259225
          14.16455247	87.99224163
          15.33087679	77.89942321
          16.59324450	77.89942321
          18.31836127	105.63535801
          19.43837476	73.29581398
          20.62685893	212.83457841
          21.45928552	82.79217880
          21.45928552	73.29581398
          24.64635643	96.41105718
          24.64635643	46.41590847
          28.30676189	96.41105718
          28.30676189	66.89546991
          28.30676189	59.22247717
          33.82280600	85.35259025
          33.82280600	87.99224163
          40.41374320	130.73802247
          44.61537712	119.32170438
          47.34321163	166.81004166
          50.23782902	138.94949778
          55.46082866	123.01189938
          62.45002974	105.63535801
          63.69771026	200.25672881
          63.69771026	206.44995564
          68.94267660	316.22776602
          73.15790966	240.40988856
          76.11027024	271.55791576
          82.37730564	206.44995564
          84.02311047	346.48342474
          87.41394708	73.29581398
          96.50197942	316.22776602
          100.39641327	171.96876978
          102.40221935	326.00735154
          108.66320662	499.35867589
          124.80155127	326.00735154
          135.07790080	581.50055422
          143.33671611	96.41105718
          143.33671611	85.35259025
          152.10048471	415.95626786
          152.10048471	200.25672881
          164.62466995	442.08162109
          178.18011564	741.94277873
          178.18011564	379.63384788
          181.73995158	247.84474823
          185.37075233	143.24671047
          208.73144269	336.08959690
          310.03384309	357.19868965
          385.39927180	637.13707731
          385.39927180	788.54318383
          385.39927180	863.98846733
          393.09877844	279.95605200
          817.28094134	1450.02541742
          938.66113909	1794.60229203
          1036.24861234	975.92868928
          1036.24861234	1245.19704616
          2425.93932450	1588.75920011
          2625.69485793	3507.30408356
          3075.90481573	1323.40615936
          3075.90481573	1966.30408525
          3137.35524203	4756.07582595
          3603.30615364	2289.75077543
          3603.30615364	4084.23983373
          3748.72434392	5886.28618212
          3900.00786236	4756.07582595
          4305.47402341	2833.87583444
          6146.95252724	4903.16110847
          8270.38951601	3300.03566589
          12779.96122955	7982.08667777
          87068.79483044	1794.60229203];
        %
        WpT_mamm = [ ... % body weight (g), field metabolic rate (kJ/d)
          7.37390746	29.39368074
          8.63825734	30.30272251
          9.53633382	26.82696294
          10.32157005	35.28733818
          12.83061727	22.34634927
          14.16455247	36.37864977
          17.26288876	61.05401729
          17.60777419	52.42965436
          19.05762510	43.67284685
          19.82672299	36.37864977
          20.62685893	12.91550038
          20.62685893	42.36277407
          22.32530587	34.22880904
          30.63755782	41.09194663
          31.87399403	54.05104635
          34.49854717	115.74228567
          36.60782729	66.89546991
          39.62217146	42.36277407
          41.22116380	57.44595558
          44.61537712	64.88877833
          44.61537712	77.89942321
          46.41587526	49.33119572
          55.46082866	226.20242545
          55.46082866	82.79217880
          61.22678819	147.67672455
          67.59226016	62.94220042
          79.18184320	147.67672455
          84.02311047	96.41105718
          84.02311047	123.01189938
          102.40221935	130.73802247
          119.96042827	156.95209643
          124.80155127	212.83457841
          167.91368351	171.96876978
          217.15500872	226.20242545
          328.98966218	288.61409481
          631.95658322	863.98846733
          725.81294418	469.84815946
          801.27243003	530.72270726
          938.66113909	677.15433992
          976.54174772	530.72270726
          1238.17996362	677.15433992
          1450.48099649	1207.84356026
          1767.75886877	1406.52747937
          1913.31720542	581.50055422
          2112.23613316	1794.60229203
          2786.23280502	918.25439421
          3200.03602950	2586.41585803
          4221.14044100	547.13571289
          4391.48878330	1171.60984387
          5908.50875000	1688.54697951
          7344.79483583	1688.54697951
          7344.79483583	2666.40448149
          7491.53547838	2027.11486191
          8108.39305011	1966.30408525
          8776.05046536	2360.56460532
          25039.50267591	16082.33769707
          34362.33033850	26181.19426208
          35749.08674457	4613.39981373
          37934.79419507	18727.79774442
          42715.35573360	26181.19426208
          45327.05910243	9295.09799480
          51039.19752304	37732.84828755
          78869.19524999	38899.77813509
          88808.33026805	41343.00622799
          94238.25146051	52749.96682354];

        WpT = [WpT_rep; WpT_aves; WpT_mamm]; pT = WpT(:,2)./WpT(:,1);
        fprintf('range in weight-specific metabolic rate \n')';
        fprintf(['min ', num2str(min(pT)), ' kJ/d.g; max ', num2str(max(pT)), ' kJ/d.g; factor ', num2str(max(pT)/min(pT)),'\n'])

        figure
        plot(log10(WpT_rep(:,1)),  log10(WpT_rep(:,2)),  'og', ...
        log10(WpT_aves(:,1)), log10(WpT_aves(:,2)), 'or', ...
        log10(WpT_mamm(:,1)), log10(WpT_mamm(:,2)), 'ok', 'LineWidth', 1, 'MarkerSize', 5);
        set(gca, 'FontSize', 15, 'Box', 'on')
        xlabel('_{10}log body weight, g')
        ylabel('_{10}log field metabolic rate, kJ/d')
        title('Nagy2005')
        xlim([0 8.5])
        
        figure
        plot(log10(WpT_rep(:,1)),  log10(WpT_rep(:,2)./WpT_rep(:,1)),  'og', ...
        log10(WpT_aves(:,1)), log10(WpT_aves(:,2)./WpT_aves(:,1)), 'or', ...
        log10(WpT_mamm(:,1)), log10(WpT_mamm(:,2)./WpT_mamm(:,1)), 'ok', 'LineWidth', 1, 'MarkerSize', 5);
        set(gca, 'FontSize', 15, 'Box', 'on')
        xlabel('_{10}log body weight, g')
        ylabel('_{10}log spec. field metabolic rate, kJ/d.g')
        title('Nagy2005')
        xlim([0 8.5])
        ylim([-3 1.5])
        %saveas(gca,'Wwi_pT_Nagy2005.png')


      case 6 % fig 2b: 
        var = read_allStat('Ww_i', 'p_Ti', 'c_T'); Ww_i = var(:,1); p_Ti = 1e-3*var(:,2)./var(:,1);
        legend = {...
          {'o', 5, 1, [0 0 1], [1 1 1]}, 'Lepidosauria'; ....
          {'o', 5, 1, [0 0 1], [1 1 1]}, 'Testudines'; ....
          {'o', 5, 1, [0 0 1], [1 1 1]}, 'Crocodilia'; ....
          {'o', 5, 1, [1 0 0], [1 1 1]}, 'Aves'; ....
          {'o', 5, 1, [0 0 0], [1 1 1]}, 'Mammalia'; ....
        };
        shstat_options('default');
        [Hfig_Wp, Hleg_Wp] = shstat([Ww_i, p_Ti], legend, 'AmP at T_{typical}'); 
        figure(Hfig_Wp) 
        xlabel('_{10}log max body weight, g')
        ylabel('_{10}log spec. heat dissipation, kJ/d.g')
        xlim([0 8.5])
        ylim([-3 1.5])
        %saveas(gca,'Wwi_pT_AmP2023.png')
     
      case 7 % fig 3a: Wwi, Wdi
        figure
        WW = read_allStat('Wd_i','Ww_i'); Wdi = WW(:,1); Wwi = WW(:,2);
        Wdi_med = median(Wdi); Wdi_min = min(Wdi); Wdi_max = max(Wdi);
        Wwi_med = median(Wwi); Wwi_min = min(Wwi); Wwi_max = max(Wwi);
        surv_Wdi = surv(Wdi); surv_Wwi = surv(Wwi); 
        W = 10.^linspace(log10(Wdi_min),log10(Wwi_max),500)'; 
        %
        AB = wblML(Wdi); % gives MLEs
        %A_Wdi = AB(1); B_Wdi = AB(2); S_Wdi = 1-wblcdf(W,A_Wdi,B_Wdi);
        A_Wdi = AB(1); B_Wdi = AB(2); S_Wdi = exp(-(W/A_Wdi).^B_Wdi);
        fprintf(['Pars Weibull for Wdi: ', num2str(A_Wdi), '  g; ', num2str(B_Wdi), '\n'])
        [M, V] = wblStat(A_Wdi,B_Wdi); 
        fprintf(['mean & var: ', num2str(M), ' , ', num2str(V),'\n'])
        AB = wblML(Wwi); % gives MLE
        A_Wwi = AB(1); B_Wwi = AB(2); S_Wwi = exp(-(W/A_Wwi).^B_Wwi);
        fprintf(['Pars Weibull for Wdi: ', num2str(A_Wwi), '  g; ', num2str(B_Wwi), '\n'])
        [M, V] = wblStat(A_Wwi,B_Wwi); 
        fprintf(['mean & var: ', num2str(M), ' , ', num2str(V),'\n'])
        %
        plot(log10(W), S_Wdi, '-', 'color', [1 0.75 0.75], 'linewidth',8)
        set(gca, 'FontSize', 15, 'Box', 'on', 'YTick', 0:0.2:1)
       
        hold on
        plot(log10(W), S_Wwi, '-', 'color', [0.75 0.75 1], 'linewidth',8)
        plot([log10(Wdi_min); log10(Wdi_med); log10(Wdi_med)], [0.5;0.5;0], 'r', log10(surv_Wdi(:,1)), surv_Wdi(:,2), 'r', 'Linewidth', 2)
        plot([log10(Wwi_min); log10(Wwi_med); log10(Wwi_med)], [0.5;0.5;0], 'b', log10(surv_Wwi(:,1)), surv_Wwi(:,2), 'b', 'Linewidth', 2)
        xlabel('_{10}log maximum body weight, g') 
        ylabel('survivor function')
        %saveas(gca, 'Wi.png')
  
      case 8 % fig 3b: Li
        figure
        Li = read_allStat('L_i'); 
        Li_med = median(Li); Li_min = min(Li); Li_max = max(Li);
        surv_Li = surv(Li); 
        Z = 10.^linspace(log10(Li_min),log10(Li_max),500)'; 
        %AB = wblfit(Li, 0.05); % gives MLEs and 100(1-ALPHA)% CI
        AB = wblML(Li); % gives MLEs
        %A = AB(1); B = AB(2); S = 1-wblcdf(Z,A,B);
        A = AB(1); B = AB(2); S = exp(-(Z/A).^B);
        fprintf(['Pars Weibull for Li: ', num2str(A), '  d/J; ', num2str(B), '\n'])
        [M, V] = wblStat(A,B); 
        fprintf(['mean & var: ', num2str(M), ' , ', num2str(V),'\n'])
        plot(log10(Z), S, '-', 'color', [0.75 0.75 1], 'linewidth',8)
        set(gca, 'FontSize', 15, 'Box', 'on', 'YTick', 0:0.2:1)
       
        hold on
        plot([log10(Li_min); log10(Li_med); log10(Li_med)], [0.5;0.5;0], 'r', log10(surv_Li(:,1)), surv_Li(:,2), 'b', 'Linewidth', 2)
        xlabel('_{10}log max struct. length L_\infty, cm') 
        ylabel('survivor function')
        %saveas(gca,'Li.png')

      case 9 % fig 4a: s_s
        figure 
        ss = read_allStat('s_s'); ss_max = 4/27;
        ss_med = median(ss); ss_min = min(ss);  m = mean(ss); v = mean(ss.^2) - mean(ss)^2;
        surv_ss = surv(ss); 
        M = m/ss_max; V = v/ss_max^2; 
        a = M*(M*(1-M)/V-1); b = a*(1-M)/M;
        fprintf(['pars beta for s_s: ', num2str(a), ' , ', num2str(b),'\n'])
        ss =linspace(0,1,100)'; S = 1 - betainc(ss,a,b);
        plot(ss*ss_max, S, '-', 'color', [0.75 0.75 1], 'linewidth',8)
        set(gca, 'FontSize', 15, 'Box', 'on', 'YTick', 0:0.2:1)
       
        hold on
        plot([ss_min; ss_med; ss_med], [0.5;0.5;0], 'r', surv_ss(:,1), surv_ss(:,2), 'b', 'Linewidth', 2)
        xlabel('supply stress s_s, -') 
        ylabel('survivor function')
        %saveas(gca,'ss.png')

      case 10 % fig 4b: p_Ji/p_Ai
        figure 
        vars = read_allStat('p_Ji','p_Si','p_Ai'); p_Ji = vars(:,1); p_Si = vars(:,2); p_Ai = vars(:,3); 
        s_JA = p_Ji./p_Ai; sJA_max = 1; 
        sJA_med = median(s_JA); sJA_min = min(s_JA);  m = mean(s_JA); v = mean(s_JA.^2) - mean(s_JA)^2;
        surv_sJA = surv(s_JA); 
        M = m/sJA_max; V = v/sJA_max^2; 
        a = M*(M*(1-M)/V-1); b = a*(1-M)/M;
        fprintf(['pars beta for s_JA: ', num2str(a), ' , ', num2str(b),'\n'])
        S_JA =linspace(0,1,100)'; S = 1 - betainc(S_JA,a,b);
        plot(S_JA*sJA_max, S, '-', 'color', [0.75 0.75 1], 'linewidth',8)
        set(gca, 'FontSize', 15, 'Box', 'on', 'YTick', 0:0.2:1)
       
        hold on
        plot([sJA_min; sJA_med; sJA_med], [0.5;0.5;0], 'r', surv_sJA(:,1), surv_sJA(:,2), 'b', 'Linewidth', 2)
        xlabel('p_J^\infty/p_A^\infty, -') 
        ylabel('survivor function')
        %saveas(gca,'sJA.png')

      case 11 % not numbered (for testing): p_Si/p_Ai = kap
        %figure 
        vars = read_allStat('p_Ji','p_Si','p_Ai'); p_Ji = vars(:,1); p_Si = vars(:,2); p_Ai = vars(:,3); 
        s_SA = p_Si./p_Ai; sSA_max = 1;
        sSA_med = median(s_SA); sSA_min = min(s_SA);  m = mean(s_SA); v = mean(s_SA.^2) - mean(s_SA)^2;
        surv_sSA = surv(s_SA); 
        M = m; V = v; 
        a = M*(M*(1-M)/V-1); b = a*(1-M)/M;
        fprintf(['pars beta for s_SA: ', num2str(a), ' , ', num2str(b),'\n'])
        S_SA =linspace(0,1,100)'; S = 1 - betainc(S_SA,a,b);
        plot(S_SA*sSA_max, S, '-', 'color', [0.75 0.75 1], 'linewidth',8)
        set(gca, 'FontSize', 15, 'Box', 'on', 'YTick', 0:0.2:1)
       
        hold on
        plot([sSA_min; sSA_med; sSA_med], [0.5;0.5;0], 'b', surv_sSA(:,1), surv_sSA(:,2), 'b', 'Linewidth', 2)
        [Hfig Hleg] = shstat({'kap'}, {'r', 'r'},[]);
        xlabel('p_S^\infty/p_A^\infty, \kappa,  -')
        ylabel('survivor function')
        %saveas(gca,'sSA.png')
    
      case 12 % fig 5a: {p_Am} s_M L_i^2
        figure 
        pAsM = read_allStat('p_Am','s_M', 'L_i'); pA = pAsM(:,1) .*pAsM(:,2) .* pAsM(:,3).^2;
        surv_pA = surv(pA); 
        pA_med = median(pA); pA_min = min(pA); pA_max = max(pA); 
        PA = 10.^linspace(log10(pA_min),log10(pA_max),500)'; 
        %AB = wblfit(pA, 0.05); % gives MLEs and 100(1-ALPHA)% CI
        AB = wblML(pA); % gives MLEs
        A = AB(1); B = AB(2);
        fprintf(['Pars Weibull for p_A: ', num2str(A), ' d/J; ', num2str(B), '\n'])
        %[M, V] = wblstat(A,B); S = 1-wblcdf(PA, A, B);
        [M, V] = wblStat(A,B); S = exp(-(PA/A).^B);
        fprintf(['mean & var: ', num2str(M), ' , ', num2str(V),'\n'])
        plot(log10(PA), S, '-', 'color', [0.75 0.75 1], 'linewidth',8)
        set(gca, 'FontSize', 15, 'Box', 'on', 'YTick', 0:0.2:1)
       
        hold on
        plot([log10(pA_min); log10(pA_med); log10(pA_med)], [0.5;0.5;0], 'r', log10(surv_pA(:,1)), surv_pA(:,2), 'b', 'Linewidth', 2)
        xlabel('_{10}log max assimilation p_A^\infty, J/d') 
        ylabel('survivor function')
        %saveas(gca,'pAi.png')

      case 13 % fig 5b: [p_M] L_i^3
        figure
        pMLi = read_allStat('p_M', 'L_i'); pM = pMLi(:,1) .* pMLi(:,2).^3;
        pM_med = median(pM); pM_min = min(pM); pM_max = max(pM);
        surv_pM = surv(pM); 
        PM = 10.^linspace(log10(pM_min),log10(pM_max),500)'; 
        %AB = wblfit(pM, 0.05); % gives MLEs and 100(1-ALPHA)% CI
        AB = wblML(pM); % gives MLEs
        %A = AB(1); B = AB(2); S = 1-wblcdf(PM,A,B);
        A = AB(1); B = AB(2); S = exp(-(PM/A).^B);
        fprintf(['Pars Weibull for p_M: ', num2str(A), '  J/d; ', num2str(B), '\n'])
        [M, V] = wblStat(A,B); 
        fprintf(['mean & var: ', num2str(M), ' , ', num2str(V),'\n'])
        plot(log10(PM), S, '-', 'color', [0.75 0.75 1], 'linewidth',8)
        set(gca, 'FontSize', 15, 'Box', 'on', 'YTick', 0:0.2:1)
        
        hold on
        plot([log10(pM_min); log10(pM_med); log10(pM_med)], [0.5;0.5;0], 'r', log10(surv_pM(:,1)), surv_pM(:,2), 'b', 'Linewidth', 2)
        xlabel('_{10}log max somatic maintenance p_M^\infty, J/d') 
        ylabel('survivor function')
        %saveas(gca,'pMi.png')
    
      case 14 % fig 5c: k_J E_Hp
        figure 
        vars = read_allStat('k_J', 'E_Hp'); pJ = vars(:,1) .* vars(:,2);
        pJ_med = median(pJ); pJ_min = min(pJ); pJ_max = max(pJ); 
        surv_pJ = surv(pJ); 
        PJ = 10.^linspace(log10(pJ_min),log10(pJ_max),500)'; 
        %AB = wblfit(pJ, 0.05); % gives MLEs and 100(1-ALPHA)% CI
        AB = wblML(pJ); % gives MLEs
        %A = AB(1); B = AB(2); S = 1-wblcdf(PJ,A,B);
        A = AB(1); B = AB(2); S = exp(-(PJ/A).^B);
        fprintf(['Pars Weibull for p_J: ', num2str(A), ' J/d; ',  num2str(B), '\n'])
        [M, V] = wblStat(A,B); 
        fprintf(['mean & var: ', num2str(M), ' , ', num2str(V),'\n'])
        plot(log10(PJ), S, '-', 'color', [0.75 0.75 1], 'linewidth',8)
        set(gca, 'FontSize', 15, 'Box', 'on', 'YTick', 0:0.2:1)
        
        hold on
        plot([log10(pJ_min); log10(pJ_med); log10(pJ_med)], [0.5;0.5;0], 'r', log10(surv_pJ(:,1)), surv_pJ(:,2), 'b', 'Linewidth', 2)
        xlabel('_{10}log max maturation maintenance p_J^\infty, J/d') 
        ylabel('survivor function')
        %saveas(gca,'pJi.png')
    
      case 15 % not numbered: pRi
        figure
        pRcT = read_allStat('p_Ri','c_T'); pR = pRcT(:,1) ./ pRcT(:,2);
        pR_med = median(pR); pR_min = min(pR); pR_max = max(pR);
        surv_pR = surv(pR); 
        PR = 10.^linspace(log10(pR_min),log10(pR_max),500)'; 
        %AB = wblfit(pR, 0.05); % gives MLEs and 100(1-ALPHA)% CI
        AB = wblML(pR); % gives MLEs
        %A = AB(1); B = AB(2); S = 1-wblcdf(PR,A,B);
        A = AB(1); B = AB(2); S = exp(-(PR/A).^B);
        fprintf(['Pars Weibull for p_R: ', num2str(A), '  d/J; ', num2str(B), '\n'])
        [M, V] = wblStat(A,B); 
        fprintf(['mean & var: ', num2str(M), ' , ', num2str(V),'\n'])
        plot(log10(PR), S, '-', 'color', [0.75 0.75 1], 'linewidth',8)
        set(gca, 'FontSize', 15, 'Box', 'on', 'YTick', 0:0.2:1)
        
        hold on
        plot([log10(pR_min); log10(pR_med); log10(pR_med)], [0.5;0.5;0], 'r', log10(surv_pR(:,1)), surv_pR(:,2), 'b', 'Linewidth', 2)
        xlabel('_{10}log max reproduction p_R^\infty, J/d') 
        ylabel('survivor function')
        %saveas(gca,'pRi.png')
        
      case 16 % fig 6: p_Si/p_Ai - p_J/p_S
        shstat_options('default');
        shstat_options('x_transform', 'none');
        shstat_options('y_transform', 'none');
        shstat_options('x_label', 'on');
        shstat_options('y_label', 'on');

        vars = read_allStat('p_Ji','p_Si','p_Ai'); p_Ji = vars(:,1); p_Si = vars(:,2); p_Ai = vars(:,3); 
        s_JA = p_Ji./p_Ai; s_SA = p_Si./p_Ai; 

        figure % s_JA-s_SA
        [Hfig Hleg] = shstat([s_JA, s_SA], legend_RSED,[],1);
        figure(Hfig) % add items to figure
        xlabel('p_J^\infty/p_A^\infty, -')
        ylabel('p_S^\infty/p_A^\infty, -')
        kap = linspace(1e-6,1,100); ss =  (1 - kap); 
        plot(ss, kap, 'k', 'Linewidth', 2)
        %saveas(gca,'sJA_sSA.png')
        %saveas(Hleg,['legend_sJA_sSA_RSED.png'])
        
      case 17 % not numbered: p_Ri/p_Ai - p_S/p_Ai
        shstat_options('default');
        shstat_options('x_transform', 'none');
        shstat_options('y_transform', 'none');
        shstat_options('x_label', 'on');
        shstat_options('y_label', 'on');

        vars = read_allStat('p_Ri','p_Si','p_Ai'); p_Ri = vars(:,1); p_Si = vars(:,2); p_Ai = vars(:,3); 
        s_RA = p_Ri./p_Ai; s_SA = p_Si./p_Ai;

        figure % s_RA-s_SA
        [Hfig Hleg] = shstat([s_RA, s_SA], legend_RSED,[],1);
        figure(Hfig) % add items to figure
        xlabel('p_R^\infty/p_A^\infty, -')
        ylabel('p_S^\infty/p_A^\infty, -')
        kap = linspace(1e-6,1,100); ss =  (1 - kap); 
        plot(ss, kap, 'k', 'Linewidth', 2)
        %saveas(gca,'sRA_sSA.png')
        %saveas(Hleg,['legend_sRA_sSA_RSED.png'])
        
      case 18 % fig 7: {p_Am} s_M - [p_M]
        shstat_options('default');
        shstat_options('x_transform', 'log10');
        shstat_options('y_transform', 'log10');
        sMpAmpM = read_allStat('s_M', 'p_Am', 'p_M'); 
        p_Am = prod(sMpAmpM(:,[1 2]),2); p_M = sMpAmpM(:,3); 

        [Hfig Hleg] = shstat([p_Am, p_M], legend_RXSE, ['Invertebrata ', datestr(datenum(date),'yyyy/mm/dd')], 1); 
        figure(Hfig)
        xlabel('_{10}log s_M \{p_{Am}\}, J/d.cm^2')      
        ylabel('_{10}log [p_M], J/d.cm^3')
        %saveas(gca,'pAm_pM_RXSE.png')
        %saveas(Hleg,'legend_pAm_pM_RXSE.png')
    
        [Hfig Hleg] = shstat([p_Am, p_M], legend_fish, ['Fish & Amphibia ', datestr(datenum(date),'yyyy/mm/dd')], 3); 
        figure(Hfig) 
        xlabel('_{10}log s_M\{p_{Am}\}, J/d.cm^2')      
        ylabel('_{10}log [p_M], J/d.cm^3')
        %saveas(gca,'pAm_pM_fish.png')
        %saveas(Hleg,'legend_pAm_pM_fish.png')

        [Hfig Hleg] = shstat([p_Am, p_M], legend_aves, ['Sauropsida ', datestr(datenum(date),'yyyy/mm/dd')], 5); 
        figure(Hfig) 
        xlabel('_{10}log \{p_{Am}\}, J/d.cm^2')      
        ylabel('_{10}log [p_M], J/d.cm^3')
        %saveas(gca,'pAm_pM_aves.png')
        %saveas(Hleg,'legend_pAm_pM_aves.png')

        [Hfig Hleg] = shstat([p_Am, p_M], legend_mamm, ['Mammalia ', datestr(datenum(date),'yyyy/mm/dd')], 7); 
        figure(Hfig) 
        xlabel('_{10}log \{p_{Am}\}, J/d.cm^2')      
        ylabel('_{10}log [p_M], J/d.cm^3')
        %saveas(gca,'pAm_pM_mamm.png')
        %saveas(Hleg,'legend_pAm_pM_mamm.png')

      case 19 % fig 8: L_i - v s_M     
        shstat_options('default');
        shstat_options('x_transform', 'log10');
        shstat_options('y_transform', 'log10');
        vars = read_allStat('s_M', 'p_Am', 'v', 'p_M', 'kap'); 
        p_Am = prod(vars(:,[1 2]),2); v = prod(vars(:,[1 3]),2); p_M = vars(:,4); kap = vars(:,5);
        xtxt = '_{10}log L_\infty, cm';
        ytxt = '_{10}log s_M v, cm/d';
        v1 = kap.*p_Am./p_M; v2 = v; vtxt = 'Li_v';

        [Hfig, Hleg] = shstat([v1, v2], legend_RXSE, 'invertebrates', 1); 
        figure(Hfig)
        xlabel(xtxt)      
        ylabel(ytxt)
        %saveas(gca,[vtxt, '_RXSE.png'])
        %saveas(Hleg,['legend_', vtxt, '_RXSE.png'])
    
        [Hfig Hleg] = shstat([v1, v2], legend_fish, 'fish & amphibia', 3); 
        figure(Hfig)
        xlabel(xtxt)      
        ylabel(ytxt)
        %saveas(gca,[vtxt, '_fish.png'])
        %saveas(Hleg,['legend_', vtxt, '_fish.png'])

        [Hfig Hleg] = shstat([v1, v2], legend_aves, 'sauropsids', 5); 
        figure(Hfig) 
        xlabel(xtxt)      
        ylabel(ytxt)
        %saveas(gca,[vtxt, '_aves.png'])
        %saveas(Hleg,['legend_', vtxt, '_aves.png'])

        [Hfig Hleg] = shstat([v1, v2], legend_mamm, 'mammals', 7); 
        figure(Hfig)
        xlabel(xtxt)      
        ylabel(ytxt)
        %saveas(gca,[vtxt, '_mamm.png'])
        %saveas(Hleg,['legend_', vtxt, '_mamm.png'])
 
      case 20 % fig 9: [p_M] - a_m  
        shstat_options('x_transform', 'log10');
        shstat_options('y_transform', 'log10');
        shstat_options('x_label', 'off'); 
        shstat_options('y_label', 'on'); 
        vars = read_allStat('p_M','a_m','c_T'); p_M = vars(:,1); a_m = vars(:,2) .* vars(:,3); 
        [hfig hleg] = shstat([p_M, a_m], legend_mamm, 'mammals at 20 C', 1);
        figure(hfig) 
        set(gca, 'FontSize', 15, 'Box', 'on')
        xlabel('spec. somatic maintenance _{10}log [p_M], J/d.cm^3')
        ylabel('longevity _{10}log a_m, d')
        %saveas(hfig, 'pM_am_mamm.png')
        %saveas(hleg, 'legend_pM_am_mamm.png')

        [hfig hleg] = shstat([p_M, a_m], legend_aves, 'birds at 20 C', 3);
        figure(hfig) 
        set(gca, 'FontSize', 15, 'Box', 'on')
        xlabel('spec. somatic maintenance _{10}log [p_M], J/d.cm^3')
        ylabel('longevity _{10}log a_m, d')
        %saveas(hfig, 'pM_am_aves.png')
        %saveas(hleg, 'legend_pM_am_aves.png')

    end
  end
end

