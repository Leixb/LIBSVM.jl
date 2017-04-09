using Compat
import ScikitLearnBase: BaseClassifier, BaseRegressor

@compat abstract type AbstractSVC<:BaseClassifier end
@compat abstract type AbstractSVR<:BaseRegressor end

type SVC<:AbstractSVC
    kernel::Symbol
    gamma::Union{Float64,Symbol}
    cost::Float64
    degree::Int32
    coef0::Float64
    tolerance::Float64
    shrinking::Bool
    probability::Bool

    fit::Union{SVM, Void}
end

type NuSVC<:AbstractSVC
    kernel::Symbol
    gamma::Union{Float64,Symbol}
    nu::Float64
    cost::Float64
    degree::Int32
    coef0::Float64
    tolerance::Float64
    shrinking::Bool

    fit::Union{SVM, Void}
end

type OneClassSVM<:AbstractSVC
    kernel::Symbol
    gamma::Union{Float64,Symbol}
    nu::Float64
    cost::Float64
    degree::Int32
    coef0::Float64
    tolerance::Float64
    shrinking::Bool

    fit::Union{SVM, Void}
end

type NuSVR<:AbstractSVR
    kernel::Symbol
    gamma::Union{Float64,Symbol}
    nu::Float64
    cost::Float64
    degree::Int32
    coef0::Float64
    tolerance::Float64
    shrinking::Bool

    fit::Union{SVM, Void}
end

type EpsilonSVR<:AbstractSVR
    kernel::Symbol
    gamma::Union{Float64,Symbol}
    epsilon::Float64
    cost::Float64
    degree::Int32
    coef0::Float64
    tolerance::Float64
    shrinking::Bool

    fit::Union{SVM, Void}
end