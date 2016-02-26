function [predict_label, accuracy, dec_values, signal_scale_label, signal_scale_inst] = svmflow(c, g, is_skipread);
if nargin < 3
   is_skipread = false; 
end
if ~is_skipread
    [signal_scale_label, signal_scale_inst] = libsvmread('signal_scale');
else
    signal_scale_label = evalin('base','signal_scale_label');
    signal_scale_inst = evalin('base','signal_scale_inst');
end
model = libsvmtrain(signal_scale_label, signal_scale_inst, sprintf('-c %f -g %f -v 2 -h 0',c,g));
[predict_label, accuracy, dec_values] = libsvmpredict(signal_scale_label, signal_scale_inst, model);

end