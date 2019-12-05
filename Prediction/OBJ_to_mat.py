import numpy as np
from scipy.io import savemat

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

def getVertexTensor(vertices):
	vertex_tensor = []
	for i in range(0, len(vertices)):
		vertex_tensor.append(vertices[i][0])
		vertex_tensor.append(vertices[i][1])
		vertex_tensor.append(vertices[i][2])
	return vertex_tensor

mesh = open('Input_Face.obj','r')
mesh_verts = getVertices(mesh)
mesh_verts_tensor = getVertexTensor(mesh_verts)

savemat('Face.mat', {'Face_verts':mesh_verts_tensor})