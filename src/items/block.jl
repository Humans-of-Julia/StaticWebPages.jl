Image = Pair{String,String}

"""
    paragraphs(args::String...)

Construct an ordered sequence of paragraphs (text entries) for a `Block` item.
"""
paragraphs(args::String...) = [p for p in args]

"""
    images(args::Image...)

Construct an ordered sequence of images for a `Block` item. An `Image` should be given as a `Pair` of strings.
"""
images(args::Image...) = [img for img in args]

"""
    iframe(url)
Construct an iframe from `url`.
"""
iframe(url) = url

"""
    Block

An item to construct a sequence of paragraphs with a (possibly empty) sequence of images on the side. Instead of images, an iframe's url can be given.
"""
struct Block <: AbstractItem
    paragraphs::Vector{String}
    images::Vector{Image}
    iframe::String
end

"""
    Block(paragraphs, images)

Construct a `Block` with paragraphs and images.
"""
Block(paragraphs, images) = Block(paragraphs, images, "")

"""
    Block(paragraphs, iframe::String)

Construct a `Block` with paragraphs and an iframe.
"""
Block(paragraphs, iframe::String) = Block(paragraphs, Vector{Image}(), iframe)

function to_html(section::Block)
    full = isempty(section.images) && isempty(section.iframe) ? "" : "medium-8 large-9"
    str = """<div class="cell $full">\n"""

    for p in section.paragraphs
        str *= """
               <p class="p-justify literal">$p</p>
               """
    end

    str *= """
           </div>
           """

    if eltype(section.images) <: Pair || !isempty(section.iframe)
        str *= """
        <div class="cell medium-4 large-3 centered">
        """

        for img in section.images
            str *= """
                   <img class="thumbnail image hide-for-small-only" src="img/$(img.first)" alt="$(img.second)">
                   """
        end

        # TODO: check the iframe stuff
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
