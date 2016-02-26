function [best_accuracy, best_c, best_g] = grid()
[signal_scale_label, signal_scale_inst] = libsvmread('signal_scale');
best_accuracy = 0;
for ce = -4:5
   c = exp(ce*log(2));
   for ge = -5:2
        g = exp(ge*log(2));
        model = libsvmtrain(signal_scale_label, signal_scale_inst, sprintf('-c %f -g %f -v 3 -h 0',c,g));
        %[predict_label, accuracy, dec_values] = libsvmpredict(signal_scale_label, signal_scale_inst, model);
        if model > best_accuracy
            best_accuracy = model;
            best_c = c;
            best_g = g;
        end
   end
end
end