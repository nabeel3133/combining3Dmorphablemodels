# Combining 3D Morphable Models: A Large scale Face-and-Head Model
This repository provides a MATLAB implementation of the CVPR 2019 Paper - Combining 3D Morphable Models: A Large scale Face-and-Head Model. It is implemented only till the Regression Matrix Calculation part.

<p align="center"><img width="50%" height="5%" src="images/main.jpg" /></p>

## Paper
[Combining 3D Morphable Models: A Large scale Face-and-Head Model](https://arxiv.org/abs/1903.03785)

## Dependencies
* [MATLAB](https://www.mathworks.com/downloads/)
* [Python 3.5](https://www.python.org/downloads/release/python-352/)
  - [Numpy](https://pypi.org/project/numpy/) -> ```pip install numpy```
  - [Scipy](https://pypi.org/project/scipy/) -> ```pip install scipy```

## Usage
### 1. Cloning the repository
```
git clone https://github.com/nabeel3133/combining3Dmorphablemodels.git
```

### 2. Downloading the models
- [LYHM: Liverpool York Head Model](https://www-users.cs.york.ac.uk/~nep/research/LYHM/)
  - After you have acquired LYHM, extract the `lyhmPublic.zip` and go to `lyhmPublic/lyhmModels/`, copy `LYHM_male.mat` and put it in the `Regression Matrix Calculation` folder.
- [BFM09: Basel Face Model 2009](https://faces.dmi.unibas.ch/bfm/index.php?nav=1-1-0&id=details)
  - After you have acquired BFM, extract the BaselFaceModel.tgz and go to "PublicMM1" folder, copy `01_MorphableModel.mat` and put it in the `Regression Matrix Calculation` folder.
  
### 3. Running the code
In order to run the code, launch MATLAB and follow the steps given below:
1. Open the file `Steps1to3.m` located in `combining3Dmorphablemodels/Regression Matrix Calculcation` and run it.
(Keep in mind that there is a variable named `total_heads` on line #7, you can change it to as much head shape parameters you want the regression matrix to learn from). 
2. After it is done executing, open the file `nricp_run.m` located in `combining3Dmorphablemodels/Non Rigid Iterative Closest Point (NICP)/nricp-master/demos` and run it. It will save `Regression_Matrix.mat` in the directory `combining3Dmorphablemodels/Regression Matrix Calculcation`.

### 4. Getting a Predicted Head
In order to get a predicted head of a BFM face, you need to have the .obj file of the BFM face for which you want to predict the head. Make sure to have your .obj file named as `Input_Face.obj`. Locate to the directory "combining3Dmorphablemodels/Prediction" and run the following command:
```
python Head_Prediction.py
```
This will output a file named `Output_Head.obj` located in the same directory.

## Citation
If this work is useful for your research or if you use this implementation in your academic projects, please cite the following papers:
- [Combining 3D Morphable Models: A Large Scale Face-And-Head Model](https://arxiv.org/abs/1903.03785)
```bibtex
@InProceedings{ploumpis2019combining,
author = {Stylianos Ploumpis and Haoyang Wang and Nick Pears and William A. P. Smith and Stefanos Zafeiriou},
title = {Combining 3D Morphable Models: A Large Scale Face-And-Head Model},
booktitle = {The IEEE Conference on Computer Vision and Pattern Recognition (CVPR)},
month = {June},
year = {2019}
}
```

- [Optimal Step Nonrigid ICP Algorithms for Surface Registration](https://gravis.dmi.unibas.ch/publications/2007/CVPR07_Amberg.pdf):
```bibtex
@InProceedings{amberg2007optimal,
  title={Optimal Step Nonrigid ICP Algorithms for Surface Registration},
  author={Amberg, Brian and Romdhani, Sami and Vetter, Thomas},
  booktitle={Computer Vision and Pattern Recognition, 2007. CVPR'07. IEEE Conference on},
  pages={1--8},
  year={2007},
  organization={IEEE}
}
```
