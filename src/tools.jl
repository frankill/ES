function Base.findfirst(A::Vector{Dict{AbstractString,Any}}, name::AbstractString)
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

Base.unique(A::Vector{Dict{AbstractString,Any}}, name::AbstractString) = findfirst(A, name) |> q -> view(A, q) 
