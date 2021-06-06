[![Docs](https://img.shields.io/badge/docs-dev-blue.svg)](https://Humans-of-Julia.github.io/StaticWebPages.jl/dev)
[![Docs](https://img.shields.io/badge/docs-stable-blue.svg)](https://Humans-of-Julia.github.io/StaticWebPages.jl/stable)
[![Build Status](https://github.com/Humans-of-Julia/StaticWebPages.jl/workflows/CI/badge.svg)](https://github.com/Humans-of-Julia/StaticWebPages.jl/actions)
[![codecov](https://codecov.io/gh/Humans-of-Julia/StaticWebPages.jl/branch/master/graph/badge.svg?token=iiIHSFqA31)](https://codecov.io/gh/Humans-of-Julia/StaticWebPages.jl)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)

# StaticWebPages.jl

A user-friendly static website generator written in Julia. No programming nor webdev skills required!!! Entirely Open-Source (GPLv2 licence)!

Although this generator originally targets academicians, it works out well for personal webpage and any static usage (front-end only) A more advanced static framework in Julia is available (cf [Franklin.jl](https://github.com/tlienart/Franklin.jl)). For a full-stack web framework, please look at the great [Genie.jl](https://www.genieframework.com/).

This generator is for you if
- you want something simple to update and manage
- responsive design (looks good on most devices)
- want light load on the server and/or low bandwidth use
- have no time/interest in making your own website by "hand"
- new item/gadget access with a simple update in the julia command line

The beta only uses text files and command lines, but the first stable release will also integrate a graphical user interface (GUI).

I deeply apologize for those that tested the versions `v0.1.x`, as, from `v0.2.0`, the syntax has changed a lot. The reason is to add options to most components. It should not change drastically from now on.

## How does it work

The user provides the content (text, images, files) and select which `Items` will display it. As simple as that. A full working example is provided here (or in the example folder). The result is available as http://baffier.fr

### Installation

The only requirement is to install Julia and this package (preferably through the package interface of Julia). Please install the last stable release of [Julia](https://julialang.org/downloads/) on the official download page.

In the Julia REPL (that you can launch as a standalone or call within a console), please enter Pkg REPL. To quote the package manager documentation:
> Pkg comes with a REPL. Enter the Pkg REPL by pressing ] from the Julia REPL. To get back to the Julia REPL, press backspace or ^C.
 
The following code snippet update the general registry of Julia's packages, then install the `StaticWebPages.jl` package.

```
(@v1.5) pkg> up
(@v1.5) pkg> add StaticWebPages
```

You can check that the installation is complete and trigger a precompilation of the package (usually take a few minutes) by using the following command.

```julia
import StaticWebPages
```

Please note that precompilation occurs at first use after installation and updates. The somewhat long compilation is related to the BibTeX parser and should occur rarely.

The package can be use from the REPL, but we recommend it to be used through a script file as the `run.jl` presented below. Running the script should be as simple as writing the following command line.

```julia
julia run.jl
```

or in the REPL

```julia
include("run.jl")
```

### Files organization

The two first following files are the only requirement. However, most users will prefer to provide some images/pictures and additional files such as a cv, a bibliography, and some downloadable content.

#### Local script file: `run.jl`

```julia
# import the website generator functions
import StaticWebPages
import StaticWebPages: local_info

## private information (local folders, connection infos, etc.)
# content and site paths are always required
local_info["content"] = "path/to/content_folder"
local_info["site"] = "path/to/site_folder"

# necessary only if using the upload_site function
local_info["protocol"] = "ftp"
local_info["user"] = "user"
local_info["password"] = "password"
local_info["server"] = "server_address"

# `rm_dir = true` will clean up the site folder before generating it again. Default to false.
# `opt_in = true` will add a link to this generator website in the side menu. Default to false.
StaticWebPages.export_site(d=local_info, rm_dir = true, opt_in = true)

## upload website (comment/delete if not needed)
# unfortunately does not work yet on windows system, please sync manually for the moment
StaticWebPages.upload_site(local_info)
```

#### Content folder

It must contain a `content.jl` file, and both an `img` and a `files` folders. Other content files, such as BibTeX bibliographic file should be put at the root of the folder (alongside `content.jl`). Please check the provided example if necessary.

```julia
## content.jl
######################################
# General information
######################################

# The pic.jpg file needs to be put in the img folder
info["avatar"] = "pic.jpg"

# The cv.pdf file needs to be put in the files folder
info["cv"] = "cv.pdf"

info["lang"] = "en"
info["name"] = "Jean-François BAFFIER"
info["title"] = "Baffier"

# The email is obfuscated using a reverse email writing. The email appear normally (re-reverse) through CSS.
# Although this is an effective technique against bots, it probably won't eventually.
# The user is free to add additional security such as replacing '@' by 'at'.
info["email"] = "jf@baffier.fr"

## icons to social networks in the side menu
# comment/delete the unwanted entries
info["researchgate"] = "https://www.researchgate.net/profile/Jean_Francois_Baffier"
info["googlescholar"] = "https://scholar.google.fr/citations?user=zo7FgSIAAAAJ&hl=fr"
info["orcid"] = "https://orcid.org/0000-0002-8800-6356"
info["dblp"] = "https://dblp.org/pid/139/8142"
info["linkedin"] = "https://www.linkedin.com/in/jeanfrancoisbaffier/"
info["github"] = "https://github.com/Azzaare"
info["twitter"] = "https://twitter.com/bioazzaare"

######################################
# publications.html
######################################
page(
    title="publications",
    sections=[
        Section(
            title="Publications",
            items=Publications("publications.bib")
        )
    ]
)
```

### Themes

The only available theme for the moment is using Zurb foundation responsive front-end. Customization of this theme and addition of other themes are expected in a near future (contributions/suggestions/requests are welcome).

### Items

Items are guaranteed to be compatible with the main theme (and hopefully new ones will be too). 

##### `Publications` : a bibliography based on a bibliography file (uses [Bibliography.jl]((https://github.com/Azzaare/Bibliography.jl)))

```julia
# Simply provide a BibTeX file (usually .bib)
# Path is based on the root of the content folder
Publications("publications.bib")
```

To add labels to the publications entries, please add a `swp-labels` field to your entries. A `labels` field is also accepted, but will also appear in the bibTeX citation generated for that article. For instance,

```latex
@inproceedings{parmentier2019introducing,
    title={Introducing multilayer stream graphs and layer centralities},
    author={Parmentier, Pimprenelle and Viard, Tiphaine and Renoust, Benjamin and Baffier, Jean-Francois},
    booktitle={International Conference on Complex Networks and Their Applications},
    pages={684--696},
    year={2019},
    organization={Springer},
    doi = {10.1007/978-3-030-36683-4_55},
    swp-labels = {conference, preprint, software}
}
```

![Image of a Publication Item](https://github.com/Humans-of-Julia/StaticWebPages.jl/raw/master/captures/publication.png)

The attribution of colors is done automatically (within the limit of 22 labels, please issue a request if you need more ...)

##### `Deck` of `Card`s : a list of ordered and clearly separate cards

```julia
Deck( # Start of the list
    Card( # generic
        "Left",
        "Right",
        "Title",
        "Content"
    ),
    Card( # example
        "2019",
        "current",
        "Postdoctoral Researcher",
        "RIKEN Center for Advanced Intelligence (AIP)"
    )
 ) # End of the list
```

![Image of Card Items](https://github.com/Humans-of-Julia/StaticWebPages.jl/raw/master/captures/card.png)

##### `GitRepo` : a list of GitHub repository displayed similarly to BibTeX entries

```julia
gitrepo = GitRepo( # currently work only with GitHub
    "Azzaare/CompressedStacks.cpp",
    "Humans-of-Julia/StaticWebPages.jl",
    "Humans-of-Julia/Bibliography.jl",
    "Humans-of-Julia/BibParser.jl",
    "Humans-of-Julia/BibInternal.jl",
    "JuliaGraphs/LightGraphs.jl",
    "JuliaGraphs/LightGraphsExtras.jl",
    "JuliaGraphs/SNAPDatasets.jl",
    "Azzaare/PackageStream.jl"
)
```

![Image of a Git Item](https://github.com/Humans-of-Julia/StaticWebPages.jl/raw/master/captures/git.png)

Please note that GitHub will restrict unidentified requests to a certain amount per IP within a time limit (that I don't know the value). If it happens, a message error from GitHub API will be returned.

To circumvent this issue, you can uncomment the line `local_info["auth_tokens"] = "PATH/TO/token.jl'` in `run.jl` (or add it if necessary) **and** edit the `token.jl` by updating your Personnal [Access Token](https://docs.github.com/en/github/authenticating-to-github/creating-a-personal-access-token).

`token.jl` aims to store all authentication tokens (for now, just GitHub). It content must be as follow (it is a simple variable containing your PAT):
```julia
# WARNING!
# YOUR TOKENS SHOULD NEVER BE SHARED! IF YOU USE GIT, DON'T FORGET TO ADD `token.jl` TO YOUR `.gitignore` FILE!
# YOU CAN ALSO STORE `token.jl` OUTSIDE OF THE STATICWEBPAGES FOLDER!

github_pat = "YOUR_PERSONAL_ACCESS_TOKEN" 
```

If the token is not valid, a `401: Bad Creditential` error from GitHUb API will be returned.

As the comment states, take care not to push your token to your git repo! A good practice could be to store `token.jl` outside of your git project.

##### `Block` : Block of paragraphs with optional images on the side
```julia
# Examples with and without images
biography = Block(
    paragraphs(
    """
   Jean-François Baffier is an academic researcher at the RIKEN Center for Advanced Intelligence Project (AIP), and a consultant in Artificial Intelligence, Big Data Science, Data Structures, and Algorithms. As an academic, he gives back to society through fundamental research in computer science supplemented by open source libraries and softwares.
    """,
    """
    paragraph 2
    """,
    """
    paragraph 3
    """,
    """
    Jean-François implemented the StaticWebPages.jl package that was used to generate this website using a simple content file. This is a dummy email: $(email("dummy@example.purpose"))
    """
    ),
    images(
        Image("cs.png", "Compressed Stack"),
        Image("knowledge.png", "Flow of Knowledge")
    )
)

research = Block(
    paragraphs(
        """
        Principal Research Projects: Network Interdiction, Compressed Data Structures, Modern Academics, Explainable AI. Other research interest includes Graph Theory, Geometry, Optimization, and Games.
        """,
        """
        All of this research is supported by Open-Source Softwares and published as peer-review academic papers. 
        """
    ),
    images()
)
```

![Image of a Block Item](https://github.com/Humans-of-Julia/StaticWebPages.jl/raw/master/captures/paragraph.png)

##### `TimeLine`s : a list of continuous items
```julia
grants = TimeLine(
    Dot(
        "Top",
        "Title",
        "Content"
    ),
    Dot(
        "2012-2015",
        "MEXT Scholarship",
        "The Monbukagakusho Scholarship is an academic scholarship offered by the Japanese Ministry of Education, Culture, Sports, Science and Technology (MEXT)."
    )
)
```

![Image of a TimeLine Item](https://github.com/Humans-of-Julia/StaticWebPages.jl/raw/master/captures/timeline.png)

##### `Nest`! A container to list several items within the same section

```julia
# Nest will take a tuple of any Items (except itself)
positions_grants = Double(
    Section(
        title="Positions and grants",
        items=Nest(work_cards, grants)
    ),
    Section(title="Research Topics", items=research)
)
```

### Pages

A page is composed of a name and a list of sections which can each be either single or double column. Each section is either a single `Item` or a pair of `Item`s.

##### A publication page with only one single column section (by default, publications spread over two columns on large screens)

```julia
######################################
# publications.html
#   option 1: background for the page is set to start with white to emphasize the bibliographic items
######################################
page(
    title="publications",
    background=bg_white,
    sections=[
        Section(
            title="Publications",
            items=Publications("publications.bib")
        )
    ]
)
```

##### An index page with a TextSection and a double column (Card, TimeLine)

```julia
######################################
# index.html
# biography
# academic positions | honors, awards, and grants
######################################

# using previously defined items, we can define sections
section_biography = Section(title="Biography", items=biography)
positions_grants = Double(
    Section(title="Positions", items=work_cards),
    Section(title="Grants", items=grants)
)

# the next line will add the index page to the generated content
page(
    title="index",
    sections=[section_biography, positions_grants]
)
```

##### The `hide` option for `page` and `Section`

```julia
# Both page() and Section() can take the hide option
# If a page is hidden, it will not be generated, but it will still appear in the side menu
# If a section is hidden, it will just not appear (and the content will not be generated, including request to external API, such as GitHub)

page(
    title="software",
    background=bg_white,
    sections=[
        Section(
            title="Software",
            hide=true, # default to false
            items=github,
        )
    ]
)
```

### Inline components
Some components can be inserted within the content of usual `Item`s, such as `Block`, `Card`, `Dot`. Currently, only `link` and `email` are supported.

##### Email can obfuscated (default), or not ...

```julia
email("dummy@example.purpose") # obfuscated
email(
    "dummy@example.purpose";
    content = "content that appears as the email link", # ignored if obfuscated
    obfuscated = false
    )
```

##### Link can be an internal or an external link
```julia
link("research project", "research.hmtl") # inner link
link("StaticWebPages.jl", "https://github.com/Humans-of-Julia/StaticWebPages.jl")
```

### License

This software is under the GPLv2 license.

The main theme, and some items (`BibTeX`, `Card`, `TimeLine`) are inspired by the Word Press Faculty template of owwwlab, also under GPLv2. All elements inspired from that template can be found in the HTML/CSS code associated with those items.
