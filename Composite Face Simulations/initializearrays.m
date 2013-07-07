% Script
%
% INITIALIZEARRAYS

%%%%%%%%%%%
% TESTING %
%%%%%%%%%%%
%
% Arrays for Gabor features
NC_LS_A = zeros(n.expressions*n.subsets, n.gaborFeatures);
NC_RS_A = zeros(n.expressions*n.subsets, n.gaborFeatures);

NC_TLBR_MA = zeros(n.expressions*n.subsets, n.gaborFeatures);
NC_TRBL_MA = zeros(n.expressions*n.subsets, n.gaborFeatures);

C_LS_A = zeros(n.compositeFaces*n.subsets, n.gaborFeatures);
C_RS_A = zeros(n.compositeFaces*n.subsets, n.gaborFeatures);

C_TLBR_MA = zeros(n.compositeFaces*n.subsets, n.gaborFeatures);
C_TRBL_MA = zeros(n.compositeFaces*n.subsets, n.gaborFeatures);

TH_LS = zeros(n.expressions*n.subsets, n.gaborFeatures);
TH_RS = zeros(n.expressions*n.subsets, n.gaborFeatures);

BH_LS = zeros(n.expressions*n.subsets, n.gaborFeatures);
BH_RS = zeros(n.expressions*n.subsets, n.gaborFeatures);

% Arrays and structs for data analysis
% Accuracy
%
% Full face
percentAccuracy.NC_LS_A = zeros(n.subsets, n.repeats);
confusionMatrix.NC_LS_A = zeros(n.expressions);
percentAccuracy.NC_RS_A = zeros(n.subsets, n.repeats);
confusionMatrix.NC_RS_A = zeros(n.expressions);
percentAccuracy.NC_A = zeros(n.subsets, n.repeats);
confusionMatrix.NC_A = zeros(n.expressions);

% Top-half face
percentAccuracy.TH_LS_A = zeros(n.subsets, n.repeats);
confusionMatrix.TH_LS_A = zeros(n.expressions);
percentAccuracy.TH_RS_A = zeros(n.subsets, n.repeats);
confusionMatrix.TH_RS_A = zeros(n.expressions);
percentAccuracy.TH_A = zeros(n.subsets, n.repeats);
confusionMatrix.TH_A = zeros(n.expressions);

