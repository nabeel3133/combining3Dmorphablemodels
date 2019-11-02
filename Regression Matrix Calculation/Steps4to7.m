%% PROJECTING HEAD AND GENERATING CORRESPONDING FACE
proj_X = zeros(length(face_U),1,total_heads);
for i=1:total_heads
%     X = reshape(transpose(registered_heads(:,:,i)),[34530,1]);
    X = reshape(transpose(registered_heads(:,:,i)),[length(head_U),1]);
    ph=(transpose(head_U(:,model_numbers(i,1))) * (X - head_mean)); 
    ph = repmat(ph, [199,1]);
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
Whf = Ch * transpose(Cf)* inv(Cf*transpose(Cf));
save('Regression_Matrix','Whf')
%% --------------------------------------------------

