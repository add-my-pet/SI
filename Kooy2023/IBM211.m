%% IBM211
% Individual-Based-Model for NetLogo: runs NetLogo's Java-code using a generalized reactor

%%
function [txxNL23W, info] = IBM211(species, tT, tJX1, tJX2, X1_0, X2_0, V_X, h, t_R, t_max, tickRate, runNetLogo)
% created 2023/12/12 by Bas Kooijman

%% Syntax
% txNL23W = <../IBM211.m *IBM211*> (species, tT, tJX1, tJX1, X1_0, X2_0, V_X, h, t_R, t_max, tickRate, runNetLogo) 
% h: optional vector with dilution and background hazards for each stage (depending on the model) and boolean for thinning
%     Default value for the std model: [h_X1, h_X2, h_B0b, h_Bbp, h_Bpi, thin] = [0 0 0 0 0 0]

%% Description
% Like IBM, but for 2 types of food and only for the std model; juveniles only consume type 1, adults types 1 & 2 

WD = cdIBMnlogo;

model = 'std211'; % only works for the std model

% make sure that results of previous runs are removed (NetLogo deletes existing txNL23W.txt file)
if exist('spline_TC.txt', 'file')==2
  delete('spline_TC.txt');
end
if exist('spline_JX1.txt', 'file')==2
  delete('spline_JX1.txt');
end
if exist('spline_JX2.txt', 'file')==2
  delete('spline_JX2.txt');
end
if exist('eaLE.txt', 'file')==2
  delete('eaLE.txt');
end

if ~exist ('runNetLogo', 'var') || isempty(runNetLogo)
  runNetLogo = true;
end

if ~exist ('t_R', 'var') || isempty(t_R)
  t_R = 0;
end

if ~exist ('tickRate', 'var') || isempty(tickRate)
  tickRate = 24;
end

% get core parameters (2 possible routes for getting pars), species and model
if iscell(species) 
  metaData = species{1}; metaPar = species{2}; par = species{3};  txtPar = species{4}; 
  species = metaData.species; info = 1;
  datePrintNm = ['date: ',datestr(date, 'yyyy/mm/dd')];
else  % use allStat.mat as parameter source 
  [par, metaPar, txtPar, metaData, info] = allStat2par(species);
  if info == 0
    fprintf('Species not recognized\n');
    txNL23W = []; return
  end
  datePrintNm = ['allStat version: ', datestr(date_allStat, 'yyyy/mm/dd')];
end
par.reprodCode = metaData.ecoCode.reprod{1};
par.genderCode = metaData.ecoCode.gender{1};
model = metaPar.model;

% unpack par and compute compound pars
vars_pull(par); vars_pull(parscomp_st(par)); 

% time to be simulated
if ~exist('t_max','var') || isempty(t_max)
  t_max = 150*365; % -, total simulation time
end

% temperature
if ~exist('tT','var') || isempty(tT) 
  T = metaData.T_typical; tT = [0 T; t_max*1.1 T];
elseif size(tT,2) == 2 && tT(1,1) == 0 && ~(tT(end,1) < t_max)
  tT = [tT; t_max*1.1 tT(end,2)];
elseif size(tT,1) == 1
  T = tT; tT = [0 T; t_max*1.1 T];   
end

% volume of reactor
if ~exist('V_X','var') || isempty(V_X)
  V_X = 1e2 * L_m^3; % cm^3, volume of reactor
end

% supply food 
if ~exist('tJX1','var') || isempty(tJX1)
  J_X1 = 75 * J_X_Am * L_m^2 ;
  tJX1 = [0 J_X1; t_max*1.1 J_X1]; 
elseif size(tJX1,2) == 1
  tJX1 = [0 tJX1; t_max*1.1 tJX1]; 
end
if tJX1(1,1) > 0
  tJX1 = [0 tJX1(1,2); tJX1];
end
if tJX1(end,1) <= t_max
  tJX1 = [tJX1; t_max*1.1 tJX1(end,2)];    
end
%
if ~exist('tJX2','var') || isempty(tJX2)
  J_X2 = 75 * J_X_Am * L_m^2 ; % J_X_Am is kept fixed
  tJX2 = [0 J_X2; t_max*1.1 J_X2]; 
elseif size(tJX2,2) == 1
  tJX2 = [0 tJX2; t_max*1.1 tJX2]; 
end
if tJX2(1,1) > 0
  tJX2 = [0 tJX2(1,2); tJX2];
end
if tJX2(end,1) <= t_max
  tJX2 = [tJX2; t_max*1.1 tJX2(end,2)];    
