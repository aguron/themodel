% Script
%
% PROJECTANDSORTSTIMULI
%   Notes:
%   06/25/2013
%     - project Gabor filter features on principal components and
%       sort stimuli for the experiment simulations
%
%   Functions called:
%       projectonbasis

cd ..
cd([pwd, '/Principal Components Analysis'])

% Adjust for the difference in size between the data
% sets for training and testing/experiments
scale.testingExperiments = size([temp.testing.NC_A;
                                 temp.experiment1;
                                 temp.experiment3;
                                 temp.top_LS_A;
                                 temp.bottom_LS_A;
                                 temp.top_RS_A;
                                 temp.bottom_RS_A;
                                 temp.top_TLBR_MA;
                                 temp.bottom_TLBR_MA;
                                 temp.top_TRBL_MA;
                                 temp.bottom_TRBL_MA],1)/...
                           size(gaborFeatures.training,1);
% 'b' - Normalize before and after projection, and
% according to the number of validation data vectors
[temp.testing.NC_A,...
 temp.experiment1,...
 temp.experiment3,...
 temp.top_LS_A,...
 temp.bottom_LS_A,...
 temp.top_RS_A,...
 temp.bottom_RS_A,...
 temp.top_TLBR_MA,...
 temp.bottom_TLBR_MA,...
 temp.top_TRBL_MA,...
 temp.bottom_TRBL_MA] =...
 projectonbasis(temp.testing.NC_A,...
                temp.experiment1,...
                temp.experiment3,...
                temp.top_LS_A,...
                temp.bottom_LS_A,...
                temp.top_RS_A,...
                temp.bottom_RS_A,...
                temp.top_TLBR_MA,...
                temp.bottom_TLBR_MA,...
                temp.top_TRBL_MA,...
                temp.bottom_TRBL_MA,...
                principalComponents,...
                scale.testingExperiments,...
                'b');

perceptronInput.testing{i_p} = temp.testing.NC_A;

gaborFeatures.experiment1{i_p} = temp.experiment1;
gaborFeatures.experiment3{i_p} = temp.experiment3;


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% INPUT TO PERCEPTRON FOR SIMULATION 1 (COMPLETE COMPOSITE PARADIGM) %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
stimulus{1}.top_LS_A{i_p} = temp.top_LS_A;
stimulus{1}.bottom_LS_A{i_p} = temp.bottom_LS_A;
stimulus{1}.top_RS_A{i_p} = temp.top_RS_A;
stimulus{1}.bottom_RS_A{i_p} = temp.bottom_RS_A;
stimulus{1}.top_TLBR_MA{i_p} = temp.top_TLBR_MA;
stimulus{1}.bottom_TLBR_MA{i_p} = temp.bottom_TLBR_MA;
stimulus{1}.top_TRBL_MA{i_p} = temp.top_TRBL_MA;
stimulus{1}.bottom_TRBL_MA{i_p} = temp.bottom_TRBL_MA;


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% INPUT TO PERCEPTRON FOR SIMULATION 2 (TANAKA ET AL. EXPERIMENT 1) %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% happy top + happy bottom
%
% left-shifted aligned
stimulus{2}.happyHappy_LS_A_bottom{i_p} =...
    perceptronInput.testing{i_p}...
        (n.expressions*order.testing.BH.LS + expression.happy,:);

% right-shifted aligned
stimulus{2}.happyHappy_RS_A_bottom{i_p} =...
    perceptronInput.testing{i_p}...
        (n.expressions*order.testing.BH.RS + expression.happy,:);

% happy bottom
%
% left-shifted aligned
stimulus{2}.happyBottom_LS{i_p} =...
    gaborFeatures.experiment1{i_p}...
        (n.expressions*order.experiment1.BH.LS + expression.happy,:);

% right-shifted aligned
stimulus{2}.happyBottom_RS{i_p} =...
    gaborFeatures.experiment1{i_p}...
        (n.expressions*order.experiment1.BH.RS + expression.happy,:);

% neutral top + happy bottom
%
% left-shifted aligned
stimulus{2}.neutralHappy_LS_A_bottom{i_p} =...
    stimulus{1}.bottom_LS_A{i_p}(expression.neutralHappy,:);

