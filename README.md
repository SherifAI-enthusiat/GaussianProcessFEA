# GPlearner
# Stress singularity in finite element analysis
# Gaussian Process (GP)
The project aimed to address the problem of Stress singularity in linear structural finite element analysis using the Gaussian machine learning approach.
In this project stress analysis data generated(i.e. Von mises stress, Von mise strain and the deformation data) from Ansys Workbench is used in the main_online.m file 
to predict stresses occuring at the region of singularity. The singularity problem considered in this project is due to geometric singularity.

The Gaussian process script is generated using the Regression learner in Matlab.Although a few modification were also made to explore to the kernel and the optimiser used.
More information about the Gaussian process and it use can be found here:-(C. E. Rasmussen & C. K. I. Williams, Gaussian Processes for Machine Learning, the MIT Press, 2006)
 http://www.gaussianprocess.org/gpml/chapters/RW.pdf