end

% initial food density
if ~exist('X1_0','var') || isempty(X1_0)
  X1_0 = 0; % -, X1 at t=0
end
%
if ~exist('X2_0','var') || isempty(X2_0)
  X2_0 = 0; % -, X2 at t=0
end

% account for male production
if strcmp(reprodCode(1), 'O') && strcmp(genderCode(1), 'D')
  par.fProb = 0.5;  % probability of embryo to be female
else
  par.fProb = 0.999; % probability of embryo to be female   
end

% rejuvenation parameters
if ~isfield('par', 'k_JX')
  k_JX = k_J/ 100; par.k_JX = k_JX;
end
if ~isfield('par', 'h_J')
  h_J = 1e-4; par.h_J = h_J;
end

% hazard rates, thinning
if ~exist('h','var') || isempty(h)
  h_X1 = 0.1; h_X2 = 0.1; thin = 0; 
else
  h_X1 = h(1); h_X2 = h(2); thin = h(end);
end
par.h_X1 = h_X1; par.h_X2 = h_X2; par.thin = thin; 
%
switch model
  case {'std','stf','sbp','abp'}
    if ~exist('h','var') || isempty(h)
      h_B0b = 1e-35; h_Bbp = 1e-35; h_Bpi = 1e-35; 
    else
      h_B0b = h(3); h_Bbp = h(4); h_Bpi = h(5);       
    end
    par.h_B0b = h_B0b; par.h_Bbp = h_Bbp; par.h_Bpi = h_Bpi; 
  otherwise
    return
end

% get trajectories
txxNL23W = get_IBMnlogo_std211(model, par, tT, tJX1, tJX2, X1_0, X2_0, V_X, t_R, t_max, tickRate, runNetLogo);

cd(WD);

if runNetLogo

%% plotting
close all
title_txt = [strrep(species, '_', ' '), ' ', datePrintNm];
%
figure(1)
plot(txxNL23W(:,1), txxNL23W(:,2), 'k', txxNL23W(:,1), txxNL23W(:,3), 'b','Linewidth', 2)
title(title_txt);
xlabel('time, d');
ylabel('scaled food densities X1/K, X2/K, -');
set(gca, 'FontSize', 15, 'Box', 'on')
%
figure(2)
plot(txxNL23W(:,1), txxNL23W(:,4), 'color', [1 0 0], 'Linewidth', 2) 
title(title_txt);
xlabel('time, d');
ylabel('# of individuals, #/L');
set(gca, 'FontSize', 15, 'Box', 'on')
%
figure(3)
plot(txxNL23W(:,1), txxNL23W(:,5),'color', [1 0 0], 'Linewidth', 2) 
title(title_txt);
xlabel('time, d');
ylabel('total structural length, cm/L');
set(gca, 'FontSize', 15, 'Box', 'on')
%
figure(4)
plot(txxNL23W(:,1), txxNL23W(:,6),'color', [1 0 0], 'Linewidth', 2) 
title(title_txt);
xlabel('time, d');
ylabel('total structural surface area, cm^2/L');
set(gca, 'FontSize', 15, 'Box', 'on')
%
figure(5)
plot(txxNL23W(:,1), txxNL23W(:,7),'color', [1 0 0], 'Linewidth', 2) 
title(title_txt);
xlabel('time, d');
ylabel('total structural volume, cm^3/L');
set(gca, 'FontSize', 15, 'Box', 'on')
%
figure(6)
plot(txxNL23W(:,1), txxNL23W(:,8),'color', [1 0 0], 'Linewidth', 2) 
title(title_txt);
xlabel('time, d');
ylabel('total wet weight, g/L');
set(gca, 'FontSize', 15, 'Box', 'on')
%
figure(7)
plot(txxNL23W(:,1), txxNL23W(:,8)./txxNL23W(:,4), 'k', 'Linewidth', 2) 
title(title_txt);
xlabel('time, d');
ylabel('mean wet weight per individual, g');
set(gca, 'FontSize', 15, 'Box', 'on')

else % runNetLogo=0: Netlogo is run from its gui
  fprintf('Load DEBtool_M/popDyn/IBMnlogo/%s.nlogo into Netlogo (dropdown "File>Open"), edit and press "go"\n',model);
end

%% report_my_pet.html

fileName = ['report_', species, '.html'];
prt_report_my_pet({par, metaPar, txtPar, metaData}, [], [], [], [], fileName);
web(fileName,'-browser') % open html in systems browser

%%  IBMnlogo_my_pet.html