% right-shifted aligned
stimulus{2}.neutralHappy_RS_A_bottom{i_p} =...
    stimulus{1}.bottom_RS_A{i_p}(expression.neutralHappy,:);

% angry top + happy bottom
%
% left-shifted aligned
stimulus{2}.angryHappy_LS_A_bottom{i_p} =...
    stimulus{1}.bottom_LS_A{i_p}(expression.angryHappy,:);

% right-shifted aligned
stimulus{2}.angryHappy_RS_A_bottom{i_p} =...
    stimulus{1}.bottom_RS_A{i_p}(expression.angryHappy,:);

% angry top + angry bottom
%
% left-shifted aligned
stimulus{2}.angryAngry_LS_A_top{i_p} =...
    perceptronInput.testing{i_p}...
        (n.expressions*order.testing.TH.LS + expression.angry,:);

% right-shifted aligned
stimulus{2}.angryAngry_RS_A_top{i_p} =...
    perceptronInput.testing{i_p}...
        (n.expressions*order.testing.TH.RS + expression.angry,:);

% angry top
%
% left-shifted aligned
stimulus{2}.angryTop_LS{i_p} =...
    gaborFeatures.experiment1{i_p}...
        (n.expressions*order.experiment1.TH.LS + expression.angry,:);

% right-shifted aligned
stimulus{2}.angryTop_RS{i_p} =...
    gaborFeatures.experiment1{i_p}...
        (n.expressions*order.experiment1.TH.RS + expression.angry,:);

% angry top + neutral bottom
%
% left-shifted aligned
stimulus{2}.angryNeutral_LS_A_top{i_p} =...
    stimulus{1}.top_LS_A{i_p}(expression.angryNeutral,:);

% right-shifted aligned
stimulus{2}.angryNeutral_RS_A_top{i_p} =...
    stimulus{1}.top_RS_A{i_p}(expression.angryNeutral,:);

% angry top + happy bottom
%
% left-shifted aligned
stimulus{2}.angryHappy_LS_A_top{i_p} =...
    stimulus{1}.top_LS_A{i_p}(expression.angryHappy,:);

% right-shifted aligned
stimulus{2}.angryHappy_RS_A_top{i_p} =...
    stimulus{1}.top_RS_A{i_p}(expression.angryHappy,:);

perceptronInput.experiment1{i_p} =...
    [stimulus{2}.happyHappy_LS_A_bottom{i_p};
     stimulus{2}.happyBottom_LS{i_p};                
     stimulus{2}.neutralHappy_LS_A_bottom{i_p};
     stimulus{2}.angryHappy_LS_A_bottom{i_p};
     stimulus{2}.angryAngry_LS_A_top{i_p};
     stimulus{2}.angryTop_LS{i_p};
     stimulus{2}.angryNeutral_LS_A_top{i_p};
     stimulus{2}.angryHappy_LS_A_top{i_p};
     
     stimulus{2}.happyHappy_RS_A_bottom{i_p};
     stimulus{2}.happyBottom_RS{i_p};
     stimulus{2}.neutralHappy_RS_A_bottom{i_p};
     stimulus{2}.angryHappy_RS_A_bottom{i_p};
     stimulus{2}.angryAngry_RS_A_top{i_p};
     stimulus{2}.angryTop_RS{i_p};
     stimulus{2}.angryNeutral_RS_A_top{i_p};
     stimulus{2}.angryHappy_RS_A_top{i_p}];

 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% INPUT TO PERCEPTRON FOR SIMULATION 3 (TANAKA ET AL. EXPERIMENT 3) %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% happy top + happy bottom
%
% left-shifted aligned
stimulus{3}.happyHappy_LS_A_bottom{i_p} =...
    stimulus{2}.happyHappy_LS_A_bottom{i_p};

% right-shifted aligned
stimulus{3}.happyHappy_RS_A_bottom{i_p} =...
    stimulus{2}.happyHappy_RS_A_bottom{i_p};

% top-left bottom-right misaligned
stimulus{3}.happyHappy_TLBR_MA_bottom{i_p} =...
    gaborFeatures.experiment3{i_p}...
    (n.expressions*order.experiment3.NC.TLBR_MA.bottom +...
     expression.happy,:);

