function getlabels(t,z)
signal = imread(sprintf('CELL/Cell_%d_%d.tif',t,z));
raw = imread(getBFfileName(z,t));
filename = sprintf('LABELS/svmsignal_scale_t%d_z%d',t,z);
if exist(filename,'file')==2
    delete(filename);
end
fid = fopen(filename,'wt+');
SQUARE_WIDTH = 17;
padding = (SQUARE_WIDTH-1)/2;
sampling = 6;
nosig_sampling = 0;
for i = 1+padding:sampling:1002-padding
   for j = 1+padding:sampling:1004-padding
       now = raw(i-padding:i+padding,j-padding:j+padding);
       if signal(i,j)
		   now_svmtext = matrix2svmtext(true, [i;j;z], now);
		   fprintf(fid, now_svmtext);      
       else
           nosig_sampling = nosig_sampling + 1;
           if nosig_sampling == 100
                now_svmtext = matrix2svmtext(false, [i;j;z], now);
                fprintf(fid, now_svmtext);
                nosig_sampling = 0;
           end
       end
       
   end
end
fclose(fid);

end

function str = matrix2svmtext(is_signal, position, now_matrix)
XPOSITION_SCALE = 1004;
YPOSITION_SCALE = 1002;
ZPOSITION_SCALE = 169;
INTENSITY_SCALE = 1000;
matrix_size = size(now_matrix);
if 	matrix_size(1) ~= 17 || matrix_size(2) ~= 17
    error('Error. The matrix size is not equal to 17*17.');
end
% classification
if is_signal
    str = '+1 ';
else
    str = '-1 ';
end
% position data
index = 1;
scale_position = position./[XPOSITION_SCALE;YPOSITION_SCALE;ZPOSITION_SCALE];
for i = 1:3
    str = sprintf('%s%d:%f ',str,index,scale_position(i));
    index = index + 1;
end
% 17*17 pixels intensity data
for i = 1:17
   for j = 1:17
       pixelintensity = double(now_matrix(i,j))/INTENSITY_SCALE;
       str = sprintf('%s%d:%f ',str,index,pixelintensity);
       index = index + 1;
   end
end
str = sprintf('%s\n',str);
end
