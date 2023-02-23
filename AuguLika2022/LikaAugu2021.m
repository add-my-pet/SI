function LikaAugu2021(fig)
% figures for LikaAugu2021 on ray-finned fish

if ~exist('fig','var')
   fig = 1:21;
end

llegend = {... % Pisces 
  {'-', 2, [0 0 0]}, 'Cyclostomata'; ....
  {'-', 2, [0 0 1]}, 'Chondrichthyes'; ....
  {'-', 2, [1 0 1]}, 'Actinopterygii'; ....
  {'-', 2, [1 0 0]}, 'CL-group'; ....
  {'-', 2, [0 1 0]}, 'Tetrapoda'; ....
 };

 legend = {... % Actinopterygii
    % 
    {'o', 8, 3, [0 0 0], [0 0 0]}, 'Polypteriformes'; ...
    {'o', 8, 3, [0 0 0], [1 1 1]}, 'Acipenseriformes'; ...
    % 
    {'o', 8, 3, [0 0 1], [0 0 0]}, 'Holostei'; ....   
    {'o', 8, 3, [0 0 1], [0 0 1]}, 'Elopocephalai'; ....
    {'o', 8, 3, [0 0 1], [1 0 1]}, 'Osteoglossocephala'; ....
    {'o', 8, 3, [0 0 1], [1 0 0]}, 'Otomorpha'; ....     
    {'o', 8, 3, [0 0 1], [1 1 1]}, 'Lepidogalaxii'; ....  
    % 
    {'o', 8, 3, [1 0 1], [0 0 0]}, 'Protacanthopterygii'; ....
    {'o', 8, 3, [1 0 1], [0 0 1]}, 'Stomiati'; ....
    {'o', 8, 3, [1 0 1], [1 0 1]}, 'Aulopa'; ....
    {'o', 8, 3, [1 0 1], [1 0 0]}, 'Myctophata'; ....
    {'o', 8, 3, [1 0 1], [1 1 1]}, 'Lampridacea'; ....
    %
    {'o', 8, 3, [1 0 0], [0 0 0]}, 'Paracanthomorphacea'; ....
    {'o', 8, 3, [1 0 0], [0 0 1]}, 'Polymixiacea'; ....
    {'o', 8, 3, [1 0 0], [1 0 1]}, 'Berycimorphaceae'; ...
    {'o', 8, 3, [1 0 0], [1 0 0]}, 'Holocentrimorphaceae'; ...
    {'o', 8, 3, [1 0 0], [1 1 1]}, 'Percomorphaceae'; ...
    % other Pisces
    {'.', 8, 8, [0 0 0], [0 0 0]}, 'Cyclostomata'; ...
    {'.', 8, 8, [0 0 1], [0 0 0]}, 'Chondrichthyes'; ...
    {'.', 8, 8, [1 0 0], [0 0 0]}, 'CL-group'; ...
    {'.', 8, 8, [0 1 0], [0 0 0]}, 'Tetrapoda'; ...
 };

 taxa = { ...
   'Cladistii'
   'Chondrostei'
   'Holostei'
   'Elopocephalai'
   'Osteoglossocephala'
   'Otomorpha'
   'Lepidogalaxii'
   'Protacanthopterygii'
   'Stomiati'
   'Aulopa'
   'Myctophata'
   'Paracanthomorphacea'
   'Polymixiacea'
   'Berycimorphaceae'
   'Holocentrimorphaceae'
   'Ophidiimopharia'
   'Batrachoidimopharia'
   'Gobiomopharia'
   'Scombrimopharia'
   'Carangimopharia'
   'Eupercaria'   
 };
 
 close all
 shstat_options('default');
 shstat_options('y_label', 'on'); 
 shstat_options('x_label', 'off'); 
 path = '';
 
 for i=1:length(fig)
 
 switch fig(i)
   case 1
     shstat_options('x_transform', 'none');
     [hkap, hleg] = shstat({'kap'}, llegend);
     figure(hkap)
     xlabel('allocation fraction to soma, \kappa, -')
     saveas(hkap, [path, 'kap.png'])
     saveas(hleg, [path, 'llegend_Actinopterygii.png'])

   case 2
     shstat_options('x_transform', 'log10');
     hp_M = shstat({'p_M'}, llegend); 
     figure(hp_M)
     xlabel('_{10}log vol-spec somatic maint, [p_M], J/d.cm^3')
     saveas(hp_M, [path, 'pM.png'])
     
   case 3 
     shstat_options('x_transform', 'log10');
     hs_M = shstat({'s_M'}, llegend); 
     figure(hs_M)
     xlabel('_{10}log acceleration factor, s_M, -')
     saveas(hs_M, [path, 'sM.png'])
 
   case 4 
     shstat_options('x_transform', 'log10');
     hs_s = shstat({'s_s'}, llegend); 
     figure(hs_s)
     xlabel('_{10}log supply stress, s_s, -')
     saveas(hs_s, [path, 'ss.png'])

   case 5
     shstat_options('x_transform', 'log10');
     hs_Hbp = shstat({'s_Hbp'}, llegend); 
     figure(hs_Hbp)
     xlabel('_{10}log precociality coeff, s_H^{bp}, -')
     saveas(hs_Hbp, [path, 'sHbp.png'])

   case 6
     shstat_options('x_transform', 'log10');
     hv = shstat({'v'}, llegend); 
     figure(hv)
     xlabel('_{10}log energy conductance, v, cm/d')
     saveas(hv, [path, 'v.png'])

   case 7
     shstat_options('x_transform', 'log10');
     hp_Am = shstat({'p_Am'}, llegend); 
     figure(hp_Am)
     xlabel('_{10}log spec assimilation rate, \{p_{Am}\}, J/d.cm^2')
     saveas(hp_Am, [path, 'pAm.png'])

   case 8
     shstat_options('x_transform', 'log10');
     Wwi_Cy = read_stat(select('Cyclostomata'),{'Ww_i'}); 
     Wwi_Ch = read_stat(select('Chondrichthyes'),{'Ww_i'}); 
     Wwi_Ai = read_stat(select('Actinopterygii'),{'Ww_i'}); 
     Wwi_CL = read_stat(select('CL-group'),{'Ww_i'});
     Wwi_T = read_stat(select('Tetrapoda'),{'Ww_i'});
     hWw_i= shstat(Wwi_Cy, {'k', 'k'});   
     shstat(Wwi_Ch, {'b', 'b'}, [], hWw_i);   
     shstat(Wwi_Ai, {'m', 'm'}, [], hWw_i);   
     shstat(Wwi_CL, {'r', 'r'}, [], hWw_i);   
     shstat(Wwi_T,  {'g', 'g'}, [], hWw_i);   
     
     shstat({'Ww_b'}, llegend, [], hWw_i);
     figure(hWw_i)
     xlabel('_{10}log wet weight at birth, death, W_b^w, W_\infty^w, g')
     saveas(hWw_i, [path, 'Wwi.png'])

   case 9
     shstat_options('x_transform', 'log10');
     hE_m = shstat({'E_m'}, llegend); 
     figure(hE_m)
     xlabel('_{10}log reserve capacity, [E_m], J/cm^3')
     saveas(hE_m, [path, 'Em.png'])

   case 10
     shstat_options('x_transform', 'log10');
     ha_m = shstat({'a_m'}, llegend); 
     figure(ha_m)
     xlabel('_{10}log age at death, a_m, d')
     saveas(ha_m, [path, 'am.png'])
     
   case 11
     shstat_options('x_transform', 'log10');
     WdW_Cy = read_stat(select('Cyclostomata'),{'W_dWm','dWm'});   WdW_Cy = WdW_Cy(:,2) ./ WdW_Cy(:,1);
     WdW_Ch = read_stat(select('Chondrichthyes'),{'W_dWm','dWm'}); WdW_Ch = WdW_Ch(:,2) ./ WdW_Ch(:,1);
     WdW_Ai = read_stat(select('Actinopterygii'),{'W_dWm','dWm'}); WdW_Ai = WdW_Ai(:,2) ./ WdW_Ai(:,1);
     WdW_CL = read_stat(select('CL-group'),{'W_dWm','dWm'});       WdW_CL = WdW_CL(:,2) ./ WdW_CL(:,1);
     WdW_T = read_stat(select('Tetrapoda'),{'W_dWm','dWm'});       WdW_T  = WdW_T (:,2) ./ WdW_T (:,1);
     hWdW = shstat(WdW_Cy, {'k', 'k'});   
     shstat(WdW_Ch, {'b', 'b'}, [], hWdW);   
     shstat(WdW_Ai, {'m', 'm'}, [], hWdW);   
     shstat(WdW_CL, {'r', 'r'}, [], hWdW);   
     shstat(WdW_T, {'g', 'g'}, [], hWdW);   
     figure(hWdW)
     xlabel('_{10}log maximum spec growth, r, g/d.g')
     saveas(hWdW, [path, 'WdW.png'])

   case 12
     shstat_options('x_transform', 'log10');
     JOiW_Cy = read_stat(select('Cyclostomata'),{'J_Oi','Ww_i'});   JOiW_Cy = JOiW_Cy(:,1) ./ JOiW_Cy(:,2);
     JOiW_Ch = read_stat(select('Chondrichthyes'),{'J_Oi','Ww_i'}); JOiW_Ch = JOiW_Ch(:,1) ./ JOiW_Ch(:,2);
     JOiW_Ai = read_stat(select('Actinopterygii'),{'J_Oi','Ww_i'}); JOiW_Ai = JOiW_Ai(:,1) ./ JOiW_Ai(:,2);
     JOiW_CL = read_stat(select('CL-group'),{'J_Oi','Ww_i'});       JOiW_CL = JOiW_CL(:,1) ./ JOiW_CL(:,2);
     JOiW_T = read_stat(select('Tetrapoda'),{'J_Oi','Ww_i'});       JOiW_T  = JOiW_T (:,1) ./ JOiW_T (:,2);
     hJOiW = shstat(JOiW_Cy, {'k', 'k'});   
     shstat(JOiW_Ch, {'b', 'b'}, [], hJOiW);   
     shstat(JOiW_Ai, {'m', 'm'}, [], hJOiW);   
     shstat(JOiW_CL, {'r', 'r'}, [], hJOiW);   
     shstat(JOiW_T,  {'g', 'g'}, [], hJOiW);   
     figure(hJOiW)
     xlabel('_{10}log specific O_2 consumption at death, J_O^m, mol/d.g')
     saveas(hJOiW, [path, 'JOiW.png'])

   case 13
     shstat_options('x_transform', 'log10');
     shstat_options('y_transform', 'log10');
     WJO = read_allStat({'Ww_i', 'J_Oi'}); WJO(:,2) = WJO(:,2) ./ WJO(:,1);
     [hWwi_JOiW, hC]= shstat(WJO, legend);   
     figure(hWwi_JOiW)
     xlabel('_{10}log wet weight at death, g')
     ylabel('_{10}log spec O_2 consumption, mol/d.g')
     saveas(hWwi_JOiW, [path, 'Wwi_JOiW.png'])
     saveas(hC, [path, 'legend_Actinopterygii.png'])

   case 14
     shstat_options('x_transform', 'log10');
     shstat_options('y_transform', 'log10');
     vsEE = read_allStat({'v', 's_M', 'E_Hb', 'E_Hj', 'E_Hp'}); 
     vs = vsEE(:,1) .* vsEE(:,2); 
     s_Hbp = vsEE(:,3) ./ vsEE(:,5); s_Hjp = vsEE(:,4) ./ vsEE(:,5);
     s_Hjp(isnan(s_Hjp)) = s_Hbp(isnan(s_Hjp));
     hvs_s_Hjp = shstat([vs, s_Hjp], legend);   
     figure(hvs_s_Hjp)
     xlabel('_{10}log post-accel energy cond., v s_M, cm/d')
     ylabel('_{10}log maturity ratio, s_H^{jp}, -')
     saveas(hvs_s_Hjp, [path, 'vsM_sHjp.png'])

   case 15
     shstat_options('x_transform', 'log10');
     shstat_options('y_transform', 'log10');
     vs = read_allStat({'v', 's_M'}); 
     v = vs(:,1); vs = vs(:,1) .* vs(:,2); 
     hv_vs = shstat([v, vs], legend);   
     figure(hv_vs)
     xlabel('_{10}log energy conductance, v, cm/d')
     ylabel('_{10}log post-accel energy cond., v s_M, cm/d')
     saveas(hv_vs, [path, 'v_vsM.png'])

    case 16
     shstat_options('x_transform', 'none');
     shstat_options('y_transform', 'log10');
     hkap_R = shstat({'kap', 'R_i'}, legend);   
     figure(hkap_R)
     xlabel('allocation fraction to soma, \kappa, -')
     ylabel('_{10}log max reprod rate, #/d')
     saveas(hkap_R, [path, 'kap_R.png'])
    
   case 17
     shstat_options('x_transform', 'none');
     shstat_options('y_transform', 'log10');
     kNWWa = read_allStat({'kap', 'R_i', 'Ww_b', 'Ww_i'}); 
     kap = kNWWa(:,1); RWW = kNWWa(:,2) .* kNWWa(:,3) ./ kNWWa(:,4);
     hkap_RWW = shstat([kap, RWW], legend);   
     figure(hkap_RWW)
     xlabel('allocation fraction to soma, \kappa, -')
     ylabel('_{10}log max reprod rate * Ww_b/ Ww_i, #/d')
     saveas(hkap_RWW, [path, 'kap_RWW.png'])

   case 18
     shstat_options('x_transform', 'log10');
     shstat_options('y_transform', 'log10');
     WdW = read_allStat({'W_dWm','dWm'}); WdW = WdW(:,2) ./ WdW(:,1);
     r = read_popStat('f1.thin1.f.r'); 
     
     hWdW_r = shstat([WdW, r], legend);   
     figure(hWdW_r)
     plot([-1 -4.5], [-1 -4.5], 'k')
     xlabel('_{10}log max spec growth, r_m, g/d.g')
     ylabel('_{10}log max spec pop growth, r_N, 1/d')
     saveas(hWdW_r, [path, 'WdW_r.png'])
     
   case 19
     shstat_options('x_transform', 'log10');
     shstat_options('y_transform', 'log10');
     
     hsM_sHbp = shstat({'s_M','s_Hbp'}, legend);   
     figure(hsM_sHbp)
     xlabel('_{10}log acceleration factor, s_M, -')
     ylabel('_{10}log procociality coeff, s_H^{bp}, -')
     saveas(hsM_sHbp, [path, 'sM_sHbp.png'])
     
   case 20
      n = length(taxa); n_spec = NaN(n,1); sM_min = NaN(n,1); sM_max = NaN(n,1); sM_med = NaN(n,1); sM_geo = NaN(n,1); sM_char = NaN(n,1); sM_ave = NaN(n,1);
      for i=1:n 
        n_spec(i) = length(select(taxa{i}));
        sM = read_stat(select(taxa{i}),{'s_M'}); sM_min(i) = min(sM); sM_max(i) = max(sM); 
        sM_ave(i) = mean(sM); sM_med(i) = median(sM); sM_geo(i) = geomean(sM); sM_char(i) = char_su(sM);
      end
     prt_tab({taxa,n_spec, sM_min, sM_max, sM_ave, sM_med, sM_geo, sM_char},{'Actinopterygii', '# spec', 's_M min', 's_M max', 's_M ave', 's_M med', 's_M geo', 's_M char'});

     shstat_options('x_transform', 'log10');
     llegend_sel = {... % some Actinopterygii taxa
       {'-', 2, [0 0 0]}, 'Otomorpha'; ....
       {'-', 2, [0 0 1]}, 'Protacanthopterygii'; ....
       {'-', 2, [1 0 1]}, 'Paracanthomorphacea'; ....
       {'-', 2, [0 1 0]}, 'Scombrimopharia'; ....
       {'-', 2, [0 1 1]}, 'Carangimopharia'; ....
       {'-', 2, [1 1 0]}, 'Eupercaria'; ....
     };
     hs_M = shstat({'s_M'}, llegend_sel); 
     figure(hs_M)
     xlabel('_{10}log acceleration factor, s_M, - ')
     
   case 21
     legend_actino =  legend(1:17,:);
     shstat_options('x_transform', 'log10');
     shstat_options('y_transform', 'log10');
     shstat_options('y_transform', 'log10');
     hLi_Em_sM = shstat({'L_i','E_m','s_M'}, legend_actino); 
     figure(hLi_Em_sM)
     xlabel('_{10}log ultimate struc length, L_\infty, cm')
     ylabel('_{10}log reserve capacity, [E_m], J/cm^3')
     zlabel('_{10}log acceleration factor, s_M, -')
     
     spec = select('Actinopterygii'); n_spec = length(spec); leg = cell(n_spec,2);
     Li_Em_sM = read_stat(spec,{'L_i','E_m','s_M'}); s_M = log(Li_Em_sM(:,3)); col = color_lava(s_M/max(s_M));
     for i=1:n_spec; leg{i,1} = {'.',8,8,col(i,:),col(i,:)}; leg{i,2}= spec{i}; end
     figure
     plot2i(Li_Em_sM(:,1:2), leg);
     xlabel('_{10}log ultimate struc length, L_\infty, cm')
     ylabel('_{10}log reserve capacity, [E_m], J/cm^3')

   case 22
     shstat_options('x_transform', 'log10');
     shstat_options('y_transform', 'log10');
     hEm_sHbp= shstat({'E_m', 's_Hbp'}, legend); 
     figure(hEm_sHbp)
     xlabel('_{10}log reserve capacity, [E_m], J/cm^3')
     ylabel('_{10}log precociality coeff, s_H^{bp}, - ')
     %saveas(hEm_sHbp, [path, 'Em_sHbp.png'])


end
end
