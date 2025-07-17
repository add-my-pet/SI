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
% Example of use:
% VerhKooy2025_SI(1)

close all
if ~exist('fig','var')
   fig = 1:31;
end

  legend = { ... % colors from legend_vert
    {'o', 8, 3, [0 0 1], [0 0 1]}, 'Actinopterygii'; 
    {'o', 8, 3, [1 0 1], [1 0 1]}, 'Squamata'; 
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
    [  0.45 24   0.0024    0.0038    0.0056], 'FuDong2022', 'Danio_rerio'             % 463 717 1066 mg O2/h.kg
    [  7    25   0.0166    0.0474    0.1062], 'FuDong2022', 'Zacco_platypus'          % 203 581 1300 mg O2/h.kg
    [  7.72 25   0.0198    0.0423    0.0612], 'FuDong2022', 'Carassius_auratus'       % 220 470  680 mg O2/h.kg
    [ 10.49 15   0.0147    0.0317    0.0600], 'FuDong2022', 'Carassius_auratus'       % 120 259  490 mg O2/h.kg
    [  9.68 25   0.0268    0.0710    0.1242], 'FuDong2022', 'Carassius_auratus'       % 237 629 1100 mg O2/h.kg
    [  7.42 25   0.0165    0.0256    0.0895], 'FuDong2022', 'Ctenopharyngodon_idella' % 191 296 1034 mg O2/h.kg
    [ 19.52 25   0.0262    0.0458    0.1776], 'FuDong2022', 'Procypris_rabaudi'       % 115 201  780 mg O2/h.kg
    [  8.27 15   0.0083    0.0128    0.0528], 'FuDong2022', 'Parabramis_pekinensis'   %  86 133  547 mg O2/h.kg
    [  4.62 25   0.0156    0.0269    0.0679], 'FuDong2022', 'Parabramis_pekinensis'   % 290 500 1260 mg O2/h.kg
    [  7.94 15   0.0105    0.0233    0.0583], 'FuDong2022', 'Cyprinus_carpio'         % 113 252  629 mg O2/h.kg
    [  7.56 25   0.0226    0.0409    0.1005], 'FuDong2022', 'Cyprinus_carpio'         % 256 464 1140 mg O2/h.kg
    [  4.62 25   0.0119    0.0189    0.0593], 'FuDong2022', 'Mylopharyngodon_piceus'  % 220 350 1100 mg O2/h.kg
    [  7.72 15   0.0093    0.0188    0.0459], 'FuDong2022', 'Spinibarbus_sinensis'    % 103 209  510 mg O2/h.kg
    [  7.71 25   0.0144    0.0255    0.1070], 'FuDong2022', 'Spinibarbus_sinensis'    % 160 283 1190 mg O2/h.kg
    [ 22.45 15   0.0141    0.0390    0.0642], 'FuDong2022', 'Silurus_meridionalis'     % 54 149  245 mg O2/h.kg
    [ 12.89 25   0.0171    0.0767    0.1144], 'FuDong2022', 'Silurus_meridionalis'    % 114 510  761 mg O2/h.kg
    [ 30    23   0.0343    0.0777    0.1228], 'FuDong2022', 'Silurus_asotus'           % 98 222  351 mg O2/h.kg
    [  6.65 25   0.0182    0.0265    0.0791], 'FuDong2022', 'Tachysurus_vachellii'    % 235 341 1020 mg O2/h.kg
    [520     9   0.2912    0.6613    2.9727], 'FuDong2022', 'Oncorhynchus_tshawytscha' % 48 109  490 mg O2/h.kg
    [  6    15   0.0132    0.0414    0.0551], 'FuDong2022', 'Oncorhynchus_mykiss'     % 189 591  787 mg O2/h.kg
    [364    22.5 0.4247    0.6795    1.4863], 'FuDong2022', 'Dicentrarchus_labrax'    % 100 160  350 mg O2/h.kg
    [105    17   0.1593    0.2327    0.4667], 'FuDong2022', 'Pagrus_auratus'          % 130 190  381 mg O2/h.kg
    [107    21   0.2035    0.3121    5.8434], 'FuDong2022', 'Pagrus_auratus'         %  163 250 4681 mg O2/h.kg
    [ 30    17   0.0364    0.0682    0.2401], 'FuDong2022', 'Aldrichetta_forsteri'    % 104 195  686 mg O2/h.kg
    [ 29    21   0.0420    0.0711    0.2703], 'FuDong2022', 'Aldrichetta_forsteri'    % 124 210  799 mg O2/h.kg
    [706    26   1.6473    6.5893   11.2348], 'FuDong2022', 'Coryphaena_hippurus'     % 200 800 1364 mg O2/h.kg
    [135.5  26   0.1423    0.7003    0.5565], 'FuDong2022', 'Pterois_volitans'         % 90 443  352 mg O2/h.kg
    [135.5  32   0.2624    0.7762    0.5470], 'FuDong2022', 'Pterois_volitans'        % 166 491  346 mg O2/h.kg
  };
  %prt_tab({act(:,[3 2]), cell2mat(act(:,1))},{'species', 'bibkey', 'mass,g', 'temp,C', 'SMR,ml O2/min', 'PMR,ml O2/min', 'MMR,ml O2/min'}, 'Actinop')
    
  squ = { ... % Squamata mass (g), Tb (C), SMR (mg O2/min) PMR (mg O2/min); %x means not in AmP
    [ 517  35  1.6    5.4], 'ChriConl1994', 'Tiliqua_rugosa'  
    [1136 35   NaN   16.9], 'ChriConl1994', 'Cyclura_nubila' 
   %[1287 35   3.1   24.3], 'ChriConl1994', 'Varanus_rosenbergi' %x
   %[1086 35   1.9   24.5], 'ChriConl1994', 'Varanus_gouldii' %x
   %[ 931 35   2.1   20.8], 'ChriConl1994', 'Varanus_panoptes' %x
   %[ 904 35   1.2   13.7], 'ChriConl1994', 'Varanus_mertensi' %x
  };

  ave = { ...  % Aves ; m(g) Tb(C) BMR(ml O2/min) PMR (ml O2/min); %x means not in AmP
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
    [45000  36.0 301.5   2340], 'KooyPong1994', 'Aptenodytes_forsteri' % 6.7, 52 ml O2/min.kg
    [55000  36.0 215.05  2473], 'MainKing1989', 'Dromaius_novaehollandiae' %  3.91 ml O2/min.kg, AS 11.5 BundHopl1999
    [130000 34.6 613.6  10738], 'MainKing1989', 'Struthio_camelus' %  4.72 ml O2/min.kg, AS 17.5 BundHopl1999
    [6210   38.2  59.2 219.46], 'BevaWoak1995', 'Pygoscelis_papua' %  9.54, 35.34 ml O2/min.kg
  };     
  %prt_tab({ave(:,[3 2]), cell2mat(ave(:,1))},{'species', 'bibkey', 'mass,g', 'temp,C', 'SMR,mg O2/h.kg', 'PMR,mg O2/h.kg'}, 'Aves')

  mar = { ... % Marsupialia & Prototheria; m(g), Tb(C), BMR(ml O2/min), PMR (ml O2/min); %x means not in AmP
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
   %[  583   39.8   NaN   74.4], 'TaylMalo1980', 'Helogale_parvula' %x 1.24 ml O2/s
   %[ 1151   39.8   NaN  139.8], 'TaylMalo1980', 'Mungos_mungo' %x 2.33 ml O2/s
   %[ 1458   36.7   NaN  154.8], 'TaylMalo1980', 'Genetta_tigrina' %x 2.58 ml O2/s
   %[ 3500   36.7   NaN  355.2], 'TaylMalo1980', 'Nesotragus_moschatus' %x 5.92 ml O2/s
    [ 4354   39.4   NaN  237.0], 'TaylMalo1980', 'Madoqua_kirkii' % 3.95 ml O2/s
   %[11200   38.9   NaN  600.0], 'TaylMalo1980', 'Gazella_granti' %x 10.0 ml O2/s
    [98000   38.0   NaN  4356 ], 'TaylMalo1980', 'Connochaetes_taurinus' % 72.6 ml O2/s
    [114000  39.4   NaN  5388 ], 'TaylMalo1980', 'Kobus_ellipsiprymnus' % 89.8 ml O2/s
    [217000  36.5   NaN  7860 ], 'TaylMalo1980', 'Taurotragus_oryx' %x 131 ml O2/s
    [ 21150  39.3   NaN  1098 ], 'TaylMalo1980', 'Capra_hircus' % 18.3 ml O2/s
    [ 22650  38.8   NaN  1050 ], 'TaylMalo1980', 'Ovis_aries' % 17.5 ml O2/s
    [ 41000  39.0 140e6  6.6e9], 'ScanMill2014', 'Acinonyx_jubatus' % FMR=DEE 9006 kJ/d PMR 120 W/kg
    [ 25000  38.0 52.8e6 1.3e9], 'GormMill1998', 'Canis_familiaris' % BMR 3.4 MJ/d canid AS 25
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
      data = cell2mat(squ(:,1)); PMR_SMR_squ = data(:,4)./data(:,3);
      ss_squ = read_stat(squ(:,3),'s_s');
      plot(ss_squ, PMR_SMR_squ, '.m', 'MarkerSize',20)
      xlim([0 4/27])
      %
      data = cell2mat(ave(:,1)); PMR_SMR_ave = data(:,4)./data(:,3);
      ss_ave = read_stat(ave(:,3),'s_s');
      plot(ss_ave, PMR_SMR_ave, '.r', 'MarkerSize',20)
      xlim([0 4/27])
      %
      data = cell2mat(mar(:,1)); PMR_SMR_mar = data(:,4)./data(:,3);
      ss_mar = read_stat(mar(:,3),'s_s');
      plot(ss_mar, PMR_SMR_mar, 'o', 'MarkerSize',4, 'LineWidth',2, 'MarkerFaceColor',[0 0 0], 'MarkerEdgeColor',[1 .5 .5])
      %
      data = cell2mat(pla(:,1)); PMR_SMR_pla = data(:,4)./data(:,3);
      ss_pla = read_stat(pla(:,3),'s_s');
      plot(ss_pla, PMR_SMR_pla,'o', 'MarkerSize',4, 'LineWidth',2, 'MarkerFaceColor',[1 .5 .5], 'MarkerEdgeColor',[1 .5 .5])

      % set species names behind markers in plot figure
      h = datacursormode(Hfig); entries_txt = [act(:,3); squ(:,3); ave(:,3); mar(:,3); pla(:,3)]; 
      data = [[ss_act;ss_squ; ss_ave;ss_mar;ss_pla],[PMR_SMR_act;PMR_SMR_squ;PMR_SMR_ave;PMR_SMR_mar;PMR_SMR_pla]];
      for i=1:length(entries_txt); entries_txt{i} = strrep(entries_txt{i}, '_' , ' '); end
      h.UpdateFcn = @(obj, event_obj)xylabels(obj, event_obj, entries_txt, data);
      datacursormode on % mouse click on plot
    
      prt_tab({entries_txt, data},{'species', 's_s', 'PMR/SMR'}, 'Vertebrates')
    
      %saveas(gcf,'ss_PSMR.png')
    
      figure
      plot(ss_act, log10(PMR_SMR_act), '.b', 'MarkerSize',20)
      hold on
      plot(ss_mar, log10(PMR_SMR_mar), 'o', 'MarkerSize',4, 'LineWidth',2, 'MarkerFaceColor',[0 0 0], 'MarkerEdgeColor',[1 .5 .5])
      plot(ss_pla, log10(PMR_SMR_pla),'o', 'MarkerSize',4, 'LineWidth',2, 'MarkerFaceColor',[1 .5 .5], 'MarkerEdgeColor',[1 .5 .5])
      plot(ss_ave, log10(PMR_SMR_ave), '.r', 'MarkerSize',20)
      xlim([0 4/27])
      xlabel('supply stress s_s, -')
      ylabel('_{10}log PMR/SMR, -')

      % set species names behind markers in plot figure
      h = datacursormode(Hfig); entries_txt = [act(:,3); squ(:,3); ave(:,3); mar(:,3); pla(:,3)]; 
      data = [[ss_act;ss_squ;ss_ave;ss_mar;ss_pla],log10([PMR_SMR_act;PMR_SMR_squ;PMR_SMR_ave;PMR_SMR_mar;PMR_SMR_pla])];
      for i=1:length(entries_txt); entries_txt{i} = strrep(entries_txt{i}, '_' , ' '); end
      h.UpdateFcn = @(obj, event_obj)xylabels(obj, event_obj, entries_txt, data);
      datacursormode on % mouse click on plot

      saveas(gcf,'ss_PSMR.png')

    case 2  % predicted FMR_measured SMR   
      WD0 = pwd; % store original directory
      nm_act = act(:,3); n_act = length(nm_act); FMR_act = zeros(n_act,1); 
      data_act = cell2mat(act(:,1)); PMR_act = data_act(:,4); SMR_act = data_act(:,3); T_act = data_act(:,2); W_act = data_act(:,1); 
      for i=1:n_act
        FMR_act(i) = 15.55 * get_FMR(nm_act{i}, W_act(i), T_act(i), 1); % ml O2/min
      end
      %
      nm_squ = squ(:,3); n_squ = length(nm_squ); FMR_squ = zeros(n_squ,1); 
      data_squ = cell2mat(squ(:,1)); PMR_squ = data_squ(:,4); SMR_squ = data_squ(:,3); T_squ = data_squ(:,2); W_squ = data_squ(:,1); 
      for i=1:n_squ
        FMR_squ(i) = 15.55 * get_FMR(nm_squ{i}, W_squ(i), T_squ(i), 1); % ml O2/min
      end
      %
      nm_ave = ave(:,3); n_ave = length(nm_ave); FMR_ave = zeros(n_ave,1);
      data_ave = cell2mat(ave(:,1)); PMR_ave = data_ave(:,4); SMR_ave = data_ave(:,3); T_ave = data_ave(:,2); W_ave = data_ave(:,1); 
      for i=1:n_ave
        FMR_ave(i) = 15.55 * get_FMR(nm_ave{i}, W_ave(i), T_ave(i), 1); % ml O2/min
      end
      %
      nm_mar = mar(:,3); n_mar = length(nm_mar); FMR_mar = zeros(n_mar,1);
      data_mar = cell2mat(mar(:,1)); PMR_mar = data_mar(:,4); SMR_mar = data_mar(:,3); T_mar = data_mar(:,2); W_mar = data_mar(:,1); 
      for i=1:n_mar
        FMR_mar(i) = 15.55 * get_FMR(nm_mar{i}, W_mar(i), T_mar(i), 1); % ml O2/min
      end
      %
      nm_pla = pla(:,3); n_pla = length(nm_pla); FMR_pla = zeros(n_pla,1);
      data_pla = cell2mat(pla(:,1)); PMR_pla = data_pla(:,4); SMR_pla = data_pla(:,3); T_pla = data_pla(:,2); W_pla = data_pla(:,1); 
      for i=1:n_pla
        FMR_pla(i) = 15.55 * get_FMR(nm_pla{i}, W_pla(i), T_pla(i), 1); % ml O2/min
      end
      cd(WD0); % return to original directory

      Hfig = figure;
      plot([-3;3], [-3;3], 'k', 'linewidth',2); % equality line
      hold on
      plot(log10(FMR_act), log10(SMR_act), '.b', 'MarkerSize',20)
      plot(log10(FMR_squ), log10(SMR_squ), '.m', 'MarkerSize',20)
      plot(log10(FMR_ave), log10(SMR_ave), '.r', 'MarkerSize',20)
      plot(log10(FMR_mar), log10(SMR_mar), 'o', 'MarkerSize',4, 'LineWidth',2, 'MarkerFaceColor',[0 0 0], 'MarkerEdgeColor',[1 .5 .5])
      plot(log10(FMR_pla), log10(SMR_pla), 'o', 'MarkerSize',4, 'LineWidth',2, 'MarkerFaceColor',[1 .5 .5], 'MarkerEdgeColor',[1 .5 .5])
      xlabel('predicted _{10}log FMR, ml O2/min')
      ylabel('measured _{10}log SMR, ml O2/min')
 
      % set species names behind markers in plot figure
      h = datacursormode(Hfig); entries_txt = [act(:,3); squ(:,3); ave(:,3); mar(:,3); pla(:,3)]; 
      data = log10([[FMR_act;FMR_squ;FMR_ave;FMR_mar;FMR_pla],[SMR_act;SMR_squ;SMR_ave;SMR_mar;SMR_pla]]);
      for i=1:length(entries_txt); entries_txt{i} = strrep(entries_txt{i}, '_' , ' '); end
      h.UpdateFcn = @(obj, event_obj)xylabels(obj, event_obj, entries_txt, data);
      datacursormode on % mouse click on plot

      %prt_tab({nm_act, W_act, T_act, FMR_act, SMR_act, PMR_act},{'species', 'weight, g', 'T, C', 'FMR, ml O2/min', 'SMR, ml O2/min', 'PMR, ml O2/min'}, 'act')
      saveas(gcf,'FMR_SMR.png')

    case 3  % ss_PMR/FMR
      WD0 = pwd; % store original directory
      nm_act = act(:,3); n_act = length(nm_act); FMR_act = zeros(n_act,1); ss_act = read_stat(nm_act, 's_s');
      data_act = cell2mat(act(:,1)); PMR_act = data_act(:,4); SMR_act = data_act(:,3); T_act = data_act(:,2); W_act = data_act(:,1); 
      for i=1:n_act
        FMR_act(i) = 15.55 * get_FMR(nm_act{i}, W_act(i), T_act(i), 1); % ml O2/min
      end
      %
      nm_squ = squ(:,3); n_squ = length(nm_squ); FMR_squ = zeros(n_squ,1); ss_squ = read_stat(nm_squ, 's_s');
      data_squ = cell2mat(squ(:,1)); PMR_squ = data_squ(:,4); SMR_squ = data_squ(:,3); T_squ = data_squ(:,2); W_squ = data_squ(:,1); 
      for i=1:n_squ
        FMR_squ(i) = 15.55 * get_FMR(nm_squ{i}, W_squ(i), T_squ(i), 1); % ml O2/min
      end
      %
      nm_ave = ave(:,3); n_ave = length(nm_ave); FMR_ave = zeros(n_ave,1); ss_ave = read_stat(nm_ave, 's_s');
      data_ave = cell2mat(ave(:,1)); PMR_ave = data_ave(:,4); SMR_ave = data_ave(:,3); T_ave = data_ave(:,2); W_ave = data_ave(:,1); 
      for i=1:n_ave
        FMR_ave(i) = 15.55 * get_FMR(nm_ave{i}, W_ave(i), T_ave(i), 1); % ml O2/min
      end
      %
      nm_mar = mar(:,3); n_mar = length(nm_mar); FMR_mar = zeros(n_mar,1); ss_mar = read_stat(nm_mar, 's_s');
      data_mar = cell2mat(mar(:,1)); PMR_mar = data_mar(:,4); SMR_mar = data_mar(:,3); T_mar = data_mar(:,2); W_mar = data_mar(:,1); 
      for i=1:n_mar
        FMR_mar(i) = 15.55 * get_FMR(nm_mar{i}, W_mar(i), T_mar(i), 1); % ml O2/min
      end
      %
      nm_pla = pla(:,3); n_pla = length(nm_pla); FMR_pla = zeros(n_pla,1); ss_pla = read_stat(nm_pla, 's_s');
      data_pla = cell2mat(pla(:,1)); PMR_pla = data_pla(:,4); SMR_pla = data_pla(:,3); T_pla = data_pla(:,2); W_pla = data_pla(:,1); 
      for i=1:n_pla
        FMR_pla(i) = 15.55 * get_FMR(nm_pla{i}, W_pla(i), T_pla(i), 1); % ml O2/min
      end
      cd(WD0); % return to original directory

      Hfig = figure;
      plot(ss_act, log10(PMR_act./FMR_act), '.b', 'MarkerSize',20)
      hold on
      plot(ss_squ, log10(PMR_squ./FMR_squ), '.m', 'MarkerSize',20)
      plot(ss_ave, log10(PMR_ave./FMR_ave), '.r', 'MarkerSize',20)
      plot(ss_mar, log10(PMR_mar./FMR_mar), 'o', 'MarkerSize',4, 'LineWidth',2, 'MarkerFaceColor',[0 0 0], 'MarkerEdgeColor',[1 .5 .5])
      plot(ss_pla, log10(PMR_pla./FMR_pla), 'o', 'MarkerSize',4, 'LineWidth',2, 'MarkerFaceColor',[1 .5 .5], 'MarkerEdgeColor',[1 .5 .5])
      xlabel('supply stress s_s, -')
      xlim([0 4/27])
      ylabel('_{10}log measured PMR/ predicted FMR, -')
       
      % set species names behind markers in plot figure
      h = datacursormode(Hfig); entries_txt = [act(:,3); squ(:,3); ave(:,3); mar(:,3); pla(:,3)]; 
      data = [[ss_act;ss_squ;ss_ave;ss_mar;ss_pla], log10([PMR_act;PMR_squ;PMR_ave;PMR_mar;PMR_pla]./[FMR_act;FMR_squ;FMR_ave;FMR_mar;FMR_pla])];
      for i=1:length(entries_txt); entries_txt{i} = strrep(entries_txt{i}, '_' , ' '); end
      h.UpdateFcn = @(obj, event_obj)xylabels(obj, event_obj, entries_txt, data);
      datacursormode on % mouse click on plot
       
      saveas(gcf,'ss_PFMR.png')
      %prt_tab({entries_txt, data},{'species', 's_s, -', 'PMR/FMR, -'}, 'PMR/FMR')
       
    case 4 % kap_ss_kapRA: kapRA = pRi/ pAi

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
       
    case 5 % kap, s_s, kapRA
        
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
        
    case 6 % ss_sHbp
      shstat_options('default');
      shstat_options('x_transform', 'none');

      [Hfig, Hleg] = shstat({'s_s','s_Hbp'}, legend_mamm, datestr(datenum(date),'yyyy/mm/dd'), 1); 
      figure(Hfig)
      xlabel('supply stress s_s, -')      
      ylabel('precociality index _{10}log s_H^{bp}, -')
      %saveas(gca,'ss_sHbp.png')
      %saveas(Hleg,'legend_mamm.png')
  
  end
end
   
% References
% 
% @article{BevaWoak1995,
%   doi = {10.1086/physzool.68.5.30163935}, 
%   title = {Heart Rate and Oxygen Consumption of Exercising Gentoo Penguins},
%   journal = {Physiological Zoology},
%   volume = {68(5)},
%   year = {1995},
%   pages = {855–877},
%   author = {Bevan, R. M. and Woakes, A. J. and Butler, P. J. and Croxall, J. P.}
% }
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
% @article{BracElSa1985,
%   title = {Comparison of running energetics in males and femlae domestic fowl},
%   journal = {Proc. R. Soc. Lond. B},
%   volume = {117},
%   year = {1985},
%   pages = {349-355},
%   author = {Brackenbury, J. H. and El-Sayed, M. S.}
% }
% 
% @article{ChriConl1994,
%   doi = {10.1071/zo9940185},
%   title = {Activity and Resting Metabolism of Varanid Lizards Compared With Typical Lizards},
%   journal = {Australian Journal of Zoology},
%   volume = {42(2)},
%   year = {1994},
%   pages = {185-193},
%   author = {Christian, K. A. and Conley, K. E.}
% }
%
% @article{GormMill1998,
%   title = {High hunting costs make African wild dogs vulnerable to kleptoparasitism by hyaenas},
%   journal = {Nature},
%   volume = {391},
%   year = {1998},
%   pages = {479-481},
%   author = {Martyn L. Gorman and Michael G. Mills and Jacobus P. Raath and John R. Speakman}
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
% @ARTICLE{ScanMill2014,
%   author = {David M. Scantlebury and Michael G. L. Mills and Rory P. Wilson and John W. Wilson and  Margaret E. J. Mills and Sarah M. Durant and Nigel C. Bennett and Peter Bradford and Nikki J. Marks and John R. Speakman},
%   title = {Flexible energetics of cheetah hunting strategies provide resistance against kleptoparasitism},
%   journal = {Science},
%   year = {2014},
%   volume = {346},
%   pages = {79-81}
% }
%
% @ARTICLE{TaylMalo1980,
%   author = {C. Richard Taylor and Geoffrey M. O. Maloiy and Ewald R. Weibel and Vaughan A. Langman and John M. Z. Kamau and Howard J. Seeherman and Norman C. Heglund},
%   title = {Design of the mammalion respiratory system {III}. {S}caling maximum aerobic capacity to body mass: wild and domestic animals},
%   journal = {Resp. Physiol.},
%   year = {1980},
%   volume = {44},
%   pages = {25-37}
% }
%
% @book{WillSton2005,
%   title = {Environmental physiology of animals},
%   publisher = {Blackwell Publishing},
%   year = {2005},
%   author = {Willmer, P. W. and Stone, G. and Johnston, I.}
% }
