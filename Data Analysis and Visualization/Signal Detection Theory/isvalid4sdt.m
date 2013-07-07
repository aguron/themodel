function indicator = isvalid4sdt(HitRate, FARate)
%ISVALID4SDT determines if the signal detection theory
%   computations for the same-different paradigm can be done

    indicator = 0;
    if sum(HitRate < FARate) > 0
        indicator = 1;
    end
end