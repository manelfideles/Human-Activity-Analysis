close all;
clear;

matfiles = dir( fullfile('dataset\', '*.txt' ));

fs = 50;

%Activity labels
labels_fid = fopen('dataset\activity_labels.txt');
activity_labels = textscan(labels_fid, '%d %s');
activity_labels = activity_labels{2};

%Activity intervals
f = fopen('dataset\labels.txt');
lines = textscan(f, '%d %d %d %d %d');
experiment_id = lines{1};
user_id = lines{2};
activity_id = lines{3};
label_start = lines{4};
label_end = lines{5};
fclose(f);

for i=1:1 % length(matfiles) - 2
    
    % 3 - IMPORTING AND PLOTTING RAW DATA
    % open data file
    [acc_x, acc_y, acc_z] = openExperimentFile(matfiles, i);
    experiment_length = length(experiment_id(i: find(experiment_id ~= i)-1));
    sample_time = linspace(1, length(acc_x) / (fs * 60), length(acc_x));
    
    % plot raw data and label activities from file
    figure(1);
    plotExperiment(sample_time, acc_x, acc_y, ...
        acc_z, label_start, label_end, activity_labels, ...
        activity_id, experiment_length);
    
    % 4 - ANALYSIS
    % 4.1 - Calculating the DFT and comparing windows
    W = getActivityVectors("W", label_start, label_end, acc_x, acc_y, acc_z, experiment_length, activity_id, activity_labels);
    WU = getActivityVectors("W-U", label_start, label_end, acc_x, acc_y, acc_z, experiment_length, activity_id, activity_labels);
    WD = getActivityVectors("W-D", label_start, label_end, acc_x, acc_y, acc_z, experiment_length, activity_id, activity_labels);
    SIT = getActivityVectors("SIT", label_start, label_end, acc_x, acc_y, acc_z, experiment_length, activity_id, activity_labels);
    STAND = getActivityVectors("STAND", label_start, label_end, acc_x, acc_y, acc_z, experiment_length, activity_id, activity_labels);
    LAY = getActivityVectors("LAY", label_start, label_end, acc_x, acc_y, acc_z, experiment_length, activity_id, activity_labels);
    STAND2SIT = getActivityVectors("STAND-SIT", label_start, label_end, acc_x, acc_y, acc_z, experiment_length, activity_id, activity_labels);
    SIT2STAND = getActivityVectors("SIT-STAND", label_start, label_end, acc_x, acc_y, acc_z, experiment_length, activity_id, activity_labels);
    SIT2LIE = getActivityVectors("SIT-LIE", label_start, label_end, acc_x, acc_y, acc_z, experiment_length, activity_id, activity_labels);
    LIE2SIT = getActivityVectors("LIE-SIT", label_start, label_end, acc_x, acc_y, acc_z, experiment_length, activity_id, activity_labels);
    STAND2LIE = getActivityVectors("STAND-LIE", label_start, label_end, acc_x, acc_y, acc_z, experiment_length, activity_id, activity_labels);
    LIE2STAND = getActivityVectors("LIE-STAND", label_start, label_end, acc_x, acc_y, acc_z, experiment_length, activity_id, activity_labels);
    
    DINAMIC = {W, WU, WD};
    STATIC = {SIT, LAY, STAND};
    TRANSITION = {STAND2SIT, SIT2STAND, SIT2LIE, LIE2SIT, STAND2LIE, LIE2STAND};
    
    % Raw signal w/ windowing
        % Hann (good for most cases, eliminates discontinuities)
%     viewThroughWindow(W, "hann");
%     viewThroughWindow(SIT, "hann");
%     viewThroughWindow(STAND2SIT, "hann");
    
        % Hamming (good freq.res, detects fair amount of m components)
%     viewThroughWindow(W, "hamming");
%     viewThroughWindow(SIT, "hamming");
%     viewThroughWindow(STAND2SIT, "hamming");
    
    % DFT w/out windowing (aka rectangular window)
    dftDINAMIC = calcActivityDFT(DINAMIC, fs);
    dftSTATIC = calcActivityDFT(STATIC, fs);
    dftTRANSITION = calcActivityDFT(TRANSITION, fs);
    
    % DFT w/ windowing
%     figure(2);
        %Hann (good for most cases, eliminates discontinuities)
%     viewThroughWindow(dftDINAMIC{1}, "hann");
%     viewThroughWindow(dftSTATIC{1}, "hann");
    viewThroughWindow(dftTRANSITION{1}, "hann");
    
        %Hamming (good freq.res, detects fair amount of m components)
%     figure(3);
%     viewThroughWindow(dftDINAMIC{1}, "hamming");
%     viewThroughWindow(dftSTATIC{1}, "hamming");
    viewThroughWindow(dftTRANSITION{1}, "hamming");

    % 4.2 - Step stats
    
    
    
end
