function [x,y,z,u,v,w,lar_x,lar_y,lar_z,lar_u,lar_v,lar_w,count]=original_coor_ty(t,z_min,z_max,sampling)

load('bead_tnxyz.mat');


%find start_num
n_row_idx = (bead_tnxyz(:,5) == z_max);
n_filtered = bead_tnxyz(n_row_idx,:);
t_row_idx = (n_filtered(:,1) == 1);
nt_filtered = n_filtered(t_row_idx,:);
% while n_filt_size(1) == 0
%     n_row_idx = (bead_tnxyz(:,5) == z_max-1);
%     n_filtered = bead_tnxyz(n_row_idx,:);
% end
start_num = min(nt_filtered(:,2));

%find max_bead_num
n_row_idx = (bead_tnxyz(:,5) == z_min);
n_filtered = bead_tnxyz(n_row_idx,:);
t_row_idx = (n_filtered(:,1) == 1);
nt_filtered = n_filtered(t_row_idx,:);

% n_filt_size = size(n_filtered);
% while n_filt_size(1) == 0
%     n_row_idx = (bead_tnxyz(:,5) == z_min+1);
%     n_filtered = bead_tnxyz(n_row_idx,:);
% end
max_bead_num = max(nt_filtered(:,2));

% position 
number=((max_bead_num-start_num+1)-mod((max_bead_num-start_num+1),sampling))/sampling; 
Atemp=zeros(number,3);
Atemp2=zeros(number,3);
bead_num=1;
index_i=1;
for i=start_num:sampling:max_bead_num+1
%original
a1=get_bead_pos_ty(t, i);
Atemp(index_i, :) = a1;
%next
a2=get_bead_pos_ty(t+1,i);
Atemp2(index_i, :) = a2;

index_i=index_i+1;
end

ori=Atemp.';

next=Atemp2.';

%displacement
dis=next-ori;
dis2=dis;

x1=ori(1,:);
y1=ori(2,:);
z1=ori(3,:);
%correction(u v w)
m_u=0.0803;
m_v=-0.0387;
m_w=-0.1704;
u1=dis2(1,:)-m_u;
v1=dis2(2,:)-m_v;
w1=dis2(3,:)-m_w;


x = [];
y = [];
z = [];
u = [];
v = [];
w = [];

lar_x=[];
lar_y=[];
lar_z=[];
lar_u=[];
lar_v=[];
lar_w=[];
count = [0 0 0 0];
% group based on displacement
for i=1:number
    if  u1(i)^2+v1(i)^2+w1(i)^2 >= 1 %>1 um
        lar_x=[lar_x x1(i)];
        lar_y=[lar_y y1(i)];
        lar_z=[lar_z z1(i)];
        lar_u=[lar_u u1(i)];
        lar_v=[lar_v v1(i)];
        lar_w=[lar_w w1(i)]; 
        
        if u1(i)^2+v1(i)^2+w1(i)^2 >= 25 %>5 um
            count(4) = count(4) + 1;
        elseif u1(i)^2+v1(i)^2+w1(i)^2 >= 4 %2-5
            count(3) = count(3) + 1;
        else
            count(2) = count(2) + 1; %1-2
        end
        
    else
        x=[x x1(i)]; 
        y=[y y1(i)];
        z=[z z1(i)];
        u=[u u1(i)];
        v=[v v1(i)];
        w=[w w1(i)]; 
        count(1) = count(1) + 1;
    end
end



