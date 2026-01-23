function [par, metaPar, txtPar] = pars_init_surv_pM(metaData)
metaPar.model = 'nat'; 

par.lambda_relax = 32.9014;  free.lambda_relax = 1;  units.lambda_relax = '-'; label.lambda_relax = 'scale for relax species'; 
par.lambda_hurry = 656.1972; free.lambda_hurry = 1;  units.lambda_hurry = '-'; label.lambda_hurry = 'scale for hurry species'; 
par.k_relax = 2;        free.k_relax = 1;       units.k_relax = '-';      label.k_relax = 'shape for relax species'; 
par.k_hurry = 0.59538;       free.k_hurry = 1;       units.k_hurry = '-';      label.k_hurry = 'shape for hurry species'; 
par.k = 0.17793;                   free.k = 1;             units.k = '-';            label.k = 'shape for relax/hurry transition'; 
par.p_Mshape = 5.2962;      free.p_Mshape = 1;      units.p_Mshape = 'J/d.cm3'; label.p_Mshape = 'scale for relax/hurry transition'; 

%% Pack output: 
txtPar.units = units; txtPar.label = label; par.free = free; 
