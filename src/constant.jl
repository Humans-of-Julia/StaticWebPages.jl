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
const color_to_label = Dict{ColorLabel,AbstractString}([
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

const academicons = Dict{AbstractString, AbstractString}([
    "researchgate"  => "ai ai-researchgate-square",
    "googlescholar" => "ai ai-google-scholar-square",
    "orcid"         => "ai ai-orcid-square",
    "dblp"          => "ai ai-dblp-square",
    "github"        => "fa fa-github-square",
    "linkedin"      => "fab fa-linkedin",
])

const info = Dict{AbstractString,AbstractString}([
    "title" => "title",
    "avatar" => "pic.jpg",
    "name" => "name",
    "lang" => "en"
])
const content = OrderedDict{AbstractString,Any}()
const local_info = Dict{AbstractString,AbstractString}()
const user_to_name = Dict{AbstractString,AbstractString}()
const publication_labels = OrderedDict{AbstractString,ColorLabel}()
