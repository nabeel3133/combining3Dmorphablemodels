from scipy.io import loadmat
import itertools
from itertools import chain

f2 = open('Output_Head.obj','w')
f3 = open('head_tri.txt','r')

pred_head_mat = loadmat('Output_Head.mat')
predicted_head_verts = pred_head_mat['pred_head']
predicted_head_verts = list(itertools.chain.from_iterable(predicted_head_verts))

j = 0
for i in range(0, len(predicted_head_verts)/3):
	f2.write("v "+str(predicted_head_verts[j])+" "+str(predicted_head_verts[j+1])+" "+str(predicted_head_verts[j+2])+"\n")
	j=j+3

for i, line in enumerate(f3):
	f2.write(line)

f2.close()
f3.close()