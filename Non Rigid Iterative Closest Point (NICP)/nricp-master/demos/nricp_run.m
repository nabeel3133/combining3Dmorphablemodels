%% APPLYING NRICP
% Load data
load ../data/Head_Tri.mat
load ../data/Target_MeanFace_Cropped.mat

% Specify that surface normals need not to be used.
Options.useNormals = 0;

% Specify that the source deformations should be plotted.
Options.plot = 1;

Options.gamm = 1;   %Default 1
Options.epsilon = 1e-4;   %Default 1e-4
Options.lambda = 1;  %Default 1
Options.alphaSet = linspace(100, 10, 20);  %Default linspace(100,10,20)
Options.biDirectional = 0;  %Default 0
Options.rigidInit = 1;   %Default 1
Options.ignoreBoundary = 1;  %Default 1
Options.normalWeighting = 1;  %Default 1

Source.faces = headTri;

Target.faces = TargetTri;
Target.vertices = TargetVerts;
Target.normals = TargetNorms;
 
registered_heads = zeros(length(head_U)/3,3,total_heads);

for i=1:total_heads
    disp(i);
    Source.vertices = transformed_heads(:,:,i);
    Source.normals = transformed_heads(:,:,i);
    [pointsTransformed, X] = nricp(Source, Target, Options);
    registered_heads(:,:,i) = pointsTransformed;
end
%% --------------------------------------------------


%% PROJECTING HEAD AND GENERATING CORRESPONDING FACE
proj_X = zeros(length(face_U),1,total_heads);
for i=1:total_heads
    X = reshape(transpose(registered_heads(:,:,i)),[length(head_U),1]);
    ph=(transpose(head_U(:,model_numbers(i,1))) * (X - head_mean)); 
    ph = repmat(ph, [length(face_U(1,:)),1]);
    proj_X(:,:,i) = face_mean + face_U*ph;
end
%% --------------------------------------------------


%% GET PARAMETERS OF FACE USING ENTIRE EIGENSPACE
Cf = zeros(length(face_U(1,:)),total_heads);
for i=1:total_heads
    Cf(:,i) = transpose(face_U) * (proj_X(:,:,i) - face_mean);
end
%% --------------------------------------------------


%% CONSTRUCTING REGRESSION MATRIX AND SAVING IT IN MAT FILE
Whf = Ch * transpose(Cf)* inv(Cf*transpose(Cf));     % Equation (5) of the paper
save('../../../Regression Matrix Calculation/Regression_Matrix','Whf')
%% --------------------------------------------------



