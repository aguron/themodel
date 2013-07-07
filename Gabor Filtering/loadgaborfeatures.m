% Script
%
% LOADGABORFEATURES
%   Notes:
%   06/27/2013
%     - loads Gabor filter features into Matlab workspace
%
i = 1;

locationFeatures = './Gabor Features/';

files = {'em.mat' 'gs.mat' 'jj.mat' 'mf.mat' 'mo.mat' ...
         'nr.mat' 'pe.mat' 'pf.mat' 'sw.mat' 'wf.mat'};
     
for fp=files
    fp = [locationFeatures, files{i}];
    load(fp,'NC_LS_A_faces', 'NC_RS_A_faces',...
            'C_LS_A_faces', 'C_RS_A_faces',...
            'C_TLBR_MA_faces', 'C_TRBL_MA_faces',...
            'TH_LS_faces', 'TH_RS_faces',...
            'BH_LS_faces', 'BH_RS_faces',...
            'NC_TLBR_MA_faces', 'NC_TRBL_MA_faces');

    NC_LS_A(n.expressions*(i-1)+1:n.expressions*i,:) = NC_LS_A_faces;
    NC_RS_A(n.expressions*(i-1)+1:n.expressions*i,:) = NC_RS_A_faces;
    NC_TLBR_MA(n.expressions*(i-1)+1:n.expressions*i,:) = NC_TLBR_MA_faces;
    NC_TRBL_MA(n.expressions*(i-1)+1:n.expressions*i,:) = NC_TRBL_MA_faces;


    C_LS_A(n.compositeFaces*(i-1)+1:n.compositeFaces*i,:) = C_LS_A_faces;
    C_RS_A(n.compositeFaces*(i-1)+1:n.compositeFaces*i,:) = C_RS_A_faces;
    C_TLBR_MA(n.compositeFaces*(i-1)+1:n.compositeFaces*i,:) =...
        C_TLBR_MA_faces;
    C_TRBL_MA(n.compositeFaces*(i-1)+1:n.compositeFaces*i,:) =...
        C_TRBL_MA_faces;


    TH_LS(n.expressions*(i-1)+1:n.expressions*i,:) = TH_LS_faces;
    TH_RS(n.expressions*(i-1)+1:n.expressions*i,:) = TH_RS_faces;

    BH_LS(n.expressions*(i-1)+1:n.expressions*i,:) = BH_LS_faces;
    BH_RS(n.expressions*(i-1)+1:n.expressions*i,:) = BH_RS_faces;


    i = i + 1;
end
clear i;