function Base.findfirst(A::Vector{T}, name::AbstractString) where T <: Union{Dict, NamedTuple}
    seen = Set{String }()
    num = length(A)
    res = Vector{Int}()
    @inbounds for x in 1:num 
        if A[x][name] ∉ seen
            push!(seen, A[x][name])
            push!(res, x)
        end
    end
    res
end

Base.unique(A::Vector{T}, name::AbstractString) where T <: Union{Dict, NamedTuple} = findfirst(A, name) |> q -> view(A, q) 
