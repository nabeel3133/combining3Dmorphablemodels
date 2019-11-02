%% PREDICTING HEAD
load('LYHM_male.mat')
load('Whf.mat')
load('Face.mat')
head_mean = transpose(shp.mu);
head_U = shp.eigVec;
load('BFM.mat')
face_mean = shapeMU;
face_U = shapePC;
input_face = transpose(Face_verts);
pred_head = head_mean + (head_U * (Whf * (transpose(face_U)*(input_face - face_mean))));
%% ---------------
