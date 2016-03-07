
t=1;
z_min=8;
z_max=20;

% %raw image
% for k=z_min:z_max
% I=imread(sprintf('Copy_of_StrainEnergy3D_SD_2015_12_31/BFFRAME/BFframe_t%06i_%04i.tif',t,k));    
% comp_im(:,:,k-z_min+1)=I; 
% end
% max_im=max(comp_im,[],3);

sampling=10;
[x,y,z,u,v,w,lar_x,lar_y,lar_z,lar_u,lar_v,lar_w,count]=original_coor_ty(t,z_min,z_max,sampling);


figure,     
% imshow(max_im*30)
% hold on
small_move=quiver(y,z,v,w,'color','red','MaxHeadSize',0.2,'AutoScaleFactor',0.89,'AutoScale','off');
hold on
Lar_move=quiver(lar_y,lar_z,lar_v,lar_w,'color','green','MaxHeadSize',0.2,'AutoScaleFactor',0.89,'AutoScale','off','Marker','x');
xlabel('y axis');
ylabel('z axis');
title(sprintf('z=%d-%d-yz',z_min,z_max));