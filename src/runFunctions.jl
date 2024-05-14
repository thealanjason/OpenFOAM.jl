
# function runApplication(appName::AbstractString; kwargs...)
#     # Define local variables
#     appRun = getfield(OpenFOAM_com_jll, Symbol(appName))()
#     logFile = "log.$appName"
#     logMode = nothing
#     appArgs = ""

#     # Parse options until executable is encountered
#     while !isempty(kwargs)
#         arg = popfirst!(kwargs)

#         # Ignore empty arguments
#         if arg == ""
#             continue
#         end

#         # Parse options
#         if arg in ["-a", "-append"]
#             logMode = :append
#         elseif arg in ["-o", "-overwrite"]
#             logMode = :overwrite
#         elseif arg in ["-s", "-suffix"]
#             logFile *= ".$(popfirst!(kwargs))"
#         elseif startswith(arg, "-decompose-dict=")
#             optValue = split(arg, '=')[2]
#             if optValue not in ["", "none", "false"]
#                 appArgs *= " -decomposeParDict $optValue"
#             end
#         elseif arg == "-decomposeParDict"
#             optValue = popfirst!(kwargs)
#             if optValue not in ["", "none", "false"]
#                 appArgs *= " -decomposeParDict $optValue"
#             end
#         else
#             appArgs *= " $arg"
#         end
#     end

#     # Check if log file already exists
#     if isfile(logFile) && isnothing(logMode)
#         println("$appName already run on $(pwd()): remove log file '$logFile' to re-run")
#     else
#         println("Running $appRun on $(pwd())")
#         if logMode == :append
#             run(`$appRun $appArgs $(kwargs...) >> $logFile 2>&1`)
#         else
#             run(`$appRun $appArgs $(kwargs...) > $logFile 2>&1`)
#         end
#     end
# end

