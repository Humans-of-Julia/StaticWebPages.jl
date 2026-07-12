[![Docs](https://img.shields.io/badge/docs-dev-blue.svg)](https://Humans-of-Julia.github.io/StaticWebPages.jl/dev)
[![Docs](https://img.shields.io/badge/docs-stable-blue.svg)](https://Humans-of-Julia.github.io/StaticWebPages.jl/stable)
[![Build Status](https://github.com/Humans-of-Julia/StaticWebPages.jl/workflows/CI/badge.svg)](https://github.com/Humans-of-Julia/StaticWebPages.jl/actions)
[![codecov](https://codecov.io/gh/Humans-of-Julia/StaticWebPages.jl/branch/master/graph/badge.svg?token=iiIHSFqA31)](https://codecov.io/gh/Humans-of-Julia/StaticWebPages.jl)
[![License: GPLv2](https://img.shields.io/badge/License-GPLv2-blue.svg)](https://www.gnu.org/licenses/old-licenses/gpl-2.0.en.html)
[![Discord chat](https://img.shields.io/discord/762167454973296644.svg?logo=discord&colorB=7289DA&style=flat-square)](https://discord.gg/7KC28q98nP)

# StaticWebPages.jl

StaticWebPages.jl is a Julia package for generating static websites from a
content folder and a small Julia configuration file.

The package is aimed at personal and academic websites, but it can also be used
for any static front-end page that needs:

- a simple content-driven workflow;
- a responsive layout;
- publications or GitHub project listings;
- optional upload to a remote server;
- a site structure described in Julia instead of hand-written HTML.

This README is the practical entry point. The full API reference lives in the
package documentation, but the goal here is to explain the actual components
and the expected project layout without needing to browse anything else.

## Quick Overview

The workflow is straightforward:

1. prepare a content folder;
2. write `content.jl` inside that folder;
3. set `local_info["content"]` and `local_info["site"]`;
4. call `export_site`;
5. optionally call `upload_site` if you deploy by FTP.

The package ships with a template in [`example/`](example/).

## Installation

Install Julia from [julialang.org](https://julialang.org/downloads/), then add
the package from the Julia REPL:

```julia
pkg> add StaticWebPages
```

If you are working from a checkout:

```julia
using StaticWebPages
```

The first load may take a little longer because the package depends on the
bibliography stack used for publications and GitHub listings.

## Minimal Example

```julia
import StaticWebPages
import StaticWebPages: local_info

local_info["content"] = "path/to/content_folder"
local_info["site"] = "path/to/site_folder"

StaticWebPages.export_site(d = local_info, rm_dir = true, opt_in = true)
```

Run the generator with:

```julia
julia run.jl
```

or from the REPL:

```julia
include("run.jl")
```

## Project Layout

Your content folder should contain at least:

- `content.jl`
- `img/`
- `files/`

Additional source files such as `.bib` files can be placed at the root of the
content folder next to `content.jl`.

Typical layout:

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

## Configuration

The package reads a `Dict{String,String}` called `local_info`. The most common
keys are:

- `content`: path to the content folder;
- `site`: path to the generated output folder;
- `lang`: page language, for example `"en"`;
- `name`: displayed name in the navigation menu;
- `title`: site title;
- `avatar`: avatar image file name inside `img/`;
- `avatar_shape`: set to `"raw"` to keep the original image shape;
- `cv`: file name inside `files/` for the CV link;
- `email`: contact email, displayed in obfuscated form in the menu;
- `nav_width`: navigation width in pixels;
- `researchgate`, `googlescholar`, `orcid`, `dblp`, `linkedin`, `github`,
  `twitter`, `discord`: optional social links.

### Site Generation

```julia
StaticWebPages.export_site(d = local_info, rm_dir = true, opt_in = false)
```

Arguments:

- `d`: configuration dictionary, usually `local_info`;
- `rm_dir`: if `true`, the output directory is deleted and recreated;
- `opt_in`: if `true`, the navigation includes a small “generated with
  StaticWebPages.jl” banner.

### Uploading

`upload_site` uploads the generated site through FTP:

```julia
StaticWebPages.upload_site(local_info)
```

For FTP upload, define:

- `protocol`
- `user`
- `password`
- `server`

Example:

```julia
local_info["protocol"] = "ftp"
local_info["user"] = "user"
local_info["password"] = "password"
local_info["server"] = "server_address"
```

## GitHub Authentication

The `GitRepo` item fetches repository metadata from the GitHub API. Public
repositories work without authentication, but GitHub rate limits anonymous
requests.

To use a token, create a `token.jl` file containing a `github_pat` variable:

```julia
github_pat = "YOUR_PERSONAL_ACCESS_TOKEN"
```

Then point `local_info["auth_tokens"]` to the directory containing that file:

```julia
local_info["auth_tokens"] = "path/to/tokens"
```

During site generation, the package loads `path/to/tokens/token.jl` and uses
the token if `github_pat` is defined.

Recommendations:

- keep `token.jl` out of version control;
- store it outside the project if possible;
- use a GitHub token with the minimum permissions needed for API access.

## Components

### Pages

Pages are declared with `page(...)`.

```julia
page(
    title = "index",
    sections = [ ... ]
)
```

Page options:

- `title`: page name and generated file name;
- `background`: page background color;
- `hide`: if `true`, the page is not generated;
- `sections`: list of sections.

### Sections

Sections are the content blocks inside a page.

Use `Section(...)` for a single-column section:

```julia
Section(
    title = "Biography",
    items = Block(...),
)
```

Use `Double(...)` to place two sections side by side:

```julia
Double(
    Section(title = "Left", items = ...),
    Section(title = "Right", items = ...),
)
```

Section options:

- `title`
- `items`
- `bgcolor`
- `hide`
- `title_size`

### Items

Items are the actual visual blocks rendered inside sections.

#### `Publications`

Renders a bibliography from a BibTeX file through `Bibliography.jl`.

```julia
Publications("publications.bib")
```

Useful for:

- publication lists;
- CV bibliographies;
- conference or software pages.

Entries can be labeled with `swp-labels`:

```latex
swp-labels = {conference, preprint, software}
```

If a `labels` field is present, it is also read, but it stays part of the BibTeX
citation. Prefer `swp-labels` for site-specific tagging.

#### `GitRepo`

Displays GitHub repositories similarly to publication cards.

```julia
GitRepo(
    "Humans-of-Julia/StaticWebPages.jl",
    "Humans-of-Julia/Bibliography.jl"
)
```

You can also attach labels to a repository entry:

```julia
GitRepo(
    "Humans-of-Julia/StaticWebPages.jl" => ["julia", "website"]
)
```

By default, bot accounts such as `github-actions[bot]` are filtered out of the
contributors list.

#### `Block`

Wraps paragraphs and optional side images.

```julia
Block(
    paragraphs("First paragraph", "Second paragraph"),
    images()
)
```

Useful for:

- biography sections;
- project descriptions;
- research summaries.

#### `Deck` of `Card`s

A card deck is a compact way to display structured items like positions,
responsibilities, or milestones.

```julia
Deck(
    Card("2019", "current", "Researcher", "Some institute"),
    Card("2016", "2019", "PhD", "Some university")
)
```

#### `TimeLine`

Timeline items are meant for chronological data such as grants, positions, or
career history.

```julia
TimeLine(
    Dot("2012-2015", "MEXT Scholarship", "Description"),
    Dot("2016-2019", "PhD", "Description")
)
```

### Inline Components

Some helper components can be embedded inside text content.

#### `email`

```julia
email("dummy@example.org")
email("dummy@example.org"; content = "contact me", obfuscated = false)
```

By default, the address is obfuscated in the generated HTML.

#### `link`

```julia
link("StaticWebPages.jl", "https://github.com/Humans-of-Julia/StaticWebPages.jl")
link("Publications", "publications.html")
```

## Example Content File

```julia
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

## Templates and Examples

The repository includes:

- `example/content.jl`
- `example/run.jl`
- sample bibliography files
- images and assets
- template archives for quick reuse

## Theming

The current theme is based on Zurb Foundation.

The package is intentionally opinionated so sites stay lightweight and
predictable. The content model is stable, so future themes can be added without
forcing users to rewrite their content files.

## License

This software is distributed under the GPLv2 license.

Some visual ideas and several items, including `BibTeX`, `Card`, and
`TimeLine`, are inspired by the WordPress Faculty template from owwwlab, also
under GPLv2.
