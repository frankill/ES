function Base.findfirst(A::AbstractVector, name::AbstractString)c
    seen = Set{A[1] |> eltype |> a -> a.parameters[1] }()
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