% Bottom-half face
percentAccuracy.BH_LS_A = zeros(n.subsets,n.repeats);
confusionMatrix.BH_LS_A = zeros(n.expressions);
percentAccuracy.BH_RS_A = zeros(n.subsets, n.repeats);
confusionMatrix.BH_RS_A = zeros(n.expressions);
percentAccuracy.BH_A = zeros(n.subsets, n.repeats);
confusionMatrix.BH_A = zeros(n.expressions);


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% SIMULATION 1 (COMPLETE COMPOSITE PARADIGM) %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 1 - Same
% 0 - Different
%
% Same-different judgments
%
% left-shifted aligned
%
% Incongruent Same
Trials.all.ITS_LS_A = zeros(n.IS.all, 1);
Trials.all.IBS_LS_A = zeros(n.IS.all, 1);
% Incongruent Different
Trials.all.ITD_LS_A = zeros(n.ID.all, 1);
Trials.all.IBD_LS_A = zeros(n.ID.all, 1);
% Congruent Same
Trials.all.CTS_LS_A = zeros(n.CS.all, 1);
Trials.all.CBS_LS_A = zeros(n.CS.all, 1);            
% Congruent Different
Trials.all.CTD_LS_A = zeros(n.CD.all, 1);
Trials.all.CBD_LS_A = zeros(n.CD.all, 1);
%
% right-shifted aligned
%
% Incongruent Same
Trials.all.ITS_RS_A = zeros(n.IS.all, 1);
Trials.all.IBS_RS_A = zeros(n.IS.all, 1);
% Incongruent Different
Trials.all.ITD_RS_A = zeros(n.ID.all, 1);
Trials.all.IBD_RS_A = zeros(n.ID.all, 1);            
% Congruent Same
Trials.all.CTS_RS_A = zeros(n.CS.all, 1);
Trials.all.CBS_RS_A = zeros(n.CS.all, 1);            
% Congruent Different
Trials.all.CTD_RS_A = zeros(n.CD.all, 1);
Trials.all.CBD_RS_A = zeros(n.CD.all, 1);
%
% top-left bottom-right misaligned
%
% Incongruent Same
Trials.all.ITS_TLBR_MA = zeros(n.IS.all, 1);
Trials.all.IBS_TLBR_MA = zeros(n.IS.all, 1);
% Incongruent Different
Trials.all.ITD_TLBR_MA = zeros(n.ID.all, 1);
Trials.all.IBD_TLBR_MA = zeros(n.ID.all, 1);            
% Congruent Same
Trials.all.CTS_TLBR_MA = zeros(n.CS.all, 1);
Trials.all.CBS_TLBR_MA = zeros(n.CS.all, 1);            
% Congruent Different
Trials.all.CTD_TLBR_MA = zeros(n.CD.all, 1);
Trials.all.CBD_TLBR_MA = zeros(n.CD.all, 1);
%
% top-right bottom-left misaligned
%
% Incongruent Same
Trials.all.ITS_TRBL_MA = zeros(n.IS.all, 1);
Trials.all.IBS_TRBL_MA = zeros(n.IS.all, 1);
% Incongruent Different
Trials.all.ITD_TRBL_MA = zeros(n.ID.all, 1);
Trials.all.IBD_TRBL_MA = zeros(n.ID.all, 1);            
% Congruent Same
Trials.all.CTS_TRBL_MA = zeros(n.CS.all, 1);
Trials.all.CBS_TRBL_MA = zeros(n.CS.all, 1);            
% Congruent Different
Trials.all.CTD_TRBL_MA = zeros(n.CD.all, 1);
Trials.all.CBD_TRBL_MA = zeros(n.CD.all, 1);

% Confusion matrices
array = zeros(2,2,n.runs);

% Incongruent Top
%
% left-shifted aligned
confusionMatrix.all.IT_LS_A = array;
% right-shifted aligned
confusionMatrix.all.IT_RS_A = array;
% top-left bottom-right misaligned
confusionMatrix.all.IT_TLBR_MA = array;
% top-right bottom-left misaligned
confusionMatrix.all.IT_TRBL_MA = array;
%
% Incongruent Bottom
%
% left-shifted aligned
confusionMatrix.all.IB_LS_A = array;
% right-shifted aligned
confusionMatrix.all.IB_RS_A = array;
% top-left bottom-right misaligned
confusionMatrix.all.IB_TLBR_MA = array;
% top-right bottom-left misaligned
confusionMatrix.all.IB_TRBL_MA = array;
%
% Congruent Top
%
% left-shifted aligned
confusionMatrix.all.CT_LS_A = array;
% right-shifted aligned
confusionMatrix.all.CT_RS_A = array;
% top-left bottom-right misaligned
confusionMatrix.all.CT_TLBR_MA = array;
% top-right bottom-left misaligned
confusionMatrix.all.CT_TRBL_MA = array;
%
% Congruent Bottom
%
% left-shifted aligned
confusionMatrix.all.CB_LS_A = array;
% right-shifted aligned
confusionMatrix.all.CB_RS_A = array;
% top-left bottom-right misaligned
confusionMatrix.all.CB_TLBR_MA = array;
% top-right bottom-left misaligned
confusionMatrix.all.CB_TRBL_MA = array;

% Hit and False Alarm Rates
array = zeros(4,2,n.subsets,n.repeats);

