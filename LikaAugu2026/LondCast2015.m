%bibkey = 'LondCast2015'; type = 'Article'; bib = [ ... 
% 'doi = {10.1111/1365-2435.12348}, ' ...
% 'title = {Basal metabolism in tropical birds: latitude, altitude, and the ‘pace of life’}, ' ...
% 'journal = {Functional Ecology}, ' ...
% 'volume = {29}, ' ...
% 'year = {2015}, ' ...
% 'pages = {338–346}, ' ...
% 'author = {Gustavo A. Londono and Mark A. Chappell Marıa del Rosario Castaneda and Jill E. Jankowski and Scott K. Robinson}'];
%
% several species names are replaced by those used in AmP
% 1 watt; = 60/20.1 ml O2/min
aves = { ...
% spec              mass(g) BMR(W)  sel N   breeding habitat Ref   
'Crypturellus_soui'         220.8	0.77	1;%1	Tropical	This Study
'Struthio_camelus'        100000.0 63.05	0;%N/A	Tropical	McKechnie & Wolf 2004
'Apteryx_australis'         2380.0	4.03	1;%N/A	Temperate	McKechnie & Wolf 2004
'Callipepla_gambelii'       126.1	0.76	1;%N/A	Temperate	McKechnie & Wolf 2004
'Colinus_virginianus'       258.0	1.32	1;%5	Temperate	UCR
'Odontophorus_stellatus' 	296.5	1.15	0;%1	Tropical	This Study
'Bonasa_umbellus'           644.0	2.38	1;%N/A	Temperate	McKechnie & Wolf 2004
'Dendragapus_obscurus'      1131.0	4.96	1;%N/A	Temperate	McKechnie & Wolf 2004
'Alectoris_chukar'          525.7	1.22	1;%5	Temperate	UCR
'Coturnix_coturnix'         97.0	0.89	1;%N/A	Temperate	Wiersma et al. 2007
'Coturnix_pectoralis'       95.8	0.64	1;%N/A	Temperate	McKechnie & Wolf 2004
'Synoicus_chinensis'        44.9	0.37	0;%N/A	Tropical	McKechnie & Wolf 2004
'Synoicus_chinensis'        42.4	0.42	0;%7	Tropical	UCR
'Gallus_gallus'             1196.0  3.02	1;%20	Temperate	UCR
'Gallus_gallus'             2710.0   6.00	0;%N/A	Tropical	McKechnie & Wolf 2004
'Pygoscelis_adeliae'        3970.0	12.23	1;%N/A	Temperate	McKechnie & Wolf 2004
'Spheniscus_humboldti'      3870.0	9.49	1;%N/A	Temperate	McKechnie & Wolf 2004
'Phoebastria_immutabilis' 	2522.0	7.46	1;%N/A	Temperate	McKechnie & Wolf 2004
'Diomedea_exulans'          8130.0	20.31	1;%N/A	Temperate	McKechnie & Wolf 2004
'Thalassarche_chrysostoma' 	3753.0	8.51	1;%N/A	Temperate	McKechnie & Wolf 2004
'Macronectes_giganteus'     4780.0	13.36	1;%N/A	Temperate	McKechnie & Wolf 2004
'Phalacrocorax_auritus'     1330.0	5.49	1;%N/A	Temperate	McKechnie & Wolf 2004
'Anhinga_rufa'              1040.0	3.19	0;%N/A	Tropical	McKechnie & Wolf 2004
'Accipiter_nisus'            135.0	0.95	1;%N/A	Temperate	Wiersma et al. 2007
'Accipiter_striatus'         173.4	0.52	0;%1	Tropical	This Study
'Buteo_lineatus'             658.0	2.11	1;%N/A	Temperate	McKechnie & Wolf 2004
'Buteo_lineatus'             609.0	2.80	1;%6	Temperate	UCR
'Buteo_jamaicensis'         1140.9	4.33	1;%6	Temperate	UCR
'Turnix_suscitator'          58.1	0.39	0;%N/A	Tropical	McKechnie & Wolf 2004
'Haematopus_ostralegus'     554.0	2.91	1;%N/A	Temperate	McKechnie & Wolf 2004
'Pluvialis_squatarola'      226.0	1.78	1;%N/A	Temperate	McKechnie & Wolf 2004
'Charadrius_dubius'          36.0	0.42	1;%N/A	Temperate	Wiersma et al. 2007
'Jacana_jacana'             107.0	1.01	0;%N/A	Tropical	Wiersma et al. 2007
'Thinocorus_rumicivorus'	55.5	0.31	1;%N/A	Temperate	McKechnie & Wolf 2004
'Scolopax_minor'            156.7	1.07	1;%N/A	Temperate	McKechnie & Wolf 2004
'Arenaria_interpres'         90.0	0.92	1;%N/A	Temperate	McKechnie & Wolf 2004
'Calidris_tenuirostris'     198.2	2.01	1;%N/A	Temperate	White et al. 2007
'Calidris_canutus'          130.0	0.88	1;%N/A	Temperate	McKechnie & Wolf 2004
'Larus_argentatus'          1000.0	4.80	1;%N/A	Temperate	McKechnie & Wolf 2004
'Uria_lomvia'               989.0	6.80	1;%N/A	Temperate	McKechnie & Wolf 2004
'Uria_aalge'                956.0	6.80	1;%N/A	Temperate	McKechnie & Wolf 2004
'Pterocles_orientalis'      386.4	1.95	1;%N/A	Temperate	McKechnie & Wolf 2004
'Columba_livia'             316.3	2.12	1;%8	Temperate	UCR
'Columba_leucomela'         456.0	2.44	1;%N/A	Temperate	McKechnie & Wolf 2004
'Streptopelia_capicola'     151.9	0.91	1;%6	Temperate	UCR
'Oena_capensis'             56.0	0.40	0;%2	Tropical	UCR
'Chalcophaps_indica'        124.0	0.79	0;%N/A	Tropical	McKechnie & Wolf 2004
'Phaps_chalcoptera'         304.0	1.53	1;%N/A	Temperate	McKechnie & Wolf 2004
'Phaps_elegans'             190.0	1.24	1;%N/A	Temperate	McKechnie & Wolf 2004
'Phaps_histrionica'     	257.0	1.30	1;%N/A	Temperate	McKechnie & Wolf 2004
'Ocyphaps_lophotes'         187.0	1.09	1;%N/A	Temperate	McKechnie & Wolf 2004
'Geophaps_plumifera'        81.0	0.39	1;%N/A	Temperate	McKechnie & Wolf 2004
'Geophaps_smithii'          198.0	0.87	1;%N/A	Temperate	McKechnie & Wolf 2004
'Leucosarcia_melanoleuca'	445.0	1.69	1;%N/A	Temperate	McKechnie & Wolf 2004
'Geopelia_cuneata'          39.0	0.27	1;%N/A	Temperate	McKechnie & Wolf 2004
'Geopelia_cuneata'          37.5	0.28	1;%6	Temperate	UCR
'Geopelia_placida'          52.0	0.36	1;%N/A	Temperate	McKechnie & Wolf 2004
'Zenaida_macroura'          121.7	0.79	1;%N/A	Temperate	Wiersma et al. 2007
'Columbina_inca'            40.5	0.25	1;%N/A	Temperate	McKechnie & Wolf 2004
'Columbina_talpacoti'       45.7	0.41	0;%N/A	Tropical	Wiersma et al. 2007
'Leptotila_verreauxi'       131.0	0.89	0;%N/A	Tropical	Wiersma et al. 2007
'Leptotila_rufaxilla'       150.6	0.69	0;%3	Tropical	This Study
'Zentrygon_frenata'         322.4	0.88	0;%2	Tropical	This Study
'Geotrygon_montana'         117.9	0.82	0;%16	Tropical	This Study
'Ptilinopus_superbus'       120.4	0.76	0;%N/A	Tropical	McKechnie & Wolf 2004
'Ptilinopus_melanospilus'	98.0	0.49	0;%N/A	Tropical	McKechnie & Wolf 2004
'Geococcyx_californianus'	284.7	1.46	1;%N/A	Temperate	McKechnie & Wolf 2004
'Cuculus_canorus'           111.6	0.84	1;%N/A	Temperate	Wiersma et al. 2007
'Tyto_alba'                 456.1	2.61	1;%6	Temperate	UCR
'Megascops_asio'            166.0	0.59	1;%N/A	Temperate	McKechnie & Wolf 2004
'Megascops_kennicottii'     147.3	1.27	1;%6	Temperate	UCR
'Megascops_trichopsis'      120.0	0.45	1;%N/A	Temperate	McKechnie & Wolf 2004
'Bubo_scandiacus'           2026.0	4.21	1;%N/A	Temperate	McKechnie & Wolf 2004
'Bubo_virginianus'          1450.0	5.23	1;%N/A	Temperate	McKechnie & Wolf 2004
'Bubo_virginianus'          1195.4	4.39	1;%6	Temperate	UCR
'Strix_occidentalis'        571.0	2.67	1;%N/A	Temperate	McKechnie & Wolf 2004
'Glaucidium_jardinii'       60.6	0.68	0;%5	Tropical	This Study
'Glaucidium_brasilianum'	60.6	0.43	0;%1	Tropical	This Study
'Athene_cunicularia'        159.7	1.02	1;%6	Temperate	UCR
'Asio_otus'                 252.0	0.95	1;%N/A	Temperate	McKechnie & Wolf 2004
'Podargus_strigoides'       380.3	1.03	1;%N/A	Temperate	McKechnie & Wolf 2004
'Chordeiles_minor'          72.0	0.44	1;%N/A	Temperate	McKechnie & Wolf 2004
'Uropsalis_segmentata'      34.7	0.54	0;%1	Tropical	This Study
'Uropsalis_lyra'            77.5	0.52	0;%1	Tropical	This Study
'Streptoprocne_rutila'      16.1	0.24	0;%1	Tropical	This Study
'Apus_apus'                 44.9	0.44	1;%N/A	Temperate	Wiersma et al. 2007
'Eutoxeres_condamini'       10.0	0.22	0;%6	Tropical	This Study
'Glaucis_hirsutus'          6.9     0.18	0;%1	Tropical	This Study
'Threnetes_leucurus'        9.4     0.15	0;%3	Tropical	This Study
'Phaethornis_guy'           5.9     0.13	0;%8	Tropical	This Study
'Phaethornis_hispidus'      4.9     0.14	0;%5	Tropical	This Study
'Phaethornis_superciliosus' 5.2     0.14	0;%3	Tropical	This Study
'Phaethornis_koepckeae'     5.4     0.13	0;%2	Tropical	This Study
'Doryfera_ludovicae'        5.9     0.16	0;%5	Tropical	This Study
'Colibri_thalassinus'       6.2     0.16	0;%1	Tropical	This Study
'Colibri_coruscans'         8.4     0.15	0;%25	Tropical	This Study
'Thalurania_furcata'        3.8     0.13	0;%1	Tropical	This Study
'Taphrospilus_hypostictus'	7.5     0.13	0;%4	Tropical	This Study
'Adelomyia_melanogenys' 	3.5     0.08	0;%6	Tropical	This Study
'Phlogophilus_harterti' 	2.8     0.15	0;%2	Tropical	This Study
'Heliodoxa_leadbeateri'     7.5     0.19	0;%21	Tropical	This Study
'Boissonneaua_matthewsii'	7.5     0.20	0;%5	Tropical	This Study
'Aglaeactis_cupripennis'	7.2     0.12	0;%9	Tropical	This Study
'Aglaeactis_castelnaudii'	6.9     0.10	0;%1	Tropical	This Study
'Oreotrochilus_estella'     8.4     0.19	0;%N/A	Tropical	McKechnie & Wolf 2004
'Lafresnaya_lafresnayi'     5.7     0.14	0;%1	Tropical	This Study
'Coeligena_coeligena'       7.1     0.19	0;%6	Tropical	This Study
'Coeligena_violifer'        7.8     0.14	0;%23 Tropical	This Study
'Pterophanes_cyanopterus'	10.8	0.11	0;%1	Tropical	This Study
'Sephanoides_sephaniodes'	5.7     0.10	1;%N/A	Temperate	McKechnie & Wolf 2004
'Heliangelus_amethysticollis'   5.8	0.15	0;%14	Tropical	This Study
'Haplophaedia_aureliae'      4.8	0.14	0;%3	Tropical	This Study
'Ocreatus_underwoodii'       3.3	0.08	0;%2	Tropical	This Study
'Ramphomicron_microrhynchum' 3.9	0.08	0;%1	Tropical	This Study
'Metallura_tyrianthina'      3.8	0.10	0;%17	Tropical	This Study
'Chalcostigma_ruficeps'      3.6	0.15	0;%7	Tropical	This Study
'Schistes_geoffroyi'         4.8	0.18	0;%3	Tropical	This Study
'Chaetocercus_mulsant'       3.6	0.07	0;%1	Tropical	This Study
'Colius_striatus'           51.0	0.24	0;%N/A	Tropical	McKechnie & Wolf 2004
'Colius_colius'             35.1	0.18	1;%N/A	Temperate	McKechnie & Wolf 2004
'Trogon_personatus'         59.0	0.83	0;%1	Tropical	This Study
'Dacelo_novaeguineae'      336.0	1.12	1;%N/A	Temperate	White et al. 2007
'Chloroceryle_aenea'        11.8	0.17    0;%N/A	Tropical	Wiersma et al. 2007
'Todus_mexicanus'            6.1	0.11	0;%N/A	Tropical	White et al. 2007
'Momotus_momota'            123.1	0.52	0;%2	Tropical	This Study
'Momotus_momota'            102.4	0.49	0;%N/A	Tropical	Wiersma et al. 2007
'Momotus_aequatorialis' 	158.5	0.58	0;%1	Tropical	This Study
'Baryphthengus_martii'      127.1	0.55	0;%3	Tropical	This Study
'Merops_viridis'             33.8	0.30	0;%N/A	Tropical	McKechnie & Wolf 2004
'Phoeniculus_purpureus' 	74.1	0.17	0;%N/A	Tropical	McKechnie & Wolf 2004
'Galbula_cyanescens'        24.0	0.23	0;%2	Tropical	This Study
'Notharchus_macrorhynchos'	43.2	0.32	0;%N/A	Tropical	Wiersma et al. 2007
'Bucco_macrodactylus'       23.7	0.18	0;%1	Tropical	This Study
'Malacoptila_semicincta'	47.1	0.33	0;%1	Tropical	This Study
'Malacoptila_fulvogularis'	49.6	0.53	0;%2	Tropical	This Study
'Micromonacha_lanceolata' 	21.9	0.36	0;%1	Tropical	This Study
'Monasa_nigrifrons'         86.0	0.46	0;%5	Tropical	This Study
'Monasa_morphoeus'          67.5	0.45	0;%2	Tropical	This Study
'Aulacorhynchus_prasinus'	137.0	0.98	0;%2	Tropical	This Study
'Selenidera_reinwardtii'	173.6	1.20	0;%1	Tropical	This Study
'Andigena_hypoglauca'       282.9	1.71	0;%1	Tropical	This Study
'Picumnus_rufiventris'      21.9	0.26	0;%2	Tropical	This Study
'Melanerpes_formicivorus'	73.1	0.74	1;%N/A	Temperate	Wiersma et al. 2007
'Melanerpes_rubricapillus' 	48.7	0.54	0;%N/A	Tropical	Wiersma et al. 2007
'Dryobates_pubescens'       21.7	0.38	1;%N/A	Temperate	McKechnie & Wolf 2004
'Dryobates_pubescens'       24.1	0.41	1;%N/A	Temperate	White et al. 2007
'Veniliornis_nigriceps'     43.4	0.49	0;%3	Tropical	This StudY
'Colaptes_rivolii'          81.5	0.93	0;%3	Tropical	This Study
'Celeus_loricatus'          83.1	0.69	0;%N/A	Tropical	Wiersma et al. 2007
'Celeus_spectabilis'        113.0	0.98	0;%1	Tropical	This Study
'Micrastur_ruficollis'      304.1	0.72	0;%1	Tropical	This Study
'Micrastur_gilvicollis'     170.5	1.04	0;%1	Tropical	This Study
'Falco_sparverius'          111.6	1.13	1;%6	Temperate	UCR
'Calyptorhynchus_banksii'	535.5	2.97	1;%N/A	Temperate	White et al. 2007
'Eolophus_roseicapilla'     268.7	1.25	1;%N/A	Temperate	McKechnie & Wolf 2004
'Cacatua_tenuirostris'      549.9	3.17	1;%N/A	Temperate	McKechnie & Wolf 2004
'Cacatua_galerita'          776.1	3.42	1;%N/A	Temperate	McKechnie & Wolf 2004
'Nymphicus_hollandicus' 	96.8	0.66	0;%6	Tropical	UCR
'Trichoglossus_haematodus'	137.1	1.19	0;%N/A	Tropical	White et al. 2007
'Barnardius_zonarius'       131.8	0.79	1;%N/A	Temperate	White et al. 2007
'Neopsephotus_bourkii'      35.0	0.29	1;%1	Temperate	UCR
'Neophema_petrophila'       48.4	0.63	1;%N/A	Temperate	White et al. 2007
'Melopsittacus_undulatus'	42.8	0.36	1;%6	Temperate	UCR
'Agapornis_roseicollis' 	48.3	0.36	1;%6	Temperate	UCR
'Bolborhynchus_orbygnesius' 46.4	0.38	0;%3	Tropical	This Study
'Brotogeris_jugularis'      63.5	0.58	0;%N/A	Tropical	Wiersma et al. 2007
'Asthenes_helleri'          15.0	0.19	0;%4	Tropical	This Study
'Synallaxis_azarae'         13.6	0.23	0;%9	Tropical	This Study
'Synallaxis_cabanisi'       19.3	0.30	0;%3	Tropical	This Study
'Cranioleuca_marcapatae'	19.0	0.28	0;%6	Tropical	This Study
'Premnoplex_brunnescens'	15.7	0.32	0;%17	Tropical	This Study
'Margarornis_squamiger'     16.7	0.27	0;%15	Tropical	This Study
'Pseudocolaptes_boissonneautii' 42.9 0.55	0;%1	Tropical	This Study
'Anabacerthia_striaticollis' 24.2   0.35	0;%8	Tropical	This Study
'Syndactyla_ucayalae'       51.2	0.61	0;%1	Tropical	This Study
'Ancistrops_strigilatus'	36.0	0.22	0;%1	Tropical	This Study
'Automolus_subulatus'       30.2	0.49	0;%1	Tropical	This Study
'Neophilydor_erythrocercum' 38.2	0.42	0;%1	Tropical	This Study
'Anabazenops_dorsalis'      39.2	0.45	0;%1	Tropical	This Study
'Thripadectes_melanorhynchus' 47.5	0.54	0;%14	Tropical	This Study
'Thripadectes_holostictus' 	42.5	0.38	0;%5	Tropical	This Study
'Automolus_ochrolaemus'     36.7	0.63	0;%1	Tropical	This Study
'Automolus_melanopezus'     31.6	0.38	0;%1	Tropical	This Study
'Automolus_rufipileatus'	36.2	0.46	0;%5	Tropical	This Study
'Sclerurus_mexicanus'       28.8	0.44	0;%3	Tropical	This Study
'Sclerurus_caudacutus'      36.2	0.46	0;%4	Tropical	This Study
'Lochmias_nematura'         30.5	0.34	0;%3	Tropical	This Study
'Xenops_minutus'            12.7	0.18	0;%1	Tropical	This Study
'Dendrocincla_tyrannina'	58.3	0.53	0;%2	Tropical	This Study
'Dendrocincla_fuliginosa'	33.1	0.37	0;%9	Tropical	This Study
'Dendrocincla_merula'       52.8	0.62	0;%11	Tropical	This Study
'Sittasomus_griseicapillus'	14.4	0.27	0;%1	Tropical	This Study
'Glyphorynchus_spirurus'	15.5	0.25	0;%21	Tropical	This Study
'Dendrocolaptes_picumnus'	80.2	0.72	0;%1	Tropical	This Study
'Xiphorhynchus_elegans'     41.4	0.51	0;%9	Tropical	This Study
'Xiphorhynchus_guttatus'	60.1	0.52	0;%7	Tropical	This Study
'Xiphorhynchus_triangularis' 44.1	0.60	0;%7	Tropical	This Study
'Lepidocolaptes_lacrymiger'	32.6	0.22	0;%1	Tropical	This Study
'Thamnophilus_doliatus'     26.2	0.29	0;%N/A	Tropical	Wiersma et al. 2007
'Thamnophilus_palliatus'	27.8	0.49	0;%1	Tropical	This Study
'Thamnophilus_atrinucha'	20.5	0.28	0;%N/A	Tropical	Wiersma et al. 2007
'Thamnophilus_punctatus'	21.0	0.34	0;%N/A	Tropical	Wiersma et al. 2007
'Thamnomanes_ardesiacus'	19.3	0.27	0;%9	Tropical	This Study
'Thamnomanes_schistogynus'	19.7	0.34	0;%3	Tropical	This Study
'Epinecrophylla_leucophthalma' 9.4	0.19	0;%8	Tropical	This Study
'Isleria_hauxwelli'         10.8	0.21	0;%9	Tropical	This Study
'Myrmotherula_axillaris'	8.9     0.19	0;%4	Tropical	This Study
'Myrmotherula_schisticolor'	8.3     0.25	0;%2	Tropical	This Study
'Myrmotherula_longipennis'	9.6     0.22	0;%1	Tropical	This Study
'Myrmotherula_menetriesii'	9.3     0.28	0;%2	Tropical	This Study
'Drymophila_caudata'        12.2	0.14	0;%1	Tropical	This Study
'Cercomacroides_tyrannina'	15.4	0.19	0;%N/A	Tropical	Wiersma et al. 2007
'Pyriglena_leuconota'       32.1	0.55	0;%4	Tropical	This Study
'Myrmoborus_leucophrys'     19.8	0.33	0;%1	Tropical	This Study
'Myrmoborus_myotherinus'	21.2	0.28	0;%3	Tropical	This Study
'Hypocnemis_subflava'       15.6	0.24	0;%3	Tropical	This Study
'Myrmoborus_lophotes'       31.6	0.33	0;%3	Tropical	This Study
'Myrmelastes_leucostigma'	17.8	0.18	0;%1	Tropical	This Study
'Myrmeciza_longipes'        27.4	0.33	0;%N/A	Tropical	Wiersma et al. 2007
'Poliocrania_exsul'         28.3	0.29	0;%N/A	Tropical	Wiersma et al. 2007
'Sciaphylax_hemimelaena'	18.0	0.25	0;%5	Tropical	This Study
'Akletos_goeldii'           42.4	0.42	0;%4	Tropical	This Study
'Gymnopithys_bicolor'       27.7	0.33	0;%N/A	Tropical	Wiersma et al. 2007
'Oneillornis_salvini'       27.1	0.32	0;%7	Tropical	This Study
'Rhegmatorhina_melanosticta' 42.2	0.41	0;%1	Tropical	This Study
'Hylophylax_naevioides'     16.1	0.24	0;%N/A	Tropical	Wiersma et al. 2007
'Hylophylax_naevius'        12.8	0.35	0;%1	Tropical	This Study
'Willisornis_poecilinotus'	22.3	0.39	0;%4	Tropical	This Study
'Phlegopsis_nigromaculata'	47.1	0.48	0;%2	Tropical	This Study
'Formicarius_analis'        54.9	0.62	0;%3	Tropical	This Study
'Formicarius_rufipectus' 	70.3	0.73	0;%1	Tropical	This Study
'Grallaria_guatimalensis'	87.0	0.62	0;%1	Tropical	This Study
'Grallaria_rufula'          33.8	0.52	0;%1	Tropical	This Study
'Conopophaga_peruviana' 	24.5	0.34	0;%4	Tropical	This Study
'Conopophaga_ardesiaca'     27.5	0.39	0;%15	Tropical	This Study
'Scytalopus_atratus'        21.5	0.38	0;%4	Tropical	This Study
'Scytalopus_parvirostris'	17.0	0.36	0;%3	Tropical	This Study
'Elaenia_albiceps'          16.8	0.19	0;%3	Tropical	This Study
'Elaenia_gigas'             30.7	0.41	0;%1	Tropical	This Study
'Elaenia_obscura'           13.9	0.14	0;%1	Tropical	This Study
'Elaenia_pallatangae'       15.7	0.23	0;%17	Tropical	This Study
'Camptostoma_obsoletum'     12.5	0.26	0;%N/A	Tropical	Wiersma et al. 2007
'Mecocerculus_leucophrys'	13.9	0.15	0;%3	Tropical	This Study
'Mecocerculus_stictopterus'	10.9	0.22	0;%1	Tropical	This Study
'Anairetes_parulus'          6.6	0.15	0;%2	Tropical	This Study
'Corythopis_torquatus'      18.7	0.28	0;%5	Tropical	This Study
'Zimmerius_bolivianus'      11.0	0.28	0;%2	Tropical	This Study
'Pogonotriccus_ophthalmicus' 8.8	0.24	0;%2	Tropical	This Study
'Mionectes_striaticollis' 	14.7	0.27	0;%38	Tropical	This Study
'Mionectes_olivaceus'       15.7	0.28	0;%21	Tropical	This Study
'Mionectes_oleagineus'      11.4	0.18	0;%7	Tropical	This Study
'Mionectes_oleagineus'      10.3	0.16	0;%N/A	Tropical	Wiersma et al. 2007
'Mionectes_macconnelli'     11.4	0.16	0;%14	Tropical	This Study
'Leptopogon_amaurocephalus' 14.1	0.22	0;%6	Tropical	This Study
'Leptopogon_superciliaris'	12.9	0.25	0;%9	Tropical	This Study
'Hemitriccus_granadensis' 	8.2 	0.14	0;%2	Tropical	This Study
'Lophotriccus_pileatus'     8.2     0.19	0;%2	Tropical	This Study
'Todirostrum_cinereum'      7.3     0.17	0;%N/A	Tropical	Wiersma et al. 2007
'Cnipodectes_subbrunneus'	20.5	0.27	0;%N/A	Tropical	Wiersma et al. 2007
'Rhynchocyclus_olivaceus'	21.0	0.30	0;%N/A	Tropical	Wiersma et al. 2007
'Rhynchocyclus_fulvipectus'	26.0	0.39	0;%3	Tropical	This Study
'Platyrinchus_coronatus'	10.8	0.16	0;%2	Tropical	This Study
'Platyrinchus_platyrhynchos' 14.0	0.30	0;%1	Tropical	This Study
'Pyrrhomyias_cinnamomeus'	10.7	0.20	0;%4	Tropical	This Study
'Lathrotriccus_euleri'       9.3	0.21	0;%1	Tropical	This Study
'Sayornis_phoebe'           21.6	0.34	1;%N/A	Temperate	McKechnie & Wolf 2004
'Sayornis_phoebe'           21.6	0.34	1;%N/A	Temperate	Wiersma et al. 2007
'Contopus_sordidulus'       12.5	0.56	1;%1	Temperate	This Study
'Contopus_virens'           13.9	0.26	1;%N/A	Temperate	Wiersma et al. 2007
'Empidonax_virescens'       12.3	0.18	1;%N/A	Temperate	Wiersma et al. 2007
'Knipolegus_aterrimus'      34.0	0.31	0;%1	Tropical	This Study
'Syrtidicola_fluviatilis'	13.6	0.26	0;%1	Tropical	This Study
'Myiotheretes_fuscorufus' 	29.2	0.52	0;%1	Tropical	This Study
'Silvicultrix_spodionota' 	10.7	0.17	0;%1	Tropical	This Study
'Silvicultrix_pulchella'	12.0	0.17	0;%6	Tropical	This Study
'Ochthoeca_rufipectoralis' 	10.9	0.20	0;%6	Tropical	This Study
'Legatus_leucophaius'       26.7	0.16	0;%1	Tropical	This Study
'Myiozetetes_similis'       27.1	0.29	0;%1	Tropical	This Study
'Myiodynastes_maculatus'	41.0	0.59	0;%N/A	Tropical	Wiersma et al. 2007
'Tyrannus_melancholicus'	38.0	0.36	0;%N/A	Tropical	Wiersma et al. 2007
'Tyrannus_tyrannus'         36.1	0.36	1;%2	Temperate	This Study
'Myiarchus_crinitus'        33.9	0.38	1;%N/A	Temperate	McKechnie & Wolf 2004
'Myiarchus_crinitus'        33.9	0.38	1;%N/A	Temperate	Wiersma et al. 2007
'Ramphotrigon_fuscicauda'	17.4	0.28	0;%1	Tropical	This Study
'Attila_spadiceus'          32.7	0.14	0;%1	Tropical	This Study
'Pipreola_intermedia'       49.6	0.61	0;%2	Tropical	This Study
'Pipreola_arcuata'          93.0	0.60	0;%1	Tropical	This Study
'Rupicola_peruvianus'       246.5	1.08	0;%3	Tropical	This Study
'Lipaugus_vociferans'       86.6	0.76	0;%1	Tropical	This Study
'Machaeropterus_pyrocephalus' 10.0	0.24	0;%2	Tropical	This Study
'Lepidothrix_coronata'      10.6	0.20	0;%20	Tropical	This Study
'Lepidothrix_coeruleocapilla' 9.6	0.24	0;%8	Tropical	This Study
'Manacus_vitellinus'        15.5	0.23	0;%N/A	Tropical	McKechnie & Wolf 2004
'Chiroxiphia_lanceolata' 	18.4	0.34	0;%N/A	Tropical	Wiersma et al. 2007
'Chiroxiphia_boliviana'     17.0	0.30	0;%11	Tropical	This Study
'Cryptopipo_holochlora' 	16.0	0.21	0;%1	Tropical	This Study
'Pipra_fasciicauda'         16.4	0.26	0;%38	Tropical	This Study
'Ceratopipra_mentalis'      12.3	0.19	0;%N/A	Tropical	White et al. 2007
'Ceratopipra_chloromeros' 	16.2	0.29	0;%20	Tropical	This Study
'Onychorhynchus_coronatus'	14.0	0.30	0;%2	Tropical	This Study
'Myiobius_villosus'         14.7	0.30	0;%1	Tropical	This Study
'Terenotriccus_erythrurus'   9.3	0.24	0;%2	Tropical	This Study
'Gliciphila_melanops'       18.8	0.29	1;%N/A	Temperate	McKechnie & Wolf 2004
'Acanthorhynchus_tenuirostris' 9.7	0.25	1;%N/A	Temperate	McKechnie & Wolf 2004
'Lichmera_indistincta'       9.0	0.21	1;%N/A	Temperate	McKechnie & Wolf 2004
'Phylidonyris_novaehollandiae' 17.3 0.32	1;%N/A	Temperate	McKechnie & Wolf 2004
'Melithreptus_lunatus'      14.3	0.25	1;%N/A	Temperate	McKechnie & Wolf 2004
'Gavicalis_virescens'       25.0	0.35	1;%N/A	Temperate	McKechnie & Wolf 2004
'Lanius_collurio'           27.0	0.38	1;%N/A	Temperate	Wiersma et al. 2007
'Lanius_excubitor'          61.8	0.56	1;%N/A	Temperate	Wiersma et al. 2007
'Vireo_olivaceus'           16.2	0.24	1;%N/A	Temperate	Wiersma et al. 2007
'Vireo_flavoviridis'        15.9	0.28	0;%N/A	Tropical	Wiersma et al. 2007
'Oriolus_oriolus'           64.9	0.65	1;%N/A	Temperate	Wiersma et al. 2007
'Cyanolyca_viridicyanus'	82.6	1.07	0;%2	Tropical	This Study
'Pica_pica'                 158.9	1.20	1;%N/A	Temperate	McKechnie & Wolf 2004
'Pica_nuttalli'             151.9	1.47	1;%N/A	Temperate	McKechnie & Wolf 2004
'Poecile_atricapillus'  	10.3	0.25	1;%N/A	Temperate	McKechnie & Wolf 2004
'Parus_major'               18.5	0.38	1;%N/A	Temperate	White et al. 2007
'Alaemon_alaudipes'         37.7	0.43	1;%N/A	Temperate	McKechnie & Wolf 2004
'Chersomanes_albofasciata'	25.7	0.34	0;%N/A	Tropical	White et al. 2007
'Ammomanes_deserti'         21.5	0.23	1;%N/A	Temperate	White et al. 2007
'Eremopterix_nigriceps' 	15.2	0.19	1;%N/A	Temperate	White et al. 2007
'Calendulauda_erythrochlamys' 27.3	0.41	1;%N/A	Temperate	McKechnie & Wolf 2004
'Mirafra_erythroptera'      27.3	0.42	0;%N/A	Tropical	White et al. 2007
'Lullula_arborea'           25.5	0.57	1;%N/A	Temperate	Wiersma et al. 2007
'Alauda_arvensis'           31.7	0.72	1;%N/A	Temperate	McKechnie & Wolf 2004
'Galerida_cristata'         31.2	0.37	1;%N/A	Temperate	White et al. 2007
'Eremophila_alpestris'      26.0	0.45	1;%N/A	Temperate	White et al. 2007
'Calandrella_brachydactyla'	24.0	0.41	1;%N/A	Temperate	White et al. 2007
'Melanocorypha_calandra'	50.6	0.57	1;%N/A	Temperate	White et al. 2007
'Eremalauda_dunni'          20.6	0.28	1;%N/A	Temperate	McKechnie & Wolf 2004
'Alaudala_rufescens'        23.6	0.37	1;%N/A	Temperate	White et al. 2007
'Pycnonotus_finlaysoni'     26.3	0.22	0;%N/A	Tropical	McKechnie & Wolf 2004
'Pycnonotus_goiavier'       28.6	0.25	0;%N/A	Tropical	McKechnie & Wolf 2004
'Riparia_riparia'           13.6	0.23	1;%N/A	Temperate	Wiersma et al. 2007
'Tachycineta_bicolor'       16.4	0.29	1;%N/A	Temperate	Wiersma et al. 2007
'Tachycineta_albilinea' 	11.7	0.25	0;%N/A	Tropical	Wiersma et al. 2007
'Progne_chalybea'           34.9	0.47	0;%N/A	Tropical	Wiersma et al. 2007
'Stelgidopteryx_ruficollis'	14.0	0.22	0;%2	Tropical	This Study
'Hirundo_tahitica'          14.1	0.18	0;%N/A	Tropical	McKechnie & Wolf 2004
'Psaltriparus_minimus'       5.5	0.12	1;%N/A	Temperate	McKechnie & Wolf 2004
'Phylloscopus_trochilus'	10.7	0.21	1;%N/A	Temperate	Wiersma et al. 2007
'Phylloscopus_collybita'     8.2	0.17	1;%N/A	Temperate	Wiersma et al. 2007
'Acrocephalus_arundinaceus'	21.9	0.26	1;%N/A	Temperate	McKechnie & Wolf 2004
'Acrocephalus_schoenobaenus' 11.5	0.22	1;%N/A	Temperate	Wiersma et al. 2007
'Acrocephalus_palustris'	10.8	0.20	1;%N/A	Temperate	Wiersma et al. 2007
'Hippolais_icterina'        12.5	0.25	1;%N/A	Temperate	Wiersma et al. 2007
'Sylvia_atricapilla'        21.9	0.42	1;%N/A	Temperate	Wiersma et al. 2007
'Sylvia_borin'              24.8	0.42	1;%N/A	Temperate	Wiersma et al. 2007
'Curruca_curruca'           10.6	0.20	1;%N/A	Temperate	Wiersma et al. 2007
'Zosterops_lateralis'       11.0	0.15	1;%N/A	Temperate	McKechnie & Wolf 2004
'Cinnycerthia_fulva'        16.3	0.20	0;%4	Tropical	This Study
'Pheugopedius_fasciatoventris' 27.2	0.31	0;%N/A	Tropical	Wiersma et al. 2007
'Thryophilus_rufalbus'      22.6	0.30	0;%N/A	Tropical	Wiersma et al. 2007
'Cantorchilus_leucotis'     18.0	0.21	0;%N/A	Tropical	Wiersma et al. 2007
'Thryothorus_ludovicianus'	20.1	0.36	1;%N/A	Temperate	Wiersma et al. 2007
'Troglodytes_aedon_aedon'	10.2	0.21	1;%N/A	Temperate	Wiersma et al. 2007: Troglodytes_aedon_aedon
'Troglodytes_aedon_musculus' 13.3	0.21	0;%N/A	Tropical	Wiersma et al. 2007: Troglodytes_aedon_musculus
'Troglodytes_solstitialis'	13.0	0.27	0;%2	Tropical	This Study
'Henicorhina_leucophrys'	15.3	0.31	0;%6	Tropical	This Study
'Microcerculus_marginatus'	19.4	0.33	0;%3	Tropical	This Study
'Cyphorhinus_thoracicus' 	34.4	0.42	0;%13	Tropical	This Study
'Sitta_carolinensis'        19.4	0.36	1;%N/A	Temperate	White et al. 2007
'Mimus_polyglottos'         44.2	0.68	1;%N/A	Temperate	Wiersma et al. 2007
'Mimus_gilvus'              68.9	0.74	0;%N/A	Tropical	Wiersma et al. 2007
'Acridotheres_cristatellus'	109.4	1.21	0;%N/A	Tropical	White et al. 2007
'Sturnus_vulgaris'          85.0	1.25	1;%N/A	Temperate	White et al. 2007
'Sialia_mexicana'           27.5	0.42	1;%N/A	Temperate	McKechnie & Wolf 2004
'Myadestes_ralloides'       28.8	0.39	0;%7	Tropical	This Study
'Catharus_dryas'            35.9	0.46	0;%9	Tropical	This Study
'Catharus_ustulatus'        28.2	0.43	1;%38	Temperate	This Study
'Entomodestes_leucotis'     60.7	0.26	0;%1	Tropical	This Study
'Turdus_leucops'            62.2	0.71	0;%1	Tropical	This Study
'Turdus_fuscater'           138.0	0.96	0;%1	Tropical	This Study
'Turdus_chiguanco'          87.0	0.54	0;%4	Tropical	This Study
'Turdus_serranus'           81.2	0.97	0;%4	Tropical	This Study
'Turdus_nigriceps'          51.1	0.53	0;%5	Tropical	This Study
'Turdus_ignobilis'          56.6	0.41	0;%1	Tropical	This Study
'Turdus_lawrencii'          55.3	0.67	0;%1	Tropical	This Study
'Turdus_hauxwelli'          63.3	0.50	0;%4	Tropical	This Study
'Turdus_grayi'              77.9	0.68	0;%N/A	Tropical	Wiersma et al. 2007
'Turdus_albicollis'     	51.3	0.46	0;%15	Tropical	This Study
'Turdus_migratorius'        62.4	0.76	1;%N/A	Temperate	Wiersma et al. 2007
'Copsychus_saularis'        33.5	0.23	0;%N/A	Tropical	McKechnie & Wolf 2004
'Muscicapa_striata'         14.4	0.25	1;%N/A	Temperate	Wiersma et al. 2007
'Larvivora_cyane'           13.4	0.17	1;%N/A	Temperate	White et al. 2007
'Luscinia_svecica'          15.5	0.28	1;%N/A	Temperate	White et al. 2007
'Luscinia_svecica'          19.9	0.26	1;%N/A	Temperate	White et al. 2007
'Phoenicurus_phoenicurus'	13.0	0.23	1;%N/A	Temperate	Wiersma et al. 2007
'Cinnyris_venustus'          7.1	0.14	0;%N/A	Tropical	McKechnie & Wolf 2004
'Aethopyga_christinae'       5.2	0.12	0;%N/A	Tropical	McKechnie & Wolf 2004
'Passer_domesticus'         23.5	0.31	1;%30	Temperate	UCR
'Passer_montanus'           17.5	0.20	1;%N/A	Temperate	White et al. 2007
'Ploceus_aurantius'         18.7	0.22	0;%6	Tropical	UCR
'Amadina_erythrocephala'	22.4	0.21	0;%N/A	Tropical	McKechnie & Wolf 2004
'Amadina_fasciata'          17.2	0.21	0;%N/A	Tropical	McKechnie & Wolf 2004
'Amadina_fasciata'          18.2	0.23	0;%4	Tropical	UCR
'Estrilda_melpoda'           7.5	0.13	0;%N/A	Tropical	McKechnie & Wolf 2004
'Taeniopygia_guttata'       14.1	0.12	1;%6	Temperate	UCR
'Spermestes_cucullata'      10.6	0.08	1;%N/A	Temperate	McKechnie & Wolf 2004
'Spermestes_fringilloides' 	19.8	0.23	1;%4	Temperate	UCR
'Lonchura_fuscans'           9.5	0.10	0;%N/A	Tropical	McKechnie & Wolf 2004
'Lonchura_punctulata'       14.5	0.19	0;%5	Tropical	UCR
'Lonchura_malacca'          11.8	0.14	0;%N/A	Tropical	McKechnie & Wolf 2004
'Lonchura_maja'             12.8	0.15	0;%N/A	Tropical	McKechnie & Wolf 2004
'Lonchura_oryzivora'        25.4	0.31	0;%N/A	Tropical	McKechnie & Wolf 2004
'Vidua_macroura'            13.8	0.13	0;%2	Tropical	UCR
'Motacilla_flava'           14.7	0.26	1;%N/A	Temperate	Wiersma et al. 2007
'Anthus_campestris'     	21.8	0.38	1;%N/A	Temperate	Wiersma et al. 2007
'Anthus_pratensis'          18.9	0.30	1;%N/A	Temperate	Wiersma et al. 2007
'Anthus_trivialis'          19.7	0.34	1;%N/A	Temperate	Wiersma et al. 2007
'Fringilla_montifringilla'	21.0	0.38	1;%N/A	Temperate	Wiersma et al. 2007
'Loxioides_bailleui'        36.0	0.46	0;%N/A	Tropical	McKechnie & Wolf 2004
'Himatione_sanguinea'       13.5	0.30	0;%N/A	Tropical	McKechnie & Wolf 2004
'Haemorhous_cassinii'       26.8	0.37	1;%N/A	Temperate	Wiersma et al. 2007
'Haemorhous_mexicanus'      20.4	0.31	1;%N/A	Temperate	McKechnie & Wolf 2004
'Acanthis_flammea'          16.0	0.24	1;%N/A	Temperate	White et al. 2007
'Serinus_canaria'           19.5	0.14	1;%2	Temperate	UCR
'Spinus_tristis'            12.8	0.33	1;%N/A	Temperate	White et al. 2007
'Spinus_pinus'              13.8	0.35	1;%N/A	Temperate	Wiersma et al. 2007
'Spinus_magellanicus'       11.6	0.20	0;%1	Tropical	This Study
'Euphonia_laniirostris'     13.5	0.29	0;%N/A	Tropical	Wiersma et al. 2007
'Euphonia_xanthogaster' 	12.9	0.22	0;%13	Tropical	This Study
'Seiurus_aurocapilla'       19.0	0.24	1;%N/A	Temperate	White et al. 2007
'Parkesia_noveboracensis'	18.7	0.28	1;%N/A	Temperate	White et al. 2007
'Vermivora_cyanoptera'       7.8	0.15	1;%N/A	Temperate	Wiersma et al. 2007
'Protonotaria_citrea'       12.8	0.20	1;%N/A	Temperate	McKechnie & Wolf 2004
'Geothlypis_trichas'        10.6	0.17	1;%N/A	Temperate	White et al. 2007
'Setophaga_citrina'         12.0	0.22	1;%N/A	Temperate	White et al. 2007
'Setophaga_americana'        7.0	0.12	1;%N/A	Temperate	White et al. 2007
'Setophaga_petechia'        12.2	0.14	0;%N/A	Tropical	Wiersma et al. 2007: Setophaga_petechia_erithachorides
'Setophaga_petechia'         8.9	0.20	1;%N/A	Temperate	Wiersma et al. 2007: Setophaga_petechia_petechia
'Setophaga_palmarum'         9.8	0.16	1;%N/A	Temperate	Wiersma et al. 2007
'Setophaga_pinus'           12.0	0.18	1;%N/A	Temperate	Wiersma et al. 2007
'Setophaga_coronata'        11.5	0.19	1;%N/A	Temperate	Wiersma et al. 2007
'Setophaga_dominica'         9.8	0.16	1;%N/A	Temperate	McKechnie & Wolf 2004
'Myiothlypis_luteoviridis'	14.7	0.24	0;%12	Tropical	This Study
'Myiothlypis_signata'       14.3	0.22	0;%2	Tropical	This Study
'Myiothlypis_fulvicauda'	12.8	0.35	0;%1	Tropical	This Study
'Myiothlypis_bivittata'     15.5	0.30	0;%11	Tropical	This Study
'Myiothlypis_chrysogaster'	14.4	0.28	0;%2	Tropical	This Study
'Myiothlypis_coronata'      17.4	0.33	0;%13	Tropical	This Study
'Basileuterus_tristriatus'	12.6	0.25	0;%11	Tropical	This Study
'Myioborus_miniatus'         9.8	0.20	0;%6	Tropical	This Study
'Myioborus_melanocephalus'	11.7	0.21	0;%11	Tropical	This Study
'Cacicus_chrysonotus'       94.0	0.85	0;%1	Tropical	This Study
'Amblycercus_holosericeus'	50.4	0.57	0;%4	Tropical	This Study
'Icterus_galbula'           37.5	0.50	1;%N/A	Temperate	Wiersma et al. 2007
'Agelaius_phoeniceus'       47.1	0.56	1;%N/A	Temperate	Wiersma et al. 2007
'Quiscalus_quiscula'        92.2	0.99	1;%N/A	Temperate	Wiersma et al. 2007
'Quiscalus_mexicanus'       137.3	1.13	0;%N/A	Tropical	Wiersma et al. 2007
'Leistes_militaris'         38.2	0.44	0;%N/A	Tropical	Wiersma et al. 2007
'Coereba_flaveola'          11.0	0.24	0;%3	Tropical	This Study
'Emberiza_schoeniclus'      17.6	0.30	1;%N/A	Temperate	Wiersma et al. 2007
'Melospiza_melodia'         19.0	0.27	1;%N/A	Temperate	McKechnie & Wolf 2004
'Melospiza_georgiana'       14.9	0.21	1;%N/A	Temperate	McKechnie & Wolf 2004
'Zonotrichia_capensis'      22.2	0.31	0;%3	Tropical	This Study
'Zonotrichia_querula'       33.3	0.45	1;%N/A	Temperate	McKechnie & Wolf 2004
'Zonotrichia_leucophrys'	26.1	0.34	1;%N/A	Temperate	McKechnie & Wolf 2004
'Zonotrichia_albicollis'	20.2	0.28	1;%N/A	Temperate	McKechnie & Wolf 2004
'Junco_hyemalis'            18.0	0.30	1;%N/A	Temperate	McKechnie & Wolf 2004
'Passerculus_sandwichensis'	15.9	0.22	1;%N/A	Temperate	McKechnie & Wolf 2004
'Ammodramus_savannarum'     13.8	0.18	1;%N/A	Temperate	McKechnie & Wolf 2004
'Ammodramus_aurifrons'      16.4	0.26	0;%2	Tropical	This Study
'Spizella_passerina'        11.9	0.19	1;%N/A	Temperate	McKechnie & Wolf 2004
'Pooecetes_gramineus'       21.5	0.27	1;%N/A	Temperate	McKechnie & Wolf 2004
'Amphispiza_bilineata'      11.6	0.20	1;%N/A	Temperate	McKechnie & Wolf 2004
'Arremonops_conirostris'	39.7	0.45	0;%N/A	Tropical	Wiersma et al. 2007
'Arremon_taciturnus'        27.7	0.42	0;%4	Tropical	This Study
'Arremon_torquatus'         42.8	0.47	0;%6	Tropical	This Study
'Arremon_castaneiceps'      35.7	0.53	0;%1	Tropical	This Study
'Atlapetes_melanolaemus'	25.5	0.34	0;%20	Tropical	This Study
'Chlorospingus_parvirostris' 23.1	0.33	0;%9	Tropical	This Study
'Chlorospingus_flavigularis' 26.5	0.33	0;%15	Tropical	This Study
'Cissopis_leverianus'       61.4	0.28	0;%1	Tropical	This Study
'Kleinothraupis_atropileus'	20.4	0.38	0;%13	Tropical	This Study
'Thlypopsis_superciliaris'	14.6	0.32	0;%3	Tropical	This Study
'Sphenopsis_melanotis'      17.3	0.32	0;%8	Tropical	This Study
'Pseudospingus_xanthophthalmus' 13.0 0.19	0;%3	Tropical	This Study
'Thlypopsis_sordida'        14.9	0.31	0;%1	Tropical	This Study
'Thlypopsis_ruficeps'       11.9	0.23	0;%5	Tropical	This Study
'Trichothraupis_melanops'	24.9	0.45	0;%9	Tropical	This Study
'Eucometis_penicillata'     30.7	0.39	0;%N/A	Tropical	Wiersma et al. 2007
'Loriotus_luctuosus'        12.5	0.32	0;%1	Tropical	This Study
'Lanio_versicolor'          20.4	0.33	0;%2	Tropical	This Study
'Ramphocelus_dimidiatus'	26.4	0.37	0;%N/A	Tropical	Wiersma et al. 2007
'Ramphocelus_carbo'         26.5	0.29	0;%17	Tropical	This Study
'Ramphocelus_flammigerus'	32.0	0.42	0;%N/A	Tropical	Wiersma et al. 2007
'Thraupis_episcopus'        30.4	0.42	0;%N/A	Tropical	Wiersma et al. 2007
'Thraupis_palmarum'         32.6	0.40	0;%N/A	Tropical	Wiersma et al. 2007
'Sporathraupis_cyanocephala' 38.2	0.46	0;%13	Tropical	This Study
'Rauenia_bonariensis'       34.8	0.56	0;%5	Tropical	This Study
'Buthraupis_montana'        89.7	1.02	0;%9	Tropical	This Study
'Anisognathus_igniventris'	35.0	0.44	0;%24	Tropical	This Study
'Chlorornis_riefferii'      49.8	0.51	0;%8	Tropical	This Study
'Iridosornis_analis'        27.1	0.47	0;%3	Tropical	This Study
'Iridosornis_jelskii'       20.6	0.38	0;%9	Tropical	This Study
'Pipraeidea_melanonota'     20.3	0.38	0;%3	Tropical	This Study
'Chlorochrysa_calliparaea'	16.9	0.25	0;%5	Tropical	This Study
'Tangara_arthus'            22.4	0.37	0;%;5	Tropical	This Study
'Ixothraupis_xanthogastra'	15.1	0.21	0;%1	Tropical	This Study
'Stilpnia_cyanicollis'      16.3	0.35	0;%1	Tropical	This Study
'Stilpnia_larvata'          16.2	0.24	0;%N/A	Tropical	Wiersma et al. 2007
'Tangara_vassorii'          18.5	0.23	0;%3	Tropical	This Study
'Cyanerpes_cyaneus'         13.5	0.27	0;%N/A	Tropical	Wiersma et al. 2007
'Conirostrum_sitticolor'	11.0	0.18	0;%2	Tropical	This Study
'Diglossa_mystacalis'       15.4	0.28	0;%9	Tropical	This Study
'Diglossa_brunneiventris'	10.6	0.24	0;%4	Tropical	This Study
'Diglossa_cyanea'           19.1	0.32	0;%41	Tropical	This Study
'Haplospiza_rustica'        18.0	0.14	0;%1	Tropical	This Study
'Sporophila_americana'      10.2	0.20	0;%N/A	Tropical	Wiersma et al. 2007
'Sporophila_nigricollis'	 8.9	0.20	0;%1	Tropical	This Study
'Sporophila_castaneiventris' 8.5	0.20	0;%4	Tropical	This Study
'Sporophila_angolensis'     12.3	0.20	0;%N/A	Tropical	Wiersma et al. 2007
'Asemospiza_obscura'        12.1	0.16	0;%2	Tropical	This Study
'Catamblyrhynchus_diadema'	17.0	0.25	0;%6	Tropical	This Study
'Habia_rubica'              36.7	0.58	0;%2	Tropical	This Study
'Driophlox_fuscicauda'      40.0	0.36	0;%N/A	Tropical	Wiersma et al. 2007
'Cardinalis_cardinalis'     40.5	0.52	1;%N/A	Temperate	McKechnie & Wolf 2004
'Cardinalis_sinuatus'       32.0	0.39	1;%N/A	Temperate	McKechnie & Wolf 2004
'Saltator_grossus'          49.5	0.44	0;%2	Tropical	This Study
'Saltator_maximus'          44.8	0.55	0;%N/A	Tropical	Wiersma et al. 2007
'Saltator_coerulescens'     47.0	0.39	0;%N/A	Tropical	Wiersma et al. 2007
'Saltator_orenocensis'      32.7	0.31	0;%N/A	Tropical	Wiersma et al. 2007
'Saltator_striatipectus'	42.1	0.51	0;%N/A	Tropical	Wiersma et al. 2007
'Cyanoloxia_cyanoides'      25.0	0.38	0;%3	Tropical	This Study
};
nm = aves(:,1); data = cell2mat(aves(:,2:4)); Ww = data(:,1); JOi= data(:,2); sel = data(:,3);

