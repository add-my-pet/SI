# LikaAugu2023
Supplementary Information: The relationship between confidence intervals and distributions of estimators for parameters of deterministic models

Konstadia Lika$^{1,2}$, Starrlight Augustine$^{3,4}$, Sebastiaan A.L.M. Kooijman$^{4\ast}$}
  
$^1$ Department of Biology, University of Crete, 70013, Heraklion, Greece
$^2$ Institute of Computational Mathematics,
Foundation of Research and Technology Hellas, 70013 Heraklion, Greece
$^3$ MARETEC – Marine, Environment and Technology Centre, 
Instituto Superior T\'{e}cnico, Universidade de Lisboa, 1049-001 Lisboa, 
Av. Rovisco Pais, 1, 1049-001 Lisboa,
Portugal
$^4$  Amsterdam Institute for Life and Environment (A-LIFE), 
VU University Amsterdam, de Boelelaan 1087, 1081 HV, The Netherlands
$^\ast$ Corresponding author: bas.kooijman@vu.nl

In this document the code used generating each of the 13 figures is listed. The code works Matlab\textsuperscript{\textcopyright} and with free open source DEBtool\_M software - \url{https://debtool.debtheory.org/docs/index.html}.

Code was run with Matlab^\textcopyright R2021a. 


*  mydata_F2S_exp.m - From loss function to survivor function for the exponential model. Calls exprnd.m and exponential.m
* mydata_F2S_wbl.m - From loss function to survivor function for the Weibull model. Calls wblrnd.m and weibull.m 
* mydata_Ssb_exp.m - Compares SB-estimates for parameters of exponential distribution based on fitting exp$(-\lambda \, t)$ for 2 definitions of empirical survival data. Calls exprnd.m and exponential.m
* mydata_Ssb_wbl.m - Compares SB and ML-estimates for parameters of the Weibull distribution based on fitting exp$(-\lambda \, t)^k$. Calls wblrnd.m and weibull.m 
* mydata_F2S_vBert.m - Generates figures 11 and 12 . Calls vBert.m and generates  vBert.mat and/or else loads those data.
* mydata_F2S_vBert_2D.m  - Generates figures 13. Calls vBert.m and either generates .mat files vBert\_2D.mat and vBert.mat or else loads those data. vBert\_2D.mat and vBert.mat are in the folder which enables the function to execute fast. User can un-comment relevant parts of the code to re-generate the data. 
