%% PREDICTING HEAD
load('./Regression Matrix Calculation/LYHM_male.mat')
load('./Regression Matrix Calculation/Regression_Matrix.mat')
load('Face.mat')
head_mean = transpose(shp.mu);
head_U = shp.eigVec;
load('./Regression Matrix Calculation/01_MorphableModel.mat')
face_mean = shapeMU;
face_U = shapePC;
input_face = transpose(Face_verts);
pred_head = head_mean + (head_U * (Whf * (transpose(face_U)*(input_face - face_mean))));
%% ---------------
