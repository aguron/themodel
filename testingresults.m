% left-shifted and right-shifted face stimuli features alternate
% every 7 entries
%
% display accuracy results
% left-shifted faces:
disp([Class.Test(1:n.Expr,:)...
      Y_test(1:n.Expr,:)...
      Class.Test(2*n.Expr+1:3*n.Expr,:)...
      Y_test(2*n.Expr+1:3*n.Expr,:)...
      Class.Test(4*n.Expr+1:5*n.Expr,:)...
      Y_test(4*n.Expr+1:5*n.Expr,:)]);

% right-shifted faces:
disp([Class.Test(n.Expr+1:2*n.Expr,:)...
      Y_test(n.Expr+1:2*n.Expr,:)...
      Class.Test(3*n.Expr+1:4*n.Expr,:)...
      Y_test(3*n.Expr+1:4*n.Expr,:)...
      Class.Test(5*n.Expr+1:6*n.Expr,:)...
      Y_test(5*n.Expr+1:6*n.Expr,:)]);


% store results
% confusion matrices
for i=1:6*n.Expr
    % left-shifted faces
    %
    % full face
    if ((i >= 1) && (i <= n.Expr))
        Conf_Mx.NC_LS_A(Y_test(i),Class.Test(i)) =...
          Conf_Mx.NC_LS_A(Y_test(i),Class.Test(i)) + 1;
    end

    % top-half face
    if ((i >= 2*n.Expr+1) && (i <= 3*n.Expr))
        Conf_Mx.TH_LS_A(Y_test(i),Class.Test(i)) =...
          Conf_Mx.TH_LS_A(Y_test(i),Class.Test(i)) + 1;
    end

    % bottom-half face
    if ((i >= 4*n.Expr+1) && (i <= 5*n.Expr))
        Conf_Mx.BH_LS_A(Y_test(i),Class.Test(i)) =...
          Conf_Mx.BH_LS_A(Y_test(i),Class.Test(i)) + 1;
    end

    % right-shifted faces
    %
    % full face
    if ((i >= n.Expr+1) && (i <= 2*n.Expr))
        Conf_Mx.NC_RS_A(Y_test(i),Class.Test(i)) =...
          Conf_Mx.NC_RS_A(Y_test(i),Class.Test(i)) + 1;
    end

    % top-half face
    if ((i >= 3*n.Expr+1) && (i <= 4*n.Expr))
        Conf_Mx.TH_RS_A(Y_test(i),Class.Test(i)) =...
          Conf_Mx.TH_RS_A(Y_test(i),Class.Test(i)) + 1;
    end

    % bottom-half face
    if ((i >= 5*n.Expr+1) && (i <= 6*n.Expr))
        Conf_Mx.BH_RS_A(Y_test(i),Class.Test(i)) =...
          Conf_Mx.BH_RS_A(Y_test(i),Class.Test(i)) + 1;
    end
end

% overall
%
% full face
Conf_Mx.NC_A = Conf_Mx.NC_LS_A + Conf_Mx.NC_RS_A;

% top-half face
Conf_Mx.TH_A = Conf_Mx.TH_LS_A + Conf_Mx.TH_RS_A;

% bottom-half face
Conf_Mx.BH_A = Conf_Mx.BH_LS_A + Conf_Mx.BH_RS_A;


% Percentage Error
% Current iteration on a particular subset
i_i = mod(i_r - 1, n.Runs2) + 1;
% left-shifted faces
%
% full face
Pct_Acc.NC_LS_A(i_t, i_i) = ...
    100*(1 - pdist([Class.Test(1:n.Expr,:)';...
    Y_test(1:n.Expr,:)'], 'hamming'));

% top-half face
Pct_Acc.TH_LS_A(i_t, i_i) = ...
    100*(1 - pdist([Class.Test(2*n.Expr+1:3*n.Expr,:)';...
    Y_test(2*n.Expr+1:3*n.Expr,:)'], 'hamming'));

% bottom-half face
Pct_Acc.BH_LS_A(i_t, i_i) = ...
    100*(1 - pdist([Class.Test(4*n.Expr+1:5*n.Expr,:)';...
    Y_test(4*n.Expr+1:5*n.Expr,:)'], 'hamming'));

% right-shifted faces
%
% full face
Pct_Acc.NC_RS_A(i_t, i_i) = ...
    100*(1 - pdist([Class.Test(n.Expr+1:2*n.Expr,:)';...
    Y_test(n.Expr+1:2*n.Expr,:)'], 'hamming'));

% top-half face
Pct_Acc.TH_RS_A(i_t, i_i) = ...
    100*(1 - pdist([Class.Test(3*n.Expr+1:4*n.Expr,:)';...
    Y_test(3*n.Expr+1:4*n.Expr,:)'], 'hamming'));

% bottom-half face
Pct_Acc.BH_RS_A(i_t, i_i) = ...
    100*(1 - pdist([Class.Test(5*n.Expr+1:6*n.Expr,:)';...
    Y_test(5*n.Expr+1:6*n.Expr,:)'], 'hamming'));

% overall
%
% full face
Pct_Acc.NC_A(i_t, i_i) = ...
    100*(1 - pdist([Class.Test(1:2*n.Expr,:)';...
    Y_test(1:2*n.Expr,:)'], 'hamming'));

% top-half face
Pct_Acc.TH_A(i_t, i_i) = ...
    100*(1 - pdist([Class.Test(2*n.Expr+1:4*n.Expr,:)';...
    Y_test(2*n.Expr+1:4*n.Expr,:)'], 'hamming'));

% bottom-half face
Pct_Acc.BH_A(i_t, i_i) = ...
    100*(1 - pdist([Class.Test(4*n.Expr+1:6*n.Expr,:)';...
    Y_test(4*n.Expr+1:6*n.Expr,:)'], 'hamming'));