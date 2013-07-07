function bargraph(data, errorbars,...
                   ctitle, clegend,...
                   cylabel, cgrouplabels,...
                   cfilepath, cfiletype,...
                   multplot)
%BARGRAPH generates (a) bar chart(s) with one or more series

    % size of data
    [M,N] = size(data);

    % New figure
    figure;

    if (multplot == 0) || (N == 1)
        % Single plot
        if (N == 1)
            % One bar in each group
            % Space between bars
            % No legend
            h = bar(data,0.5);

            % Color the bar series
            set(h(1), 'FaceColor', 0.75*ones(1,3))

        else
            % Multiple bars in each group
            % No space between bars
            % Legend
            h = bar(data,1);

            % Color the bar series
            for bsi=1:N
                set(h(bsi), 'FaceColor',...
                    (0.75/(N-1))*(bsi-1)*ones(1,3))
            end

            hl = legend(char(clegend));

            % Set font size
            set(hl, 'FontSize', 16,...
                    'FontWeight', 'bold');

            % Remove legend box
            set(hl, 'Box', 'off');

            % Allow background to show through legend box
            set(hl, 'Color', 'none')

            % Place legend outside plot area
            set(hl, 'Location', 'EastOutside');

        end
        hold on;

        % Get direct access to invididual bar series
        hc=get(h,'Children');

        % Compute the Errorbar locations for each bar series
        x = zeros(M,N);
        for bsi=1:N
            if (N == 1)
                hxi = get(hc,'XData');
            else
                hxi = get(hc{bsi},'XData');
            end
            x(:,bsi) = mean(hxi(2:3,:))';
        end

        % Insert Errorbars (color of errorbars is black)
        errorbar(x,data,errorbars,'.k');

        % title, legend and labels
        title(ctitle,...
              'FontName', 'Times New Roman',...
              'FontSize', 24);

        ylabel(cylabel,...
              'FontName', 'Times New Roman',...
              'FontSize', 18,...
              'FontWeight', 'bold');

        % Pad the group labels to the same length
        cgrouplabels = char(cgrouplabels);
        newcgrouplabels = cell(size(cgrouplabels,1),1);
        grouplabelarray = [];
        for i=1:size(cgrouplabels,1)
            newcgrouplabels(i) = {cgrouplabels(i,:)};
            grouplabelarray = [grouplabelarray; newcgrouplabels(i)];
        end

        if ((N == 1) && (M > 2)) || (N > 2)
            fontsize = 8;
        else
            fontsize = 16;
        end

        set(gca,'XTickLabel', grouplabelarray,...
            'FontName', 'Times New Roman',...
            'FontSize', fontsize,...
            'FontWeight', 'bold');

        % Resize the figure;
        % N.B. screenSize = get(0,'ScreenSize'); % Screen resolution
        figSize = get(gcf,'Position');
        figSize(4) = 0.6*figSize(4);
        set(gcf,'Position', figSize);

        hold off

    else
        % Multiple plots (Space between bars)
        % (There must be more than one bar in each group)
        % All the plots have the same range of y values
        yrange = [Inf -Inf];

        for ploti=1:M
            subplot(1,M,ploti);
            h = bar(data(ploti,:),0.5);

            % Color the bar series
            set(h(1), 'FaceColor', 0.75*ones(1,3))
            hold on;

            % Get direct access to invididual bar series
            hc=get(h,'Children');

            % Compute the Errorbar locations for each bar series
            x = zeros(1,N);
            hxi = get(hc,'XData');
            x = mean(hxi(2:3,:))';

            % Insert Errorbars (color of errorbars is black)
            subplot(1,M,ploti);
            errorbar(x,data(ploti,:),errorbars(ploti,:),'.k');

            % title, legend and labels
            title(cgrouplabels{ploti},...
                  'FontName', 'Times New Roman',...
                  'FontSize', 24);

            ylabel(cylabel,...
                  'FontName', 'Times New Roman',...
                  'FontSize', 18,...
                  'FontWeight', 'bold');

            % Pad the bar labels to the same length
            cbarlabels = char(clegend);
            newcbarlabels = cell(size(cbarlabels,1),1);
            barlabelarray = [];
            for i=1:size(cbarlabels,1)
                newcbarlabels(i) = {cbarlabels(i,:)};
                barlabelarray = [barlabelarray; newcbarlabels(i)];
            end

            if ((N == 1) && (M > 2)) || (N > 2)
                fontsize = 8;
            else
                fontsize = 16;
            end

            set(gca,'XTickLabel', barlabelarray,...
                'FontName', 'Times New Roman',...
                'FontSize', fontsize,...
                'FontWeight', 'bold');

            % Resize the figure;
            % N.B. screenSize = get(0,'ScreenSize'); % Screen resolution
            figSize = get(gcf,'Position');
            figSize(4) = 0.6*figSize(4);
            set(gcf,'Position', figSize);

            hold off

            yrange = [min([yrange(1) min(ylim)]),...
                      max([yrange(2) max(ylim)])];
        end

        for ploti=1:M
            subplot(1,M,ploti);
            ylim(yrange)
        end
    end

    % save bar chart
    saveas(gca, cfilepath, cfiletype)

end

