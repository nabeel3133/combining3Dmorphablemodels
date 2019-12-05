from scipy.io import loadmat, savemat
import numpy as np

def getVertices(Mesh):
	mesh_verts_list = []
	for i, line in enumerate(Mesh):
		if(line[0] == 'v'):
			mesh_verts = line.strip('\n').split()
			mesh_verts = mesh_verts[1:4]
			mesh_verts_list.append(mesh_verts)
		else:
			break
	return np.array(list(np.float_(mesh_verts_list)))


def getVerticesTensor(vertices):
	vertex_tensor = []
	for i in range(0, len(vertices)):
		vertex_tensor.append(vertices[i][0])
		vertex_tensor.append(vertices[i][1])
		vertex_tensor.append(vertices[i][2])

	vertex_tensor = np.reshape(np.array(vertex_tensor), (len(vertex_tensor),1))
	return vertex_tensor


def predictHead(head_mean, head_U, Whf, input_face, face_U, face_mean):
	# Equation (6) of the paper
	step1 = input_face - face_mean
	step2 = np.matmul(np.transpose(face_U), step1)
	step3 = np.matmul(Whf, step2)
	step4 = np.matmul(head_U, step3)
	head = head_mean + step4
	return head

def tensorToVertices(tensor):
	j = 0
	vertices = []
	for i in range(0, int(len(tensor)/3)):
		vertices.append([tensor[j], tensor[j+1], tensor[j+2]])
		j=j+3

	vertices = np.reshape(np.array(vertices), (len(vertices),3))
	return (np.array(vertices))


def write_obj(head_verts):
	f2 = open('Output_Head.obj','w')
	f3 = open('head_tri.txt','r')
	for i in range(0, len(head_verts)):
		f2.write("v "+str(head_verts[i][0])+" "+str(head_verts[i][1])+" "+str(head_verts[i][2])+"\n")

	for i, line in enumerate(f3):
		f2.write(line)

	f2.close()
	f3.close()



input_face = open('Input_Face.obj','r')
input_face_verts = getVertices(input_face)
input_face_tensor = getVerticesTensor(input_face_verts)

print("Predicting Head Shape...")

head_model_dict = loadmat('../Regression Matrix Calculation/LYHM_male.mat')

head_U = head_model_dict['shp'][0][0][0]
head_mean = np.transpose(head_model_dict['shp'][0][0][2])

face_model_dict = loadmat('../Regression Matrix Calculation/01_MorphableModel.mat')
face_U = face_model_dict['shapePC']
face_mean = face_model_dict['shapeMU']

regression_matrix_dict = loadmat('../Regression Matrix Calculation/Regression_Matrix_Test.mat')
Whf = regression_matrix_dict['Whf']

pred_head_tensor = predictHead(head_mean, head_U, Whf, input_face_tensor, face_U, face_mean)   

pred_head_verts = tensorToVertices(pred_head_tensor)

write_obj(pred_head_verts)

print("Head Shape Prediction Completed")