# Model-based Risk Management in Geohazards

This is a self contained repository for code and documentation for the Bachelor Thesis of Lucia Rhein carried out at the Chair of Methods for Model-based Development in Computational Engineering, RWTH Aachen University.

## Repository Structure
This repositor is a combination repository that is meant to host both, the computational code and documentation. It contains the following two folders:
- code : The software assets should be stored here
- docs (coming soon): The documentation website assets should be stored here

## Getting Started with Code
NOTE: Currently only Intel Processor based Linux is supported. If running Windows, please Windows Subsystem for Linux (WSL).

1. Install Julia using instructions from [here](https://julialang.org/downloads/)
2. Clone this repository using `git clone https://git.rwth-aachen.de/mbd_teaching/ba-rhein.git`
3. Change directory to cloned folder
4. Setup the Environment using `julia setup.jl`
5. Try out example testcase 
    - Change directory to `code`
    - Run the test using `julia --project=@. test-run.jl`
    - Play around by changing modes in `test-run.jl` to run and clean the test case.

INFO: A non-exhaustive guide with useful tips for working with Julia-lang can be found at [https://modernjuliaworkflows.github.io/](https://modernjuliaworkflows.github.io/)
## References
- Rauter, M., Kofler, A., Huber, A., and Fellin, W.: faSavageHutterFOAM 1.0: depth-integrated simulation of dense snow avalanches on natural terrain with OpenFOAM, Geosci. Model Dev., 11, 2923–2939, 2018. ([Web](https://doi.org/10.5194/gmd-11-2923-2018)) ([Full-text](https://gmd.copernicus.org/articles/11/2923/2018/gmd-11-2923-2018.pdf))

- Zhao, H., Amann, F. & Kowalski, J. Emulator-based global sensitivity analysis for flow-like landslide run-out models. Landslides 18, 3299–3314 (2021). ([Web](https://doi.org/10.1007/s10346-021-01690-w)) ([Full-text](https://link.springer.com/content/pdf/10.1007/s10346-021-01690-w.pdf))

-  Mengyang Gu. Xiaojing Wang. James O. Berger. "Robust Gaussian stochastic process emulation." Ann. Statist. 46 (6A) 3038 - 3066, December 2018. ([Web](https://doi.org/10.1214/17-AOS1648)) ([Full-text](https://projecteuclid.org/journalArticle/Download?urlId=10.1214%2F17-AOS1648)) # OpenFOAM.jl
