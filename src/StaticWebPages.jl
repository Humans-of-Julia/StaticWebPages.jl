module StaticWebPages

import DataStructures: OrderedDict
import FTPClient: FTP
import GitHub: Repo

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

function load_example()
    include(joinpath(@__DIR__, "..", "example", "content.jl"))
end

include("constant.jl")
include("inline.jl")
include("items.jl")
include("skeleton.jl")
include("page.jl")
include("io.jl")

end # module StaticWebPages
