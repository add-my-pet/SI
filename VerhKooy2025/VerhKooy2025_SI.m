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
% 5) Copy wget.exe from e.g. https://eternallybored.org/misc/wget/ and make a path to it in the system-setting (Windows/Mac OS)
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
    {'o', 8, 3, [0 0 1], [0 1 1]}, 'Chondrichthyes'; 
    {'o', 8, 3, [0 0 1], [0 0 1]}, 'Actinopterygii'; 
    {'o', 8, 3, [1 0 1], [0 1 1]}, 'Amphibia'; 
    {'o', 8, 3, [1 0 1], [1 0 1]}, 'Squamata'; 
    {'o', 8, 3, [1 0 0], [1 0 0]}, 'Aves'; 
    {'o', 8, 3, [1 .5 .5], [0 0 0]}, 'Marsupialia'
    {'o', 8, 3, [1 .5 .5], [1 .5 .5]}, 'Placentalia'
  };
  %Hlegend = shlegend(legend);
  %saveas(Hlegend,'legend_AS.png')

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
  cho = { ... % Chondrichthyes, mass(g), temp(C), SMR(ml O2/min), PMR(ml O2/min) 
    [ 3400 25    6.3    10.2], 'GrahDewa1990', 'Negaprion_brevirostris' % 160 257 mg O2/h.kg
    [ 6000 15    7.4    10.8], 'GrahDewa1990', 'Triakis_semifasciata' % 105 154 mg O2/h.kg
    [ 3900 18   13.7    21.2], 'GrahDewa1990', 'Isurus_oxyrinchus' % 300 466 mg O2/h.kg
    [ 2530 18.5  1.47   7.25], 'PiipMeye1977', 'Scyliorhinus_stellaris' % 0.026 0.128 mmol/kg.min
  };

  % 1 mg O2/h = 0.7 ml O2/h
  act = { ... % Actinopterygii, mass(g), temp(C), SMR(ml O2/min), PMR(ml O2/min), MMR(ml O2/min) 
    [  0.45 24   0.0024    0.0038    0.0056], 'FuDong2022',   'Danio_rerio'             % 463 717 1066 mg O2/h.kg
    [  7    25   0.0166    0.0474    0.1062], 'FuDong2022',   'Zacco_platypus'          % 203 581 1300 mg O2/h.kg
    [  7.72 25   0.0198    0.0423    0.0612], 'FuDong2022',   'Carassius_auratus'       % 220 470  680 mg O2/h.kg
    [ 10.49 15   0.0147    0.0317    0.0600], 'FuDong2022',   'Carassius_auratus'       % 120 259  490 mg O2/h.kg
    [  9.68 25   0.0268    0.0710    0.1242], 'FuDong2022',   'Carassius_auratus'       % 237 629 1100 mg O2/h.kg
    [  7.42 25   0.0165    0.0256    0.0895], 'FuDong2022',   'Ctenopharyngodon_idella' % 191 296 1034 mg O2/h.kg
    [ 19.52 25   0.0262    0.0458    0.1776], 'FuDong2022',   'Procypris_rabaudi'       % 115 201  780 mg O2/h.kg
    [  8.27 15   0.0083    0.0128    0.0528], 'FuDong2022',   'Parabramis_pekinensis'   %  86 133  547 mg O2/h.kg
    [  4.62 25   0.0156    0.0269    0.0679], 'FuDong2022',   'Parabramis_pekinensis'   % 290 500 1260 mg O2/h.kg
    [  7.94 15   0.0105    0.0233    0.0583], 'FuDong2022',   'Cyprinus_carpio'         % 113 252  629 mg O2/h.kg
    [  7.56 25   0.0226    0.0409    0.1005], 'FuDong2022',   'Cyprinus_carpio'         % 256 464 1140 mg O2/h.kg
    [  4.62 25   0.0119    0.0189    0.0593], 'FuDong2022',   'Mylopharyngodon_piceus'  % 220 350 1100 mg O2/h.kg
    [  7.72 15   0.0093    0.0188    0.0459], 'FuDong2022',   'Spinibarbus_sinensis'    % 103 209  510 mg O2/h.kg
    [  7.71 25   0.0144    0.0255    0.1070], 'FuDong2022',   'Spinibarbus_sinensis'    % 160 283 1190 mg O2/h.kg
    [ 22.45 15   0.0141    0.0390    0.0642], 'FuDong2022',   'Silurus_meridionalis'    %  54 149  245 mg O2/h.kg
    [ 12.89 25   0.0171    0.0767    0.1144], 'FuDong2022',   'Silurus_meridionalis'    % 114 510  761 mg O2/h.kg
    [ 30    23   0.0343    0.0777    0.1228], 'FuDong2022',   'Silurus_asotus'          %  98 222  351 mg O2/h.kg
    [  6.65 25   0.0182    0.0265    0.0791], 'FuDong2022',   'Tachysurus_vachellii'    % 235 341 1020 mg O2/h.kg
    [520     9   0.2912    0.6613    2.9727], 'FuDong2022',   'Oncorhynchus_tshawytscha'%  48 109  490 mg O2/h.kg
    [  6    15   0.0132    0.0414    0.0551], 'FuDong2022',   'Oncorhynchus_mykiss'     % 189 591  787 mg O2/h.kg
    [364    22.5 0.4247    0.6795    1.4863], 'FuDong2022',   'Dicentrarchus_labrax'    % 100 160  350 mg O2/h.kg
    [105    17   0.1593    0.4667    0.4667], 'FuDong2022',   'Pagrus_auratus'          % 130 190  381 mg O2/h.kg
    [107    21   0.3121    0.5843    0.5843], 'FuDong2022',   'Pagrus_auratus'          % 163 250 4681 mg O2/h.kg
    [ 30    17   0.0364    0.0682    0.2401], 'FuDong2022',   'Aldrichetta_forsteri'    % 104 195  686 mg O2/h.kg
    [ 29    21   0.0420    0.0711    0.2703], 'FuDong2022',   'Aldrichetta_forsteri'    % 124 210  799 mg O2/h.kg
    [706    26   1.6473    6.5893   11.2348], 'FuDong2022',   'Coryphaena_hippurus'     % 200 800 1364 mg O2/h.kg
    [135.5  26   0.1423    0.7003    0.7003], 'FuDong2022',   'Pterois_volitans'        %  90 443  352 mg O2/h.kg
    [135.5  32   0.2624    0.7762    0.7762], 'FuDong2022',   'Pterois_volitans'        % 166 491  346 mg O2/h.kg
    [1600   21   5.5014   25.6424   36.0640], 'ClarJeff2011', 'Oncorhynchus_gorbuscha'  % 4.912 22.895 32.2 mg O2/min.kg
    [  50   15   0.0362    0.2217    NaN   ], 'GrahDewa1990', 'Oncorhynchus_nerka'      % 62 380 mg O2/h.kg
  };
  %prt_tab({act(:,[3 2]), cell2mat(act(:,1))},{'species', 'bibkey', 'mass,g', 'temp,C', 'SMR,ml O2/min', 'PMR,ml O2/min', 'MMR,ml O2/min'}, 'Actinop')

  % 1 mg O2/h = 0.7 ml O2/h; %x means not in AmP
  amp = { ... % Amphibia, mass(g), temp(C), SMR(ml O2/min), PMR(ml O2/min) 
    [ 2  13 0.0007  0.0075], 'Fede1986', 'Desmognathus_ochrophaeus' % 0.9 10 mumol/h.g
    [4.1 13  0.005  0.0376], 'Full1985', 'Plethodon_jordani' % PMR 0.55 ml O2/h.g; FAS 6-9
  };

  squ = { ... % Squamata mass (g), Tb (C), SMR (mg O2/min) PMR (mg O2/min); %x means not in AmP
    [ 517  35  1.6    5.4], 'ChriConl1994', 'Tiliqua_rugosa'  
    [1136 35   NaN   16.9], 'ChriConl1994', 'Cyclura_nubila' 
   %[1287 35   3.1   24.3], 'ChriConl1994', 'Varanus_rosenbergi' %x
   %[1086 35   1.9   24.5], 'ChriConl1994', 'Varanus_gouldii' %x
   %[ 931 35   2.1   20.8], 'ChriConl1994', 'Varanus_panoptes' %x
   %[ 904 35   1.2   13.7], 'ChriConl1994', 'Varanus_mertensi' %x
    [ 580 35  0.841 9.783], 'Glee1979',     'Amblyrhynchus_cristatus' % 0.087	1.012 ml O2/h.g
  };

  ave = { ...  % Aves ; m(g) Tb(C) BMR(ml O2/min) PMR (ml O2/min); %x means not in AmP
    % Casuariiformes
    [55000  36.0 215.05  2473], 'MainKing1989', 'Dromaius_novaehollandiae' %  3.91 ml O2/min.kg, AS 11.5 BundHopl1999
    % Rheiformes
    [21800  39.0 103.6   3728], 'BundHopl1999', 'Rhea_americana' % 2.85 ml O2/s.kg, AS 36
    % Struthioniformes
    [130000 34.6 613.6  10738], 'MainKing1989', 'Struthio_camelus' %  4.72 ml O2/min.kg, AS 17.5 BundHopl1999
    % Galliformes
    [ 161.0 41.3  4.41  20.48], 'HindBaud1993', 'Coturnix_japonica' % 
    [  42.1 40.5  1.20   6.57], 'HindBaud1993', 'Synoicus_chinensis' 
    [ 2800  41.0  24.1 299.60], 'BracElSa1985', 'Gallus_gallus_WL' % 8.6, 107 ml CO2/min.kg
    % Anseriformes
    [275    4.12   NaN  23.22], 'Kirk1983',     'Dendrocygna_autumnalis' % PMR 672 kJ/d; 20.1 kJ/l O2
   %[ 944.1 39.7 12.23  61.51], 'HindBaud1993', 'Anas_castanea' %x
    [190    41.2   NaN  21.39], 'Kirk1983',     'Aythya_affinis' % PMR 619 kJ/d; 20.1 kJ/l O2
    % Columbiformes
   %[ 302.0 41.7  4.34  28.24], 'HindBaud1993', 'Columba_livia' 
    [ 419   41.7  7.08  162.8], 'Pear1964',     'Columba_livia' % PMR 112 kcal/h.kg (4.184 J/cal; 20.1 kJ/l O2); FAS 23 
    [40.5   42.1   NaN   8.54], 'WierChap2007', 'Columbina_talpacoti' % PMR 2.86 W; 20.1 kJ/l O2
    % Gruiformes
    [ 850.3 37.4  9.19  52.08], 'HindBaud1993', 'Porphyrio_martinica' 
    % Apodiformes
    [ 5.7   40.7  0.051 0.717], 'BergHart1972', 'Chionomesa_fimbriata' % PMR 43 ml/h.g, FAS 14
    [ 3.3   34    0.198 1.815], 'Lasi1963',     'Archilochus_alexandri' % PMR 33 ml/h.g SMR 3.6 ml/h.g
    [ 4.1   39    0.232 9.157], 'Lasi1963',     'Selasphorus_rufus' % PMR 124 ml/h.g SMR 3.4 ml/h.g
    [ 3.2   36.2  0.192 7.147], 'Lasi1963',     'Selasphorus_sasin' % PMR 134 ml/h.g SMR 3.6 ml/h.g
    [ 2.3   36    0.153 2.542], 'Lasi1963',     'Selasphorus_calliope' % PMR 66.3 ml/h.g SMR 4.0 ml/h.g
    [ 4.1   35.5  0.260 4.647], 'Lasi1963',     'Calypte_anna' % PMR 68 ml/h.g SMR 3.8 ml/h.g
    [ 3.2   36.7  0.155 4.053], 'Lasi1963',     'Calypte_costae' % PMR 76 ml/h.g SMR 2.9 ml/h.g
    [ 6.3   38.5  0.051 2.50 ], 'SchuSchm1979', 'Trochilus_polytmus' % PMR 4.9 23.8 ml O2/h.g
    [ 4.9   41.4  0.054 1.89 ], 'SchuSchm1979', 'Trochilus_scitulus' % PMR 6.6 23.1 ml O2/h.g
    [19.9   41.4  0.675 2.390], 'LasiWeat1967', 'Patagona_gigas' % 2.131 7.547 ml O2/h.g
    [ 6.0   38.5  0.317 2.651], 'RezeSwan2002', 'Sephanoides_sephaniodes' % 3.17 26.51 ml O2/h.g
    % Sphenisciformes
    [1080.0 38.5 13.31  57.42], 'HindBaud1993', 'Eudyptula_minor' 
    [45000  36.0 301.5   2340], 'KooyPong1994', 'Aptenodytes_forsteri' % 6.7, 52 ml O2/min.kg
    [6210   38.2  59.2 219.46], 'BevaWoak1995', 'Pygoscelis_papua' %  9.54, 35.34 ml O2/min.kg
    % Suliformes
    [1300   40.6   NaN  64.95], 'Kirk1983',     'Phalacrocorax_pelagicus' % PMR 1880 kJ/d; 20.1 kJ/l O2
    % Charadriiformes
    [277    40.9  8.13  45.97], 'BernThom1973', 'Leucophaeus_atricilla' % 0.0099 0.056 W/g
    [63.4   41.0 1.409 16.906], 'Putt1980',     'Calidris_ferruginea' % 1699 kJ/h; FAS 12; 20.1 kJ/l O2
    [58.4   41.0  1.94  10.41], 'ThomSwan2019', 'Calidris_melanotos' % 
    [19.4   41.0  0.84   4.62], 'ThomSwan2019', 'Calidris_minutilla' %  
    [16.0   41.0  1.38   3.19], 'WillTiel2007', 'Calidris_minutilla' % 40.0 92.3 kJ/d; 20.1 kJ/l O2
    [41.1   41.0  3.02   7.71], 'WillTiel2007', 'Calidris_alpina' % 87.45 223.11 kJ/d; 20.1 kJ/l O2
    [125.5  41.0  3.58  23.88], 'VeziGers2017', 'Calidris_canutus' % 1.2 8.0 W; 20.1 kJ/l O2
    [61.0   41.0  3.63   8.62], 'WillTiel2007', 'Tringa_flavipes' % 105.2 249.4 kJ/d; 20.1 kJ/l O2
    [55.0   41.0  2.38   7.60], 'WillTiel2007', 'Limnodromus_griseus' % 68.88 220.04 kJ/d; 20.1 kJ/l O2
    [75.4   40.9  3.72  11.18], 'WillTiel2007', 'Pluvialis_dominica' % 107.8 323.6 kJ/d; 20.1 kJ/l O2
    [151.0  41.0  7.08  16.41], 'WillTiel2007', 'Limosa_haemastica' % 204.8 474.9 kJ/d; 20.1 kJ/l O2
    [190.0  41.0  7.79  23.38], 'WillTiel2007', 'Numenius_phaeopus' % 225.6 676.6 kJ/d; 20.1 kJ/l O2
    % Strigiformes
    [ 76    41.0  1.86   8.85], 'RezeSwan2002', 'Glaucidium_nana' % 1.47 6.67 ml O2/h.g; (weight 98 g is given, but 76 g is max)
    % Falconiformes
    [106    40.0   NaN  11.09], 'Kirk1983',     'Falco_tinnunculus' % PMR 321 kJ/d; 20.1 kJ/l O2
    % Piciformes
    [ 25    41.0  1.275  7.94], 'RezeSwan2002', 'Dryobates_pubescens' % 3.06 19.05  ml O2/h.g
    % Psittaciformes
    [89.4   40.0   NaN  12.79], 'HindBaud1993', 'Platycercus_elegans' % actually Platycercus_eximius
    [36.0   39.7  1.28   7.91], 'HindBaud1993', 'Melopsittacus_undulatus' % BundHopl1999 give AS 21
   %[12.0   41.6   NaN  11.91], 'WierChap2007', 'Myiodynastes_maculatus' %x PMR 3.99 W; 20.1 kJ/l O2
    % Passeriformes
    % % Tyrannides
   %[27.5   41.6   NaN   6.27], 'WierChap2007', 'Thamnophilus_doliatus' %x PMR 2.1 W; 20.1 kJ/l O2 Thamnophilidae
   %[22.5   41.3   NaN   6.00], 'WierChap2007', 'Myrmeciza_longipes' %x PMR 2.01 W; 20.1 kJ/l O2 Thamnophilidae
   %[29.0   41.6   NaN   1.94], 'WierChap2007', 'Myrmotherula_fulviventris' %x PMR 0.65 W; 20.1 kJ/l O2 Thamnophilidae
   %[12.0   41.1   NaN   1.46], 'WierChap2007', 'Hylophylax_naevioides' %x PMR 0.49 W; 20.1 kJ/l O2 Thamnophilidae
   %[39.0   41.4   NaN   7.88], 'WierChap2007', 'Sclerurus_guatemalensis' %x PMR 2.64 W; 20.1 kJ/l O2 Furnariidae
   %[27.9   41.6   NaN   9.55], 'WierChap2007', 'Dendrocincla_fuliginosa' %x PMR 3.2 W; 20.1 kJ/l O2 Furnariidae
   %[10.8   41.5   NaN   4.21], 'WierChap2007', 'Xenops_minutus' %x PMR 1.41 W; 20.1 kJ/l O2 Furnariidae  
    [18.5   41.6   NaN   6.03], 'WierChap2007', 'Chiroxiphia_lanceolata' % PMR 2.02 W; 20.1 kJ/l O2 Pipridae
   %[12.3   41.6   NaN   4.96], 'WierChap2007', 'Pipra_mentalis' %x PMR 1.66 W; 20.1 kJ/l O2 Pipridae
   %[18.2   41.6   NaN   4.48], 'WierChap2007', 'Manacus_vitellinus' %x PMR 1.5 W; 20.1 kJ/l O2 Pipridae
   %[42.0   41.6  1.491 8.183], 'RezeSwan2002', 'Phytotoma_rara' %x 2.13 11.69 ml O2/h.g Cotingidae
   %[ 9.0   41.6   NaN   1.40], 'WierChap2007', 'Oncostoma_olivaceum' %x PMR 0.47 W; 20.1 kJ/l O2 Tyrannidae
   %[33.5   41.6   NaN   6.45], 'WierChap2007', 'Elaenia_chiriquensis' %x PMR 2.16 W; 20.1 kJ/l O2 Tyrannidae
   %[ 7.0   41.6   NaN   2.45], 'WierChap2007', 'Tyrannulus_elatus' %x PMR 0.82 W; 20.1 kJ/l O2 Tyrannidae
    [40.0   41.6   NaN   7.88], 'WierChap2007', 'Tyrannus_melancholicus' %x PMR 2.64 W; 20.1 kJ/l O2 Tyrannidae
    [37.0   41.6 1.369  8.060], 'RezeSwan2002', 'Tyrannus_tyrannus' %x PMR 2.22 13.07 ml O2/h.g O2 Tyrannidae
   %[25.7   40.7   NaN   3.16], 'WierChap2007', 'Rhynchocyclus_olivaceus' %x PMR 1.06 W; 20.1 kJ/l O2 Tyrannidae
   %[ 6.5   41.6   NaN   2.87], 'WierChap2007', 'Camptostoma_obsoletum' %x PMR 0.96 W; 20.1 kJ/l O2 Tyrannidae
   %[ 7.0   41.6   NaN   3.01], 'WierChap2007', 'Capsiempis_flaveola' %x PMR 1.01 W; 20.1 kJ/l O2 Tyrannidae
   %[ 6.5   41.6   NaN   2.18], 'WierChap2007', 'Todirostrum_cinereum' %x PMR 0.73 W; 20.1 kJ/l O2 Tyrannidae
    [46.5   41.6   NaN   6.30], 'WierChap2007', 'Myiozetetes_similis' % PMR 2.11 W; 20.1 kJ/l O2 Tyrannidae
    [61.5   41.6   NaN   2.23], 'WierChap2007', 'Mionectes_oleagineus' % PMR 0.75 W; 20.1 kJ/l O2 Tyrannidae
   %[14.5   41.6   NaN   4.18], 'WierChap2007', 'Tolmomyias_assimillis' %x PMR 1.4 W; 20.1 kJ/l O2 Tyrannidae
   %[14.0   41.6 0.642   3.87], 'RezeSwan2002', 'Contopus_virens' %x  2.75 16.57 ml O2/h.g  Tyrannidae
   %[14.0   41.5 0.595  3.867], 'DuteSwan1996', 'Contopus_virens' %x  Tyrannidae
    [10.0   41.6   NaN   3.34], 'WierChap2007', 'Myiobius_atricaudus' % PMR 1.12 W; 20.1 kJ/l O2 Onychorhynchidae
    % % Passeri
    [275    41.6 10.67  68.13], 'BernThom1973', 'Corvus_ossifragus' % 0.013 0.083 W/g Corvidae
    [18.2   41.6   NaN   3.26], 'Kirk1983',     'Delichon_urbicum' % PMR 94.5 kJ/d; 20.1 kJ/l O2 Hirundinidae
   %[38.7   41.6   NaN   4.48], 'WierChap2007', 'Hylophilus_flavipes' %x PMR 1.5 W; 20.1 kJ/l O2 Vireonidae
   %[14.8   41.6   NaN  14.66], 'WierChap2007', 'Mimus_gilvus' %x PMR 4.91 W; 20.1 kJ/l O2 Mimidae
    [34.0   41.6 1.552  8.149], 'RezeSwan2002', 'Dumetella_carolinensis' % 2.74 14.38 cm^3 O2/h.g Mimidae
    [34.4   41.5 1.469  8.247], 'DuteSwan1996', 'Dumetella_carolinensis' % Mimidae
    [13.5   41.9   NaN   9.04], 'WierChap2007', 'Progne_chalybea' % PMR 3.03 W; 20.1 kJ/l O2 Hirundinidae
    [20.0   41.9 1.103  6.717], 'RezeSwan2002', 'Sitta_carolinensis' % 3.31 20.15 ml O2/h.g Sittidae
    [ 9.0   42.1   NaN   3.52], 'WierChap2007', 'Tachycineta_albilinea' % PMR 1.18 W; 20.1 kJ/l O2 Hirundinidae
   %[36.8   41.6   NaN   2.27], 'WierChap2007', 'Ramphocaenus_melanurus' %x PMR 0.76 W; 20.1 kJ/l O2 Polioptilidae
   %[ 9.5   41.6   NaN   8.18], 'WierChap2007', 'Ramphocelus_dimidiatus' %x PMR 2.74 W; 20.1 kJ/l O2 Polioptilidae
   %[24.5   41.6   NaN   5.19], 'WierChap2007', 'Thryothorus_fasciatoventris' %x PMR 1.74 W; 20.1 kJ/l O2 Troglodytidae
   %[20.3   42.7   NaN   6.21], 'WierChap2007', 'Thryothorus_leucotis' %x PMR 2.08 W; 20.1 kJ/l O2 Troglodytidae
   %[15.0   41.6   NaN   3.94], 'WierChap2007', 'Thryothorus_rutilus' %x PMR 1.32 W; 20.1 kJ/l O2 Troglodytidae
    [13.5   42.0   NaN   5.28], 'WierChap2007', 'Troglodytes_aedon' % PMR 1.77 W; 20.1 kJ/l O2 Troglodytidae
    [10.5   41.6 0.555  4.083], 'DuteSwan1996', 'Troglodytes_aedon'  % Troglodytidae
    [11.0   41.6 0.422  2.867], 'RezeSwan2002', 'Zosterops_lateralis' % 2.30 15.64 ml O2/h.g Zosteropidae
    [ 5.9   41.6   NaN  2.324], 'RezeSwan2002', 'Corthylio_calendula'  % PMR 23.63 ml O2/h.g Regulidae
    [ 5.8   41.6   NaN  2.510], 'RezeSwan2002', 'Regulus_satrapa'  % PMR 25.97 ml O2/h.g Regulidae
   %[72.0   42.1   NaN  15.19], 'WierChap2007', 'Turdus_grayi' %x PMR 5.09 W; 20.1 kJ/l O2 Turdidae
   %[18.2   41.9   NaN   5.19], 'WierChap2007', 'Vireo_flavoviridis' %x PMR 1.74 W; 20.1 kJ/l O2 Vireonidae
   %[13.0   41.9 0.685  4.108], 'RezeSwan2002', 'Vireo_gilvus' %x 3.16 18.96 ml O2/h.g Vireonidae
    [13.7   41.6 1.092  7.714], 'DuteSwan1996', 'Poecile_atricapillus' % Paridae 
    [11.0   41.6 0.744  4.670], 'RezeSwan2002', 'Poecile_gambeli' % 4.06 25.47 ml O2/h.g Paridae 
    % % % Passerida
    [11.3   41.0  0.68   4.03], 'HindBaud1993', 'Taeniopygia_guttata' % Estrildidae
    [12.0   41.6 0.722  4.098], 'RezeSwan2002', 'Taeniopygia_guttata' % 3.61 20.49 ml O2/h.g Estrildidae 
    [23.1   41.6  0.97   9.99], 'ButtBech2010', 'Passer_domesticus' % for adults; juveniles 22.34 g, 1.06, 8.81 ml O2/min Passeridae
    [27.2   41.6 1.314 10.605], 'DuteSwan1996', 'Passer_domesticus'  %  Passeridae 
   %[28.9   41.6   NaN   3.88], 'WierChap2007', 'Euphonia_laniirostris' %x PMR 1.3 W; 20.1 kJ/l O2 Fringillidae
    [30.0   41.6   NaN   3.80], 'Kirk1983',     'Fringilla_coelebs' % PMR 110 kJ/d; 20.1 kJ/l O2 Fringillidae
    [20.8   41.6 0.971  2.392], 'DawsButt1985', 'Haemorhous_mexicanus' % 2.8 6.9 cm^3 O2/h.g Fringillidae % cold stress down to 0C; at lower temp MR might be higher 
    [14.0   41.6 0.863  5.088], 'RezeSwan2002', 'Acanthis_flammea' %  3.70 21.80  cm^3 O2/h.g Fringillidae
    [13.0   41.6 0.867  4.314], 'RezeSwan2002', 'Spinus_tristis' % 4.0 19.91 cm^3 O2/h.g Fringillidae
    [40.7   41.6 1.564  8.922], 'DuteSwan1996', 'Pheucticus_ludovicianus' % Cardinalidae 
   %[27.9   41.6   NaN   6.51], 'WierChap2007', 'Cyanocompsa_cyanoides' %x PMR 2.18 W; 20.1 kJ/l O2 Cardinalidae
   %[13.2   41.6   NaN   7.97], 'WierChap2007', 'Habia_fuscicauda' %x PMR 2.67 W; 20.1 kJ/l O2 Cardinalidae
    [46.0   41.6 NaN    9.721], 'RezeSwan2002', 'Cardinalis_cardinalis' % 12.68 cm^3 O2/h.g Cardinalidae
   %[27.0   41.6   NaN   6.21], 'RezeSwan2002', 'Phrygilus_gayi' %x PMR 13.80 ml O2/h.g Thraupidae
   %[ 7.5   41.6   NaN   4.09], 'WierChap2007', 'Oryzoborus_angolensis' %x PMR 1.37 W; 20.1 kJ/l O2 Thraupidae
   %[21.8   41.6   NaN   8.24], 'WierChap2007', 'Eucometis_penicillata' %x PMR 2.76 W; 20.1 kJ/l O2 Thraupidae
   %[39.0   41.6   NaN   7.79], 'WierChap2007', 'Saltator_striatipectus' %x PMR 2.61 W; 20.1 kJ/l O2 Thraupidae
   %[36.5   41.6   NaN   4.09], 'WierChap2007', 'Sporophila_americana' %x PMR 1.37 W; 20.1 kJ/l O2 Thraupidae
   %[10.1   41.6   NaN   4.39], 'WierChap2007', 'Sporophila_nigricollis' %x PMR 1.47 W; 20.1 kJ/l O2 Thraupidae
    [29.7   41.3   NaN   7.28], 'WierChap2007', 'Thraupis_episcopus' % PMR 2.44 W; 20.1 kJ/l O2 Thraupidae
   %[30.5   41.6   NaN   6.42], 'WierChap2007', 'Thraupis_palmarum' %x PMR 2.15 W; 20.1 kJ/l O2 Thraupidae
    [34.0   41.6  NaN   9.100], 'RezeSwan2002', 'Diuca_diuca' % 16.06 cm^3 O2/h.g Thraupidae
   %[41.2   41.6   NaN   9.91], 'WierChap2007', 'Arremonops_conirostris' %x PMR 3.32 W; 20.1 kJ/l O2 Passerellidae
    [32.4   41.6   NaN   4.46], 'Kirk1983',     'Zonotrichia_leucophrys' % PMR 129 kJ/d; 20.1 kJ/l O2 Passerellidae
    [28.0   41.6   NaN   4.91], 'Kirk1983',     'Zonotrichia_albicollis' % PMR 142 kJ/d; 20.1 kJ/l O2 Passerellidae
    [20.0   41.6 1.037  5.433], 'RezeSwan2002', 'Zonotrichia_capensis' % 3.11 16.30 ml O2/h.g Passerellidae
    [12.8   41.6 0.722  4.539], 'DuteSwan1996', 'Spizella_pusilla' % Passerellidae
    [18.6   41.6 1.209  7.478], 'DuteSwan1996', 'Spizelloides_arborea' % Passerellidae
    [20.0   41.6 1.423  8.619], 'DuteSwan1996', 'Junco_hyemalis' % Passerellidae   
    [17.0   41.6 0.941  5.879], 'RezeSwan2002', 'Junco_hyemalis' % 3.32 20.75 ml O2/h.g Passerellidae   
    [19.0   41.6 1.311  7.638], 'RezeSwan2002', 'Spizelloides_arborea' % 4.14 24.12 ml O2/h.g Passerellidae   
    [11.0   41.6 0.638  3.584], 'RezeSwan2002', 'Spizella_passerina' % 3.48 19.55 ml O2/h.g Passerellidae   
    [13.0   41.6 0.789  4.611], 'RezeSwan2002', 'Spizella_pusilla' % 3.64 21.28 ml O2/h.g Passerellidae   
   %[11.0   41.6   NaN   3.52], 'WierChap2007', 'Basileuterus_rufifrons' %x PMR 1.18 W; 20.1 kJ/l O2 Parulidae
    [ 9.3   41.6 0.546  3.018], 'DuteSwan1996', 'Setophaga_petechia' % Parulidae
    [ 9.0   41.6 0.744  3.894], 'RezeSwan2002', 'Setophaga_petechia' % 3.72 19.47 cm^3 O2/h.g Parulidae
   %[12.0   41.6 0.746  3.937], 'RezeSwan2002', 'Setophaga_coronata' %x 3.73 19.69 cm^3 O2/h.g Parulidae
    [32.0   41.6 1.499  7.242], 'RezeSwan2002', 'Icterus_galbula' % 2.81 13.58 cm^3 O2/h.g Icteridae
};     
  %prt_tab({ave(:,[3 2]), cell2mat(ave(:,1))},{'species', 'bibkey', 'mass,g', 'temp,C', 'SMR,ml O2/min', 'PMR,ml O2/min'}, 'Aves')

  mar = { ... % Marsupialia & Prototheria; m(g), Tb(C), BMR(ml O2/min), PMR (ml O2/min); %x means not in AmP
   % Prototheria
    [ 1112.5 30.8 10.87  49.86], 'HindBaud1993', 'Ornithorhynchus_anatinus' 
    [ 3293.0 30.8  7.76  47.05], 'HindBaud1993', 'Tachyglossus_aculeatus' 
    [ 3900.0 30.8  9.75  91.00], 'HampNels2010', 'Tachyglossus_aculeatus' % 0.15 1.4 ml O2/h.g
   % Marsupialia
    [   15.6 35.0  0.48   2.38], 'HindBaud1993', 'Sminthopsis_crassicaudata' 
    [   16.7 32.7  0.35   2.38], 'HindBaud1993', 'Sminthopsis_macroura'
    [  119.5 35.3  1.52  19.36], 'HindBaud1993', 'Dasyuroides_byrnei'
   %[  532.3 33.7  3.20  29.85], 'HindBaud1993', 'Dasyurus_hallucatus' %x
    [ 1054.0 35.1  6.28  69.60], 'HindBaud1993', 'Dasyurus_viverrinus' 
    [  717.2 33.9  3.71  43.43], 'HindBaud1993', 'Isoodon_obesulus'
    [  837.3 35.2  7.01  48.76], 'HindBaud1993', 'Perameles_gunnii'
    [  122.0 34.9  1.40   8.24], 'HindBaud1993', 'Petaurus_breviceps' 
    [  965.7 37.2  9.39  70.07], 'HindBaud1993', 'Bettongia_penicillata'
    [ 1385.0 35.6 10.69 100.10], 'HindBaud1993', 'Bettongia_gaimardi' 
    [ 1027.8 35.8  8.72  65.90], 'HindBaud1993', 'Potorous_tridactylus' 
    [ 2026.5 35.8 13.85  74.65], 'HindBaud1993', 'Trichosurus_vulpecula'
  };
  %  
  pla = {... % Placentalia; m(g), Tb(C), BMR(ml O2/min), PMR (ml O2/min); %x means not in AmP
   % Eulipotyphla
    [    3.3 39.0  0.15   1.60], 'Lech1978',     'Sorex_cinereus'
    [   8.2  39.6 0.803   3.21], 'OchoTayl2005', 'Sorex_araneus' % BMR 58.1/2.5 kJ/d; PMR 23.5 ml O2/h.g; 20.1 kJ/l O2
   % Carnivora
   %[  583   39.8   NaN   74.4], 'TaylMalo1980', 'Helogale_parvula' %x 1.24 ml O2/s
   %[ 1151   39.8   NaN  139.8], 'TaylMalo1980', 'Mungos_mungo' %x 2.33 ml O2/s
   %[ 1458   36.7   NaN  154.8], 'TaylMalo1980', 'Genetta_tigrina' %x 2.58 ml O2/s
    [ 41000  39.0 311.2  14700], 'ScanMill2014', 'Acinonyx_jubatus' % FMR=DEE 9006 kJ/d PMR 120 W/kg; 20.1 kJ/l O2
    [ 25000  38.0 117.5   2900], 'GormMill1998', 'Canis_familiaris' % BMR 3.4 MJ/d canid AS 25; 20.1 kJ/l O2
    [450000  36.8   NaN   5782], 'Kirk1983',     'Ursus_maritimus' % PMR 167360 kJ/d; 20.1 kJ/l O2
    [    86  39.6   NaN   7.34], 'Kirk1983',     'Mustela_nivalis' % PMR 224 kJ/d; 20.1 kJ/l O2
    [   63e3 37   289.8    945], 'DaviWill1985', 'Phoca_vitulina' % 4.6 15 ml O2/min.kg   
   % Perissodactyla
    [500000  38.0  1600  88000], 'Hodg2025',     'Equus_ferus_caballus' % BMR 2.2-4.2 mL O2/kg/min; FAS 50-60
   %[635000  38.0   NaN   4957], 'Kirk1983',     'Equus_ferus_caballus' % PMR 143470 kJ/d; 20.1 kJ/l O2. Reliable? PMR is less than for a cow
   % Cetartiodactyla
    [205000  39.0   NaN   2371], 'Kirk1983',     'Sus_domesticus' % PMR 68620 kJ/d; 20.1 kJ/l O2 
   %[ 3500   36.7   NaN  355.2], 'TaylMalo1980', 'Nesotragus_moschatus' %x 5.92 ml O2/s
    [ 4354   39.4   NaN  237.0], 'TaylMalo1980', 'Madoqua_kirkii' % 3.95 ml O2/s
   %[11200   38.9   NaN  600.0], 'TaylMalo1980', 'Gazella_granti' %x 10.0 ml O2/s
    [32000   39.5 152.5   9792], 'LindHoka1991', 'Antilocapra_americana' % 5.1 ml O2/s.kg = 9792 ml O2/min; Bish1999 FAS 64.2; BMR 9792/64.2 ml O2/min
    [98000   38.0   NaN  4356 ], 'TaylMalo1980', 'Connochaetes_taurinus' % 72.6 ml O2/s
    [114000  39.4   NaN  5388 ], 'TaylMalo1980', 'Kobus_ellipsiprymnus' % 89.8 ml O2/s
    [217000  36.5   NaN  7860 ], 'TaylMalo1980', 'Taurotragus_oryx' % 131 ml O2/s
    [ 21150  39.3   NaN  1098 ], 'TaylMalo1980', 'Capra_hircus' % 18.3 ml O2/s
    [ 22650  38.8   NaN  1050 ], 'TaylMalo1980', 'Ovis_aries' % 17.5 ml O2/s
    [550000  38.6   NaN   6082], 'Kirk1983',     'Bos_primigenius_Holstein' % PMR 176040 kJ/d; 20.1 kJ/l O2 (milk production)
    [  817e3 35.5  3315  10897], 'JohnChri2024', 'Delphinapterus_leucas' % 4.058 13.338 ml O2/min.kg
    [5.318e6 36.0  6633  39635], 'WortWort2013', 'Orcinus_orca' % 8.0 47.8 MJ/h; 20.1 kJ/l O2 
   % Rodentia
   %[   255  39.0 2.928  29.88], 'Bozi1992',     'Microcavia_niata' %x 175.7 1792.7 ml O2/h
   %[    35  39.6 1.030   5.35], 'Bozi1992',     'Abrothrix_andinus' %x 61.8 321.1 ml O2/h
   %[    29  39.6 0.877   6.91], 'Bozi1992',     'Abrothrix_andinus' %x 52.6 414.6 ml O2/h
   %[    25  39.6 0.660   6.11], 'Bozi1992',     'Abrothrix_andinus' %x 39.6 366.6 ml O2/h
   %[    33  39.6 0.977   5.92], 'Bozi1992',     'Abrothrix_andinus' %x 58.6 355.3 ml O2/h
   %[    23  39.6 0.735   4.87], 'Bozi1992',     'Abrothrix_andinus' %x 44.1 292.3 ml O2/h
   %[    42  39.6 1.308   6.09], 'Bozi1992',     'Abrothrix_longipilis' %x 78.5 365.4 ml O2/h
   %[    27  39.6 0.823   4.14], 'Bozi1992',     'Abrothrix_olivaceus' %x 49.4 248.4 ml O2/h
   %[    31  36.2 0.775   6.10], 'Bozi1992',     'Akodon_albiventer' %x 46.5 365.8 ml O2/h
   %[    24  39.6 0.760   5.00], 'Bozi1992',     'Abrothrix_lanosus' %x 45.6 300.0 ml O2/h
   %[    77  39.6 1.848   9.75], 'Bozi1992',     'Auliscomys_boliviensis' %x 110.9 585.2 ml O2/h
   %[    62  39.6 1.622   7.44], 'Bozi1992',     'Loxodontomys_micropus' %x 97.3 446.4 ml O2/h
    [     7  36.0 0.333   1.44], 'Bozi1992',     'Baiomys_taylori' %  20.0 86.1 ml O2/h
    [    48  36.6 1.183   5.44], 'Bozi1992',     'Calomys_callosus' % 71.0 326.4 ml O2/h
    [    48  38.0  0.93   5.34], 'Lech1978',     'Calomys_callosus'
    [    16  36.6 0.480   3.73], 'Bozi1992',     'Calomys_lepidus' % 28.8 224.0 ml O2/h
    [    17  36.6 0.468   3.00], 'Bozi1992',     'Calomys_musculinus' % 28.1 180.2 ml O2/h
    [    28  36.6 1.283   6.30], 'Bozi1992',     'Myodes_rutilus' % 77.0 378.0 ml O2/h
    [    15  36.6 0.813   6.60], 'Bozi1992',     'Myodes_rutilus' % 48.8 396.0 ml O2/h
    [    21  39.6 0.560   6.66], 'Bozi1992',     'Eligmodontia_typus' % 33.6 399.6 ml O2/h
    [    18  39.6 0.513   3.45], 'Bozi1992',     'Eligmodontia_typus' % 30.8 207.0 ml O2/h
   %[    69  39.6 1.392   7.25], 'Bozi1992',     'Graomys_griseoflavus' %x 83.5 434.7 ml O2/h
   %[    28  36.2 0.845   4.57], 'Bozi1992',     'Oryzomys_longicaudatus' %x 50.7 274.4 ml O2/h
    [    32  38.4 1.280   6.67], 'Bozi1992',     'Microtus_oeconomus' % 76.8 400.0 ml O2/h
    [    41  36.4 0.941   3.48], 'Bozi1992',     'Peromyscus_californicus' % 56.5 208.9 ml O2/h
    [    18  36.6 0.405   2.41], 'Bozi1992',     'Peromyscus_eremicus' % 24.3 144.3 ml O2/h
    [    19  36.6 0.448   2.41], 'Bozi1992',     'Peromyscus_eremicus' % 26.9 144.4 ml O2/h
    [  17.3  36.6 1.510   4.15], 'Haye2010',     'Peromyscus_maniculatus' % 4.45 mL CO2/h.g, 0.24 ml O2/min.g; 0.85 mL CO2/mL O2
    [    49  39.6 1.093   5.86], 'Bozi1992',     'Phyllotis_darwini' % 65.6 351.4 ml O2/h
    [    59  39.6 1.190   6.79], 'Bozi1992',     'Phyllotis_darwini' % 71.4 407.1 ml O2/h
    [    36  39.6 0.757   5.15], 'Bozi1992',     'Phyllotis_darwini' % 45.4 308.9 ml O2/h
   %[    79  39.6 1.280   9.48], 'Bozi1992',     'Reithrodon_auritus' %x 76.8 569.0 ml O2/h
    [    33  37.0 0.772   3.79], 'Bozi1992',     'Dipodomys_merriami' % 46.3 227.5 ml O2/h
    [    34  37.0 0.627   4.29], 'Bozi1992',     'Dipodomys_merriami' % 37.6 257.5 ml O2/h
    [    45  39.6 0.835   3.34], 'Bozi1992',     'Heteromys_salvini' % 50.1 200.3 ml O2/h
   %[    20  34.7 0.397   2.84], 'Bozi1992',     'Perognathus_fallax' %x 23.8 170.2 ml O2/h
   %[    21  34.7 0.463   2.78], 'Bozi1992',     'Perognathus_fallax' %x 27.8 166.6 ml O2/h
   %[    18  34.7 0.425   2.56], 'Bozi1992',     'Perognathus_fallax' %x 25.5 147.5 ml O2/h
   %[   176  37.6 3.053  12.91], 'Bozi1992',     'Octodon_bridgesi' %x 183.2 774.4 ml O2/h
    [   195  37.6 3.023  17.88], 'Bozi1992',     'Octodon_degus' % 181.4 1072.5 ml O2/h
   %[   173  37.6 2.855  15.28], 'Bozi1992',     'Octodon_lunatus' %x 171.3 916.9 ml O2/h
    [   28.0 37.0  1.28   6.30], 'Lech1978',     'Myodes_rutilus'
    [    6.9 36.0  0.24   1.41], 'Lech1978',     'Baiomys_taylori'
    [  113   38.0  2.47  11.20], 'Lech1978',     'Mesocricetus_auratus'
   %[  819.0 34.6  9.51  44.27], 'HindBaud1993', 'Uromys_caudimaculatus' %x
    [  212.3 35.9  2.71  14.85], 'HindBaud1993', 'Conilurus_penicillatus' 
    [   38.8 36.2  0.83   3.48], 'HindBaud1993', 'Notomys_alexis'
    [    17  36.9 0.502   3.91], 'Bozi1992',     'Mus_musculus' % 30.1 234.6 ml O2/h
    [    17  36.9 0.500   3.49], 'Bozi1992',     'Mus_musculus' % 30.0 209.1 ml O2/h
    [   34   37.0  0.88   5.30], 'Lech1978',     'Mus_musculus'
    [   253  37.0 4.470  21.93], 'Bozi1992',     'Rattus_norvegicus' % 268.2 1315.6 ml O2/h
    [  181.2 38.0  4.47  21.90], 'Lech1978',     'Rattus_norvegicus' 
   %[  165.7 36.2  2.05  11.51], 'HindBaud1993', 'Rattus_colletti' %x
   %[  247.8 36.0  2.43  14.48], 'HindBaud1993', 'Rattus_villosissimus' %x
    [ 3200.0 37.0  10.1  80.00], 'HampNels2010', 'Marmota_marmota' %  0.19 1.5 ml O2/h.g 
   %[  800.0 35.5  6.67  35.33], 'HampNels2010', 'Urocitellus_parryii' %x 0.5 2.65 ml O2/h.g 
    [  240.0 35.5  4.47  21.90], 'HampNels2010', 'Ictidomys_tridecemlineatus' % 0.96 4.7 ml O2/h.g 
   % Lagomorpha
    [ 1242.0 38.3  8.84  18.8], 'HindBaud1993', 'Oryctolagus_cuniculus'
   % Primates
    [70000   37.0 268.3   3733], 'WillSton2005', 'Homo_sapiens' % 0.23, 3.2 ml O2/h.g
 };               
  %prt_tab({[mar(:,[3 2]);pla(:,[3 2])], [cell2mat(mar(:,1));cell2mat(pla(:,1))]},{'species', 'bibkey', 'mass,g', 'temp,C', 'SMR,ml O2/min', 'PMR,ml O2/min'}, 'Mammalia')
         
