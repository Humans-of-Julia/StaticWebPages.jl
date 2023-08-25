"""
    AbstractItem

An abstract supertype for all items making the content of `Section`s.
"""
abstract type AbstractItem end

"""
    AbstractSection

An abstract supertype for all `Section`s.
"""
abstract type AbstractSection end

include("items/card.jl")
include("items/git.jl")
include("items/publications.jl")
include("items/block.jl")
include("items/timeline.jl")
include("items/blog.jl")

Item = Union{Deck,GitRepo,Publications,Block,TimeLine,Blog}


"""
    to_html(args...)

Generate the html code associated with each element in the `args` collection.
"""
function to_html end

"""
    Nest

A structure to handle nested items.
"""
struct Nest
    list::Vector{Item}
    Nest(args...) = new([item for item in args])
end

SectionItems = Union{Item,Nest}

function to_html(nest::Nest)
    str = ""
    for item in nest.list
        str *= """
               $(to_html(item))
               """
    end
    return str
end

"""
    Section

A structure for single column sections.
"""
struct Section <: AbstractSection
    bgcolor::BackgroundColor
    hide::Bool
    items::SectionItems
    title::String
    title_size::Int # 0 means inherited
end

"""
    Section(; keyargs...)

Create a new single column section.
- `bgcolor::BackgroundColor = bg_none`: set the section background to `bg_none` (default background), `bg_white`, or `bg_grey`.
- `hide::Bool = false`: if set to true, the section will not be built.
- `items::SectionItems=Nest()`: the list of items in the section. Default to an empty `Nest`ed item.
- `title::String=""`.
- `title_size=0` : If set to `0`, the size will be inherited.
)
"""
function Section(;
    bgcolor::BackgroundColor=bg_none,
    hide::Bool=false,
    items::SectionItems=Nest(),
    title::String="",
    title_size=0
)
    return Section(bgcolor, hide, items, title, title_size)
end

function to_html(s::Section, x::Int)
    str = """
          <h$x class="hx cell">$(s.title)</h$x>
          $(to_html(s.items))
          """
    return str
end

"""
    Double

A structure for double columns sections.
"""
struct Double <: AbstractSection
    first::Section
    second::Section
    hide::Bool
end

"""
    Double(first::Section, second::Section)

Construct a two-columns section.
"""
function Double(f::Section, s::Section)
    h = f.hide && s.hide
    return Double(f, s, h)
end

function to_html(d::Double, x::Int)
    str = ""
    if !d.first.hide
        str *= """
               <div class="cell small-12 medium-6">
                   <h$x class="hx">$(d.first.title)</h$x>
                   $(to_html(d.first.items))
               </div>
               """
    end
    if !d.second.hide
        str *= """
               <div class="cell small-12 medium-6">
                   <h$x class="hx">$(d.second.title)</h$x>
                   $(to_html(d.second.items))
               </div>
               """
    end
    return str
end
