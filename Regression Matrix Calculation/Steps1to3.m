%% LOADING MAT FILES AND VARIABLES
%load('LYHM_global.mat')
load('LYHM_male.mat')
load('BFM.mat')

total_heads = 700;

face_mean = shapeMU;
face_U = shapePC;

head_mean=transpose(shp.mu);
head_U=shp.eigVec;
head_lambda=shp.eigVal(1:100,1);
%% --------------------------------------------------

% gaussian =normrnd(0,3, 1, 1);
% Sd = 0;
% gaussian_values = [-3 -2 -1 1 2 3];
% model_min = 1;
% model_max = 100;
% model_rand = int16(model_min+rand(1,n)*(model_max-model_min));


%% GENERATING RANDOM HEADS USING FIRST EIGENVECTORS
gaussian_min=-3;
gaussian_max=3;

n=1;

ph = zeros(total_heads,1);
new_heads = zeros(length(head_U),total_heads);
model_numbers = zeros(total_heads,1);
j = 1;
for i=1:total_heads
%     Sd = gaussian_values(i);
%     ph(i,1) = sqrt(head_lambda(1,1))*Sd;
%     new_heads(:,i)=  head_mean + (head_U(:,1)* ph(i,1)) ;

    model_rand = randi([1,100]);
    model_numbers(j,1) = model_rand;
    Sd = gaussian_min+rand(1,n)*(gaussian_max-gaussian_min);
    ph(i,1) = sqrt(head_lambda(model_rand,1))*Sd;
    new_heads(:,i)=  head_mean + (head_U(:,model_rand)* ph(i,1)) ;
 
    j = j+1;
end
%% --------------------------------------------------


%% GET PARAMETERS OF HEAD USING ENTIRE EIGENSPACE
Ch = zeros(length(head_U(1,:)),total_heads);
for i=1:total_heads
    Ch(:,i) = transpose(head_U) * (new_heads(:,i) - head_mean);
end
%% --------------------------------------------------


%% TRANSFORMING HEADS  
temp_transformed= ones(length(head_U)/3,4);
transformed_heads = ones(length(head_U)/3,3,total_heads);
Transformation_matrix = [9.757 0 0 0; 0 9.757 0 0; 0 0 9.757 0; 0 232.59 -316.33 1];
for i=1:total_heads
    temp_transformed(:,1:3) = transpose(reshape(new_heads(:,i), [3,length(head_U)/3]));
    temp_transformed = temp_transformed * Transformation_matrix;
    transformed_heads(:,:,i)= temp_transformed(:,1:3);
end
%% --------------------------------------------------



%% APPLY NRICP
%% --------------------------------------------------










