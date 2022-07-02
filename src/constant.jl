"""
    FieldSort

An enumeration of the different sorting rules for a bibliography item.
- unsorted
- required
- lexicographic
"""
@enum FieldSort begin
    unsorted
    required
    lexicographic
end

"""
    Parser

An enumeration of the different parsers for a bibliography item.
- bibtex
"""
@enum Parser begin
    bibtex
end

"""
    FieldSort

An enumeration of the different background colors available. It will need to be adjusted for `Theme` and `SubTheme`.
- bg_none
- bg_white
- bg_grey
"""
@enum BackgroundColor begin
    bg_none
    bg_white
    bg_grey
end

"""
    ColorLabel

An enumeration of the different colors available for labels.
- red
- green
- yellow
- blue
- orange
- purple
- cyan
- magenta
- lime
- pink
- teal
- lavender
- brown
- beige
- maroon
- mint
- olive
- apricot
- navy
- grey
- white
- black

Currently, label colors cycle once the limit has been reached. Creation of cycles with different varieties of colors is welcomed.
"""
@enum ColorLabel begin
    red
    green
    yellow
    blue
    orange
    purple
    cyan
    magenta
    lime
    pink
    teal
    lavender
    brown
    beige
    maroon
    mint
    olive
    apricot
    navy
    grey
    white
    black
end

"""
    color_to_label

A dictionary to translate the enumeration in ColorLabel to actual HTML/CSS labels. An optional `black-text` color for text is given (it defaults to white-text).
"""
const color_to_label = Dict{ColorLabel,String}([
    red => "label-red",
    green => "label-green",
    yellow => "label-yellow black-text",
    blue => "label-blue",
    orange => "label-orange",
    purple => "label-purple",
    cyan => "label-cyan black-text",
    magenta => "label-magenta",
    lime => "label-lime black-text",
    pink => "label-pink black-text",
    teal => "label-teal",
    lavender => "label-lavender black-text",
    brown => "label-brown",
    beige => "label-beige black-text",
    maroon => "label-maroon",
    mint => "label-mint black-text",
    olive => "label-olive",
    apricot => "label-apricot black-text",
    navy => "label-navy",
    grey => "label-grey",
    white => "label-white black-text",
    black => "label-black",
])


"""
    CardColor

An enumeration of the different background colors available. It will need to be adjusted for `Theme` and `SubTheme`.
- card_blue
- card_green
- card_red
- card_orange
- card_julia_blue
- card_julia_green
- card_julia_purple
- card_julia_red
"""
@enum CardColor begin
    card_blue
    card_green
    card_red
    card_orange
    card_julia_blue
    card_julia_green
    card_julia_purple
    card_julia_red
end

"""
    color_to_card

A dictionary to translate the enumeration in CardColor to actual HTML/CSS attributes. A card can be composed of either one or two colors.
"""
const color_to_card = Dict{CardColor,Tuple{String,String}}([
    card_blue => ("blue-first", "blue-second"),
    card_green => ("green-first", "green-second"),
    card_red => ("red-first", "red-second"),
    card_orange => ("orange-first", "orange-second"),
    card_julia_blue => ("julia-blue", "julia-blue"),
    card_julia_green => ("julia-green", "julia-green"),
    card_julia_purple => ("julia-purple", "julia-purple"),
    card_julia_red => ("julia-red", "julia-red"),
])

"""
    TimeLineColor

An enumeration of the different `TimeLine`` colors available. It will need to be adjusted for `Theme` and `SubTheme`.
- tl_blue
- tl_green
- tl_red
- tl_orange
- tl_julia_blue
- tl_julia_green
- tl_julia_purple
- tl_julia_red
- tl_julia
"""
@enum TimeLineColor begin
    tl_blue
    tl_green
    tl_red
    tl_orange
    tl_julia_blue
    tl_julia_green
    tl_julia_purple
    tl_julia_red
    tl_julia
end

"""
    color_to_timeline

A dictionary to translate the enumeration in `TimeLineColor` to actual HTML/CSS attributes.
"""
const color_to_timeline = Dict{TimeLineColor,Tuple{String,String}}([
    tl_blue => ("tl-blue-bg", "tl-blue-border"),
    tl_green => ("tl-green-bg", "tl-green-border"),
    tl_red => ("tl-red-bg", "tl-red-border"),
    tl_orange => ("tl-orange-bg", "tl-orange-border"),
    tl_julia_blue => ("julia-blue", "julia-blue-border"),
    tl_julia_green => ("julia-green", "julia-green-border"),
    tl_julia_purple => ("julia-purple", "julia-purple-border"),
    tl_julia_red => ("julia-red", "julia-red-border"),
])

"""
    academicons

A dictionary that tracks the HTML/CSS attributes for icons from font-awesome.
"""
const academicons = Dict{String,String}([
    "researchgate" => "ai ai-researchgate-square",
    "googlescholar" => "ai ai-google-scholar-square",
    "orcid" => "ai ai-orcid-square",
    "dblp" => "ai ai-dblp-square",
    "github" => "fa fa-github-square",
    "linkedin" => "fab fa-linkedin",
    "twitter" => "fa fa-twitter-square",
    # "discord"       => "fab fa-discord",
])

"""
    info

A dictionary, with default values, used to customize personal information.
"""
const info = Dict{String,String}([
    "title" => "title", "avatar" => "pic.jpg", "name" => "name", "lang" => "en"
])

"""
    content

An ordered dictionary to store the different web pages.
"""
const content = OrderedDict{String,Any}()

"""
    local_info

A dictionary that stores local information required to build and export the website.
"""
const local_info = Dict{String,String}()

"""
    user_to_name

A dictionary to translate user id (such as GitHub id) to real name. Normal use is that if an entry is found, then the id will be replaced by the appropriate name. Otherwise, the id is kept in use.

When a list of id is too long, priority is given to the id with an associated name.
"""
const user_to_name = Dict{String,String}()

"""
    publication_labels

An ordered dictionary to store the attributions of labels to keywords in a `Publications`.
"""
const publication_labels = OrderedDict{String,ColorLabel}()
