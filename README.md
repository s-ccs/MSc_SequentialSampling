# **MSc-Thesis:** Simulation of EEG Activity Based on Sequential Sampling Models
**Author:** *Timo Zaoral*

**Supervisor(s):** *Benedikt Ehinger*

**Year:** *2024/2025*

## Project Description
>The primary aim of this thesis is to investigate the relationship between Sequential Sampling Models (SSMs) and evidence accumulation processes as observed in EEG data. Therefore the thesis seeks to provide a computational framework for simulating EEG data using different SSMs to explore how these models reflect the evidence accumulation process in the brain. The computational framework is to be integrated into the existing Julia package for simulating EEG data UnfoldSim.jl (https://github.com/unfoldtoolbox/UnfoldSim.jl).

## Zotero Library Path
`Bib`-File in the `report` folder: report/thesis/Master_Thesis_Zaoral_Timo/refs.bib

## Instruction for a new student
The first step is to create a virtual Julia environment.
The UnfoldSim.jl repository with the extension must then be cloned into the environment or the release version of UnfoldSim.jl must be installed in which the extension is already included.
In addition, the following packages must be installed in the environment for most use cases:
- UnfoldSim
- Unfold
- StableRNGs
- SequentialSamplingModels
- CairoMakie
- UnfoldMakie

The following notebooks can be used to reconstruct the diagrams from the thesis:
nb_ThesisPlots.ipynb, Use_Cases: nb_Simulation_Space.ipynb, nb_Comment_Rebuild.ipynb, nb_Kelly_Overlap_Simulation.ipynb, nb_No_Ramp_after_deconv.ipynb

The ThesisPlots are simple illustrating Figures for the thesis. The Simulation Space notebook contains the sample figure creation for each SequentialSampling Model (LBA,DDM,KellyModel) and the other use case notebooks the described use cases from the thesis section 4.2.
## Overview of Folder Structure 

```
│projectdir          <- Project's main folder. It is initialized as a Git
│                       repository with a reasonable .gitignore file.
│
├── report           <- **Immutable and add-only!**
│   ├── proposal     <- Proposal PDF
│   ├── thesis       <- Final Thesis PDF
│   ├── talks        <- PDFs (and optionally pptx etc) of the Intro,
|   |                   Midterm & Final-Talk
|
├── _research        <- writing tips for the thesis
│
├── plots            <- All exported plots go here.
|   |                   all plots can be
|   |                   recreated using the plotting scripts in the scripts folder.
│
├── scripts          <- Various scripts/notebooks, e.g. simulations, plotting, analysis,
│
├── src              <- Dev source code of this project. Contains functions,
│                       structures and modules that are used throughout
│                       the project and build the basis for the integration of the extension.
│
├── test             <- Contains README with information about the tests.
│
├── README.md        <- Top-level README.
|
├── .gitignore       <- focused on Julia, but some Matlab things as well
│
├── (Manifest.toml)  <- Contains full list of exact package versions used currently.
|── (Project.toml)   <- Main project file, allows activation and installation.
                        
```