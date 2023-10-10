function LikaKooy2023a_SI(fig)
% Supporting Information for LikaKooy202a
% Title: The metabolic interpretation of the von Bertalanffy growth rate
% Authors: Lika, Kooijman
% Journal: Ecol. Mod
% DOI: 
% Date: 2023/10/04
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
% To run the code for a figure: type in the Matlab window e.g. LikaAugu2022_SI(2)
%
% Remarks: 
%  The figures show current AmP data, which might change in time; the results might differ from the publication
%  The scripts call functions read_popStat and read_allStat; the first call to these functions loads the .mat file, which can take some time
%  Click on a marker in the Matlab-figure to see the species name
%  Uncomment "print" to save the Matlab-figure to a png-file
%  Modify selection of taxa and markers by changing the legend, see https://add-my-pet.github.io/AmPtool/docs/index.html
%  Allowed names of taxa match the names of the tree nodes at http://www.bio.vu.nl/thb/deb/deblab/add_my_pet/species_tree_Animalia.html

close all
global fVec dataset Range
dataset = []; Range = [];

if ~exist('fig','var')
   fig = 1:31;
end

  % type, size, linewidth, edge color and face color of a marker, taxon
  legend_fish = {...
    {'o', 4, 2, [0 1 1], [0 1 1]}, 'Chondrichthyes'; ....
    {'o', 4, 2, [0 0 1], [0 0 1]}, 'Actinopterygii'; ....
  };

  legend_crus = {...
    {'o', 4, 2, [0 0 1], [0 0 1]}, 'Branchiopoda'; ....
    {'o', 4, 2, [1 0 1], [1 0 1]}, 'Multicrustacea'; ....
    {'o', 4, 2, [1 0 0], [1 0 0]}, 'Oligostraca'; ....
  };

  legend_moll = {...
    {'o', 4, 2, [0 0 1], [0 0 1]}, 'Bivalvia'; ....
    {'o', 4, 2, [1 0 1], [1 0 1]}, 'Gastropoda'; ....
    {'o', 4, 2, [1 0 0], [1 0 0]}, 'Cephalopoda'; ....
  };

 close all
 shstat_options('default');
 shstat_options('y_label', 'on'); 
 shstat_options('x_label', 'off'); 
  
 for i=1:length(fig)
 
 switch fig(i)
   case 1 % Mammalia +
     WD = cdEntr('Macroscelides_proboscideus'); data = mydata_Macroscelides_proboscideus; cd(WD);
     tW0=data.tW_m4G; tW1=data.tW_m4J; tW2=data.tW_m4C; tW3=data.tW_m4B; 
     par = [7 0;       %  1 Ww_b
            40  1;     %  2 Wwi_0
            35  1;     %  3 Wwi_1
            35  1;     %  4 Wwi_2
            35  1;     %  5 Wwi_3
            0.0259 1;  %  6 rB_0
            0.0269 1;  %  7 rB_1
            0.0281 1;  %  8 rB_2
            0.0281 1;  %  9 rB_3
            4.67 0];   % 10 ome
     %[EW0, EW1, EW2, EW3] = rB_W(par, tW0, tW1, tW2, tW3);
     nmregr_options('max_step_number',1000);
     par = nmregr('rB_W', par, tW0, tW1, tW2, tW3);
     par = nmregr('rB_W', par, tW0, tW1, tW2, tW3);
     par = nmregr('rB_W', par, tW0, tW1, tW2, tW3);
     par = nmregr('rB_W', par, tW0, tW1, tW2, tW3);
     
     shregr_options('all_in_one', 1); 
     shregr('rB_W', par, tW0, tW1, tW2, tW3) 
     xlabel('time since birth, d')
     ylabel('weight, g')
     title('Macroscelides proboscideus, m')
     set(gca, 'FontSize', 15, 'Box', 'on')
     saveas(gcf,'t_Ww_Macroscelides_proboscideus.png')
          
     par
     
     figure
     Li = (par(2:5,1)/(1+par(10,1))).^(1/3); irB = 1./par(6:9,1);
     plot(Li, irB, 'or');
     xlabel('ultimate structural length, cm')
     ylabel('1/vBGR, d')
     title('Macroscelides proboscideus, m')
     set(gca, 'FontSize', 15, 'Box', 'on')
     saveas(gcf,'Li_irB_Macroscelides_proboscideus.png')
     
   case 2 % Mammalia +
     WD = cdEntr('Mustela_vison'); data = mydata_Mustela_vison; cd(WD);
     tW0=data.tW_f; tW1=data.tW_m; tW2 = data.tW_0f; tW3 = data.tW_0m;
     par = [8.5 0;     %  1 Ww_b
            925  1;    %  2 Wwi_0
            925  1;    %  3 Wwi_1
            925  1;    %  4 Wwi_2
            925  1;    %  5 Wwi_3
            0.0259 1;  %  6 rB_0
            0.0269 1;  %  7 rB_1
            0.0281 1;  %  8 rB_2
            0.0281 1;  %  9 rB_3
            9.77 0];   % 10 ome
     %[EW0, EW1, EW2, EW3] = rB_W(par, tW0, tW1, tW2, tW3);
     nmregr_options('max_step_number',1000);
     par = nmregr('rB_W', par, tW0, tW1, tW2, tW3);
     par = nmregr('rB_W', par, tW0, tW1, tW2, tW3);
     par = nmregr('rB_W', par, tW0, tW1, tW2, tW3);
     par = nmregr('rB_W', par, tW0, tW1, tW2, tW3);
     shregr_options('all_in_one', 1); 
     shregr('rB_W', par, tW0, tW1,tW2, tW3) 
     xlabel('time since birth, d')
     ylabel('weight, g')
     title('Mustela vison, mm/ff')
     set(gca, 'FontSize', 15, 'Box', 'on')
     saveas(gcf,'t_Ww_Mustela_vison.png')
          
     par
     
     figure
     Li = (par(2:5,1)/(1+par(10,1))).^(1/3); irB = 1./par(6:9,1);
     plot(Li, irB, 'or');
     xlabel('ultimate structural length, cm')
     ylabel('1/vBGR, d')
     title('Mustela vison, mm/ff')
     set(gca, 'FontSize', 15, 'Box', 'on')
     saveas(gcf,'Li_irB_Mustela_vison.png')
     
   case 3 % Mammalia +
     WD = cdEntr('Neomonachus_schauinslandi'); data = mydata_Neomonachus_schauinslandi; cd(WD);
     tL0=data.tL_MHI; tL1=data.tL_FFS; tL2=data.tL_LAY; tL3=data.tL_LIS; tL4=data.tL_PHR; tL5=data.tL_MDY; tL6=data.tL_KUR; 
     
     par = [100  1;     %  1 Lw_b
            200  1;     %  2 Lwi_0
            200  1;     %  3 Lwi_1
            200  1;     %  4 Lwi_2
            200  1;     %  5 Lwi_3
            200  1;     %  6 Lwi_4
            200  1;     %  7 Lwi_5
            200  1;     %  8 Lwi_6
            1e-3 1;     %  9 rB_0
            1e-3 1;     % 10 rB_1
            1e-3 1;     % 11 rB_2
            1e-3 1;     % 12 rB_3
            1e-3 1;     % 13 rB_4
            1e-3 1;     % 14 rB_5
            1e-3 1;     % 15 rB_6
            0.14374 0;  % 16 del_M
            33.95   0]; % 17 L_m
     nmregr_options('max_step_number',1000);
     par = nmregr('rB_L', par, tL0, tL1, tL2, tL3, tL4, tL5, tL6);
     par = nmregr('rB_L', par, tL0, tL1, tL2, tL3, tL4, tL5, tL6);
     par = nmregr('rB_L', par, tL0, tL1, tL2, tL3, tL4, tL5, tL6);
     shregr_options('all_in_one', 1); 
     shregr('rB_L', par, tL0, tL1, tL2, tL3, tL4, tL5, tL6) 
     xlabel('time since birth, d')
     ylabel('standard height, cm')
     title('Neomonachus schauinslandi')
     set(gca, 'FontSize', 15, 'Box', 'on')
     saveas(gcf,'t_L_Neomonachus_schauinslandi.png')

     par
     
     figure
     Li = par(2:8,1) * par(16,1); irB = 1./par(9:15,1);
     plot(Li, irB, 'or');
     xlabel('ultimate structural length, cm')
     ylabel('1/vBGR, d')
     title('Neomonachus schauinslandi')
     set(gca, 'FontSize', 15, 'Box', 'on')
     saveas(gcf,'Li_irB_Neomonachus_schauinslandi.png')

   case 4 %  Mammalia +
     WD = cdEntr('Bison_bison'); data = mydata_Bison_bison; cd(WD);
     tW0=data.tW_mO; tW1=data.tW_mK; tW2=data.tW_fO; tW3=data.tW_fK; 
     par = [19.4e3 1;  %  1 Ww_b
            514e3  1;  %  2 Wwi_0
            514e3  1;  %  3 Wwi_1
            514e3  1;  %  4 Wwi_2
            514e3  1;  %  5 Wwi_3
            1.3e-3 1;  %  6 rB_0
            1.3e-3 1;  %  7 rB_1
            1.3e-3 1;  %  8 rB_2
            1.3e-3 1;  %  9 rB_3
            4.19 0];   % 10 ome
     %[EW0, EW1, EW2, EW3] = rB_W(par, tW0, tW1, tW2, tW3);
     nmregr_options('max_step_number',1000);
     par = nmregr('rB_W', par, tW0, tW1, tW2, tW3);
     par = nmregr('rB_W', par, tW0, tW1, tW2, tW3);
     par = nmregr('rB_W', par, tW0, tW1, tW2, tW3);
     par = nmregr('rB_W', par, tW0, tW1, tW2, tW3);
     shregr_options('all_in_one', 1); 
     shregr('rB_W', par, tW0, tW1, tW2, tW3) 
     xlabel('time since birth, d')
     ylabel('weight, g')
     title('Bison bison')
     set(gca, 'FontSize', 15, 'Box', 'on')
     saveas(gcf,'t_Ww_Bison_bison.png')
          
     par
     
     figure
     Li = (par(2:5,1)/(1+par(10,1))).^(1/3); irB = 1./par(6:9,1);
     plot(Li, irB, 'or');
     xlabel('ultimate structural length, cm')
     ylabel('1/vBGR, d')
     title('Bison bison')
     set(gca, 'FontSize', 15, 'Box', 'on')
     saveas(gcf,'Li_irB_Bison_bison.png')
 

   case 5 % Mammalia  +
     WD = cdEntr('Mastomys_natalensis'); data = mydata_Mastomys_natalensis; cd(WD);
     tW0=data.tWw_m; tW1=data.tWw_f; 
     par = [2.4  0;   %  1 Ww_b
            37  1;    %  2 Wwi_0
            37  1;    %  3 Wwi_1
            0.026 1;  %  4 rB_0
            0.026 1;  %  5 rB_1
            13.1 0];  %  6 ome
     %[EW0, EW1] = rB_W(par, tW0, tW1);
     nmregr_options('max_step_number',1000);
     par = nmregr('rB_W', par, tW0, tW1);
     par = nmregr('rB_W', par, tW0, tW1);
     shregr_options('all_in_one', 1); 
     shregr('rB_W', par, tW0, tW1) 
     xlabel('time since birth, d')
     ylabel('weight, g')
     title('Mastomys natalensis, m/f')
     set(gca, 'FontSize', 15, 'Box', 'on')
     saveas(gcf,'t_Ww_Mastomys_natalensis.png')
          
     par
     
     figure
     Li = (par(2:3,1)/(1+par(6,1))).^(1/3); irB = 1./par(4:5,1);
     plot(Li, irB, 'or');
     xlabel('ultimate structural length, cm')
     ylabel('1/vBGR, d')
     title('Mastomys natalensis, m/f')
     set(gca, 'FontSize', 15, 'Box', 'on')
     saveas(gcf,'Li_irB_Mastomys_natalensis.png')
     
   case 6 % Mammalia +
     WD = cdEntr('Tatera_indica'); data = mydata_Tatera_indica; cd(WD);
     tW0=data.tWw_m; tW1=data.tWw_f; 
     par = [3  0;     %  1 Ww_b
            139  1;   %  2 Wwi_0
            139  1;   %  3 Wwi_1
            0.026 1;  %  4 rB_0
            0.026 1;  %  5 rB_1
            23.4 0];  %  6 ome
     %[EW0, EW1] = rB_W(par, tW0, tW1);
     nmregr_options('max_step_number',1000);
     par = nmregr('rB_W', par, tW0, tW1);
     par = nmregr('rB_W', par, tW0, tW1);
     shregr_options('all_in_one', 1); 
     shregr('rB_W', par, tW0, tW1) 
     xlabel('time since birth, d')
     ylabel('weight, g')
     title('Tatera indica, m/f')
     set(gca, 'FontSize', 15, 'Box', 'on')
     saveas(gcf,'t_Ww_Tatera_indica.png')
         
     par
     
     figure
     Li = (par(2:3,1)/(1+par(6,1))).^(1/3); irB = 1./par(4:5,1);
     plot(Li, irB, 'or');
     xlabel('ultimate structural length, cm')
     ylabel('1/vBGR, d')
     title('Tatera indica, m/f')
     set(gca, 'FontSize', 15, 'Box', 'on')
     saveas(gcf,'Li_irB_Tatera_indica.png')

   case 7 % Mammalia +
     WD = cdEntr('Millardia_meltada'); data = mydata_Millardia_meltada; cd(WD);
     tW0=data.tWw_m; tW1=data.tWw_f; 
     par = [2.4  0;   %  1 Ww_b
            69  1;    %  2 Wwi_0
            69  1;    %  3 Wwi_1
            0.034 1;  %  4 rB_0
            0.034 1;  %  5 rB_1
            33.7 0];  %  6 ome
     %[EW0, EW1] = rB_W(par, tW0, tW1);
     nmregr_options('max_step_number',1000);
     par = nmregr('rB_W', par, tW0, tW1);
     par = nmregr('rB_W', par, tW0, tW1);
     shregr_options('all_in_one', 1); 
     shregr('rB_W', par, tW0, tW1) 
     xlabel('time since birth, d')
     ylabel('weight, g')
     title('Millardia meltada, m/f')
     set(gca, 'FontSize', 15, 'Box', 'on')
     saveas(gcf,'t_Ww_Millardia_meltada.png')
          
     par
     
     figure
     Li = (par(2:3,1)/(1+par(6,1))).^(1/3); irB = 1./par(4:5,1);
     plot(Li, irB, 'or');
     xlabel('ultimate structural length, cm')
     ylabel('1/vBGR, d')
     title('Millardia meltada, m/f')
     set(gca, 'FontSize', 15, 'Box', 'on')
     saveas(gcf,'Li_irB_Millardia_meltada.png')

   case 8 % Chondrichthyes +
     WD = cdEntr('Rhizoprionodon_taylori'); data = mydata_Rhizoprionodon_taylori; cd(WD);
     tL0=data.tL_f; tL1=data.tL_m; 
     
     par = [24  0;     %  1 Lw_b
            73  1;     %  2 Lwi_0
            65  1;     %  3 Lwi_1
            3.2e-3 0;  %  4 rB_0
            3.6e-3 0;  %  5 rB_1
            0.0637 0;  %  6 del_M
            4.73   0]; %  7 L_m
     nmregr_options('max_step_number',1000);
     par = nmregr('rB_L', par, tL0, tL1);
     par = nmregr('rB_L', par, tL0, tL1);
     par = nmregr('rB_L', par, tL0, tL1);
     shregr_options('all_in_one', 1); 
     shregr('rB_L', par, tL0, tL1) 
     xlabel('time since birth, d')
     ylabel('total length, cm')
     title('Rhizoprionodon taylori, f/m')
     set(gca, 'FontSize', 15, 'Box', 'on')
     saveas(gcf,'t_L_Rhizoprionodon_taylori.png')

     par
     
     figure
     Li = par(2:3,1) * par(6,1); irB = 1./par(4:5,1);
     plot(Li, irB, 'or');
     xlabel('ultimate structural length, cm')
     ylabel('1/vBGR, d')
     title('Rhizoprionodon taylori, f/m')
     set(gca, 'FontSize', 15, 'Box', 'on')
     saveas(gcf,'Li_irB_Rhizoprionodon_taylori.png')
   
     % free vBGR gives negative slope but positive slope also fits well

   case 9 % Chondrichthyes +
     WD = cdEntr('Raja_radula'); data = mydata_Raja_radula; cd(WD);
     tL0=data.tL_f; tL1=data.tL_m; 
     
     par = [10  0;     %  1 Lw_b
            77  1;     %  2 Lwi_0
            65  1;     %  3 Lwi_1
            3.9e-4 1;  %  4 rB_0
            3.9e-4 1;  %  5 rB_1
            0.11598 0; %  6 del_M
            9.69   0]; %  7 L_m
     nmregr_options('max_step_number',1000);
     par = nmregr('rB_L', par, tL0, tL1);
     par = nmregr('rB_L', par, tL0, tL1);
     par = nmregr('rB_L', par, tL0, tL1);
     shregr_options('all_in_one', 1); 
     shregr('rB_L', par, tL0, tL1) 
     xlabel('time since birth, d')
     ylabel('total length, cm')
     title('Raja radula, f/m')
     set(gca, 'FontSize', 15, 'Box', 'on')
     saveas(gcf,'t_L_Raja_radula.png')

     par
     
     figure
     Li = par(2:3,1) * par(6,1); irB = 1./par(4:5,1);
     plot(Li, irB, 'or');
     xlabel('ultimate structural length, cm')
     ylabel('1/vBGR, d')
     title('Raja radula, f/m')
     set(gca, 'FontSize', 15, 'Box', 'on')
     saveas(gcf,'Li_irB_Raja_radula.png')

   case 10 % Actinopterygii +
     WD = cdEntr('Nothobranchius_furzeri'); data = mydata_Nothobranchius_furzeri; cd(WD);
     tL0=data.tL_mNF221; tL1=data.tL_mNF222; tL2=data.tL_fNF221; tL3=data.tL_fNF222;
     
     par = [0.46 0;     %  1 Lw_b
            6.8  1;     %  2 Lwi_0
            6.8  1;     %  3 Lwi_0
            4.9  1;     %  4 Lwi_1
            4.9  1;     %  5 Lwi_1
            5e-2 1;     %  6 rB_0
            5e-2 1;     %  7 rB_1
            5e-2 1;     %  8 rB_1
            5e-2 1;     %  9 rB_1
            0.12219 0;  % 10 del_M
            0.53001 0]; % 11 L_m
     nmregr_options('max_step_number',1000);
     par = nmregr('rB_L', par, tL0, tL1, tL2, tL3);
     par = nmregr('rB_L', par, tL0, tL1, tL2, tL3);
     par = nmregr('rB_L', par, tL0, tL1, tL2, tL3);
     shregr_options('all_in_one', 1); 
     shregr('rB_L', par, tL0, tL1, tL2, tL3) 
     xlabel('time since birth, d')
     ylabel('total length, cm')
     title('Nothobranchius furzeri, mm/ff')
     set(gca, 'FontSize', 15, 'Box', 'on')
     saveas(gcf,'t_L_Nothobranchius_furzeri.png')

     par
     
     figure
     Li = par(2:5,1) * par(10,1); irB = 1./par(6:9,1);
     plot(Li, irB, 'or');
     xlabel('ultimate structural length, cm')
     ylabel('1/vBGR, d')
     title('Nothobranchius furzeri, mm/ff')
     set(gca, 'FontSize', 15, 'Box', 'on')
     saveas(gcf,'Li_irB_Nothobranchius_furzeri.png')

   case 11 % Actinopterygii +
     WD = cdEntr('Cynopoecilus_melanotaenia'); data = mydata_Cynopoecilus_melanotaenia; cd(WD);
     tL0=data.tL_m; tL1=data.tL_f; 
     
     par = [0.47  0;    %  1 Lw_b
            3.5  1;     %  2 Lwi_0
            2.5  1;     %  3 Lwi_1
            2.0e-2 0;   %  4 rB_0
            2.3e-2 0;   %  5 rB_1
            0.113 0;    %  6 del_M
            0.27 0];    %  7 L_m
     nmregr_options('max_step_number',1000);
     par = nmregr('rB_L', par, tL0, tL1);
     par = nmregr('rB_L', par, tL0, tL1);
     par = nmregr('rB_L', par, tL0, tL1);
     shregr_options('all_in_one', 1); 
     shregr('rB_L', par, tL0, tL1) 
     xlabel('time since birth, d')
     ylabel('total length, cm')
     title('Cynopoecilus melanotaenia, m/f')
     set(gca, 'FontSize', 15, 'Box', 'on')
     saveas(gcf,'t_L_Cynopoecilus_melanotaenia.png')

     par
     
     figure
     Li = par(2:3,1) * par(6,1); irB = 1./par(4:5,1);
     plot(Li, irB, 'or');
     xlabel('ultimate structural length, cm')
     ylabel('1/vBGR, d')
     title('Cynopoecilus melanotaenia, m/f')
     set(gca, 'FontSize', 15, 'Box', 'on')
     saveas(gcf,'Li_irB_Cynopoecilus_melanotaenia.png')
 
     % a negative slope results, but a positive also fits well
     
   case 12 % Amphibia +
     WD = cdEntr('Pyxicephalus_adspersus'); data = mydata_Pyxicephalus_adspersus; cd(WD);
     tL0=data.tL_m; tL1=data.tL_f; tW0=data.tW_m; tW1=data.tW_f; 
     
     par = [1.3    0;   %  1 Lw_b
            24.5   1;   %  2 Lwi_0
            19.2   1;   %  3 Lwi_1
            5.7e-3 1;   %  4 rB_0
            5.6e-3 1;   %  5 rB_1
            0.2873 0;   %  6 del_M
            5.10   0];  %  7 L_m
     nmregr_options('max_step_number',1000);
     par = nmregr('rB_L', par, tL0, tL1);
     par = nmregr('rB_L', par, tL0, tL1);
     par = nmregr('rB_L', par, tL0, tL1);
     shregr_options('all_in_one', 1); 
     shregr('rB_L', par, tL0, tL1) 
     xlabel('time since birth, d')
     ylabel('SVL, cm')
     title('Pyxicephalus adspersus, m/f')
     set(gca, 'FontSize', 15, 'Box', 'on')
     saveas(gcf,'t_L_Pyxicephalus_adspersus.png')

     par
     
     figure
     Li = par(2:3,1) * par(6,1); irB = 1./par(4:5,1);
     plot(Li, irB, 'or');
     xlabel('ultimate structural length, cm')
     ylabel('1/vBGR, d')
     title('Pyxicephalus adspersus, m/f')    
     set(gca, 'FontSize', 15, 'Box', 'on')
     saveas(gcf,'Li_irB_Pyxicephalus_adspersus.png')

     %weight
     figure
     par = [3      0;   %  1 Ww_b
            1400   1;   %  2 Wwi_0
            840    1;   %  3 Wwi_1
            5.7e-3 1;   %  4 rB_0
            5.6e-3 1;   %  5 rB_1
            6.4    0];  %  6 ome
     nmregr_options('max_step_number',1000);
     par = nmregr('rB_W', par, tW0, tW1);
     par = nmregr('rB_W', par, tW0, tW1);
     par = nmregr('rB_W', par, tW0, tW1);
     shregr_options('all_in_one', 1); 
     shregr('rB_W', par, tW0, tW1) 
     xlabel('time since birth, d')
     ylabel('weight, g')
     title('Pyxicephalus adspersus, m/f')
     set(gca, 'FontSize', 15, 'Box', 'on')
     saveas(gcf,'t_Ww_Pyxicephalus_adspersus.png')

     par
     
     figure
     Li = (par(2:3,1)/(1+par(6,1))).^(1/3); irB = 1./par(4:5,1);
     plot(Li, irB, 'or');
     xlabel('ultimate structural length, cm')
     ylabel('1/vBGR, d')
     title('Pyxicephalus adspersus, m/f')    
     set(gca, 'FontSize', 15, 'Box', 'on')
     saveas(gcf,'Li_irB_Pyxicephalus_adspersus_W.png')

   case 13 % Reptilia +  
     WD = cdEntr('Eryx_miliaris'); data = mydata_Eryx_miliaris; cd(WD);
     tW0=data.tW_f; tW1=data.tW_m; 
     par = [7  0;      %  1 Ww_b
            180  1;    %  2 Wwi_0
            44   1;    %  3 Wwi_1
            2.6e-3 1;  %  4 rB_0
            7.9e-3 1;  %  5 rB_1
            4.0 0];    %  6 ome
     %[EW0, EW1] = rB_W(par, tW0, tW1);
     nmregr_options('max_step_number',1000);
     par = nmregr('rB_W', par, tW0, tW1);
     par = nmregr('rB_W', par, tW0, tW1);
     shregr_options('all_in_one', 1); 
     shregr('rB_W', par, tW0, tW1) 
     xlabel('time since birth, d')
     ylabel('weight, g')
     title('Eryx miliaris, f/m')
     set(gca, 'FontSize', 15, 'Box', 'on')
     saveas(gcf,'t_Ww_Eryx_miliaris.png')
          
     par
     
     figure
     Li = (par(2:3,1)/(1+par(6,1))).^(1/3); irB = 1./par(4:5,1);
     plot(Li, irB, 'or');
     xlabel('ultimate structural length, cm')
     ylabel('1/vBGR, d')
     title('Eryx miliaris, f/m')
     set(gca, 'FontSize', 15, 'Box', 'on')
     saveas(gcf,'Li_irB_Eryx_miliaris.png')

   case 14 % Reptilia +
     WD = cdEntr('Bitis_arietans'); data = mydata_Bitis_arietans; cd(WD);
     tL0=data.tL_f1; tL1=data.tL_f2; tL2=data.tL_m1; tL3=data.tL_m2;
     
     par = [35   0;     %  1 Lw_b
            115   1;    %  2 Lwi_0
            100   0;    %  3 Lwi_1
            90    0;    %  4 Lwi_2
            83    0;    %  5 Lwi_3
            1.1e-3 1;   %  6 rB_0
            1.1e-3 1;   %  7 rB_1
            1.1e-3 1;   %  8 rB_2
            1.1e-3 1;   %  9 rB_3
            0.0569 0;   % 10 del_M
            10.5   0];  % 11 L_m
     nmregr_options('max_step_number',1000);
     par = nmregr('rB_L', par, tL0, tL1, tL2, tL3);
     par = nmregr('rB_L', par, tL0, tL1, tL2, tL3);
     par = nmregr('rB_L', par, tL0, tL1, tL2, tL3);
     shregr_options('all_in_one', 1); 
     shregr('rB_L', par, tL0, tL1, tL2, tL3) 
     xlabel('time since birth, d')
     ylabel('total length, cm')
     title('SBitis arietans, ff/mm')
     set(gca, 'FontSize', 15, 'Box', 'on')
     saveas(gcf,'t_L_Bitis_arietans.png')

     par
     
     figure
     Li = par(2:5,1) * par(10,1); irB = 1./par(6:9,1);
     plot(Li, irB, 'or');
     xlabel('ultimate structural length, cm')
     ylabel('1/vBGR, d')
     title('Bitis arietans, ff/mm')    
     set(gca, 'FontSize', 15, 'Box', 'on')
     saveas(gcf,'Li_irB_Bitis_arietans.png')


   case 114 % Reptilia +
     WD = cdEntr('Spalerosophis_diadema'); data = mydata_Spalerosophis_diadema; cd(WD);
     tL0=data.tL_fm(:,[1 2]); tL1=data.tL_fm(:,[1 3]); tL1(end-1:end,:)=[]; tW0=data.tW_fm(:,[1 2]); tW1=data.tW_fm(:,[1 3]); tW1(end-1:end,:)=[];
     
     par = [37.5  0;    %  1 Lw_b
            165   1;    %  2 Lwi_0
            150   0;    %  3 Lwi_1
            4.25e-4 1;  %  4 rB_0
            4.25e-4 1;  %  5 rB_1
            0.2873 0;   %  6 del_M
            9.56   0];  %  7 L_m
     nmregr_options('max_step_number',1000);
     par = nmregr('rB_L', par, tL0, tL1);
     par = nmregr('rB_L', par, tL0, tL1);
     par = nmregr('rB_L', par, tL0, tL1);
     shregr_options('all_in_one', 1); 
     shregr('rB_L', par, tL0, tL1) 
     xlabel('time since birth, d')
     ylabel('total length, cm')
     title('Spalerosophis diadema, f/m')
     set(gca, 'FontSize', 15, 'Box', 'on')
     saveas(gcf,'t_L_Spalerosophis_diadema.png')

     par
     
     figure
     Li = par(2:3,1) * par(6,1); irB = 1./par(4:5,1);
     plot(Li, irB, 'or');
     xlabel('ultimate structural length, cm')
     ylabel('1/vBGR, d')
     title('Spalerosophis diadema, f/m')    
     set(gca, 'FontSize', 15, 'Box', 'on')
     saveas(gcf,'Li_irB_Spalerosophis_diadema.png')

     % weight
     figure
     par = [13.2   0;   %  1 Ww_b
            1062   0;   %  2 Wwi_0
            800    0;   %  3 Wwi_1
            0.081  1;   %  4 rB_0
            0.118  1;   %  5 rB_1
            0.45   0];  %  6 ome
     nmregr_options('max_step_number',500);
     par = nmregr('rB_W', par, tW0, tW1);
     par = nmregr('rB_W', par, tW0, tW1);
     par = nmregr('rB_W', par, tW0, tW1);
     shregr_options('all_in_one', 1); 
     shregr('rB_W', par, tW0, tW1) 
     xlabel('time since birth, d')
     ylabel('weight, g')
     title('Spalerosophis diadema, f/m')
     set(gca, 'FontSize', 15, 'Box', 'on')
     saveas(gcf,'t_Ww_Spalerosophis_diadema.png')

     par
     
     figure
     Li = (par(2:3,1)/(1+par(6,1))).^(1/3); irB = 1./par(4:5,1);
     plot(Li, irB, 'or');
     xlabel('ultimate structural length, cm')
     ylabel('1/vBGR, d')
     title('Spalerosophis diadema, f/m')    
     set(gca, 'FontSize', 15, 'Box', 'on')
     saveas(gcf,'Li_irB_Spalerosophis_diadema_W.png')

   case 15 % Aves +
     WD = cdEntr('Philomachus_pugnax'); data = mydata_Philomachus_pugnax; cd(WD);
     tW0=data.tW_m; tW1=data.tW_f; 
     par = [10  0;    %  1 Ww_b
            180  1;   %  2 Wwi_0
            110  1;   %  3 Wwi_1
            0.037 1;  %  4 rB_0
            0.037 1;  %  5 rB_1
            41.11 0]; %  6 ome
     %[EW0, EW1] = rB_W(par, tW0, tW1);
     nmregr_options('max_step_number',1000);
     par = nmregr('rB_W', par, tW0, tW1);
     par = nmregr('rB_W', par, tW0, tW1);
     shregr_options('all_in_one', 1); 
     shregr('rB_W', par, tW0, tW1) 
     xlabel('time since birth, d')
     ylabel('weight, g')
     title('Philomachus pugnax, m/f')
     set(gca, 'FontSize', 15, 'Box', 'on')
     saveas(gcf,'t_Ww_Philomachus_pugnax.png')
          
     par
     
     figure
     Li = (par(2:3,1)/(1+par(6,1))).^(1/3); irB = 1./par(4:5,1);
     plot(Li, irB, 'or');
     xlabel('ultimate structural length, cm')
     ylabel('1/vBGR, d')
     title('Philomachus pugnax, m/f')
     set(gca, 'FontSize', 15, 'Box', 'on')
     saveas(gcf,'Li_irB_Philomachus_pugnax.png')

   case 16 % Mollusca +
     WD = cdEntr('Mytilus_edulis'); data = mydata_Mytilus_edulis; cd(WD);
     tL0=data.tL_0; tL1=data.tL_13; tL2=data.tL_33; 
     
     par = [0    0;     %  1 Lw_b
            8    1;     %  2 Lwi_0
            7    1;     %  3 Lwi_1
            6    1;     %  4 Lwi_2
            1e-4 1;     %  5 rB_0
            2e-4 1;     %  6 rB_1
            3e-4 1;     %  7 rB_2
            0.34144 0;  %  8 del_M
            4.16*1.16 0]; %9 L_m
     nmregr_options('max_step_number',1000);
     par = nmregr('rB_L', par, tL0, tL1, tL2);
     par = nmregr('rB_L', par, tL0, tL1, tL2);
     par = nmregr('rB_L', par, tL0, tL1, tL2);
     shregr_options('all_in_one', 1); 
     shregr('rB_L', par, tL0, tL1, tL2) 
     xlabel('time since birth, d')
     ylabel('standard height, cm')
     title('Mytilus edulis')
     set(gca, 'FontSize', 15, 'Box', 'on')
     saveas(gcf,'t_L_Mytilus_edulis.png')

     par
     
     figure
     Li = par(2:4,1) * par(9,1); irB = 1./par(5:7,1);
     plot(Li, irB, 'or');
     xlabel('ultimate structural length, cm')
     ylabel('1/vBGR, d')
     title('Mytilus edulis')
     set(gca, 'FontSize', 15, 'Box', 'on')
     saveas(gcf,'Li_irB_Mytilus_edulis.png')

   case 17 % Mollusca +
     WD = cdEntr('Patella_vulgata'); data = mydata_Patella_vulgata; cd(WD);
     tL0=data.tL1; tL1=data.tL2; tL2=data.tL3; tL3=data.tL4; 
     
     par = [0    0;     %  1 Lw_b
            10   0;     %  2 Lwi_0
            4    1;     %  3 Lwi_1
            3    1;     %  4 Lwi_2
            2    1;     %  5 Lwi_3
            5e-4 1;     %  6 rB_0
            6e-4 1;     %  7 rB_1
            7e-4 1;     %  8 rB_2
            8e-4 1;     %  9 rB_3
            0.27269 0;  % 10 del_M
            1.67 0];    % 11 L_m
     nmregr_options('max_step_number',1000);
     par = nmregr('rB_L', par, tL0, tL1, tL2, tL3);
     par = nmregr('rB_L', par, tL0, tL1, tL2, tL3);
     par = nmregr('rB_L', par, tL0, tL1, tL2, tL3);
     shregr_options('all_in_one', 1); 
     shregr('rB_L', par, tL0, tL1, tL2, tL3) 
     xlabel('time since birth, d')
     ylabel('length, cm')
     title('Patella vulgata')
     set(gca, 'FontSize', 15, 'Box', 'on')
     saveas(gcf,'t_L_Patella_vulgata.png')

     par
     
     figure
     Li = par(2:5,1) * par(10,1); irB = 1./par(6:9,1);
     plot(Li, irB, 'or');
     xlabel('ultimate structural length, cm')
     ylabel('1/vBGR, d')
     title('Patella vulgata')
     set(gca, 'FontSize', 15, 'Box', 'on')
     saveas(gcf,'Li_irB_Patella_vulgata.png')

   case 18 % L-Ww 
     WD = cdEntr('Gloydius_blomhoffii'); data = mydata_Gloydius_blomhoffii; cd(WD);
     LW_f=data.LW_f; LW_m=data.LW_m; 
     
     figure
     plot(LW_f(:,1),LW_f(:,2),'.r', LW_m(:,1),LW_m(:,2),'.b','MarkerSize',10)
     hold on
     L_f=19:64; W_f=.00084*L_f.^3; L_m= 19:55; W_m=.0006*L_m.^3;
     plot(L_f, W_f, 'r', L_m, W_m, 'b', 'LineWidth',3)
     xlabel('total length, cm')
     ylabel('weight, g')
     title('Gloydius blomhoffii, f/m')
     set(gca, 'FontSize', 15, 'Box', 'on')
     saveas(gcf,'L_Ww_Gloydius_blomhoffii.png')
     
   case 19 % Wwi-rB
     [h hleg] = shstat({'L_i', 'r_B'}, legend_fish);
     L=linspace(-0.5,2,100)';
     figure(h)
     Li_rB = log10([read_stat('Chondrichthyes',{'L_i','r_B'});read_stat('Actinopterygii',{'L_i','r_B'})]);
     nmregr_options('max_step_number',500);
     par = [.1 1; 0.1 1];
     %par = nmregr('LirB', par, Li_rB);
     rB = log10(par(1,1)./(1 + 10.^L/par(2,1)));
     plot(L,rB,'k', 'linewidth', 2)
     xlabel('_{10}log L_{\infty}, cm')
     ylabel('_{10}log vBGR, d^{-1}')
     title('Chondrichthyes & Actinopterygii')
     saveas(gcf,'Li_rB_Chon_Acti.png')

     par
     
   case 20 % Wwi-rB
     [h hleg] = shstat({'L_i', 'r_B'}, legend_crus);
     L=linspace(-2.2,1.5,100)';
     figure(h)
     Li_rB = log10(read_stat('Crustacea',{'L_i','r_B'}));
     nmregr_options('max_step_number',500);
     par = [.07 1; 0.1 1];
     %par = nmregr('LirB', par, Li_rB);
     rB = log10(par(1,1)./(1 + 10.^L/par(2,1)));
     plot(L,rB,'k', 'linewidth', 2)
     xlabel('_{10}log L_{\infty}, cm')
     ylabel('_{10}log vBGR, d^{-1}')
     title('Crustacea')
     saveas(gcf,'Li_rB_Crus.png')

     par
     
   case 21 % Wwi-rB
     [h hleg] = shstat({'L_i', 'r_B'}, legend_moll);
     L=linspace(-1.5,2.1,100)';
     figure(h)
     Li_rB = log10(read_stat('Mollusca',{'L_i','r_B'}));
     nmregr_options('max_step_number',500);
     par = [.07 1; 0.1 1];
     %par = nmregr('LirB', par, Li_rB);
     rB = log10(par(1,1)./(1 + 10.^L/par(2,1)));
     plot(L,rB,'k', 'linewidth', 2)
     xlabel('_{10}log L_{\infty}, cm')
     ylabel('_{10}log vBGR, d^{-1}')
     title('Mollusca')
     saveas(gcf,'Li_rB_Moll.png')

     par
end
end
end
