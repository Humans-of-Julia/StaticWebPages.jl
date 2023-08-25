struct BlogArticle <: AbstractItem
    title::String
    creation::Date
    last_update::Date
    tags::Vector{String}
    content::String
end