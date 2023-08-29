struct Post <: AbstractPage
    blog::Union{String, Pair{String, String}}
    page::Page
    date::Date
    description::String
end

function post(
    blog::Union{String, Pair{String, String}};
    background::BackgroundColor=bg_grey,
    date::TimeType=now(UTC),
    hide::Bool=false,
    sections::Vector{<:AbstractSection}=Vector{AbstractSection}(),
    title::String="",
)
    pa = Page(background, hide, sections, title)
    po = Post(blog, pa, date, title)
    return push!(content, title => po)
end

hide(p::Post) = hide(p.page)
sections(p::Post) = sections(p.page)

to_html(p::Post, opt_in::Bool) = to_html(p.page, opt_in, p.date)

function blog(
    blogs::Vector{String} = Vector{String}();
    background::BackgroundColor=bg_grey,
    hide::Bool=false,
    sections::Vector{<:AbstractSection}=Vector{AbstractSection}(),
    title::String,
)
    if !isempty(blogs)
        foreach(b -> push!(BLOGS, (title => b) => Vector{Any}()), blogs)
    else
        push!(BLOGS, title => Vector{Any}())
    end

    isempty(sections) || page(; background, hide, sections, title)

    return nothing
end
