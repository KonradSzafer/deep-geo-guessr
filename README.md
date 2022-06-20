# **deep-geo-guessr**

Geo Guessr is a game where the player is randomly dropped onto a Google Street View map and has to guess the current location based on the surroundings.\
In this research, the problem was simplified not to the exact location but to the country of origin of the image.\
The goal is to create a neural network that can predict a country name for a given Google Street View image.

# Data

Data was collected from 5 different countries: France, Greece, Portugal, Spain and Switezerland.\
The dataset is balanced and each class contains over 1000 samples with a resolution of 800x800px.\
Dataset is unclean, photos have many imperfections, for example: majority of picture is blurred or shows interior of building.

Incorrect examples:
<p align="center">
    <img src="images/france1_blurred.png" alt="drawing" width="200"/>
    <img src="images/greece1_building.png" alt="drawing" width="200"/>
    <img src="images/spain1_plane.png" alt="drawing" width="200"/>
</p>

Correct examples:
<p align="center">
    <img src="images/france0.png" alt="drawing" width="200"/>
    <img src="images/greece0.png" alt="drawing" width="200"/>
    <img src="images/portugal0.png" alt="drawing" width="200"/>
</p>
<p align="center">
    <img src="images/spain0.png" alt="drawing" width="200"/>
    <img src="images/switzerland0.png" alt="drawing" width="200"/>
</p>

Depending on notebook, different data augmentation is implemented. \
Techniques used:
- RandomCrop
- RandomRotation
- RandomHorizontalFlip
- RandomVerticalFlip
- RandomPerspective

Data cannot be shuffled, because there are multiple images from one place.
Due to the use of ResNet, data is normalized with ImageNet values.

# Neural Network

The network is based on the pretreated ResNet18 model with replaced fully connected layer. \
SGD optimizer was used to train the model and the Focal Loss as a function of loss. \

To perform the training efficiently, the code was optimized mainly based on [1] and [2].

# Results

At this point, a result of ~50% accuracy on test samples has been achieved.
The confusion matrix shows that most of the bad predictions occur between countries that border each other or have similar climates.

<p align="center">
    <img src="images/confusion_matrix.jpg" alt="drawing" width="500"/>
</p>

Accuracy of model validation during training and hyperparameters. Tracked with W&B platform. \
[Project dashboard](https://wandb.ai/konradszafer/deep-geo-guessr?workspace=user-konradszafer)

<p align="center">
    <img src="images/wandb_valid_accuracy_chart.png" alt="drawing" width="600"/>
</p>

<p align="center">
    <img src="images/wandb_parallel_coordinates.png" alt="drawing" width="600"/>
</p>

# Interpreting and visualization predictions

## Weights visualization

<p align="center">
    <img src="images/weights_visualization.jpg" alt="drawing" width="600"/>
</p>

## Class activation mapping

<p align="center">
    <img src="images/class_activation_mapping.jpg" alt="drawing" width="600"/>
</p>

## Grad cam

<p align="center">
    <img src="images/grad_cam.jpg" alt="drawing" width="600"/>
</p>

## Interesting regions

<p align="center">
    <img src="images/interesting_regions.png" alt="drawing" width="400"/>
</p>

## Torch PRISM

<p align="center">
    <img src="images/torch_prism.jpg" alt="drawing" width="600"/>
</p>

# Future work

- Adding country-specific elements, such as flags, writing, and other symbols, as a method of data augmentation.
- Define the probelm as a regression task for determining geographic coordinates to reduce border bias.
- More precise manual data cleaning.

# Bibliography

[1] https://towardsdatascience.com/what-library-can-load-image-in-python-and-what-are-their-difference-d1628c6623ad \
[2] https://towardsdatascience.com/optimize-pytorch-performance-for-speed-and-memory-efficiency-2022-84f453916ea6 \
[3] https://arxiv.org/pdf/1311.2901.pdf
