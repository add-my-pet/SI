function [par, metaPar, txtPar] = pars_init_group(metaData)

metaPar.model = {'abj', 'abj', 'abj', 'abj'}; 
metaPar.cov_rules = ''; % see function parGrp2Pets

%% reference parameter (not to be changed) 
par.T_ref = 293.15;   free.T_ref = 0;   units.T_ref = 'K';        label.T_ref = 'Reference temperature'; 

%% core primary parameters 
par.E_G = 5217.5302;  free.E_G   = 1;   units.E_G = 'J/cm^3';     label.E_G = '[E_G], spec cost for structure'; 
par.E_Hb = 5.254e-03; free.E_Hb  = 1;   units.E_Hb = 'J';         label.E_Hb = 'maturity at birth'; 
par.E_Hj = 1.757e-02; free.E_Hj  = 1;   units.E_Hj = 'J';         label.E_Hj = 'maturity at metamorphosis'; 
par.E_Hp = [2.029e+04 4.413e+05 8.450e+03 7.097e+03]; free.E_Hp  = [1  1  1  1];   units.E_Hp = 'J';         label.E_Hp = 'maturity at puberty'; 
par.F_m = 6.5;        free.F_m   = 0;   units.F_m = 'l/d.cm^2';   label.F_m = '{F_m}, max spec searching rate'; 
par.T_A = 9000;       free.T_A   = 0;   units.T_A = 'K';          label.T_A = 'Arrhenius temperature'; 
par.h_a = 3.493e-10;  free.h_a   = 1;   units.h_a = '1/d^2';      label.h_a = 'Weibull aging acceleration'; 
par.k_J = 0.002;      free.k_J   = 0;   units.k_J = '1/d';        label.k_J = 'maturity maint rate coefficient'; 
par.kap = [0.95405     0.98601     0.99842     0.99665];  free.kap   = [1  1  1  1];   units.kap = '-';          label.kap = 'allocation fraction to soma'; 
par.kap_P = 0.1;      free.kap_P = 0;   units.kap_P = '-';        label.kap_P = 'faecation efficiency of food to faeces'; 
par.kap_R = 0.95;     free.kap_R = 0;   units.kap_R = '-';        label.kap_R = 'reproduction efficiency'; 
par.kap_X = 0.8;      free.kap_X = 0;   units.kap_X = '-';        label.kap_X = 'digestion efficiency of food to reserve'; 
par.p_M = [695.2827       505.323      103.7029      120.8709];  free.p_M   = [1  1  1  1];   units.p_M = 'J/d.cm^3';   label.p_M = '[p_M], vol-spec somatic maint'; 
par.p_T = 0;          free.p_T   = 0;   units.p_T = 'J/d.cm^2';   label.p_T = '{p_T}, surf-spec somatic maint'; 
par.s_G = 0.0001;     free.s_G   = 0;   units.s_G = '-';          label.s_G = 'Gompertz stress coefficient'; 
par.v = [0.02912    0.060498     0.14061     0.10344];  free.v     = [1  1  1  1];   units.v = 'cm/d';         label.v = 'energy conductance'; 
par.z = [7.17418       10.208       17.592      17.9879];  free.z     = [1  1  1  1];   units.z = '-';            label.z = 'zoom factor'; 

%% other parameters 
par.del_M = 0.11836;  free.del_M = 1;   units.del_M = '-';        label.del_M = 'shape coefficient for total length'; 
par.f = 1;            free.f     = 0;   units.f = '-';            label.f = 'scaled functional response for 0-var data'; 
par.f_tW = 0.30617;   free.f_tW  = 1;   units.f_tW = '-';         label.f_tW = 'scaled functional response for tW data'; 

%% set chemical parameters from Kooy2010 
[phylum, class] = metaData2taxo(metaData); 
[par, units, label, free] = addchem(par, units, label, free, phylum, class); 

%% Pack output: 
txtPar.units = units; txtPar.label = label; par.free = free; 
