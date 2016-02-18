function getlabels(t,z)
signal = imread(sprintf('CELL/Cell_%d_%d.tif',t,z));
raw = imread(getBFfileName(z,t));
%mkdir('LABELS');
%cd('LABELS');
%mkdir('');
square_width = 17;
padding = (square_width-1)/2;
for i = 1+padding:4:1002-padding
   for j = 1+padding:4:1004-padding
       now = raw(i-padding:i+padding,j-padding:j+padding);
       if signal(i,j)
           imwrite(now, sprintf('Bead-Tracking/LABELS/with_signal/t%d_z%d_%04i_%04i.png',t,z,i,j));
       end
       
   end
end

end