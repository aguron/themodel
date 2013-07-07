function gaborFilters = gaborfilterset()
%GABORFILTERSET generates 40 Gabor filters:
%   5 frequencies and 8 orientations

    cd([pwd, '/Stiven Schwanz Dias'])

    gaborFilters.f4 = [];
    gaborFilters.f8 = [];
    gaborFilters.f16 = [];
    gaborFilters.f32 = [];
    gaborFilters.f64 = [];
    
    gaborFilters.orientation = 0:7;
    gaborFilters.frequency = 2:6;
    
    for i=gaborFilters.orientation
        for j=gaborFilters.frequency
            S = 3/(sqrt(2*pi)*(2^j));
            F = 1/(2^j);
            W = (i*pi)/8;
            P = 0;

            [gaborFilter, ~]=gaborfilter(1,S,F,W,P);

            switch j
                case 2
                    gaborFilters.f4 = [gaborFilters.f4 gaborFilter];
                case 3
                    gaborFilters.f8 = [gaborFilters.f8 gaborFilter];
                case 4
                    gaborFilters.f16 = [gaborFilters.f16 gaborFilter];
                case 5
                    gaborFilters.f32 = [gaborFilters.f32 gaborFilter];
                case 6
                    gaborFilters.f64 = [gaborFilters.f64 gaborFilter];
                otherwise
                    disp('Error');
            end
        end
    end
    
    % Tidy up
    cd ..
end