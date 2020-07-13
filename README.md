# StaticWebPages.jl

A user-friendly static website generator written in Julia. No programming nor webdev skills required!!! Entirely Open-Source (GPLv2 license)!

Although this generator originally targets academicians, it works out well for personal web page and any static usage (front-end only). For a full-stack web framework, please look at the great [Genie.jl](https://www.genieframework.com/).

This generator is for you if
- you want something simple to update and manage
- responsive design (looks good on most devices)
- want light load on the server and/or low bandwidth use
- have no time/interest in making your own website by "hand"
- new item/gadget access with a simple update in the Julia command line

The beta only uses text files and command lines, but the first stable release will also integrate a graphical user interface (GUI).

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

The two first following files are the only requirement. However, most users will prefer to provide some images/pictures and additional files such as a CV, a bibliography, and some downloadable content.

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

# `rm_dir = true` will clean up the site folder before generating it again. Default to false.
# `opt_in = true` will add a link to this generator website in the side menu. Default to false.
StaticWebPages.export_site(local_info; rm_dir = true, opt_in = true)

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
info["linkedin"] = "https://www.linkedin.com/in/