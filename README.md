# StaticWebPages.jl

A user-friendly static website generator written in Julia. No programming nor webdev skills required!!! Entirely Open-Source (MIT licence)!

Although this generator originally targets academicians, it works out well for personnal webpage and any static usage (front-end only).

This generator is for you if
- you want something simple to update and manage
- responsive design (looks good on most devices)
- want light load on the server and/or low bandwidth use
- have no time/interest in making your own website by "hand"
- new item/gadget access with a simple update in the julia command line

The beta only uses text files and command lines, but the first stable release will also integrate a graphical user interface (GUI).

## How does it work

The user provides the content (text, images, files) and select in which `Items` will display it. As simple as that. A full working example is provided here (or in the example folder). The result is available as http://baffier.fr

### Installation
The only requirement is to install Julia and this package (preferably through the package interface of Julia).

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

Please note that precompilation occurs before at first use after installation and updates. The somewhat long compilation is related to the BibTeX parser and should occur rarely.

The package can be use from the REPL, but we recommend it to be used through a script file as the `run.jl` presented below. Running the script should be as simple as writing the following command line.

```julia
julia run.jl
```

### Files organization

The two first following files are the only requirement. However, most users will prefer to provide some images/pictures and additional files such as a cv, a bibliography, and some downloadable content.

#### Local script file: `run.jl`

```julia
# import the website generator functions
import StaticWebPages
import StaticWebPages: local_info

## private informations (local folders, connection infos, etc.)
# content and site paths are always required
local_info["content"] = "path/to/content_folder"
local_info["site"] = "path/to/site_folder"

# necessary only if using the upload_site function
local_info["protocole"] = "ftp"
local_info["user"] = "user"
local_info["password"] = "password"
local_info["server"] = "server_address"

## export site to local folder
# `rm_dir = true` will clean up the site folder before generating it again
StaticWebPages.export_site(local_info; rm_dir = true)

## upload website (comment/delete if not needed)
# unfortunately does not work yet on windows system, please sync manually for the moment
StaticWebPages.upload_site(local_info)
```

#### Content folder

It must contain a `content.jl` file, and both an `img` and a `files` folders. Other content files, such as BibTeX bilbliographic file should be put at the root of the folder (alongside `content.jl`). Please check the provided example if necessary. 

```julia
## content.jl
######################################
# General informations
######################################

# The pic.jpg file needs to be put in the img folder
info["avatar"] = "pic.jpg"

# The cv.pdf file needs to be put in the files folder
info["cv"] = "cv.pdf"

info["lang"] = "en"
info["name"] = "Jean-François BAFFIER"
info["title"] = "Baffier"

## icons to social networks in the side menu
# comment/delete the unwanted entries
info["researchgate"] = "https://www.researchgate.net/profile/Jean_Francois_Baffier"
info["googlescholar"] = "https://scholar.google.fr/citations?user=zo7FgSIAAAAJ&hl=fr"
info["orcid"] = "https://orcid.org/0000-0002-8800-6356"
info["dblp"] = "https://dblp.org/pid/139/8142"
info["linkedin"] = "https://www.linkedin.com/in/jeanfrancoisbaffier/"
info["github"] = "https://github.com/Azzaare"

######################################
# publications.html (simple page example)
######################################
content["publications"] = [
    "Publications" => Bibtex("publications.bib")
] # end of publications.html
```

### Themes

The only available theme for the moment is using zurb foundation responsive front-end. Customization of this theme and addition of other themes are exepected in a near future (contributions/suggestions/requests are welcome).

### Items

Items are guaranteed to be compatible with the main theme (and hopefully new ones will be too). 

##### `Bibtex` : a bibliography based on a BibTeX file (use [Bibliography.jl]((https://github.com/Azzaare/Bibliography.jl)))

```julia
# Simply provide a BibTeX file (usually .bib)
# Path is based on the root of the content folder
Bibtex("publications.bib")
```

##### (list of) `Card`s : a list of ordered and clearly separate cards

```julia
[ # Start of the list
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
] # End of the list
```

##### `TextSection` : paragraphs with optional images on the side
```julia
# Examples with and without images
TextSection( # Start biography section
    [ # Start text paragraphs
    """
    Jean-François Baffier is an academic researcher at the RIKEN Center for Advanced Intelligence Project (AIP), and a consultant in Artificial Intelligence, Big Data Science, Data Structures, and Algorithms. As an academic, he gives back to society through fundamental research in computer science supplemented by open source libraries and softwares.
    """,
    """
    Paragraph 2
    """,
    """
    Paragraph 3
    """,
    """
    Jean-François implemented the ModernAcademics.jl package that was used to generate this website using a simple content file.
    """
    ], # End text paragraphs
    [ # Start images list (displayed in order)
        "cs.png" => "Compressed Stack",
        "knowledge.png" => "Flow of Knowledge"
    ] # end images list
)

TextSection(
        [ # list of paragraphs
            """
            Principal Research Projects: Network Interdiction, Compressed Data Sructures, Modern Academics, Explainable AI. Other research interest includes Graph Theory, Geometry, Optimization, and Games.
            """,
            """
            All of this research is supported by Open-Source Softwares and published as peer-review academic papers. 
            """
        ],
        [
            # empty list of images
        ]
    )

```

##### (list of) `TimeLine`s : a list of continuous items
```julia
[ 
    TimeLine( # generic
        "Top",
        "Title",
        "Content"
    ),
    TimeLine( # real example
        "2012-2015",
        "MEXT Scholarship",
        "The Monbukagakusho Scholarship is an academic scholarship offered by the Japanese Ministry of Education, Culture, Sports, Science and Technology (MEXT)."
    )
]
```

### Pages

A page is composed of a name and a list of sections which can each be either single or double column. Each section is either a single `Item` or a pair of `Item`s.

##### A publication page with only one single column section

```julia
######################################
# publications.html (simple page example)
######################################
content["publications"] = [
    "Publications" => Bibtex("publications.bib")
] # end of publications.html
```

##### An index page with a TextSection and a double column (Card, TimeLine)

```julia
######################################
# index.html
# biography
# academic positions | honors, awards, and grants
######################################
content["index"] = [

"Biography" => TextSection( # Start biography section
    [ # Start text paragraphs
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
    Jean-François implemented the ModernAcademics.jl package that was used to generate this website using a simple content file.
    """
    ], # End text paragraphs
    [ # Start images list
        "cs.png" => "Compressed Stack",
        "knowledge.png" => "Flow of Knowledge"
    ] # end images list
), # end biography section

# Start double column content
("Academic positions" => [ # Start column #1
    Card(
        "2020",
        "current",
        "Consultant",
        "Data Science and Optimization"
    ),
    Card(
        "2019",
        "current",
        "Postdoctoral Researcher",
        "RIKEN Center for Advanced Intelligence (AIP)"
    )
],
"Honors, awards, and grants" => [ 
    TimeLine(
        "2017-2019",
        "JSPS-CNRS fellowship",
        "Competitive fellowship with an associated grant (KAKENHI 17F17727 ) for international researchers in Japan."
    ),
    TimeLine(
        "2012-2015",
        "MEXT Scholarship",
        "The Monbukagakusho Scholarship is an academic scholarship offered by the Japanese Ministry of Education, Culture, Sports, Science and Technology (MEXT)."
    )
]) # end of double column content
] # end of index.html
```

### License

This software is under the GPLv2 license.

The main theme, and some items (`BibTeX`, `Card`, `TimeLine`) are inspired by the Word Press Faculty template of owwwlab, also under GPLv2. All elements inspired from that template can be found HTML/CSS code associated with those items.