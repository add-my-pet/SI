close all;
global pets

pets = { ...
         'Clarias_gariepinus', ...
         'Clarias_gariepinus_x_Heterobranchus_longifilis', ...
         'Heterobranchus_longifilis', ...
         'Heterobranchus_longifilis_x_Clarius_gariepinus', ...
       };

estim_options('default');
estim_options('max_step_number', 1e3);
estim_options('max_fun_evals',5e3);

estim_options('pars_init_method', 1);
estim_options('results_output', 3);
estim_options('method', 'no');

estim_pars;

