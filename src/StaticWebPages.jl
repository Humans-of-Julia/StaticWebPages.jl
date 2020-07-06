module StaticWebPages

using FTPClient, DataStructures

import Bibliography
import Bibliography: bibtex_to_web, Publication

export export_site, upload_site,
       AbstractItem, TextSection, Card, TimeLine

include("constant.jl")
include("items.jl")
include("skeleton.jl")
include("page.jl")
include("io.jl")

end # module StaticWebPages