fileName = ['IBMnlogo_', species, '.html'];
oid = fopen(fileName, 'w+'); % open file for writing, delete existing content

fprintf(oid, '<!DOCTYPE html>\n');
fprintf(oid, '<HTML>\n');
fprintf(oid, '<HEAD>\n');
fprintf(oid, '  <TITLE>IBM %s</TITLE>\n', strrep(species, '_', ' '));
fprintf(oid, '  <style>\n');
fprintf(oid, '    .newspaper {\n');
fprintf(oid, '      column-count: 3;\n');
fprintf(oid, '      height: 500px;\n');
fprintf(oid, '    }\n\n');

fprintf(oid, '    div.temp {\n');
fprintf(oid, '      width: 100%%;\n');
fprintf(oid, '    }\n\n');

fprintf(oid, '    div.par {\n');
fprintf(oid, '      width: 100%%;\n');
fprintf(oid, '      padding-bottom: 100px;\n');
fprintf(oid, '    }\n\n');

fprintf(oid, '    .head {\n');
fprintf(oid, '      background-color: #FFE7C6\n');                  % pink header background
fprintf(oid, '    }\n\n');

fprintf(oid, '    #par {\n');
fprintf(oid, '      border-style: solid hidden solid hidden;\n');   % border top & bottom only
fprintf(oid, '    }\n\n');

fprintf(oid, '    tr:nth-child(even){background-color: #f2f2f2}\n');% grey on even rows
fprintf(oid, '  </style>\n');
fprintf(oid, '</HEAD>\n\n');
fprintf(oid, '<BODY>\n\n');

fprintf(oid, '  <div>\n');
fprintf(oid, '  <h1>%s</h1>\n', strrep(species, '_', ' '));
fprintf(oid, '  </div>\n\n');

fprintf(oid, '  <div class="newspaper">\n');
fprintf(oid, '  <div class="par">\n');

% Table with DEB parameters

fprintf(oid, '  <TABLE id="par">\n');
fprintf(oid, '    <TR  class="head"><TH>symbol</TH> <TH>units</TH> <TH>value</TH>  <TH>description</TH> </TR>\n');
fprintf(oid, '    <TR><TD>%s</TD> <TD>%s</TD> <TD>%s</TD> <TD>%s</TD></TR>\n', 'model', '-', model, 'model type');
fprintf(oid, '    <TR><TD>%s</TD> <TD>%s</TD> <TD>%s</TD> <TD>%s</TD></TR>\n', 'reprodCode', '-', reprodCode, 'ecoCode reprod');
fprintf(oid, '    <TR><TD>%s</TD> <TD>%s</TD> <TD>%s</TD> <TD>%s</TD></TR>\n\n', 'genderCode', '-', genderCode, 'ecoCode gender');

       str = '    <TR><TD>%s</TD> <TD>%s</TD> <TD>%3.4g</TD> <TD>%s</TD></TR>\n';
fprintf(oid, str, 'k_JX', '1/d', k_JX, 'rejuvenation rate');
fprintf(oid, str, 'h_J', '1/d', h_J, 'hazard rate for rejuvenation');
fprintf(oid, str, 'h_X1', '1/d', h_X1, 'hazard rate for food 1 from reactor');
fprintf(oid, str, 'h_X2', '1/d', h_X2, 'hazard rate for food 2 from reactor');
fprintf(oid, str, 'thin', '-', thin, 'boolean for thinning');
switch model
  case {'std','stf','sbp','abp'}
      fprintf(oid, str, 'h_B0b', '1/d', h_B0b, 'background hazard rate from 0 to b');
      fprintf(oid, str, 'h_Bbp', '1/d', h_Bbp, 'background hazard rate from b to p');
      fprintf(oid, str, 'h_Bpi', '1/d', h_Bpi, 'background hazard rate from p to i');
  case 'stx'
      fprintf(oid, str, 'h_B0b', '1/d', h_B0b, 'background hazard rate from 0 to b');
      fprintf(oid, str, 'h_Bbx', '1/d', h_Bbx, 'background hazard rate from b to x');
      fprintf(oid, str, 'h_Bxp', '1/d', h_Bxp, 'background hazard rate from x to p');
      fprintf(oid, str, 'h_Bpi', '1/d', h_Bpi, 'background hazard rate from p to i');
  case 'ssj'
      fprintf(oid, str, 'h_B0b', '1/d', h_B0b, 'background hazard rate from 0 to b');
      fprintf(oid, str, 'h_Bbs', '1/d', h_Bbs, 'background hazard rate from b to s');
      fprintf(oid, str, 'h_Bsp', '1/d', h_Bsp, 'background hazard rate from s to p');
      fprintf(oid, str, 'h_Bpi', '1/d', h_Bpi, 'background hazard rate from p to i');
  case 'abj'
      fprintf(oid, str, 'h_B0b', '1/d', h_B0b, 'background hazard rate from 0 to b');
      fprintf(oid, str, 'h_Bbj', '1/d', h_Bbj, 'background hazard rate from b to j');
      fprintf(oid, str, 'h_Bjp', '1/d', h_Bjp, 'background hazard rate from j to p');
      fprintf(oid, str, 'h_Bpi', '1/d', h_Bpi, 'background hazard rate from p to i');
  case 'asj'
      fprintf(oid, str, 'h_B0b', '1/d', h_B0b, 'background hazard rate from 0 to b');
      fprintf(oid, str, 'h_Bbs', '1/d', h_Bbs, 'background hazard rate from b to s');
      fprintf(oid, str, 'h_Bsj', '1/d', h_Bsj, 'background hazard rate from s to j');
      fprintf(oid, str, 'h_Bjp', '1/d', h_Bjp, 'background hazard rate from j to p');
      fprintf(oid, str, 'h_Bpi', '1/d', h_Bpi, 'background hazard rate from p to i');
