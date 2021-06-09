module StaticWebPages

using FTPClient, DataStructures, GitHub

import Base.show

import Bibliography
import Bibliography: bibtex_to_web, Publication

export export_site, upload_site, paragraphs, images, iframe
export AbstractItem, Block, Card, TimeLine, GitRepo
export CardColor, TimeLineColor

include("constant.jl")
include("inline.jl")
include("items.jl")
include("skeleton.jl")
include("page.jl")
include("io.jl")

end # module StaticWebPages
