using OpenFOAM_com_jll
cd(dirname(@__FILE__))


run(gridToSTL())
run(pMesh())
run(makeFaMesh())
cp("0.orig", "0")
run(releaseAreaMapping())
run(faSavageHutterFoam())

