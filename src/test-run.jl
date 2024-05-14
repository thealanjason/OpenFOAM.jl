
case="synthetic-slope-elliptic-hemisphere"
modes = [
    # "run",
    "clean",
]
if "run" in modes
    include(joinpath("test", case, "Allrun-serial.jl"))
end
if "clean" in modes
    include(joinpath("test", case, "Allclean.jl"))
end