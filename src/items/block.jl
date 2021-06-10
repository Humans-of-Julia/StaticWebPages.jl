Image = Pair{AbstractString,AbstractString}
paragraphs(args::String...) = [p for p in args]
images(args::Image...) = [img for img in args]
iframe(url) = url

struct Block <: AbstractItem
    paragraphs::Vector{AbstractString}
    images::Vector{Image}
    iframe::String
end

Block(paragraphs, images) = Block(paragraphs, images, "")
Block(paragraphs, iframe::String) = Block(paragraphs, Vector{Image}(), iframe)

function to_html(section::Block)
    full = eltype(section.images) <: Union && isempty(section.iframe) ? "" :  "medium-8 large-9"
    str = """<div class="cell $full">\n"""

    for p in section.paragraphs
        str *=
        """
        <p class="p-justify literal">$p</p>
        """
    end

    str *=
    """
    </div>
    """

    if eltype(section.images) <: Pair || !isempty(section.iframe)
        str *= """
        <div class="cell medium-4 large-3 centered">
        """

        for img in section.images
            str *=
            """
            <img class="thumbnail image hide-for-small-only" src="img/$(img.first)" alt="$(img.second)">
            """
        end

        if !isempty(section.iframe)
            str *= """
            <iframe src="$(section.iframe)" class="discord-widget"
            allowtransparency="true" frameborder="0"
            sandbox="allow-popups allow-popups-to-escape-sandbox allow-same-origin allow-scripts">
            </iframe>
            """
        end

    str *= """</div>\n"""
    end
end
