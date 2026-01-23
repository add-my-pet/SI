function [data, auxData, metaData, txtData, weights] = mydata_surv_pM
metaData.species = 'surv_pM'; metaData.COMPLETE = 1;
data.surv_pM = surv(log10(read_allStat('p_M'))); 
units.surv_pM = {'J/d.cm^3','-'}; label.surv_pM= {'_{10} log spec som maint [p_M]', 'survivor function'};  
bibkey.surv_pM = 'AmP'; temp.surv_pM = C2K(20); units.temp.surv_pM = 'K'; label.temp.surv_pM = 'temperature'; 

%% set weights for all real data
weights = setweights(data, []);

%% set pseudodata and respective weights
%[data, units, label, weights] = addpseudodata(data, units, label, weights);

%% pack auxData and txtData for output
auxData.temp = temp;
txtData.units = units;
txtData.label = label;
txtData.bibkey = bibkey;

