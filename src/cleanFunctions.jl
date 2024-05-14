using Glob

function cleanTimeDirectories()
    println("Cleaning case $(pwd())")
    
    # Define a function to recursively remove files and directories
    function remove_recursive(path)
        ispath(path) && rm(path; force=true, recursive=true)
    end
    
    paths = String[]
    zeroos=""
    while length(zeroos) < 8
        append!(paths, Glob.readdir(Glob.GlobMatch("0.$(zeroos)[1-9]*"), pwd()))
        append!(paths, Glob.readdir(Glob.GlobMatch("-0.$(zeroos)[1-9]*"), pwd()))

        zeroos="0"*zeroos
    end
    append!(paths, Glob.readdir(glob"[1-9]*", pwd()))
    append!(paths, Glob.readdir(glob"-[1-9]*", pwd()))

    rm.(paths; force=true, recursive=true)
end

function cleanAdiosOutput()
    ispath("adiosData") && ispath("system") && rm("adiosData"; recursive=true)
end

function cleanAuxiliary()
    paths = String[]
    append!(paths, Glob.readdir(glob"log.*", pwd()))
    append!(paths, Glob.readdir(glob"log-*", pwd()))
    append!(paths, Glob.readdir(glob"logSummary.*", pwd()))
    append!(paths, Glob.readdir(glob"*.xml", pwd()))
    append!(paths, Glob.readdir(glob"Paraview*", pwd()))
    append!(paths, Glob.readdir(glob"paraFoam*", pwd()))
    append!(paths, Glob.readdir(glob"Paraview*", pwd()))
    append!(paths, Glob.readdir(glob"*.blockMesh", pwd()))
    append!(paths, Glob.readdir(glob"*.foam", pwd()))
    append!(paths, Glob.readdir(glob"*.OpenFOAM", pwd()))

    rm.(paths; recursive=true)
    ispath("log") && rm("log"; recursive=true)
    ispath(".fxLock") && rm(".fxLock"; recursive=true)
    ispath(".setSet") && rm(".setSet"; recursive=true)

end

function cleanDynamicCode() 
    ispath("dynamicCode") && ispath("system") && rm("dynamicCode"; recursive=true)
end


function cleanOptimisation()
    ispath("optimisation") && rm("optimisation"; recursive=true)
    controlPoints = joinpath("constant", "controlPoints")
    ispath(controlPoints) && rm(controlPoints; recursive=true)
end

function cleanPostProcessing()
    ispath("Ensight") && rm("Ensight"; recursive=true)
    ispath("EnSight") && rm("EnSight"; recursive=true)
    ispath("ensightWrite") && rm("ensightWrite"; recursive=true)
    ispath("insitu") && rm("insitu"; recursive=true)
    ispath("VTK") && rm("VTK"; recursive=true)
    ispath("postProcessing") && rm("postProcessing"; recursive=true)
    ispath("cuttingPlane") && rm("cuttingPlane"; recursive=true)
    ispath("surfaceSampling") && rm("surfaceSampling"; recursive=true)
    paths = String[]
    append!(paths, Glob.readdir(glob"postProcessing-*", pwd()))
    rm.(paths; recursive=true)
end

function cleanFaMesh()
    faMesh1 = joinpath("constant", "finite-area", "faMesh")
    ispath(faMesh1) && rm(faMesh1; force=true, recursive=true)

    faMesh2 = joinpath("constant", "faMesh")

    if ispath(faMesh2) 
        if ispath(joinpath(faMesh2, "faMeshDefinition"))
            println("Warning: not removing constant/faMesh/")
            println("    It contains a 'faMeshDefinition' file")
            println("    Please relocate file(s) to system/ !!")
        else
            rm(faMesh2; force=true, recursive=true)
        end
    end
end


