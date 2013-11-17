clear all;
close all;
clc;

test = wavread('chord.wav');
constants = struct();
constants.samplingRate = 44100;	%Hz
constants.desiredPitchDetectionSampleLength = 0.1; %Seconds
constants.fftWindow = 2^nextpow2(constants.samplingRate*constants.desiredPitchDetectionSampleLength);
constants.actualSL = constants.fftWindow/constants.samplingRate;
constants = createConstants(constants);
constants.fh = figure('position',[10 10 1000 500]);
constants.sp(1) = subplot(3,1,1);
plot(test);
hold on;
constants.overlayH = plot(1:constants.fftWindow,test(1:constants.fftWindow),'r');
constants.sp(2) = subplot(3,1,2);
constants.freqVisualizationIndices = find(constants.freq <=10000);
constants.fftH = plot(constants.freq(constants.freqVisualizationIndices),zeros(1,length(constants.freqVisualizationIndices)));
constants.sp(3) = subplot(3,1,3);
constants.whitenedH = plot(constants.freq(constants.freqVisualizationIndices),zeros(1,length(constants.freqVisualizationIndices)));
for i = 1:constants.fftWindow/2:length(test)-constants.fftWindow;
	constants.epoch = i:i+constants.fftWindow-1;
	detectedf0 = polyphonicPitchDetect(test(constants.epoch),constants);
	disp(['F0 '  num2str(detectedf0) ' dataIndex ' num2str(i)]);
end
