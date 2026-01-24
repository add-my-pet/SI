function [par, metaPar, txtPar] = pars_init_surv_pM(metaData)
metaPar.model = 'nat'; 

par.lambda_relax = 23.9;  free.lambda_relax = 1;  units.lambda_relax = '-'; label.lambda_relax = 'scale for relax species'; 
par.lambda_hurry = 910.4; free.lambda_hurry = 1;  units.lambda_hurry = '-'; label.lambda_hurry = 'scale for hurry species'; 
par.k_relax = 3.649;      free.k_relax = 1;       units.k_relax = '-';      label.k_relax = 'shape for relax species'; 
par.k_hurry = 0.5971;     free.k_hurry = 1;       units.k_hurry = '-';      label.k_hurry = 'shape for hurry species'; 
par.p_relax = 0.32;       free.p_relax = 1;       units.p_relax = '-'; label.p_relax = 'probabilbity on relax species'; 

%% Pack output: 
txtPar.units = units; txtPar.label = label; par.free = free; 
