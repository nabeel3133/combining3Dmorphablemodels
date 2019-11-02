%% APPLYING NRICP
% Load data
load ../data/Head_Tri.mat
load ../data/Target_MeanFace_Cropped.mat

% Specify that surface normals are available and can be used.
Options.useNormals = 0;

% Specify that the source deformations should be plotted.
Options.plot = 1;

Options.gamm = 1;   %Default 1
Options.epsilon = 1e-4;   %Default 1e-4
Options.lambda = 1;  %Default 1
Options.alphaSet = linspace(1000, 100, 15);  %Default linspace(100,10,20)
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


