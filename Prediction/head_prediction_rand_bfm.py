from scipy.io import loadmat
import numpy as np
import random

def tensorToVertices(tensor):
	j = 0
	vertices = []
	for i in range(0, int(len(tensor)/3)):
		vertices.append([tensor[j], tensor[j+1], tensor[j+2]])
		j=j+3

	vertices = np.reshape(np.array(vertices), (len(vertices),3))
	return (np.array(vertices))

def write_obj(verts,writeFile,triFile):
	for i in range(0, len(verts)):
		writeFile.write("v "+str(verts[i][0])+" "+str(verts[i][1])+" "+str(verts[i][2])+"\n")

	for i, line in enumerate(triFile):
		writeFile.write(line)

def predictHead(head_mean, head_U, Whf, input_face, face_U, face_mean):
	# Equation (6) of the paper
	step1 = input_face - face_mean
	step2 = np.matmul(np.transpose(face_U), step1)
	step3 = np.matmul(Whf, step2)
	step4 = np.matmul(head_U, step3)
	head = head_mean + step4
	return head

print ('Generating Random BFM...')
face_model_dict = loadmat('../Regression Matrix Calculation/01_MorphableModel.mat')
face_U = face_model_dict['shapePC']
face_mean = face_model_dict['shapeMU']

low = 0
high = np.shape(face_U)[0]
size = 1
rand_row = [low + int(random.random() * (high - low)) for _ in range(size)][0]       

shape_parameters = np.reshape(face_U[rand_row][:], (np.shape(face_U)[1],1))
rand_bfm_tensor = face_mean + np.matmul(face_U,shape_parameters)

rand_bfm_verts = tensorToVertices(rand_bfm_tensor)


bfm_file = open('Input_Face.obj','w')
bfm_tri = open('bfm_tri.txt','r')
write_obj(rand_bfm_verts, bfm_file, bfm_tri)
bfm_file.close()
bfm_tri.close()
print ('Random BFM generated and saved as "Input_Face.obj" file\n')

print("Predicting Head Shape...")

head_model_dict = loadmat('../Regression Matrix Calculation/LYHM_male.mat')
head_U = head_model_dict['shp'][0][0][0]
head_mean = np.transpose(head_model_dict['shp'][0][0][2])

regression_matrix_dict = loadmat('../Regression Matrix Calculation/Regression_Matrix.mat')
Whf = regression_matrix_dict['Whf']

input_face_tensor = rand_bfm_tensor
pred_head_tensor = predictHead(head_mean, head_U, Whf, input_face_tensor, face_U, face_mean)   

pred_head_verts = tensorToVertices(pred_head_tensor)

head_file = open('Output_Head.obj','w')
head_tri = open('head_tri.txt','r')
write_obj(pred_head_verts, head_file, head_tri)
head_file.close()
head_tri.close()

print('Head Shape Prediction Completed and saved as "Output_Head.obj" file')
