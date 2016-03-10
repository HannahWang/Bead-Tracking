function [predict_label, accuracy, dec_values, signal_scale_label, signal_scale_inst, model] = svmflow(c, g, t, z, is_skipmodel, is_skipread);
if nargin < 6
    if nargin < 5
       is_skipmodel = false; 
    end
    is_skipread = false;
end
if is_skipmodel
   is_skipread = true; 
end

if ~is_skipread
    [signal_scale_label, signal_scale_inst] = libsvmread('signal_scale');
else
    signal_scale_label = evalin('base','signal_scale_label');
    signal_scale_inst = evalin('base','signal_scale_inst');
end
if ~is_skipmodel
    model = libsvmtrain(signal_scale_label, signal_scale_inst, sprintf('-c %f -g %f -h 0',c,g));
else
    model = evalin('base','model');
end

[signal_scale_label, signal_scale_inst] = libsvmread(sprintf('LABELS/rawsignal_scale_t%d_z%d',t,z));
[predict_label, accuracy, dec_values] = libsvmpredict(signal_scale_label, signal_scale_inst, model);

drawpredict(t,z,predict_label);
end