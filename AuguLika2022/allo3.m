function [logWb, logR, logRWbW] = allo3(p, logWWb, logWR, logWRWbW)

logWb0 = p(1); logR0 = p(2); beta_Wb = p(3); beta_R = p(4); % unpack pars

logWb = logWb0 + beta_Wb * (logWWb(:,1) + (logWWb(:,2) - logWb0 - beta_Wb * logWWb(:,1))/ (beta_Wb + 1/ beta_Wb));
logR = logR0 + beta_R * (logWR(:,1) + (logWR(:,2) - logR0 - beta_R * logWR(:,1))/ (beta_R + 1/ beta_R));
logRWbW0 = logR0 + logWb0; beta_RWbW = beta_R + beta_Wb - 1;
logRWbW = logRWbW0 + beta_RWbW * (logWRWbW(:,1) + (logWRWbW(:,2) - logRWbW0 - beta_RWbW * logWRWbW(:,1))/ (beta_RWbW + 1/ beta_RWbW));