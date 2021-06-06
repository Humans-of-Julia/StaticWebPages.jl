function head(
    info::Dict{String,String},
    page::String
    )
    subtitle = page == "index" ? "homepage" : page

    str =
    """
    <head>
      <meta charset="utf-8">
      <meta http-equiv="x-ua-compatible" content="ie=edge">
      <meta name="viewport" content="width=device-width, initial-scale=1.0">
      <title>$(info["title"]): $(subtitle)</title>
      <link rel="stylesheet" href="css/foundation.min.css">
      <link rel="stylesheet" href="https://cdn.rawgit.com/jpswalsh/academicons/master/css/academicons.min.css">
      <script src="https://kit.fontawesome.com/06a987762e.js" crossorigin="anonymous"></script>
      <link rel="stylesheet" href="css/app.css">
    </head>
    """
end

function nav(
    info::Dict{String,String},
    content::OrderedDict{String,Any},
    page::String,
    opt_in::Bool
    )
    avatar = get(info, "avatar_shape", "round") == "raw" ? "avatar_raw" : "avatar_round"
    str =
    """
    <div class="top-bar">
      <button class="close-button" aria-label="Close menu" type="button" data-close>
        <span aria-hidden="true">&times;</span>
      </button>
      <ul class="vertical dropdown menu" id="menu" data-dropdown-menu>
        <img src="img/$(info["avatar"])" alt="$(info["title"])" class="$avatar">
        <li class="menu-text">$(info["name"])</li>
    """

    for (p, c) in content
        item = p == "index" ? "Home" : uppercasefirst(p)
        if page == p
            str *=
           """
           <li class="is-active"><a href="$p.html">$item</a></li>
           """
        else
            str *=
           """
           <li><a href="$p.html">$item</a></li>
           """
        end
    end

    str *= "cv" ∈ keys(info) ? """\n<li><a href="files/$(info["cv"])">C.V.</a></li>\n""" : ""

    if "email" ∈ keys(info)
        if length(info["email"]) > 20
            aux = split(info["email"], "@")
            str *= """\n<li><span class="obfuscate unselectable nota">$(reverse(aux[1]))</span></li>\n"""
            str *= """\n<li><span class="obfuscate unselectable nota">$(reverse(aux[2]))@</span></li>\n"""
        else
            str *= """\n<li><span class="obfuscate unselectable nota">$(reverse(info["email"]))</span></li>\n"""
        end
    end

            acc = 1
    for i in keys(academicons)
        if i ∈ keys(info)
            if mod(acc, 3) == 1
                if acc > 1
                    str *=
            """
                </li>
            """
                end
                str *=
          """
              <li>
          """
            end
            str *=
        """
              <a href="$(info[i])" class="icon-menu" title="" target="_blank" data-original-title="Cite">
                <i class="$(academicons[i])"></i>
              </a>
        """
            acc += 1
        end
    end
    str *= acc > 1 ? "\n<li>\n" : ""

    aux = # only if users opt-in in the export_site function
    """\n<div class="opt-in">This site was generated using <a href="https://github.com/Azzaare/StaticWebPages.jl">StaticWebPages.jl</a></div></li>\n"""
    str *=
    """
          $(opt_in ? aux : "")
        </ul>
      </div>
    """
    return str
end

function js()
    str = """
    <script src="js/vendor/jquery.js"></script>
    <script src="js/vendor/what-input.js"></script>
    <script src="js/vendor/foundation.min.js"></script>
    <script src="js/app.js"></script>

    <script>
         \$(document).ready(function() {
            \$(document).foundation();
         })
     </script>
    """
    return str
end