function cleanPolyMesh()
    polyMesh = joinpath("constant", "polyMesh")
    if ispath(polyMesh)
        if ispath(joinpath(polyMesh, "blockMeshDict")) || ispath(joinpath(polyMesh, "blockMeshDict.m4"))
            println("Warning: not removing constant/polyMesh/")
            println("    It contains a 'blockMeshDict' or 'blockMeshDict.m4' file")
            println("    Please relocate file(s) to system/ !!")
        else
            rm("polyMesh"; force=true, recursive=true)
        end
    end

    systemBlockMeshDict = joinpath("system","blockMeshDict")
    systemBlockMeshDictm4 = joinpath("system","blockMeshDict.m4")
    ispath(systemBlockMeshDict) && rm(systemBlockMeshDict; force=true)
    ispath(systemBlockMeshDictm4) && rm(systemBlockMeshDictm4; force=true)
end

function cleanSnappyFiles()
    paths = [
    joinpath("constant","polyMesh","cellLevel" ),
    joinpath("constant","polyMesh","pointLevel" ),
    joinpath("constant","polyMesh","refinementHistory" ),
    joinpath("constant","polyMesh","level0Edge" ),
    joinpath("constant","polyMesh","surfaceIndex" ),
    joinpath("constant","cellLevel" ),
    joinpath("constant","pointLevel" ),
    joinpath("0", "cellLevel" ),
    joinpath("0", "pointLevel"),
    ]

    for path in paths 
        ispath(path) && rm(path; force=true)
    end

    globPaths = String[]
    append!(globPaths, Glob.readdir(glob"processor*/constant/polyMesh/cellLevel", pwd()))
    append!(globPaths, Glob.readdir(glob"processor*/constant/polyMesh/pointLevel", pwd()))
    append!(globPaths, Glob.readdir(glob"processor*/constant/polyMesh/refinementHistory", pwd()))
    append!(globPaths, Glob.readdir(glob"processor*/constant/polyMesh/level0Edge", pwd()))
    append!(globPaths, Glob.readdir(glob"processor*/constant/polyMesh/surfaceIndex", pwd()))
    append!(globPaths, Glob.readdir(glob"processor*/constant/cellLevel", pwd()))
    append!(globPaths, Glob.readdir(glob"processor*/constant/pointLevel", pwd()))
    append!(globPaths, Glob.readdir(glob"processor*/0/cellLevel", pwd()))
    append!(globPaths, Glob.readdir(glob"processor*/0/pointLevel", pwd()))

    rm.(globPaths, force=true)

end



function cleanCase()
    cleanTimeDirectories()
    cleanAdiosOutput()
    cleanAuxiliary()
    cleanDynamicCode()
    cleanOptimisation()
    cleanPostProcessing()

    cleanFaMesh()
    cleanPolyMesh()
    cleanSnappyFiles()

    globPaths = String[]
    append!(globPaths, Glob.readdir(glob"processor*", pwd()))
    append!(globPaths, Glob.readdir(glob"probes*", pwd()))
    append!(globPaths, Glob.readdir(glob"forces*", pwd()))
    append!(globPaths, Glob.readdir(glob"graphs*", pwd()))
    append!(globPaths, Glob.readdir(glob"constant/cellLevel*", pwd()))
    append!(globPaths, Glob.readdir(glob"constant/pointLevel*", pwd()))
    rm.(globPaths, force=true)

    paths = [
        "TDAC",
        "sets",
        joinpath("system, machines"),
        "blockTopology.vtu",   
        "blockFaces.vtp", 
        "blockTopology.obj",
        "blockCentres.obj",
        "cellDist.vtu",
        joinpath("0","cellDist"),
        "gdbCommands",
        "mpirun.schema",
        joinpath("constant","cellDecomposition"),
        joinpath("constant","cellToRegion"),
        joinpath("constant","tetDualMesh"),
        
    ]

    for path in paths 
        ispath(path) && rm(path; force=true)
    end
end

function cleanCase0()ispath("0") 
    cleanCase()
    ispath("0") && rm("0", recursive=true)
end


function cleanSamples()

    paths = [
        "sets",
        "samples",
        "sampleSurfaces"
    ]

    for path in paths 
        ispath(path) && rm(path; recursive=true, force=true)
    end
end

function cleanUcomponents()
    paths = [
        joinpath("0", "Ux"),
        joinpath("0", "Uy"),
        joinpath("0", "Uz")
    ]

    for path in paths 
        ispath(path) && rm(path; recursive=true, force=true)
    end
end

