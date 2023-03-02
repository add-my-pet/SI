function BaasKooy2015_SI(figi)
% Supporting Information for BaasKooy2015
% Title:  Sensitivity of animals to chemical compounds links to metabolic rate
% Authors: Baas & Kooijman
% Journal: Ecotoxicology 24 (2015) 657–663
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
% To run the code (here for section 3), open this file in the Matlab Editor and type in the Matlab window: BaasKooy2015_SI(3)
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
    figi = 1:5;
  end
  
  for i=1:length(figi)
 
    switch figi(i)
      case 1 % fig 1a: NEC-pM for Chlorpyriphos
        nm_Chlor = {...
        'Paratya_australiensis'    % -
        'Gammarus_pulex'           % +
        'Macrobachium_lanchesteri' % -
        'Neocaridina_denticulata'  % -
        'Palaemonetes_pugio'       % +
        'Parathelphusinae'         % -
        'Procambarus_clarkia'      % -
        'Gammarus_pseudolimnaeus'  % +
        'Hyalella_azteca'          % +
        'Anguilla_anguilla'        % +
        'Cirhinus_mrigala'         % -
        'Gibelion_catla'           % -
        'Lepomis_cyanellus'        % +
        'Melanotaenia_fluviatilis' % -
        'Oreochromis_mossambicus'  % +
        'Tilapia_guineensis'       % -
        'Ctenopharyngodon_idella'  % +
        'Gambusia_affinis'         % +
        };
    
        NEC_Chlor = [5e-4 5e-4 7e-3 1.22 1.7e-3 5e-2 5.9e-2 4.7e-4 3.7e-4 1.51 4.1 5.21 9e-2 0.2 6.7e-2 3e-2 0.1 0.25]; % mummol/L
        pM_Chlor = [600 600 600 16 828 40 16 600 600 39 9 9 13 9 29 29 62 99];
        
        Hfig = figure;
        val_plot = [log10(NEC_Chlor)',log10(pM_Chlor)']; 
        plot(val_plot(:,1), val_plot(:,2), '.r', 'Markersize',12)

        xlabel('NEC for Chlorpyriphos, mumol/L')
        ylabel('spec somatic maint, [p_M], J/d.cm^3');
        h = datacursormode(Hfig); entries_txt = nm_Chlor; n_entries = length(nm_Chlor);
        for i=1:n_entries; entries_txt{i} = strrep(entries_txt{i}, '_' , ' '); end
        h.UpdateFcn = @(obj, event_obj)xylabels(obj, event_obj, entries_txt, val_plot);
        datacursormode on % mouse click on plot
        %print -r0 -dpng NEC_pM_Chlor.png

      case 2 % fig 1b: NEC-pM for Malathion
        nm_Malat = {...
        'Baritelphua_amicularis'       % -?
        'Gammarus_pulex'               % +
        'Macrobrachium_lamarrei'       % -
        'Oziotelphusa_senex'           % -
        'Channa_punctata'              % +
        'Cirhinus_mrigala'             % -
        'Lepomis_gibbosus'             % -
        'Puntius_sophore'              % -
        'Dania_rerio'                  % +
        'Cyprinus_carpio'              % +
        'Echinometra_mathaei'          % +
        'Elliptio_icterina'            % -
        'Lampsilis_subangulata'        % -
        'Daphnia_magna'                % +
        'Peltodytus_spec'              % -
        };
    
        NEC_Malat = [1.5 2e-3 3.5 12.6 1.52 3 1.4 2.8 2.8 3 2.3 38 23 1e-3 3]; % mummol/L
        pM_Malat = [40 600 27 40 18 18 13 61 60 61 19 40 29 1400 19];
        
        Hfig = figure;
        val_plot = [log10(NEC_Malat)',log10(pM_Malat)']; 
        plot(val_plot(:,1), val_plot(:,2), '.r', 'Markersize',12)

        xlabel('NEC for Malathion, mumol/L')
        ylabel('spec somatic maint, [p_M], J/d.cm^3');
        h = datacursormode(Hfig); entries_txt = nm_Malat; n_entries = length(nm_Malat);
        for i=1:n_entries; entries_txt{i} = strrep(entries_txt{i}, '_' , ' '); end
        h.UpdateFcn = @(obj, event_obj)xylabels(obj, event_obj, entries_txt, val_plot);
        datacursormode on % mouse click on plot
        %print -r0 -dpng NEC_pM_Malat.png


      case 3 % fig 1c: NEC-pM for Carbofuran
        nm_Carbo = {...
        'Gammarus_pulex'           % +
        'Anabas_testudineus'       % -
        'Heteropneustes_fossilis'  % -
        'Lepomis_cyanellus'        % +
        'Lepidocephalichthys_thermalis' % -
        'Mystus_vittatus'          % -
        'Gambusia_affinis'         % +
        };

        NEC_Carbo = [1.6e-2 4.07 2.4 0.7 6 0.46 2.3]; % mummol/L
        pM_Carbo = [600 20 18 13 8 18 99];
 
        Hfig = figure;
        val_plot = [log10(NEC_Carbo)',log10(pM_Carbo)']; 
        plot(val_plot(:,1), val_plot(:,2), '.r', 'Markersize',12)

        xlabel('NEC for Carbofuran, mumol/L')
        ylabel('spec somatic maint, [p_M], J/d.cm^3');
        h = datacursormode(Hfig); entries_txt = nm_Carbo; n_entries = length(nm_Carbo);
        for i=1:n_entries; entries_txt{i} = strrep(entries_txt{i}, '_' , ' '); end
        h.UpdateFcn = @(obj, event_obj)xylabels(obj, event_obj, entries_txt, val_plot);
        datacursormode on % mouse click on plot
         print -r0 -dpng NEC_pM_Carbo.png

      case 4 % fig 1d: NEC-pM for Carbaryl
        nm_Carba = {...
        'Cancer_magister'              % -
        'Gammarus_pulex'               % +
        'Homarus_americanus'           % +
        'Macrobrachium_dagam'          % -?
        'Macrobrachium_lamarrei'       % -
        'Palaemonetes_kadiakensis'     % -
        'Palaemonetes_pugio'           % +
        'Paratelphusa_jaquemontii'     % -
        'Daphnia_magna'                % +
        'Pontoporeia_hoyi'             % -
        'Procambarus_simulans'         % -
        'Scylla_serrata'               % -
        'Americamysis_bahia'           % +
        'Gammarus_pseudolimnaeus'      % +
        'Barbus_ticto'                 % -
        'Channa_punctata'              % +
        'Estheostoma_lepidum'          % -
        'Pseudosphromenus_dayi'        % - Macropocus_cupanus
        'Nuria_danrica'                % -
        'Scarphirhynchus_platorynchus' % -
        'Ictalurus_punctatus'          % +
        'Lepomis_macrochirus'          % +
        'Menidia_beryllina'            % +
        'Pimephales_promelas'          % +
        'Salvelinus_fontinalis'        % +
        'Cyprinus_carpio'              % +
        'Oncorhynchus_kisutch'         % +
        'Oncorhynchus_mykiss'          % +
        'Carassius_auratus'            % +
        'Etheostoma_rubrum'            % -
        'Corbicula_fluminea'           % -
        };
          
        NEC_Carba = [.82 .11 .1 .16 .11 .42 .108 17.5 .108 .8 11.1 2.3 4.2e-2 3.1e-2 17.9 11.8 8.9 61 55 5.8 61 10.8 7.9 24.8 .23 4.8 2.3 4.3 10.1 9.3 25]; % mummol/L
        pM_Carba = [40 600 27 27 27 828 828 40 1400 600 40 40 600 600  18 18 61 21 61 10 18 13 42 61 83 31 42 83 61 61 28];
        
        Hfig = figure;
        val_plot = [log10(NEC_Carba)',log10(pM_Carba)']; 
        plot(val_plot(:,1), val_plot(:,2), '.r', 'Markersize',12)

        xlabel('NEC for Carbaryl, mumol/L')
        ylabel('spec somatic maint, [p_M], J/d.cm^3');
        h = datacursormode(Hfig); entries_txt = nm_Carba; n_entries = length(nm_Carba);
        for i=1:n_entries; entries_txt{i} = strrep(entries_txt{i}, '_' , ' '); end
        h.UpdateFcn = @(obj, event_obj)xylabels(obj, event_obj, entries_txt, val_plot);
        datacursormode on % mouse click on plot
        %print -r0 -dpng NEC_pM_Carba.png
      
      case 5 % fig 2: Li-pM for RSED
        shstat_options('default');
        [HfigLipM, HlegLipM] = shstat({'L_i', 'p_M'}, legend_RSED, title); 
        
        figure(HfigLipM)
        xlabel('ultimate structural length, _{10}log L_{\infty}, cm')
        ylabel('spec somatic maint rate, _{10}log [p_M], J/d.cm^3')
        %print -r0 -dpng Li_pM.png
        figure(HlegLipM)
        %print -r0 -dpng legend_RSED.png
          
    end
  end
end
