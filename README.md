# Using the Gaussian Process (GP) to address stress singularity in finite element analysis

The project aimed to address the problem of stress singularity in linear structural finite element analysis using the Gaussian machine learning approach.
In the project data such as the Von mises stress, Von mise strain and the deformation data generated using Ansys Workbench is used in the "main_online.m" file 
to predict stresses occuring at the region of singularity. 

### What problems were studied?
The singularity cases studied in this project are maninly due to geometric singularity. The image below shows some of the problems considered.

<img width="619" alt="image" src="https://user-images.githubusercontent.com/60384279/146005409-b060bdb9-267f-4e33-a9f7-f9b24c5ea700.png">

<img width="619" alt="image" src="https://user-images.githubusercontent.com/60384279/146007214-c3516bac-1ace-4dab-8634-58418a9da707.png">

### Why the Gaussian process?
The Gaussian process script is generated using the Regression learner in Matlab. Although a few modification were also made to explore to the kernel and the optimiser used.
More information about the Gaussian process and it use can be found here:-(C. E. Rasmussen & C. K. I. Williams, Gaussian Processes for Machine Learning, the MIT Press, 2006)
http://www.gaussianprocess.org/gpml/chapters/RW.pdf
 
### How were problems solved using the Gaussian process(GP)?
Geometries of the form shown above were defined in Ansys 18.2, note that the geometries above are halves of the original due to symmetry. These geometries would be pulled from either direction with some defined amount of force. The stress,strain and deformation are then exported and used to train the GP model in Matlab to allow for prediction of the region of interest(ROI). An example image of how the tension specimen was defined is shown below; the ROI is the square section containing the stress singularity. The kernel used is the radial basis function (Gausian kernel).

<img width="561" alt="image" src="https://user-images.githubusercontent.com/60384279/146011542-a0a15462-9397-4479-bce0-82c3c6f0c501.png">

<img width="621" alt="image" src="https://user-images.githubusercontent.com/60384279/146012182-1a6bf636-110e-4442-bd79-eb14127283c4.png">

### Results
The Gaussian machine learning approach was used to predict the ROI denoted as "test", and the three orange arrows in the above image to allow more precise behavior of the GP to be studied near the singularity. The image below shows a plot of the results from the GP model and FEA, where the red plot denote the ROI/test region and the black shows the non-singualarity region.

<img width="624" alt="image" src="https://user-images.githubusercontent.com/60384279/146014014-ba1810f2-ebf6-42ed-8546-eb2b8f06d1cf.png">

### Author
Name : Sherif Zantiba
Supervisors : Dr Charles Lord & Dr Paul Gardner
Date : 04/05/2020
