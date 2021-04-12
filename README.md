# Exploiting Spatial and Spectral Attention for Fast Hyperspectral Tracking
Matlab implementation of FHT tracker.

## Installation
1. Download the repository;
2. Compile mex files running compile.m command
    Set opencv_include and opencv_libpath to the correct Opencv paths
3. Use demo_scr.m script for the visualization of the tracker
    Set tracker_path variable to the directory where your source code is and base_path to the directory where you have stored the HSI sequences.
    
## Project summary
Compared with visible images, HyperSpectral Images HSI) can take advantage of rich spectral information to better discriminate foreground objects from complicated backgrounds. Despite continuous performance improvement, HSI trackers are always slow in dealing with high-dimensional HSI data. In this paper, we propose a new method named Fast Hyperspectral Tracker (FHT) in the correlation-filter (CF) based framework to track objects fast in hyperspectral videos by exploiting spatial and spectral attention from the HSI data.  The spatial attention map adaptively adjusts the filter support to the part of the object suitable for tracking. The spectral attention weights reflect the spectral-wise quality of the learned filters and are used as the feature weighting coefficients in localization. To acheive fast HSI tracking, we extract lightweight hyperspectral features from high-dimensional HSI data. Extensive experiments on the recently released Whisper dataset demonstrated the effectiveness of our work in terms of both accuracy and efficiency.
