[![Docs](https://img.shields.io/badge/docs-dev-blue.svg)](https://Humans-of-Julia.github.io/StaticWebPages.jl/dev)
[![Docs](https://img.shields.io/badge/docs-stable-blue.svg)](https://Humans-of-Julia.github.io/StaticWebPages.jl/stable)
[![Build Status](https://github.com/Humans-of-Julia/StaticWebPages.jl/workflows/CI/badge.svg)](https://github.com/Humans-of-Julia/StaticWebPages.jl/actions)
[![codecov](https://codecov.io/gh/Humans-of-Julia/StaticWebPages.jl/branch/master/graph/badge.svg?token=iiIHSFqA31)](https://codecov.io/gh/Humans-of-Julia/StaticWebPages.jl)
[![License: GPLv2](https://img.shields.io/badge/License-GPLv2-blue.svg)](https://www.gnu.org/licenses/old-licenses/gpl-2.0.en.html)
[![Discord chat](https://img.shields.io/discord/762167454973296644.svg?logo=discord&colorB=7289DA&style=flat-square)](https://discord.gg/7KC28q98nP)

# StaticWebPages.jl

StaticWebPages.jl is a Julia package for building static web pages from a
simple content folder.

It is designed for personal and academic websites, especially when you want to
describe the site content in Julia instead of hand-writing HTML.

Typical use cases:

- a personal homepage;
- an academic profile page;
- a publications page backed by BibTeX;
- a lightweight static site with no backend.

The package focuses on a small, explicit workflow:

1. write a `content.jl` file that describes the pages;
2. point the generator at your content folder and output folder;
3. run `export_site`;
4. optionally upload the generated files to your server.

The documentation site contains the full reference for all components. This
README is meant to be the quick start and the overview.

## Requirements

- Julia
- This package

Install the latest stable Julia release from
[julialang.org](https://julialang.org/downloads/).

Then install the package from the Julia REPL:

```julia
pkg> add StaticWebPages
```

If you are working from a checkout, you can also activate the package directly
and load it with:

```julia
using StaticWebPages
```

The first load may take a little while because the package also depends on the
bibliography stack.

## Quick Start

The usual entry point is a small Julia script, often named `run.jl`:

```julia
import StaticWebPages
import StaticWebPages: local_info

local_info["content"] = "path/to/content_folder"
local_info["site"] = "path/to/site_folder"

StaticWebPages.export_site(d = local_info, rm_dir = true, opt_in = true)
```

Run it with:

```julia
julia run.jl
```

or from the REPL:

```julia
include("run.jl")
```

If you want to upload the generated site after building it, fill the optional
connection settings:

```julia
local_info["protocol"] = "ftp"
local_info["user"] = "user"
local_info["password"] = "password"
local_info["server"] = "server_address"

StaticWebPages.upload_site(local_info)
```

## Content Folder

Your content folder must contain at least:

- `content.jl`
- `img/`
- `files/`

Other data files, such as `publications.bib`, can live at the root of the
content folder next to `content.jl`.

For convenience, the repository includes a ready-to-copy template in
[`example/`](example/).

### Example Layout

```text
content/
  content.jl
  publications.bib
  img/
    avatar.jpg
  files/
    cv.pdf
site/
```

### Example `content.jl`

```julia
using StaticWebPages

info["avatar"] = "avatar.jpg"
info["cv"] = "cv.pdf"
info["lang"] = "en"
info["name"] = "Jean-Francois Baffier"
info["title"] = "Baffier"
info["email"] = "jf@example.org"

info["github"] = "https://github.com/username"
info["linkedin"] = "https://www.linkedin.com/in/username/"

page(
    title = "index",
    sections = [
        Section(
            title = "About",
            items = Block(
                paragraphs(
                    "Write a short biography here.",
                    "Add as many paragraphs as needed."
                ),
                images()
            )
        ),
        Section(
            title = "Publications",
            items = Publications("publications.bib")
        )
    ]
)
```

## Main Concepts

### Pages

A page is created with `page(...)`.

It has:

- a `title`;
- an optional `background`;
- a list of `sections`;
- an optional `hide` flag.

Hidden pages are not generated, but they can still appear in the navigation.

### Sections

Use `Section(...)` for a single-column section.
Use `Double(...)` to build a two-column section from two `Section`s.

Sections also accept:

- `title`
- `items`
- `bgcolor`
- `hide`
- `title_size`

### Items

Items are the building blocks displayed inside sections.

Available item types include:

- `Publications`
- `Deck` of `Card`s
- `GitRepo`
- `Block`
- `TimeLine`

Some helpers are also exported for composing content:

- `paragraphs`
- `images`
- `iframe`
- `link`
- `email`

### Inline Components

Some pieces of content can be embedded directly in your text.

Examples:

```julia
email("dummy@example.org")
email("dummy@example.org"; content = "contact me", obfuscated = false)
link("StaticWebPages.jl", "https://github.com/Humans-of-Julia/StaticWebPages.jl")
```

## Publications

`Publications` uses the bibliography stack bundled with the Humans of Julia
projects.

```julia
Publications("publications.bib")
```

You can add labels to bibliography entries with `swp-labels`.

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

If a `labels` field is present, it is also used, but it will remain part of the
generated BibTeX citation. Prefer `swp-labels` for site-specific tagging.

## Common `local_info` Keys

These keys are the ones most often used by `content.jl` and `run.jl`:

- `content`: path to the content folder
- `site`: path to the generated site folder
- `lang`: site language code
- `name`: displayed name in the navigation
- `title`: site title
- `avatar`: avatar image file name in `img/`
- `cv`: CV file name in `files/`
- `email`: contact address, obfuscated in the menu
- `nav_width`: navigation width in pixels
- `avatar_shape`: set to `raw` to keep the original avatar shape
- social links such as `github`, `twitter`, `linkedin`, `orcid`, `dblp`,
  `googlescholar`, and `researchgate`
- `protocol`, `user`, `password`, `server`: optional upload settings

## Theming

The current theme is based on Zurb Foundation.

The package is intentionally opinionated so the generated sites stay simple,
fast, and readable. Additional themes can be added later without changing the
content model.

## Examples

The `example/` folder includes:

- a complete `content.jl`;
- a sample BibTeX bibliography;
- asset folders;
- downloadable template archives.

## License

This software is distributed under the GPLv2 license.

Some items and the general theme are inspired by the WordPress Faculty template
from owwwlab, also under GPLv2.
