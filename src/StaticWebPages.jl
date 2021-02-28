module StaticWebPages

using DataStructures
using FTPClient
using GitHub

using Gtk, GtkReactive

import Base.show

import Bibliography
import Bibliography: bibtex_to_web, Publication

export export_site
export iframe
export images
export paragraphs
export upload_site

export AbstractItem
export Block
export Card
export CardColor
export GitRepo
export TimeLine
export TimeLineColor

include("constant.jl")
include("inline.jl")
include("items.jl")
include("skeleton.jl")
include("page.jl")
include("io.jl")
include("gui.jl")

end # module StaticWebPages
