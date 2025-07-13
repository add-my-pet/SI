function VerhKooy2025_SI(fig)
% Supporting Information for VerhKooy2025
% Title: Aerobic scope in the context of the supply-demand spectrum
% Authors: Verhille, Kooijman
% Journal: Ecol. Mod
% DOI: 
% Date: 2025/07/02
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
% To run the code for a figure: type in the Matlab window e.g. VerhKooy2025_SI(1)
%
% Remarks: 
%  The figures show current AmP data, which might change in time; the results might differ from the publication
%  The scripts call functions read_popStat and read_allStat; the first call to these functions loads the .mat file, which can take some time
%  Click on a marker in the Matlab-figure to see the species name
%  Uncomment "print" to save the Matlab-figure to a png-file
%  Modify selection of taxa and markers by changing the legend, see https://add-my-pet.github.io/AmPtool/docs/index.html
%  Allowed names of taxa match the names of the tree nodes at http://www.bio.vu.nl/thb/deb/deblab/add_my_pet/species_tree_Animalia.html
%
% Example of use
% VerhKooy2025_SI(1)

close all
if ~exist('fig','var')
   fig = 1:31;
end

 legend = { ... % % colors from legend_vert
   {'o', 8, 3, [0 0 1], [0 0 1]}, 'Actinopterygii'; 
   {'o', 8, 3, [1 0 0], [1 0 0]}, 'Aves'; 
   {'o', 8, 3, [1 .5 .5], [0 0 0]}, 'Masupialia'
   {'o', 8, 3, [1 .5 .5], [1 .5 .5]}, 'Placentalia'
 };
 % Hlegend = shlegend(legend);
 % saveas(Hlegend,'legend_AS.png')

  legend_aves = {...
   %{'o', 8, 3, [0 0 0], [0 0 0]}, 'Crocodilia'
    {'o', 8, 3, [0 0 1], [0 0 0]}, 'Paleognathae'
    {'o', 8, 3, [0 0 1], [0 0 1]}, 'Galloanserae'
    % Neoaves: edge magenta and red
    {'o', 8, 3, [1 0 1], [0 0 0]}, 'Mirandornithes'
    {'o', 8, 3, [1 0 1], [0 0 1]}, 'Gruimorphae'
    {'o', 8, 3, [1 0 1], [1 0 1]}, 'Opisthocomiformes'
    {'o', 8, 3, [1 0 1], [1 0 0]}, 'Strisores'
    {'o', 8, 3, [1 0 1], [1 1 1]}, 'Columbea'
    % Passerea: edge red
    {'o', 8, 3, [1 0 0], [0 0 0]}, 'Elementaves'
    {'o', 8, 3, [1 0 0], [0 0 1]}, 'Afroaves'
    {'o', 8, 3, [1 0 0], [1 0 0]}, 'Australaves'
  };

  legend_mamm = {...
    {'o', 8, 3, [0 0 0], [1 1 1]}, 'Prototheria'; ...
    {'o', 8, 3, [0 0 1], [1 1 1]}, 'Marsupialia'; ...
    {'o', 8, 3, [0 0 1], [0 0 1]}, 'Xenarthra'; ...
    {'o', 8, 3, [0 0 1], [1 0 1]}, 'Afrotheria'; ....
    {'o', 8, 3, [0 0 1], [1 0 0]}, 'Laurasiatheria'; ....
    {'o', 8, 3, [1 0 1], [1 0 1]}, 'Gliriformes'; ....
    {'o', 8, 3, [1 0 1], [1 0 0]}, 'Scandentia'; ....
    {'o', 8, 3, [1 0 0], [1 0 0]}, 'Dermoptera'; ....
    {'o', 8, 3, [1 0 0], [1 .5 .5]}, 'Primates'; ....
  };

     % 1 mg O2/h = 0.7 ml O2/h
     act = { ... % Actinopterygii, mass(g), temp(C), SMR(ml O2/min), PMR(ml O2/min), MMR(ml O2/min) 
       [  0.45 24    8.8  13.6  20.1], 'FuDong2022', 'Danio_rerio' % 463 717 1066 mg O2/h.kg, 1
       [  7    25   59.7 170.8 382.2], 'FuDong2022', 'Zacco_platypus' % 203 581 1300 mg O2/h.kg
       [  7.72 25   64.7 138.2 199.9], 'FuDong2022', 'Carassius_auratus' % 220 470  680 mg O2/h.kg
       [ 10.49 15   52.9 114.1 215.9], 'FuDong2022', 'Carassius_auratus' % 120 259  490 mg O2/h.kg
       [  9.68 25   96.4 255.7 447.2], 'FuDong2022', 'Carassius_auratus' % 237 629 1100 mg O2/h.kg
       [  7.42 25   59.5  92.3 322.2], 'FuDong2022', 'Ctenopharyngodon_idella' % 191 296 1034 mg O2/h.kg
       [ 19.52 25   94.3 164.8 639.5], 'FuDong2022', 'Procypris_rabaudi' % 115 201  780 mg O2/h.kg
       [  8.27 15   29.9  46.2 190.0], 'FuDong2022', 'Parabramis_pekinensis' % 86 133  547 mg O2/h.kg
       [  4.62 25   56.3  97.0 244.5], 'FuDong2022', 'Parabramis_pekinensis' % 290 500 1260 mg O2/h.kg
       [  7.94 15   37.2  83.0 207.1], 'FuDong2022', 'Cyprinus_carpio' % 113 252  629 mg O2/h.kg
       [  7.56 25   81.3 147.3 362.0], 'FuDong2022', 'Cyprinus_carpio' % 256 464 1140 mg O2/h.kg
       [  4.62 25   42.7  67.9 213.4], 'FuDong2022', 'Mylopharyngodon_piceus' % 220 350 1100 mg O2/h.kg
       [  7.72 15   33.4  67.7 165.1], 'FuDong2022', 'Spinibarbus_sinensis' % 103 209  510 mg O2/h.kg
       [  7.71 25   51.8  91.6 385.3], 'FuDong2022', 'Spinibarbus_sinensis' % 160 283 1190 mg O2/h.kg
       [ 22.45 15   50.9 140.5 231.0], 'FuDong2022', 'Silurus_meridionalis' % 54 149  245 mg O2/h.kg
       [ 12.89 25   61.7 276.1 412.0], 'FuDong2022', 'Silurus_meridionalis' % 114 510  761 mg O2/h.kg
       [ 30    23  123.5 279.7 442.2], 'FuDong2022', 'Silurus_asotus' % 98 222  351 mg O2/h.kg
       [  6.65 25   65.6  95.2 284.9], 'FuDong2022', 'Tachysurus_vachellii' % 235 341 1020 mg O2/h.kg
       [520     9 1048  2381 10702  ], 'FuDong2022', 'Oncorhynchus_tshawytscha' % 48 109  490 mg O2/h.kg
       [  6    15   47.6 148.9 198.3], 'FuDong2022', 'Oncorhynchus_mykiss' % 189 591  787 mg O2/h.kg
       [364    22.5 1529 2446  5351 ], 'FuDong2022', 'Dicentrarchus_labrax' % 100 160  350 mg O2/h.kg
       [105    17   573  838  1680  ], 'FuDong2022', 'Pagrus_auratus' % 130 190  381 mg O2/h.kg
       [107    21   732 1123  2103  ], 'FuDong2022', 'Pagrus_auratus' % 163 250  4681 mg O2/h.kg
       [ 30    17   131  245.7 864.4], 'FuDong2022', 'Aldrichetta_forsteri' % 104 195  686 mg O2/h.kg
       [ 29    21   151  255.8 973.2], 'FuDong2022', 'Aldrichetta_forsteri' % 124 210  799 mg O2/h.kg
       [706    26   5930 23722 40445], 'FuDong2022', 'Coryphaena_hippurus' % 200 800 1364 mg O2/h.kg
       [135.5  26    513  2521  2003], 'FuDong2022', 'Pterois_volitans' % 90 443  352 mg O2/h.kg
       [135.5  32    944  2794  1969], 'FuDong2022', 'Pterois_volitans' % 166 491  346 mg O2/h.kg
     };
    %prt_tab({act(:,[3 2]), cell2mat(act(:,1))},{'species', 'bibkey', 'mass,g', 'temp,C', 'SMR,ml O2/min', 'PMR,ml O2/min', 'MMR,ml O2/min'}, 'Actinop')

    ave = { ...  % Aves ; m(g) Tb(C) BMR(ml O2/min) PMR (ml O2/min); x means not in AmP
       [  36.0 39.7  1.28   7.91], 'HindBaud1993', 'Melopsittacus_undulatus' % BundHopl1999 give AS 21
       [  89.4 40.0  NaN   12.79], 'HindBaud1993', 'Platycercus_elegans' % actually Platycercus_eximius
       [  42.1 40.5  1.20   6.57], 'HindBaud1993', 'Synoicus_chinensis' 
       [ 161.0 41.3  4.41  20.48], 'HindBaud1993', 'Coturnix_japonica' 
       [ 850.3 37.4  9.19  52.08], 'HindBaud1993', 'Porphyrio_martinica' 
      %[ 944.1 39.7 12.23  61.51], 'HindBaud1993', 'Anas_castanea' %x
       [ 302.0 41.7  4.34  28.24], 'HindBaud1993', 'Columba_livia' 
       [1080.0 38.5 13.31  57.42], 'HindBaud1993', 'Eudyptula_minor' 
       [  11.3 41.0  0.68   4.03], 'HindBaud1993', 'Taeniopygia_guttata' 
       [21800  39.0 103.6   3728], 'BundHopl1999', 'Rhea_americana' % 2.85 ml O2/s.kg, AS 36
       [ 2800  41.0  24.1 299.60], 'BracElSa1985', 'Gallus_gallus_WL' % 8.6, 107 ml CO2/min.kg
       [45000  36.0 301500 2340000], 'KooyPong1994', 'Aptenodytes_forsteri' % 6.7, 52 ml O2/min.kg
       [55000  36.0 215050 2473075], 'MainKing1989', 'Dromaius_novaehollandiae' %  3.91 ml O2/min.kg, AS 11.5 BundHopl1999
       [130000  34.6 613600 10738000], 'MainKing1989', 'Struthio_camelus' %  4.72 ml O2/min.kg, AS 17.5 BundHopl1999
    };     
    %prt_tab({ave(:,[3 2]), cell2mat(ave(:,1))},{'species', 'bibkey', 'mass,g', 'temp,C', 'SMR,mg O2/h.kg', 'PMR,mg O2/h.kg'}, 'Aves')

    mar = { ... % Marsupialia & Prototheria; m(g), Tb(C), BMR(ml O2/min), PMR (ml O2/min); x means not in AmP
     [ 1112.5 30.8 10.87  49.86], 'HindBaud1993', 'Ornithorhynchus_anatinus' 
     [ 3293.0 30.8  7.76  47.05], 'HindBaud1993', 'Tachyglossus_aculeatus' 
     [   15.6 35.0  0.48   2.38], 'HindBaud1993', 'Sminthopsis_crassicaudata' 
     [   16.7 32.7  0.35   2.38], 'HindBaud1993', 'Sminthopsis_macroura'
     [  119.5 35.3  1.52  19.36], 'HindBaud1993', 'Dasyuroides_byrnei'
    %[  532.3 33.7  3.20  29.85], 'HindBaud1993', 'Dasyurus_hallucatus' %x
     [ 1054.0 35.1  6.28  69.60], 'HindBaud1993', 'Dasyurus_viverrinus' 
     [  717.2 33.9  3.71  43.43], 'HindBaud1993', 'Isoodon_obesulus'
     [  837.3 35.2  7.01  48.76], 'HindBaud1993', 'Perameles_gunnii'
     [  122.0 34.9  1.40   8.24], 'HindBaud1993', 'Petaurus_breviceps' 
     [  965.7 37.2  9.39  70.07], 'HindBaud1993', 'Bettongia_penicillata'
     [ 1027.8 35.8  8.72  65.90], 'HindBaud1993', 'Potorous_tridactylus' 
     [ 1385.0 35.6 10.69 100.10], 'HindBaud1993', 'Bettongia_gaimardi' 
     [ 2026.5 35.8 13.85  74.65], 'HindBaud1993', 'Trichosurus_vulpecula'
    };
    %  
    pla = {... % Placentalia; m(g), Tb(C), BMR(ml O2/min), PMR (ml O2/min); %x means not in AmP
     [   38.8 36.2  0.83   3.48], 'HindBaud1993', 'Notomys_alexis'
    %[  165.7 36.2  2.05  11.51], 'HindBaud1993', 'Rattus_colletti' %x
     [  181.2 38.0  4.47  21.90],     'Lech1978', 'Rattus_norvegicus' 
     [  212.3 35.9  2.71  14.85], 'HindBaud1993', 'Conilurus_penicillatus' 
    %[  247.8 36.0  2.43  14.48], 'HindBaud1993', 'Rattus_villosissimus' %x
    %[  819.0 34.6  9.51  44.27], 'HindBaud1993', 'Uromys_caudimaculatus' %x
     [ 1242.0 38.3 14.56  63.58], 'HindBaud1993', 'Oryctolagus_cuniculus'
     [   28.0 37.0  1.28   6.30],     'Lech1978', 'Myodes_rutilus'
     [    6.9 36.0  0.24   1.41],     'Lech1978', 'Baiomys_taylori'
     [   34   37.0  0.88   5.30],     'Lech1978', 'Mus_musculus'
     [  113   38.0  2.47  11.20],     'Lech1978', 'Mesocricetus_auratus'
     [   48   38.0  0.93   5.34],     'Lech1978', 'Calomys_callosus'
     [    3.3 39.0  0.15   1.60],     'Lech1978', 'Sorex_cinereus'
     [32000   39.5 152.5   9792], 'LindHoka1991', 'Antilocapra_americana' % 5.1 ml O2/s.kg = 9792 ml O2/min; Bish1999 AS = 64.2; BMR = 9792/64.2 ml O2/min
     [70000   37.0 268.3   3733], 'WillSton2005', 'Homo_sapiens' % 0.23, 3.2 ml O2/h.g
     };               
    %prt_tab({[mar(:,[3 2]);pla(:,[3 2])], [cell2mat(mar(:,1));cell2mat(pla(:,1))]},{'species', 'bibkey', 'mass,g', 'temp,C', 'SMR,ml O2/min', 'PMR,ml O2/min'}, 'Mammalia')
         