for c=1:length(fig)
 
  switch fig(c)
    case 1 % ss_AS
    
      data = cell2mat(act(:,1)); PMR_SMR_act = data(:,4)./data(:,3);
      ss_act = read_stat(act(:,3),'s_s');
      %
      data = cell2mat(cho(:,1)); PMR_SMR_cho = data(:,4)./data(:,3);
      ss_cho = read_stat(cho(:,3),'s_s');
      %
      data = cell2mat(amp(:,1)); PMR_SMR_amp = data(:,4)./data(:,3);
      ss_amp = read_stat(amp(:,3),'s_s');
      %
      data = cell2mat(squ(:,1)); PMR_SMR_squ = data(:,4)./data(:,3);
      ss_squ = read_stat(squ(:,3),'s_s');
      %
      data = cell2mat(ave(:,1)); PMR_SMR_ave = data(:,4)./data(:,3);
      ss_ave = read_stat(ave(:,3),'s_s');
      %
      data = cell2mat(mar(:,1)); PMR_SMR_mar = data(:,4)./data(:,3);
      ss_mar = read_stat(mar(:,3),'s_s');
      %
      data = cell2mat(pla(:,1)); PMR_SMR_pla = data(:,4)./data(:,3);
      ss_pla = read_stat(pla(:,3),'s_s');

      Hfig = figure;
      plot(ss_cho, log10(PMR_SMR_cho), 'o', 'MarkerSize',4, 'LineWidth',2, 'MarkerEdgeColor',[0 0 1], 'MarkerFaceColor',[0 1 1])
      hold on
      plot(ss_act, log10(PMR_SMR_act), '.b', 'MarkerSize',20)
      plot(ss_amp, log10(PMR_SMR_amp), 'o', 'MarkerSize',4, 'LineWidth',2, 'MarkerEdgeColor',[1 0 1], 'MarkerFaceColor',[0 1 1])
      plot(ss_squ, log10(PMR_SMR_squ), '.m', 'MarkerSize',20)
      plot(ss_ave, log10(PMR_SMR_ave), '.r', 'MarkerSize',20)
      plot(ss_mar, log10(PMR_SMR_mar), 'o', 'MarkerSize',4, 'LineWidth',2, 'MarkerEdgeColor',[1 .5 .5], 'MarkerFaceColor',[0 0 0])
      plot(ss_pla, log10(PMR_SMR_pla), 'o', 'MarkerSize',4, 'LineWidth',2, 'MarkerEdgeColor',[1 .5 .5], 'MarkerFaceColor',[1 .5 .5])
      xlim([0 4/27])
      xlabel('supply stress s_s, -')
      ylabel('_{10}log PMR/SMR, -')

      % set species names behind markers in plot figure
      h = datacursormode(Hfig); entries_txt = [cho(:,3); act(:,3); amp(:,3); squ(:,3); ave(:,3); mar(:,3); pla(:,3)]; 
      data = [[ss_cho;ss_act;ss_amp;ss_squ;ss_ave;ss_mar;ss_pla],log10([PMR_SMR_cho;PMR_SMR_act;PMR_SMR_amp;PMR_SMR_squ;PMR_SMR_ave;PMR_SMR_mar;PMR_SMR_pla])];
      for i=1:length(entries_txt); entries_txt{i} = strrep(entries_txt{i}, '_' , ' '); end
      h.UpdateFcn = @(obj, event_obj)xylabels(obj, event_obj, entries_txt, data);
      datacursormode on % mouse click on plot

      saveas(gcf,'ss_PSMR.fig')
      saveas(gcf,'ss_PSMR.png')

    case 2  % predicted FMR_measured SMR   
      WD0 = pwd; % store original directory
      nm_cho = cho(:,3); n_cho = length(nm_cho); FMR_cho = zeros(n_cho,1); 
      data_cho = cell2mat(cho(:,1)); PMR_cho = data_cho(:,4); SMR_cho = data_cho(:,3); T_cho = data_cho(:,2); W_cho = data_cho(:,1); 
      for i=1:n_cho
        FMR_cho(i) = 15.55 * get_FMR(nm_cho{i}, W_cho(i), T_cho(i), 1); % ml O2/min
      end
      %
      nm_act = act(:,3); n_act = length(nm_act); FMR_act = zeros(n_act,1); 
      data_act = cell2mat(act(:,1)); PMR_act = data_act(:,4); SMR_act = data_act(:,3); T_act = data_act(:,2); W_act = data_act(:,1); 
      for i=1:n_act
        FMR_act(i) = 15.55 * get_FMR(nm_act{i}, W_act(i), T_act(i), 1); % ml O2/min
      end
      %
      nm_amp = amp(:,3); n_amp = length(nm_amp); FMR_amp = zeros(n_amp,1); 
      data_amp = cell2mat(amp(:,1)); PMR_amp = data_amp(:,4); SMR_amp = data_amp(:,3); T_amp = data_amp(:,2); W_amp = data_amp(:,1); 
      for i=1:n_amp
        FMR_amp(i) = 15.55 * get_FMR(nm_amp{i}, W_amp(i), T_amp(i), 1); % ml O2/min
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
      plot([-3;4], [-3;4], 'k', 'linewidth',2); % equality line
      hold on
      plot(log10(FMR_cho), log10(SMR_cho), 'o', 'MarkerSize',4, 'LineWidth',2, 'MarkerEdgeColor',[0 0 1], 'MarkerFaceColor',[0 1 1])
      plot(log10(FMR_act), log10(SMR_act), '.b', 'MarkerSize',20)
      plot(log10(FMR_amp), log10(SMR_amp), 'o', 'MarkerSize',4, 'LineWidth',2, 'MarkerEdgeColor',[1 0 1], 'MarkerFaceColor',[0 1 1])
      plot(log10(FMR_squ), log10(SMR_squ), '.m', 'MarkerSize',20)
      plot(log10(FMR_ave), log10(SMR_ave), '.r', 'MarkerSize',20)
      plot(log10(FMR_mar), log10(SMR_mar), 'o', 'MarkerSize',4, 'LineWidth',2, 'MarkerEdgeColor',[1 .5 .5], 'MarkerFaceColor',[0 0 0])
      plot(log10(FMR_pla), log10(SMR_pla), 'o', 'MarkerSize',4, 'LineWidth',2, 'MarkerEdgeColor',[1 .5 .5], 'MarkerFaceColor',[1 .5 .5])
      xlabel('predicted _{10}log FMR, ml O2/min')
      ylabel('measured _{10}log SMR, ml O2/min')
 
      % set species names behind markers in plot figure
      h = datacursormode(Hfig); entries_txt = [cho(:,3);act(:,3);amp(:,3);squ(:,3);ave(:,3);mar(:,3);pla(:,3)]; 
      data = log10([[FMR_cho;FMR_act;FMR_amp;FMR_squ;FMR_ave;FMR_mar;FMR_pla],[SMR_cho;SMR_act;SMR_amp;SMR_squ;SMR_ave;SMR_mar;SMR_pla]]);
      for i=1:length(entries_txt); entries_txt{i} = strrep(entries_txt{i}, '_' , ' '); end
      h.UpdateFcn = @(obj, event_obj)xylabels(obj, event_obj, entries_txt, data);
      datacursormode on % mouse click on plot

      %prt_tab({nm_act, W_act, T_act, FMR_act, SMR_act, PMR_act},{'species', 'weight, g', 'T, C', 'FMR, ml O2/min', 'SMR, ml O2/min', 'PMR, ml O2/min'}, 'act')
      saveas(gcf,'FMR_SMR.fig')
      saveas(gcf,'FMR_SMR.png')

    case 3  % ss_PMR/FMR
      WD0 = pwd; % store original directory
      nm_cho = cho(:,3); n_cho = length(nm_cho); FMR_cho = zeros(n_cho,1); ss_cho = read_stat(nm_cho, 's_s');
      data_cho = cell2mat(cho(:,1)); PMR_cho = data_cho(:,4); SMR_cho = data_cho(:,3); T_cho = data_cho(:,2); W_cho = data_cho(:,1); 
      for i=1:n_cho
        FMR_cho(i) = 15.55 * get_FMR(nm_cho{i}, W_cho(i), T_cho(i), 1); % ml O2/min
      end
      %
      nm_act = act(:,3); n_act = length(nm_act); FMR_act = zeros(n_act,1); ss_act = read_stat(nm_act, 's_s');
      data_act = cell2mat(act(:,1)); PMR_act = data_act(:,4); SMR_act = data_act(:,3); T_act = data_act(:,2); W_act = data_act(:,1); 
      for i=1:n_act
        FMR_act(i) = 15.55 * get_FMR(nm_act{i}, W_act(i), T_act(i), 1); % ml O2/min
      end
      %
      nm_amp = amp(:,3); n_amp = length(nm_amp); FMR_amp = zeros(n_amp,1); ss_amp = read_stat(nm_amp, 's_s');
      data_amp = cell2mat(amp(:,1)); PMR_amp = data_amp(:,4); SMR_amp = data_amp(:,3); T_amp = data_amp(:,2); W_amp = data_amp(:,1); 
      for i=1:n_amp
        FMR_amp(i) = 15.55 * get_FMR(nm_amp{i}, W_amp(i), T_amp(i), 1); % ml O2/min
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
      plot([0;4/27],[1/2;3/2],'-', 'Color',[.85 .85 .85], 'LineWidth',15)
      hold on
      plot(ss_cho, log10(PMR_cho./FMR_cho), 'o', 'MarkerSize',4, 'LineWidth',2, 'MarkerEdgeColor',[0 0 1], 'MarkerFaceColor',[0 1 1])
      plot(ss_act, log10(PMR_act./FMR_act), '.b', 'MarkerSize',20)
      plot(ss_amp, log10(PMR_amp./FMR_amp), 'o', 'MarkerSize',4, 'LineWidth',2, 'MarkerEdgeColor',[1 0 1], 'MarkerFaceColor',[0 1 1])
      plot(ss_squ, log10(PMR_squ./FMR_squ), '.m', 'MarkerSize',20)
      plot(ss_ave, log10(PMR_ave./FMR_ave), '.r', 'MarkerSize',20)
      plot(ss_mar, log10(PMR_mar./FMR_mar), 'o', 'MarkerSize',4, 'LineWidth',2, 'MarkerEdgeColor',[1 .5 .5], 'MarkerFaceColor',[0 0 0])
      plot(ss_pla, log10(PMR_pla./FMR_pla), 'o', 'MarkerSize',4, 'LineWidth',2, 'MarkerEdgeColor',[1 .5 .5], 'MarkerFaceColor',[1 .5 .5])
      xlabel('supply stress s_s, -')
      xlim([0 4/27])
      ylabel('_{10}log measured PMR/ predicted FMR, -')
       
      % set species names behind markers in plot figure
      h = datacursormode(Hfig); entries_txt = [cho(:,3); act(:,3); amp(:,3); squ(:,3); ave(:,3); mar(:,3); pla(:,3)]; 
      data = [[ss_cho;ss_act;ss_amp;ss_squ;ss_ave;ss_mar;ss_pla], log10([PMR_cho;PMR_act;PMR_amp;PMR_squ;PMR_ave;PMR_mar;PMR_pla]./[FMR_cho;FMR_act;FMR_amp;FMR_squ;FMR_ave;FMR_mar;FMR_pla])];
      for i=1:length(entries_txt); entries_txt{i} = strrep(entries_txt{i}, '_' , ' '); end
      h.UpdateFcn = @(obj, event_obj)xylabels(obj, event_obj, entries_txt, data);
      datacursormode on % mouse click on plot
       
      saveas(gcf,'ss_PFMR.fig')
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
      saveas(gcf,'kap_ss_kapRA_vert.fig')
      saveas(gcf,'kap_ss_kapRA_vert.png')
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
      saveas(gcf,'kap_ss_kapRA_invert.fig')
      saveas(gcf,'kap_ss_kapRA_invert.png')
      saveas(Hleg_invert,'legend_invert.png')
       
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
        
    case 6 % simulation of standard DEB model with stochastic searching
      shtraject % description see DEBtool_M/animal/shtraject
      saveas(Hfig_O,'organics.png')
      saveas(Hfig_M,'minerals.png')
      
    case 7 % ss_var(j_Oi)
      ssJOiW = read_allStat({'s_s', 'J_Oi', 'Ww_i', 'c_T'}); s_s = ssJOiW(:,1); Wwi = ssJOiW(:,3); jT_Oi = ssJOiW(:,2)./Wwi; j_Oi = jT_Oi./ssJOiW(:,4);
      ss_int = linspace(0,4/27,20)'; ss = mean([ss_int(1:19),ss_int(2:20)],2); n = nan(19,1); std_jTOi = n; std_jOi = n;
      for j = 1:19
        sel = s_s>ss_int(j) & s_s<ss_int(j+1); 
        jTO = jT_Oi(sel); jO = j_Oi(sel); std_jTOi(j) = std(jTO); std_jOi(j) = std(jO); n(j)=length(jTO);
      end
      
      figure
      plot(ss, 1e3*std_jTOi, 'ob')
      xlabel('supply stress, -')
      ylabel('standard dev spec ultimate resp, mmol O_2/d.g')
      saveas(gca,'ss_stdjTOi.png')

      figure
      plot(ss, 1e3*std_jOi, 'ob')
      xlabel('supply stress, -')
      ylabel('standard dev spec ultimate resp, mmol O_2/d.g')
      saveas(gca,'ss_stdjOi.png')
      
      figure
      plot(s_s, log10(1e3*j_Oi), 'or')
      xlabel('supply stress, -')
      ylabel('_{10}log spec ultimate resp, mmol O_2/d.g')

      figure
      plot(s_s, log10(Wwi), 'or')
      xlabel('supply stress, -')
      ylabel('_{10}log ultimate body weight, g')
      
      jOi_min = min(j_Oi); jOi_max = max(j_Oi);  jO_int = linspace(jOi_min,jOi_max,20)'; 
      jO = mean([jO_int(1:19),jO_int(2:20)],2); n = nan(19,1); std_jO = n; 
      for j = 1:19
        sel = s_s>jO_int(j) & s_s<jO_int(j+1); 
        jO2 = j_Oi(sel); std_jO(j) = std(jO2); n(j)=length(jO2);
      end

      figure
      plot(1e3*jO, 1e3*std_jO, 'or')
      xlabel('spec ultimate respiration mmol O2/d.g')
      ylabel('standard dev spec ultimate resp, mmol O_2/d.g')

  end
