# Items supertype
abstract type AbstractItem end

abstract type AbstractSection end

include("items/card.jl")
include("items/git.jl")
include("items/publications.jl")
include("items/block.jl")
include("items/timeline.jl")

Item = Union{Deck,GitRepo,Publications,Block,TimeLine}

# Nest(ed) items
struct Nest
    list::Vector{Item}
    Nest(args...) = new([ item for item in args])
end

SectionItems = Union{Item,Nest}

function to_html(nest::Nest)
    str = ""
    for item in nest.list
        str *=
        """
        $(to_html(item))
        """
    end
    return str
end

# Single column section
struct Section <: AbstractSection
    bgcolor::BackgroundColor
    hide::Bool
    items::SectionItems
    title::String
    title_size::Int # 0 means inherited

    function Section(;
        bgcolor::BackgroundColor=bg_none,
        hide::Bool=false,
        items::SectionItems=Nest(),
        title::String="",
        title_size=0
    )
        new(bgcolor, hide, items, title, title_size)

    end
end

function to_html(s::Section, x::Int)
    str =
   """
   <h$x class="hx cell">$(s.title)</h$x>
   $(to_html(s.items))
   """
    return str
end

# Double column
struct Double <: AbstractSection
    first::Section
    second::Section
    hide::Bool

    function Double(
        f::Section,
        s::Section
        )
        h = f.hide && s.hide
        new(f, s, h)
    end
end

function to_html(
    d::Double,
    x::Int
    )
    str = ""
    if !d.first.hide
        str *=
        """
        <div class="cell small-12 medium-6">
            <h$x class="hx">$(d.first.title)</h$x>
            $(to_html(d.first.items))
        </div>
        """
    end
    if !d.second.hide
        str *=
        """
        <div class="cell small-12 medium-6">
            <h$x class="hx">$(d.second.title)</h$x>
            $(to_html(d.second.items))
        </div>
        """
    end
    return str
end
