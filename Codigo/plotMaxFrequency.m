function plotMaxFrequency(D, S, T, fs)
%     maxACTD = [];
%     for i=1:length(D)
%         ACT = D{i};
%         maxAXIS = [];
%         for j = 1:3
%             OCC = ACT{j};
%             maxOCC = [];
%             for k = 1:length(OCC)
%                 maxAmplitude = max(OCC{k});
%                 C = OCC{j};
%                 ind = C == maxAmplitude;
%                 maxFreq
%                 maxOCC{k} = maxAmplitude;
%             end
%             maxAXIS{j} = maxOCC;
%         end
%         maxACTD{i} = maxAXIS;
%     end
%     maxACTS = [];
%     for i=1:length(S)
%         ACT = S{i};
%         maxAXIS = [];
%         for j = 1:3
%             OCC = ACT{j};
%             maxOCC = [];
%             for k = 1:length(OCC)
%                 maxAmplitude = max(OCC{k});
%                 maxOCC{k} = maxAmplitude;
%             end
%             maxAXIS{j} = maxOCC;
%         end
%         maxACTS{i} = maxAXIS;
%     end
%     maxACTT = [];
%     for i=1:length(T)
%         ACT = T{i};
%         maxAXIS = [];
%         for j = 1:3
%             OCC = ACT{j};
%             maxOCC = [];
%             for k = 1:length(OCC)
%                 maxAmplitude = max(OCC{k});
%                 maxOCC{k} = maxAmplitude;
%             end
%             maxAXIS{j} = maxOCC;
%         end
%         maxACTT{i} = maxAXIS;
%     end
    maxACTD = getSPM(D, "true", fs);
    maxACTS = getSPM(S, "true", fs);
    maxACTT = getSPM(T, "true", fs);
    
    % EIXO DOS XX
    figure();
    tiledlayout(1,3);
    nexttile;
    
    % dinamic
    maxWx = cell2mat(maxACTD{1,1}{1,1});
    maxWUx = cell2mat(maxACTD{1,2}{1,1});
    maxWDx = cell2mat(maxACTD{1,3}{1,1});
    plot(maxWx, 'ob');
    hold on;
    plot(maxWUx, 'ob');
    hold on;
    plot(maxWDx, 'ob');
    hold on;

    maxDx = max([max(maxWx), max(maxWUx), max(maxWDx)]);
    minDx = min([min(maxWx), min(maxWUx), min(maxWDx)]);
    upperBound = 0:length(maxWx);
    upperBound(1:end) = maxDx;
    area(upperBound,'basevalue', minDx, 'ShowBaseLine', 'off', 'FaceAlpha', 0.4, 'LineStyle', 'none', 'FaceColor', 'green');
     
        
    % static
    maxSITx = cell2mat(maxACTS{1,1}{1,1});
    maxLAYx = cell2mat(maxACTS{1,2}{1,1});
    maxSTANDx = cell2mat(maxACTS{1,3}{1,1});
    maxDx = [max(maxSITx), max(maxLAYx), max(maxSTANDx)];
    minDx = [min(maxSITx), min(maxLAYx), min(maxSTANDx)];
    plot(maxSITx, 'or');
    hold on;
    plot(maxLAYx, 'or');
    hold on;
    plot(maxSTANDx, 'or');
    
    % transition
    maxSTAND2SITx = cell2mat(maxACTT{1,1}{1,1});
    maxSIT2STANDx = cell2mat(maxACTT{1,2}{1,1});
    maxSIT2LIEx = cell2mat(maxACTT{1,3}{1,1});
    maxLIE2SITx = cell2mat(maxACTT{1,4}{1,1});
    maxSTAND2LIEx = cell2mat(maxACTT{1,5}{1,1});
    maxLIE2STANDx = cell2mat(maxACTT{1,6}{1,1});
    plot(maxSTAND2SITx, 'og');
    hold on;
    plot(maxSIT2STANDx, 'og');
    hold on;
    plot(maxSIT2LIEx, 'og');
    hold on;
    plot(maxLIE2SITx, 'og');
    hold on;
    plot(maxSTAND2LIEx, 'og');
    hold on;
    plot(maxLIE2STANDx, 'og');
    hold on;
    
    xlabel("X-AXIS");
    ylabel("DFT AMPLITUDE");
    hold off
    
    % EIXO DOS YY
    nexttile;
    % dinamic
    maxWy = cell2mat(maxACTD{1,1}{1,2});
    maxWUy = cell2mat(maxACTD{1,2}{1,2});
    maxWDy = cell2mat(maxACTD{1,3}{1,2});
    plot(maxWy, 'ob');
    hold on;
    plot(maxWUy, 'ob');
    hold on;
    plot(maxWDy, 'ob');
    hold on;
    % static
    maxSITy = cell2mat(maxACTS{1,1}{1,2});
    maxLAYy = cell2mat(maxACTS{1,2}{1,2});
    maxSTANDy = cell2mat(maxACTS{1,3}{1,2});
    plot(maxSITy, 'or');
    hold on;
    plot(maxLAYy, 'or');
    hold on;
    plot(maxSTANDy, 'or');

    maxDy = max([max(maxWy), max(maxWUy), max(maxWDy)]);
    minDy = min([min(maxWy), min(maxWUy), min(maxWDy)]);
    upperBound = 0:length(maxWy);
    upperBound(1:end) = maxDy;
    area(upperBound,'basevalue', minDy, 'ShowBaseLine', 'off', 'FaceAlpha', 0.4, 'LineStyle', 'none', 'FaceColor', 'green');
    
    % transition
    maxSTAND2SITy = cell2mat(maxACTT{1,1}{1,2});
    maxSIT2STANDy = cell2mat(maxACTT{1,2}{1,2});
    maxSIT2LIEy = cell2mat(maxACTT{1,3}{1,2});
    maxLIE2SITy = cell2mat(maxACTT{1,4}{1,2});
    maxSTAND2LIEy = cell2mat(maxACTT{1,5}{1,2});
    maxLIE2STANDy = cell2mat(maxACTT{1,6}{1,2});
    plot(maxSTAND2SITy, 'og');
    hold on;
    plot(maxSIT2STANDy, 'og');
    hold on;
    plot(maxSIT2LIEy, 'og');
    hold on;
    plot(maxLIE2SITy, 'og');
    hold on;
    plot(maxSTAND2LIEy, 'og');
    hold on;
    plot(maxLIE2STANDy, 'og');
    hold on;
    
    xlabel("Y-AXIS");
    title("MAX DFT AMPLITUDE FOR XYZ");
    
    % EIXO DOS ZZ
    nexttile;
    % dinamic
    maxWz = cell2mat(maxACTD{1,1}{1,3});
    maxWUz = cell2mat(maxACTD{1,2}{1,3});
    maxWDz = cell2mat(maxACTD{1,3}{1,3});
    plot(maxWz, 'ob');
    hold on;
    plot(maxWUz, 'ob');
    hold on;
    plot(maxWDz, 'ob');
    hold on;

    maxDz = max([max(maxWz), max(maxWUz), max(maxWDz)]);
    minDz = min([min(maxWz), min(maxWUz), min(maxWDz)]);
    upperBound = 0:length(maxWz);
    upperBound(1:end) = maxDz;
    area(upperBound,'basevalue', minDz, 'ShowBaseLine', 'off', 'FaceAlpha', 0.4, 'LineStyle', 'none', 'FaceColor', 'green');

    % static
    maxSITz = cell2mat(maxACTS{1,1}{1,3});
    maxLAYz = cell2mat(maxACTS{1,2}{1,3});
    maxSTANDz = cell2mat(maxACTS{1,3}{1,3});
    plot(maxSITz, 'or');
    hold on;
    plot(maxLAYz, 'or');
    hold on;
    plot(maxSTANDz, 'or');
    % transition
    maxSTAND2SITz = cell2mat(maxACTT{1,1}{1,3});
    maxSIT2STANDz = cell2mat(maxACTT{1,2}{1,3});
    maxSIT2LIEz = cell2mat(maxACTT{1,3}{1,3});
    maxLIE2SITz = cell2mat(maxACTT{1,4}{1,3});
    maxSTAND2LIEz = cell2mat(maxACTT{1,5}{1,3});
    maxLIE2STANDz = cell2mat(maxACTT{1,6}{1,3});
    plot(maxSTAND2SITz, 'og');
    hold on;
    plot(maxSIT2STANDz, 'og');
    hold on;
    plot(maxSIT2LIEz, 'og');
    hold on;
    plot(maxLIE2SITz, 'og');
    hold on;
    plot(maxSTAND2LIEz, 'og');
    hold on;
    plot(maxLIE2STANDz, 'og');
    hold off;

    xlabel("Z-AXIS");
    %legend("DINAMIC","STATIC","TRANSITION","Location","SouthEast");
end
