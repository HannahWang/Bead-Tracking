% max intensity z projection
%function maxpro_im(t,z_min,z_max)
max_pro=zeros(1002,1004);
z_min=1;
z_max=2;
for k=z_min:z_max
    for i=1:1002
        for j=1:1004
    comp_image=imread(sprintf('Copy_of_StrainEnergy3D_SD_2015_12_31/BFFRAME/BFframe_t%06i_%04i',t,k))
         if max_pro(i,j)<comp_image(i,j)
            max_pro(i,j)=comp_image(i,j); 
         end
    imshow(max_pro) 
   % imshowpair(BWdfill,I,'montage');
        end
    end
end
      