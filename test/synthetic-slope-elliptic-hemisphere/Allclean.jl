using OpenFOAM_com_jll

include(joinpath("..","..","src","cleanFunctions.jl"))
cd(dirname(@__FILE__))

surfaceSTL = joinpath("constant","surface.stl")
ispath(surfaceSTL) && rm(surfaceSTL; force=true)
cleanCase0()
cleanFaMesh()