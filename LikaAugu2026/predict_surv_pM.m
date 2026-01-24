function [prdData, info] = predict_surv_pM(par, data, auxData)
vars_pull(par); v2struct(par); v2struct(data); info = 1;

if k_relax < 0 || k_relax > 5 || k_hurry < 0 || k < 0; info = 0; prdData = []; return; end
if lambda_relax < 0 || lambda_hurry < 0 || p_Mscale < 0; info = 0; prdData = []; return; end

p_M = 10.^surv_pM(:,1); % undo log10-transform
prdData.surv_pM = p_relax.*exp(-(p_M/lambda_relax).^k_relax)+(1-p_relax).*exp(-(p_M/lambda_hurry).^k_hurry);