end
fprintf(oid, str, 'X1_0', 'mol/L', X1_0, 'initial food 1 density');
fprintf(oid, str, 'X2_0', 'mol/L', X2_0, 'initial food 2 density');
fprintf(oid, str, 'V_X', 'L', V_X, 'volume of reactor');
fprintf(oid, str, 't_max', '-', t_max, 'maximum integration time');

fprintf(oid, '  </TABLE>\n'); % close prdData table
fprintf(oid, '  </div>\n\n');

fprintf(oid, '  <div class="par">\n');

% Table with knots for temperature

fprintf(oid, '  <TABLE id="par">\n');
fprintf(oid, '    <TR  class="head"> <TH>Knots for<br>temperature</TH> <TH>units<br>&deg;C</TH> </TR>\n');
n_T = size(tT,1);
if n_T == 1
    tT = [0 tT; 1 tT]; n_T = 2;
end
for i=1:n_T
  fprintf(oid, '    <TR><TD>%3.4g</TD> <TD>%3.4g</TD></TR>\n', tT(i,1), K2C(tT(i,2)));
end
fprintf(oid, '  </TABLE>\n');
fprintf(oid, '  </div>\n\n');

fprintf(oid, '  <div class="par">\n');

% Table with knots for food 1 input

fprintf(oid, '  <TABLE id="par">\n');
fprintf(oid, '    <TR  class="head"> <TH>Knots for<br>food 1 supply</TH> <TH>units<br>mol/d</TH> </TR>\n');
n_JX1 = size(tJX1,1);
if n_JX1 == 1
  tJX1 = [0 tJX1; 1 tJX1]; n_JX1 = 2;
end
for i=1:n_JX1
  fprintf(oid, '    <TR><TD>%3.4g</TD> <TD>%3.4g</TD></TR>\n', tJX1(i,1), tJX1(i,2));
end
fprintf(oid, '  </TABLE>\n');
fprintf(oid, '  </div>\n\n');

fprintf(oid, '  </TABLE>\n'); % close numPar table
fprintf(oid, '  </div>\n\n');
fprintf(oid, '  </div>\n\n'); % end div newspaper

fprintf(oid, '</BODY>\n');
fprintf(oid, '</HTML>\n');

fprintf(oid, '  <TABLE id="par">\n');
fprintf(oid, '    <TR  class="head"> <TH>Knots for<br>food 2 supply</TH> <TH>units<br>mol/d</TH> </TR>\n');
n_JX2 = size(tJX2,1);
if n_JX2 == 1
  tJX2 = [0 tJX2; 1 tJX2]; n_JX2 = 2;
end
for i=1:n_JX2
  fprintf(oid, '    <TR><TD>%3.4g</TD> <TD>%3.4g</TD></TR>\n', tJX2(i,1), tJX2(i,2));
end
fprintf(oid, '  </TABLE>\n');
fprintf(oid, '  </div>\n\n');

fprintf(oid, '  </TABLE>\n'); % close numPar table
fprintf(oid, '  </div>\n\n');
fprintf(oid, '  </div>\n\n'); % end div newspaper

fprintf(oid, '</BODY>\n');
fprintf(oid, '</HTML>\n');

fclose(oid);

web(fileName,'-browser') % open html in systems browser