for i=1:length(fig)
 
  switch fig(i)
    case 1 % ss_AS
    
    data = cell2mat(act(:,1)); PMR_SMR_act = data(:,4)./data(:,3);
    ss_act = read_stat(act(:,3),'s_s');
    Hfig = figure;
      plot(ss_act, PMR_SMR_act, '.b', 'MarkerSize',20)
      xlabel('supply stress s_s, -')
      ylabel('PMR/SMR, -')
      
    hold on
    data = cell2mat(mar(:,1)); PMR_SMR_mar = data(:,4)./data(:,3);
    ss_mar = read_stat(mar(:,3),'s_s');
    plot(ss_mar, PMR_SMR_mar, 'o', 'MarkerSize',4, 'LineWidth',2, 'MarkerFaceColor',[0 0 0], 'MarkerEdgeColor',[1 .5 .5])
    %
    data = cell2mat(pla(:,1)); PMR_SMR_pla = data(:,4)./data(:,3);
    ss_pla = read_stat(pla(:,3),'s_s');
    plot(ss_pla, PMR_SMR_pla,'o', 'MarkerSize',4, 'LineWidth',2, 'MarkerFaceColor',[1 .5 .5], 'MarkerEdgeColor',[1 .5 .5])
    %
    data = cell2mat(ave(:,1)); PMR_SMR_ave = data(:,4)./data(:,3);
    ss_ave = read_stat(ave(:,3),'s_s');
    plot(ss_ave, PMR_SMR_ave, '.r', 'MarkerSize',20)

    % set species names behind markers in plot figure
    h = datacursormode(Hfig); entries_txt = [act(:,3); ave(:,3); mar(:,3); pla(:,3)]; 
    data = [[ss_act;ss_ave;ss_mar;ss_pla],[PMR_SMR_act;PMR_SMR_ave;PMR_SMR_mar;PMR_SMR_pla]];
    for i=1:length(entries_txt); entries_txt{i} = strrep(entries_txt{i}, '_' , ' '); end
    h.UpdateFcn = @(obj, event_obj)xylabels(obj, event_obj, entries_txt, data);
    datacursormode on % mouse click on plot
    
    prt_tab({entries_txt, data},{'species', 's_s', 'PMR/SMR'}, 'Vertebrates')
    
    saveas(gcf,'ss_AS.png')
    
    figure
    plot(ss_act, log10(PMR_SMR_act), '.b', 'MarkerSize',20)
    hold on
    plot(ss_mar, log10(PMR_SMR_mar), 'o', 'MarkerSize',4, 'LineWidth',2, 'MarkerFaceColor',[0 0 0], 'MarkerEdgeColor',[1 .5 .5])
    plot(ss_pla, log10(PMR_SMR_pla),'o', 'MarkerSize',4, 'LineWidth',2, 'MarkerFaceColor',[1 .5 .5], 'MarkerEdgeColor',[1 .5 .5])
    plot(ss_ave, log10(PMR_SMR_ave), '.r', 'MarkerSize',20)
    xlabel('supply stress s_s, -')
    ylabel('_{10}log PMR/SMR, -')

    % set species names behind markers in plot figure
    h = datacursormode(Hfig); entries_txt = [act(:,3); ave(:,3); mar(:,3); pla(:,3)]; 
    data = [[ss_act;ss_ave;ss_mar;ss_pla],log10([PMR_SMR_act;PMR_SMR_ave;PMR_SMR_mar;PMR_SMR_pla])];
    for i=1:length(entries_txt); entries_txt{i} = strrep(entries_txt{i}, '_' , ' '); end
    h.UpdateFcn = @(obj, event_obj)xylabels(obj, event_obj, entries_txt, data);
    datacursormode on % mouse click on plot

    saveas(gcf,'ss_logAS.png')

    
  case 2 % BMR obs-pred
       nm_act = act(:,3); n_act = length(nm_act); SMR_prd_act = zeros(n_act,1);
       data_act = cell2mat(act(:,1)); SMR_act = data_act(:,3); T_act = data_act(:,2); W_act = data_act(:,2); 
       pars_act = read_stat(nm_act, {'kap', 'kap_R', 'g', 'k_J', 'k_M', 'L_T', 'v', 'U_Hb', 'U_Hj', 'U_Hp'});
       pars_act(isnan(pars_act(:,9)),9) = 1e-4+pars_act(isnan(pars_act(:,9)),8);
       p_act = read_stat(nm_act, {'T_A', 'p_Am', 'L_m', 'l_b', 'l_j', 'l_p', 'ome'}); 
       p_act(isnan(p_act(:,5)),5) = 1e-4+p_act(isnan(p_act(:,5)),4);
       T_A = p_act(:,1); p_Am = p_act(:,2); L_m = p_act(:,3); l_b = p_act(:,4); l_j = p_act(:,5); l_p = p_act(:,6); ome = p_act(:,7);
       p_nO = read_stat(nm_act, {'n_CX', 'n_HX', 'n_OX', 'n_NX','n_CV', 'n_HV', 'n_OV', 'n_NV','n_CE', 'n_HE', 'n_OE', 'n_NE','n_CP', 'n_HP', 'n_OP', 'n_NP' });
       p_nM = read_stat(nm_act, {'n_CC', 'n_HC', 'n_OC', 'n_NC','n_CH', 'n_HH', 'n_OH', 'n_NH','n_CO', 'n_HO', 'n_OO', 'n_NO','n_CN', 'n_HN', 'n_ON', 'n_NN' });
       p_eta = read_stat(nm_act, {'mu_E', 'y_X_E', 'y_P_E', 'y_V_E'});
       for i=1:n_act
        n_O = p_nO(i,:); n_O = n_O([1:4;5:8;9:12;13:16])';  n_M = p_nM(i,:); n_M = n_M([1:4;5:8;9:12;13:16])'; 
        mu_E = p_eta(i,1); y_X_E = p_eta(i,2); y_P_E = p_eta(i,3); y_V_E = p_eta(i,4);
        eta_XA = y_X_E/ mu_E; eta_PA = y_P_E/ mu_E; eta_VG = y_V_E/ mu_E; eta_O = [-eta_XA 0 0; 0 0 eta_VG; 1/mu_E -1/mu_E -1/mu_E; eta_PA 0 0];
        L = (W_act(i)/(1 + ome(i))).^(1/3); % cm, struc length
        pT_ref = tempcorr(C2K(T_act(i)), C2K(20), T_A(i)) * p_Am(i) * L_m(i)^2; % J/d, max assimilation power at max size
        pACSJGRD = pT_ref * scaled_power_j(L, 1, pars_act(i,:), l_b(i), l_j(i), l_p(i));  % J/d, powers
        pADG = pACSJGRD(:, [1 7 5]);
        J_M = - (n_M\n_O) * eta_O * pADG';  % mol/d: J_C, J_H, J_O, J_N in rows
        SMR_prd_act(i) = - 0.7*32e3/24/60*J_M(3,:)'; % ml O2/min
       end
    
       plot(SMR_prd_act, SMR_act,'or')
       
  case 3 % kap_ss_kapRA: kappa_RA = pRi/ pAi

       shstat_options('default');
       shstat_options('x_transform', 'none');
       shstat_options('y_transform', 'none');
       shstat_options('z_transform', 'none');
       kapRA = get_kapRA(read_allStat({'p_Am','p_M','k_J','E_Hp','s_M','kap','L_i'})); 
       kap_ss_kapRA = [read_allStat({'kap','s_s'}),kapRA(:,1)];
       
       [Hfig_vert, Hleg_vert] = shstat(kap_ss_kapRA, legend_vert, ['vertebrates @ ',datestr(datenum(date),'yyyy/mm/dd')]); % set title, output handle for adding items   
       figure(Hfig_vert) % add items to figure
       xlabel('\kappa, -'); ylabel('s_s, -'); zlabel('\kappa_R^A, -');
       kap = linspace(.005,1,50)'; ss = linspace(1e-8, 4/27, 50); kapRA = 1 - kap*ones(1,50) - kap.^-2*ss; % set x,y,z values
       mesh(kap,ss,kapRA'); % add surface to figure
       kap_xy = linspace(0,1,100)'; ss_xy= kap_xy.^2.*(1-kap_xy); plot3(kap_xy,ss_xy,0*kap_xy); % curve in kapRA=0 plane
       xlim([0 1]); ylim([0 4/27]); zlim([0 1]);
       % define colormap for mesh: k->b->m->r->white
       Colmap = [0 0 0; 0 0 .5; 0 0 1; .5 0 1; 1 0 1; 1 0 .5; 1 0 0; 1 .25 .25; 1 .5 .5; 1 .75 .75];
       colormap(Hfig_vert, Colmap) % set color map to add_my_pet colors 
       caxis([0 1]) % range for colormap
       view(150,18)
       %saveas(gcf,'kap_ss_kapRA_vert.png')
       saveas(Hleg_vert,'legend_vert.png')

       [Hfig_invert, Hleg_invert] = shstat(kap_ss_kapRA, legend_invert, ['invertebrates @ ',datestr(datenum(date),'yyyy/mm/dd')]); % set title, output handle for adding items   
       figure(Hfig_invert) % add items to figure
       xlabel('\kappa, -'); ylabel('s_s, -'); zlabel('\kappa_R^A, -');
       %kap = linspace(.005,1,50)'; ss = linspace(1e-8, 4/27, 50); kapRA = 1 - kap*ones(1,50) - kap.^-2*ss; % set x,y,z values
       mesh(kap,ss,kapRA'); % add surface to figure
       plot3(kap_xy,ss_xy,0*kap_xy); % curve in kapRA=0 plane
       xlim([0 1]); ylim([0 4/27]); zlim([0 1]);
       % define colormap for mesh: k->b->m->r->white
       % Colmap = [0 0 0; 0 0 .5; 0 0 1; .5 0 1; 1 0 1; 1 0 .5; 1 0 0; 1 .25 .25; 1 .5 .5; 1 .75 .75];
       colormap(Hfig_invert, Colmap) % set color map to add_my_pet colors 
       caxis([0 1]) % range for colormap
       view(150,18)
       %saveas(gcf,'kap_ss_kapRA_invert.png')
       %saveas(Hleg_invert,'legend_invert.png')
       
    case 4 % kap, s_s, kapRA
        
        figure % kap 
        kap = read_allStat('kap');
        kap_med = median(kap); kap_min = min(kap);  m = mean(kap); v = mean(kap.^2) - mean(kap)^2;
        surv_kap = surv(kap); 
        M = m; V = v; 
        a = M*(M*(1-M)/V-1); b = a*(1-M)/M;
        fprintf(['pars beta for kap: ', num2str(a), ' , ', num2str(b),'\n'])
        S_kap =linspace(0,1,100)'; S = 1 - betainc(S_kap,a,b);
        plot(S_kap, S, '-', 'color', [0.75 0.75 1], 'linewidth',8)
        set(gca, 'FontSize', 15, 'Box', 'on', 'YTick', 0:0.2:1)
       
        hold on
        plot([kap_min; kap_med; kap_med], [0.5;0.5;0], 'r', surv_kap(:,1), surv_kap(:,2), 'b', 'Linewidth', 2)
        xlabel('fraction of mobilized reserve to soma \kappa,  -')
        ylabel('survivor function')
        %title([num2str(length(kap)),' @ ',datestr(datenum(date),'yyyy/mm/dd')])
        %saveas(gca,'kap.png')

        figure % s_s
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

        figure % kapRA
        kapRA = get_kapRA(read_allStat({'p_Am','p_M','k_J','E_Hp','s_M','kap','L_i'})); kapRA = kapRA(:,1); 
        kapRA_med = median(kapRA); kapRA_min = min(kapRA);  m = mean(kapRA); v = mean(kapRA.^2) - mean(kapRA)^2;
        surv_kapRA = surv(kapRA); 
        M = m; V = v; 
        a = M*(M*(1-M)/V-1); b = a*(1-M)/M;
        fprintf(['pars beta for kapRA: ', num2str(a), ' , ', num2str(b),'\n'])
        S_RA =linspace(0,1,100)'; S = 1 - betainc(S_RA,a,b);
        plot(S_RA, S, '-', 'color', [0.75 0.75 1], 'linewidth',8)
        set(gca, 'FontSize', 15, 'Box', 'on', 'YTick', 0:0.2:1)
       
        hold on
        plot([kapRA_min; kapRA_med; kapRA_med], [0.5;0.5;0], 'r', surv_kapRA(:,1), surv_kapRA(:,2), 'b', 'Linewidth', 2)
        xlabel('fraction of assimilation to reproduction \kappa_R^A, -') 
        ylabel('survivor function')
        %saveas(gca,'kapRA.png')
        
      case 5
        shstat_options('default');
        shstat_options('x_transform', 'none');

        [Hfig Hleg] = shstat({'s_s','s_Hbp'}, legend_mamm, datestr(datenum(date),'yyyy/mm/dd'), 1); 
        figure(Hfig)
        xlabel('s_s, -')      
        ylabel('_{10}log s_H^{bp}, -')
        %saveas(gca,'ss_sHbp.png')
        %saveas(Hleg,'legend_mamm.png')
  
  end
end
   
% References
% 
% @article{Bish1999,
%   title = {The maximum oxygen consumption and aerobic scope of birds and mammals: getting to the heart of the matter},
%   journal = {Proc. R. Soc. Lond. B},
%   volume = {266},
%   year = {1999},
%   pages = {2275-2281},
%   author = {Bishop, C. M.}
% }
% 
% @article{BracElSa1985,
%   title = {Comparison of running energetics in males and femlae domestic fowl},
%   journal = {Proc. R. Soc. Lond. B},
%   volume = {117},
%   year = {1985},
%   pages = {349-355},
%   author = {Brackenbury, J. H. and El-Sayed, M. S.}
% }
% 
% @article{FuDong2022,
%   title = {Aerobic scope in fishes with different lifestyles and across habitats: Trade-offs among hypoxia tolerance, swimming performance and digestion},
%   journal = {Comp. Biochem. Physiol. A},
%   volume = {272},
%   year = {2022},
%   pages = {111277},
%   author = {Fu, Shi-Jian and Dong, Yun-Wei and Killen, Shaun S.}
% }
%
% @article{HindBaud1993,
%   title = {Maximum metabolism and the aerobic factorial scope of endotherms},
%   journal = {J. Exp. Biol.},
%   volume = {182},
%   year = {1993},
%   pages = {41-56},
%   author = {Bishop, C. M.}
% }
% 
% @ARTICLE{KooyPong1994,
%   author = {G. L. Kooyman and P. J. Ponganis},
%   title = {EMPEROR PENGUIN OXYGEN CONSUMPTION, HEART RATE AND PLASMA LACTATE LEVELS DURING GRADED SWIMMING EXERCISE},
%   journal = {J. exp. Biol.},
%   year = {1994},
%   volume = {195},
%   pages = {199–209}
% }
%
% @article{Lech1978,
%   title = {The scaling of maximal oxygen consumption and pulmonary dimensions in small mammals},
%   journal = {Resp. Physiol.},
%   volume = {34},
%   year = {1978},
%   pages = {29-44},
%   author = {Lechner, A. J.}
% }
% 
% @article{LindHoka1991,
%   title = {Running energetics in the pronghorn antilope},
%   journal = {Nature},
%   volume = {353},
%   year = {1991},
%   pages = {748-750},
%   author = {Lindstedt, S. L. and Hokanson, J. F. and Wells, D. J. abd Swain, S. D. and Hoppeler, H. and Navarro, V.}
% }
% 
% @ARTICLE{MainKing1989,
%   author = {J. N. Maina and A. S. King},
%   title = {The lung of the emu, Dromaius novaehollandiae: a microscopic and morphometric study},
%   journal = {J. Anat.},
%   year = {1989},
%   volume = {163},
%   pages = {67-73}
% }
%
% @book{WillSton2005,
%   title = {Environmental physiology of animals},
%   publisher = {Blackwell Publishing},
%   year = {2005},
%   author = {Willmer, P. W. and Stone, G. and Johnston, I.}
% }
