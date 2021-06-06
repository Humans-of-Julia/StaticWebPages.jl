Image = Pair{AbstractString,AbstractString}
paragraphs(args::String...) = [p for p in args]
images(args::Image...) = [img for img in args]

struct Block <: AbstractItem
    paragraphs::Vector{AbstractString}
    images::Vector{Image}
end

function to_html(section::Block)
    str =
    """
    <div class="cell medium-8 large-9">
    """

    for p in section.paragraphs
        str *=
        """
        <p class="p-justify literal">$p</p>
        """
    end

    str *=
    """
    </div>
    <div class="cell medium-4 large-3 centered">
    """

    for img in section.images
        str *=
        """
        <img class="thumbnail image hide-for-small-only" src="img/$(img.first)" alt="$(img.second)">
        """
    end

    str *=
    """
    </div>
    """
end
