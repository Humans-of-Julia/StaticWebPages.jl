const dummy_info = OrderedDict{AbstractString,AbstractString}([
    "title" => "title",
    "avatar" => "pic.jpg",
    "name" => "name",
    "lang" => "en"
])
const dummy_content = OrderedDict{AbstractString,Any}([
    "index" => [],
    "publications" => [],
    "research" => [],
    "teachings" => [],
    "softwares" => [],
    "contact" => [],
    "cv" => [],
])

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