% top-right bottom-left misaligned
stimulus{3}.happyHappy_TRBL_MA_bottom{i_p} =...
    gaborFeatures.experiment3{i_p}...
    (n.expressions*order.experiment3.NC.TRBL_MA.bottom +...
     expression.happy,:);


% angry top + happy bottom
%
% left-shifted aligned
stimulus{3}.angryHappy_LS_A_bottom{i_p} =...
    stimulus{2}.angryHappy_LS_A_bottom{i_p};

% right-shifted aligned
stimulus{3}.angryHappy_RS_A_bottom{i_p} =...
    stimulus{2}.angryHappy_RS_A_bottom{i_p};

% top-left bottom-right misaligned
stimulus{3}.angryHappy_TLBR_MA_bottom{i_p} =...
    stimulus{1}.bottom_TLBR_MA{i_p}(expression.angryHappy,:);

% top-right bottom-left misaligned
stimulus{3}.angryHappy_TRBL_MA_bottom{i_p} =...
  stimulus{1}.bottom_TRBL_MA{i_p}(expression.angryHappy,:);


% angry top + angry bottom
%
% left-shifted aligned
stimulus{3}.angryAngry_LS_A_top{i_p} =...
    stimulus{2}.angryAngry_LS_A_top{i_p};

% right-shifted aligned
stimulus{3}.angryAngry_RS_A_top{i_p} =...
    stimulus{2}.angryAngry_RS_A_top{i_p};

% top-left bottom-right misaligned
stimulus{3}.angryAngry_TLBR_MA_top{i_p} =...
    gaborFeatures.experiment3{i_p}...
        (n.expressions*order.experiment3.NC.TLBR_MA.top +...
         expression.angry,:);

% top-right bottom-left misaligned
stimulus{3}.angryAngry_TRBL_MA_top{i_p} =...
    gaborFeatures.experiment3{i_p}...
        (n.expressions*order.experiment3.NC.TRBL_MA.top +...
         expression.angry,:);


% angry top + happy bottom
%
% left-shifted aligned
stimulus{3}.angryHappy_LS_A_top{i_p} =...
    stimulus{2}.angryHappy_LS_A_top{i_p};

% right-shifted aligned
stimulus{3}.angryHappy_RS_A_top{i_p} =...
    stimulus{2}.angryHappy_RS_A_top{i_p};

% top-left bottom-right misaligned
stimulus{3}.angryHappy_TLBR_MA_top{i_p} =...
    stimulus{1}.top_TLBR_MA{i_p}(expression.angryHappy,:);

% top-right bottom-left misaligned
stimulus{3}.angryHappy_TRBL_MA_top{i_p} =...
    stimulus{1}.top_TRBL_MA{i_p}(expression.angryHappy,:);


perceptronInput.experiment3{i_p} =...
    [stimulus{3}.happyHappy_LS_A_bottom{i_p};
     stimulus{3}.happyHappy_RS_A_bottom{i_p};
     stimulus{3}.happyHappy_TLBR_MA_bottom{i_p};
     stimulus{3}.happyHappy_TRBL_MA_bottom{i_p};

     stimulus{3}.angryHappy_LS_A_bottom{i_p};
     stimulus{3}.angryHappy_RS_A_bottom{i_p};
     stimulus{3}.angryHappy_TLBR_MA_bottom{i_p};
     stimulus{3}.angryHappy_TRBL_MA_bottom{i_p};

     stimulus{3}.angryAngry_LS_A_top{i_p};
     stimulus{3}.angryAngry_RS_A_top{i_p};
     stimulus{3}.angryAngry_TLBR_MA_top{i_p};
     stimulus{3}.angryAngry_TRBL_MA_top{i_p};
     
     stimulus{3}.angryHappy_LS_A_top{i_p};
     stimulus{3}.angryHappy_RS_A_top{i_p};
     stimulus{3}.angryHappy_TLBR_MA_top{i_p};
     stimulus{3}.angryHappy_TRBL_MA_top{i_p}];


% Tidy up                     
clear scale temp

cd ..
cd([pwd, '/Composite Face Simulations'])