% left-shifted aligned
rates.all.LS_A = array;
% right-shifted aligned
rates.all.RS_A = array;
% top-left bottom-right misaligned
rates.all.TLBR_MA = array;
% top-right bottom-left misaligned
rates.all.TRBL_MA = array;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% SIMULATION 2 (TANAKA ET AL. EXPERIMENT 1) %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% Stack of confusion vectors
confusionVectors.E1.happyHappy_LS_A_bottom =...
    zeros(n.subsets, n.expressions);
confusionVectors.E1.happyHappy_RS_A_bottom =...
    zeros(n.subsets, n.expressions);
confusionVectors.E1.happyBottom_LS =...
    zeros(n.subsets, n.expressions);
confusionVectors.E1.happyBottom_RS =...
    zeros(n.subsets, n.expressions);
confusionVectors.E1.neutralHappy_LS_A_bottom =...
    zeros(n.subsets, n.expressions);
confusionVectors.E1.neutralHappy_RS_A_bottom =...
    zeros(n.subsets, n.expressions);
confusionVectors.E1.angryHappy_LS_A_bottom =...
    zeros(n.subsets, n.expressions);
confusionVectors.E1.angryHappy_RS_A_bottom =...
    zeros(n.subsets, n.expressions);

confusionVectors.E1.angryAngry_LS_A_top =...
    zeros(n.subsets, n.expressions);
confusionVectors.E1.angryAngry_RS_A_top =...
    zeros(n.subsets, n.expressions);
confusionVectors.E1.angryTop_LS =...
    zeros(n.subsets, n.expressions);
confusionVectors.E1.angryTop_RS =...
    zeros(n.subsets, n.expressions);
confusionVectors.E1.angryNeutral_LS_A_top =...
    zeros(n.subsets, n.expressions);
confusionVectors.E1.angryNeutral_RS_A_top =...
    zeros(n.subsets, n.expressions);
confusionVectors.E1.angryHappy_LS_A_top =...
    zeros(n.subsets, n.expressions);
confusionVectors.E1.angryHappy_RS_A_top =...
    zeros(n.subsets, n.expressions);


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% SIMULATION 3 (TANAKA ET AL. EXPERIMENT 3) %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% Stack of confusion vectors
confusionVectors.E3.happyHappy_LS_A_bottom =...
    zeros(n.subsets, n.expressions);
confusionVectors.E3.happyHappy_RS_A_bottom =...
    zeros(n.subsets, n.expressions);
confusionVectors.E3.happyHappy_TLBR_MA_bottom =...
    zeros(n.subsets, n.expressions);
confusionVectors.E3.happyHappy_TRBL_MA_bottom =...
    zeros(n.subsets, n.expressions);

confusionVectors.E3.angryHappy_LS_A_bottom =...
    zeros(n.subsets, n.expressions);
confusionVectors.E3.angryHappy_RS_A_bottom =...
    zeros(n.subsets, n.expressions);
confusionVectors.E3.angryHappy_TLBR_MA_bottom =...
    zeros(n.subsets, n.expressions);
confusionVectors.E3.angryHappy_TRBL_MA_bottom =...
    zeros(n.subsets, n.expressions);

confusionVectors.E3.angryAngry_LS_A_top =...
    zeros(n.subsets, n.expressions);
confusionVectors.E3.angryAngry_RS_A_top =...
    zeros(n.subsets, n.expressions);
confusionVectors.E3.angryAngry_TLBR_MA_top =...
    zeros(n.subsets, n.expressions);
confusionVectors.E3.angryAngry_TRBL_MA_top =...
    zeros(n.subsets, n.expressions);

confusionVectors.E3.angryHappy_LS_A_top =...
    zeros(n.subsets, n.expressions);
confusionVectors.E3.angryHappy_RS_A_top =...
    zeros(n.subsets, n.expressions);
confusionVectors.E3.angryHappy_TLBR_MA_top =...
    zeros(n.subsets, n.expressions);
confusionVectors.E3.angryHappy_TRBL_MA_top =...
    zeros(n.subsets, n.expressions);

% Tidy up
clear array