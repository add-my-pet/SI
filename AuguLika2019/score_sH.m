close all

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

figure(1)
plot(cell2mat(data(:,5)), cell2mat(data(:,4)), 'om')
xlabel('altrical/precocial score according to Nice1962')
ylabel('I_p of StarRick1998')


[nm sH] = prtStat('Aves', 's_Hbp', 0); n_Aves = length(nm); score = zeros(n_Aves,1);
WD = pwd;
cd(['../debtool/entries/',nm{1}]) % goto entries
for i=1:n_Aves
  cd (['../', nm{i}])
  load (['results_', nm{i}])
  [x score(i)] = get_s_Hbp(metaData.order, metaData.family);
end
cd(WD);

figure(2)
plot(score, log10(sH), 'o', 'MarkerSize', 2, 'LineWidth', 4, 'MarkerEdgeColor', [0 0 1])
xlabel('altrical/precocial score')
ylabel('_{10}log s_H^{bp}')
      h = datacursormode(2);
      h.UpdateFcn = @(obj, event_obj)xylabels(obj, event_obj, nm, [score, logsH]);
      datacursormode on % mouse click on plot
saveas(gca,'score_sH.png')

figure(3)
EHbx = read_allStat('E_Hb','E_Hx'); s_Hbx = EHbx(:,1)./EHbx(:,2); s_Hbx = s_Hbx(select_01('Aves'));
plot(score, log10(s_Hbx), 'o', 'MarkerSize', 2, 'LineWidth', 4, 'MarkerEdgeColor', [0 0 1])
xlabel('altrical/precocial score')
ylabel('_{10}log s_H^{bx}')
      h = datacursormode(2);
      h.UpdateFcn = @(obj, event_obj)xylabels(obj, event_obj, nm, [score, logsH]);
      datacursormode on % mouse click on plot
%saveas(gca,'score_sHbx.png')

