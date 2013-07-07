function [dprime, c, cnorm] =...
    sensitivitycriterion4sdt(hitRate, FARate)
%SENSITIVITYCRITERION4SDT computes the signal detection theory
%   criterion and d-prime parameters for the same-different
%   paradigm.

    pcmax = normcdf(0.5*(norminv(hitRate)-norminv(FARate)));
    dprime = 2*norminv(0.5*(1 + sqrt((2*pcmax)-1)));
    c = -0.5*(norminv(hitRate)+norminv(FARate));
    cnorm = c./(norminv(hitRate)-norminv(FARate));
end