end
   
% References
% 
% @article{BergHart1972,
%   doi = {10.1086/physzool.68.5.30163935}, 
%   title = {Die Atmung beim Kolibri Amazilia fimbriata w\"{a}hrend des Schwirrfluges bei verschiedenen Umgebungstemperaturen},
%   journal = {J. Comp. Physiol.},
%   volume = {81},
%   year = {1972},
%   pages = {363-380},
%   author = {M. Berger and J. S. Hart}
% }
% 
% @article{BernThom1973,
%   title = {POWER INPUT DURING FLIGHT OF THE FISH CROW, CORVUS OSSIFRAGUS},
%   journal = {J. Exp. Biol.},
%   volume = {58},
%   year = {1973},
%   pages = {401-410},
%   author = {Marvin H. Bernstein and Steven P. Thomas and Knut Schmidt-Nielsen}
% }
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
% @article{Bish1993,
%   title = {Maximum metabolism and the aerobic factorial scope of endotherms},
%   journal = {J. Exp. Biol.},
%   volume = {182},
%   year = {1993},
%   pages = {41-56},
%   author = {Bishop, C. M.}
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
% @article{Bozi1992,
%   title = {Scaling of Basal and Maximum Metabolic Rate in Rodents and the Aerobic Capacity Model for the Evolution of Endothermy},
%   journal = {Physiological Zoology},
%   volume = {65(5)},
%   year = {1992},
%   pages = {921-932},
%   author = {Francisco Bozinovi}
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
% @article{ButtBech2010,
%   title = {Citrate synthase activity does not account for age-related differences in maximum aerobic performance in House Sparrows (Passer domesticus)},
%   journal = {Australian Zoologist},
%   volume = {35(2)},
%   year = {2010},
%   pages = {378-382},
%   author = {William A. Buttemer and Claus Bech and Mark A. Chappell}
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
% @article{ClarJeff2011,
%   doi = {10.1242/jeb.060517},
%   title = {Exceptional aerobic scope and cardiovascular performance of pink salmon (Oncorhynchus gorbuscha) may underlie resilience in a warming climate},
%   journal = {The Journal of Experimental Biology},
%   volume = {214},
%   year = {2011},
%   pages = {3074-3081},
%   author = {Timothy D. Clark and Kenneth M. Jeffries and Scott G. Hinch and Anthony P. Farrell}
% }
%
% @article{DaviWill1985,
%   doi = {10.1086/physzool.58.5.30158585},
%   title = {Swimming Metabolism of Yearling and Adult Harbor Seals Phoca vitulina},
%   journal = {Physiological Zoology},
%   volume = {58(5)},
%   year = {1985},
%   pages = {590–596},
%   author = {Davis, R. W. and Williams, T. M. and Kooyman, G. L.}
% }
%
% @article{DawsButt1985,
%   doi = {10.1242/jeb.060517},
%   title = {A REEXAMINATION OF THE METABOLIC RESPONSE OF HOUSE FINCHES TO TEMPERATURE },
%   journal = {The Condor},
%   volume = {87},
%   year = {1985},
%   pages = {424-427},
%   author = {William R. Dawson and William A. Buttemer and Cynthia Carey}
% }
%
% @article{DuteSwan1996,
%   doi = {10.1086/physzool.69.5.30164255},
%   title = {Relationship of Basal to Summit Metabolic Rate in Passerine Birds and the Aerobic Capacity Model for the Evolution of Endothermy},
%   journal = {Physiological Zoology},
%   volume = {69(5)},
%   year = {1996},
%   pages = {1232–1254},
%   author = {Dutenhoffer, M. S. and Swanson, D. L.}
% }
%
% @article{Fede1986,
%   title = {EFFECT OF THERMAL ACCLIMATION ON LOCOMOTOR ENERGETICS AND LOCOMOTOR PERFORMANCE IN A LUNGLESS SALAMANDER, DESMOGNATHUS OCHROPHAEUS},
%   journal = {J. exp. Biol.},
%   volume = {121},
%   year = {1986},
%   pages = {271-283},
%   author = {Martin E. Feder}
% }
%
% @article{Full1985,
%   title = {Exercising without lungs: energetics and endurance in a lungless salamander, Plethodon jordani},
%   journal = {Physiologist},
%   volume = {28},
%   year = {1985},
%   pages = {R775-R780},
%   author = {Full, R. J.}
% }
%
% @article{Glee1979,
%   title = {Foraging and Transport Costs in the Galapagos Marine Iguana, Amblyrhynchus cristatus},
%   journal = {Physiological Zoology},
%   volume = {52(4)},
%   year = {1979},
%   pages = {549-557},
%   author = {Todd T. Gleeson}
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
% @article{GrahDewa1990,
%   title = {ASPECTS OF SHARK SWIMMING PERFORMANCE DETERMINED USING A LARGE WATER TUNNEL},
%   journal = {J. exp. Biol.},
%   volume = {151},
%   year = {1990},
%   pages = {175-192},
%   author = {Jeffrey B. Graham and Heidi Dewar and N. C. Lai and William R. Lowell and Steve M. Arce}
% }
%
% @article{HampNels2010,
%   doi = {10.1152/ajpregu.00273.2010}, 
%   title = {Circulation and metabolic rates in a natural hibernator: an integrative physiological model},
%   journal = {American Journal of Physiology-Regulatory},
%   volume = {299(6)},
%   year = {2010},
%   pages = {R1478–R1488},
%   author = {Hampton, M. and Nelson, B. T. and Andrews, M. T.}
% }
% 
% @article{Haye2010,
%   doi = {10.1086/physzool.62.3.30157924}, 
%   title = {Field and Maximal Metabolic Rates of Deer Mice (Peromyscus maniculatus) at Low and High Altitudes},
%   journal = {Physiological Zoology},
%   volume = {62(3)},
%   year = {2010},
%   pages = {732–744},
%   author = {Hayes, J. P.}
% }
% 
% @misc{Hodg2025,
%   author = {David R. Hodgson},
%   title = {Veterian Key; chapter 8 Thermoregulation},
%   howpublished = {\url{https://veteriankey.com/thermoregulation/}},
%   year = {2025/07/23}
% }
%
% @article{JohnChri2024,
%   doi = {10.1242/jeb.246899}, 
%   title = {Conservation energetics of beluga whales: using resting and swimming metabolism to understand threats to an endangered population},
%   journal = {Journal of Experimental Biology},
%   volume = {182},
%   year = {2024},
%   pages = {1-12},
%   author = {Jason S. John and Dennis R. Christen and Katherine L. Flammer and Traci L. Kendall and Emily C. Nazario and Beau P. Richter and Verena Gill and Terrie M. Williams}
% }
% 
% @article{Kirk1983,
%   title = {A LIMIT TO METABOLISABLE ENERGY INTAKE IN MAMMALS AND BIRDS},
%   journal = {Comp. Biochem. Physiol.},
%   volume = {75A(1)},
%   year = {1993},
%   pages = {1-3},
%   author = {James K. Kirkwood}
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
% @article{Lasi1963,
%   title = {Oxygen Consumption of Torpid, Resting, Active, and Flying Hummingbirds},
%   journal = {Physiological Zoology},
%   volume = {36(2)},
%   year = {1963},
%   pages = {29-44},
%   author = {Robert C. Lasiewski}
% }
% 
% @article{LasiWeat1967
%   author = {Robert C. Lasiewski and Wesley W. Weathers and Marvin H. Bernstein}, 
%   year = {1967},
%   title  = {PHYSIOLOGICAL RESPONSES OF THE GIANT HUMMINGBIRD, \emph{Patagona gigas}},
%   journal = {Comp. Biochem. Physiol.}, 
%   vol = {23}
%   pages = {797-813}
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
% @ARTICLE{OchoTayl2005,
%   author = {Dorota Ochoci\'{n}ska and Jan R. E. Taylor},
%   title = {Living at the Physiological Limits: Field and Maximum Metabolic Rates of the Common Shrew (Sorex araneus)},
%   journal = {Physiological and Biochemical Zoology},
%   year = {2005},
%   volume = {78(5)},
%   pages = {808–818}
% }
%
% @ARTICLE{Pear1964,
%   condor = {10.2307/1365642},
%   author = {Oliver P. Pearson},
%   title = {METABOLISM AND HEAT LOSS DURING FLIGHT IN PIGEONS},
%   journal = {Condor},
%   year = {1964},
%   volume = {30},
%   pages = {221-239}
% }
%
% @ARTICLE{PiipMeye1977,
%   author = {J. Piiper and M. Meyer and H. Worth and H. Willmer},
%   title = {RESPIRATION AND CIRCULATION DURING SWIMMING ACTIVITY IN THE DOGFISH SCYLIORHINUS STELLARIS},
%   journal = {Respiration Physiology},
%   year = {1977},
%   volume = {30},
%   pages = {221-239}
% }
%
% @ARTICLE{Putt1980,
%   author = {Gillian M. Puttick},
%   title = {Energy Budgets of Curlew Sandpipers at Langebaan Lagoon, South Africa},
%   journal = {Estuarlne and Coastal Marine Science},
%   year = {1980},
%   volume = {11},
%   pages = {207-215}
% }
%
% @ARTICLE{RezeSwan2002,
%   doi = {10.1093/czoolo/56.6.741},
%   author = {Enrico L. Rezende and David L. Swanson and F. Fernando Novoa and Francisco Bozinovic},
%   title = {Passerines versus nonpasserines: so far, no statistical differences in the scaling of avian energetics},
%   journal = {The Journal of Experimental Biology},
%   year = {2002},
%   volume = {205},
%   pages = {101–107}
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
% @ARTICLE{SchuSchm1979,
%   author = {Karl-L. Schuchmann and  Dagmar Schmidt-Marloh},
%   title = {Metabolic and Thermal Responses to Heat and Cold in Streamertail Hummingbirds (Trochilus polytmus and Trochilus scitulus, Trochilidae)},
%   journal = {Biotropica},
%   year = {1979},
%   volume = {11(2)},
%   pages = {123-126}
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
% @ARTICLE{ThomSwan2019,
%   doi = {10.1111/jav.02062},
%   author = {Nathan E. Thomas and David L. Swanson},
%   title = {Do the high energy lifestyles of shorebirds result in high maximal metabolic rates? Basal and maximal metabolic rates in least and pectoral sandpipers during migration},
%   journal = {Journal of Avian Biology},
%   year = {2019},
%   pages = {e02062}
% }
%
% @ARTICLE{VeziGers2017,
%   doi = {10.1152/ajpregu.00453.2016},
%   author = {Fran\c{c}ois V\'{e}zina and Alexander R. Gerson and Christopher G. Guglielmo and Theunis Piersma},
%   title = {The performing animal: causes and consequences of body remodeling and metabolic adjustments in red knots facing contrasting thermal environments},
%   journal = {Am J Physiol Regul Integr Comp Physiol},
%   year = {2017},
%   volume = {313}, 
%   pages = {R120–R131}
% }
%
% @ARTICLE{WierChap2007,
%   doi = {10.1073pnas.0707683104},
%   author = {Popko Wiersma and Mark A. Chappell and Joseph B. Williams},
%   title = {Cold- and exercise-induced peak metabolic rates in tropical birds},
%   journal = {PNAS},
%   volume = {104(52)},
%   year = {2007},
%   pages = {20866–20871}
% }
%
% @ARTICLE{WillTiel2007,
%   author = {Joseph B. Williams and B. Irene Tieleman and G. Henk Visser and Robert E. Ricklefs},
%   title = {Does Growth Rate Determine the Rate of Metabolism in Shorebird Chicks Living in the Arctic?},
%   journal = {Physiological and Biochemical Zoology},
%   volume = {80(5)},
%   year = {2007},
%   pages = {300-513}
% }
%
% @book{WillSton2005,
%   title = {Environmental physiology of animals},
%   publisher = {Blackwell Publishing},
%   year = {2005},
%   author = {Willmer, P. W. and Stone, G. and Johnston, I.}
% }
%
% @ARTICLE{WortWort2013,
%   doi = {10.1111/mms.12091}, 
%   author = {Graham A. J. Worthy and Tamara A. M. Worthy and Pamela K. Yochem},
%   title = {Basal metabolism of an adult male killer whale (Orcinus orca)},
%   journal = {Marime Mammal Science},
%   volume = {80(5)},
%   year = {2013},
%   pages = {1-9}
% }
%

