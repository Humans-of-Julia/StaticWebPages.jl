@enum FieldSort begin
    unsorted
    required
    lexicographic
end

@enum Parser begin
    bibtex
end

@enum BackgroundColor begin
    bg_none
    bg_white
    bg_grey
end

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

# default is white text. Color will be picked in order.
const color_to_label = Dict{ColorLabel,String}([
    red         => "label-red",
    green       => "label-green",
    yellow      => "label-yellow black-text",
    blue        => "label-blue",
    orange      => "label-orange",
    purple      => "label-purple",
    cyan        => "label-cyan black-text",
    magenta     => "label-magenta",
    lime        => "label-lime black-text",
    pink        => "label-pink black-text",
    teal        => "label-teal",
    lavender    => "label-lavender black-text",
    brown       => "label-brown",
    beige       => "label-beige black-text",
    maroon      => "label-maroon",
    mint        => "label-mint black-text",
    olive       => "label-olive",
    apricot     => "label-apricot black-text",
    navy        => "label-navy",
    grey        => "label-grey",
    white       => "label-white black-text",
    black       => "label-black"
])

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

const color_to_card = Dict{CardColor,Tuple{String,String}}([
    card_blue   => ("blue-first", "blue-second"),
    card_green  => ("green-first", "green-second"),
    card_red    => ("red-first", "red-second"),
    card_orange => ("orange-first", "orange-second"),
    card_julia_blue     => ("jl-blue", "jl-blue"),
    card_julia_green    => ("jl-green", "jl-green"),
    card_julia_purple   => ("jl-purple", "jl-purple"),
    card_julia_red      => ("jl-red", "jl-red"),
])

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

const color_to_timeline = Dict{TimeLineColor,Tuple{String,String}}([
    tl_blue   => ("tl-blue-bg", "tl-blue-border"),
    tl_green  => ("tl-green-bg", "tl-green-border"),
    tl_red    => ("tl-red-bg", "tl-red-border"),
    tl_orange => ("tl-orange-bg", "tl-orange-border"),
    tl_julia_blue     => ("jl-blue", "jl-blue-border"),
    tl_julia_green    => ("jl-green", "jl-green-border"),
    tl_julia_purple   => ("jl-purple", "jl-purple-border"),
    tl_julia_red      => ("jl-red", "jl-red-border"),
])

const academicons = Dict{String,String}([
    "researchgate"  => "ai ai-researchgate-square",
    "googlescholar" => "ai ai-google-scholar-square",
    "orcid"         => "ai ai-orcid-square",
    "dblp"          => "ai ai-dblp-square",
    "github"        => "fa fa-github-square",
    "linkedin"      => "fab fa-linkedin",
    "twitter"       => "fa fa-twitter-square",
    "discord"       => "fab fa-discord",
])

const info = Dict{String,String}([
    "title" => "title",
    "avatar" => "pic.jpg",
    "name" => "name",
    "lang" => "en"
])
const content = OrderedDict{String,Any}()
const local_info = Dict{String,String}()
const user_to_name = Dict{String,String}()
const publication_labels = OrderedDict{String,ColorLabel}()