close all
plot(log10(Ww(sel==0)), log10(JOi(sel==0)), '.b', 'markersize', 10);
hold on
plot(log10(Ww(sel==1)), log10(JOi(sel==1)), '.r', 'markersize', 10);
xlabel('weight, g'); ylabel('BMR, W');
text(1,1,'tropical','color','b');
text(1,1.2,'temperate','color','r');
text(1,1.4,'LondCast2015','color','k');

figure
nm_0 = nm(sel==0); nm_1 = nm(sel==1);
WwJOi_0 = read_stat(nm_0,{'Ww_i','J_Oi'}); Ww_0 = WwJOi_0(:,1); JOi_0 = WwJOi_0(:,2);
WwJOi_1 = read_stat(nm_1,{'Ww_i','J_Oi'}); Ww_1 = WwJOi_1(:,1); JOi_1 = WwJOi_1(:,2);

plot(log10(Ww_0), log10(JOi_0), '.b', 'markersize', 10);
hold on
plot(log10(Ww_1), log10(JOi_1), '.r', 'markersize', 10);
xlabel('weight W_w^\infty, g'); ylabel('BMR, mol O_2/d');
text(1,1,'tropical','color','b');
text(1,1.2,'temperate','color','r');
text(1,1.4,'AmP','color','k');

figure
nm_0 = nm(sel==0); nm_1 = nm(sel==1);
pM_0 = read_stat(nm_0,{'p_M'}); pM_1 = read_stat(nm_1,{'p_M'});

plot(log10(Ww_0), log10(pM_0), '.b', 'markersize', 10);
hold on
plot(log10(Ww_1), log10(pM_1), '.r', 'markersize', 10);
xlabel('weight W_w^\infty, g'); ylabel('[p_M], J/d.cm^3');
text(3.5,3.5,'tropical','color','b');
text(3.5,3.7,'temperate','color','r');
text(3.5,3.9,'AmP','color','k');
