# Items

Items are guaranteed to be compatible with the main theme (and hopefully new ones will be too).

##### `Publications` : a bibliography based on a bibliography file (uses [Bibliography.jl](https://github.com/Humans-of-Julia/Bibliography.jl))

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
    swp-labels = {conference, preprint, software, python, modern academics}
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
