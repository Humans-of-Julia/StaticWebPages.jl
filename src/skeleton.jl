function head(
    info::Dict{AbstractString,AbstractString},
    page::AbstractString
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
      <link rel="stylesheet" href="css/app.css">
      <script src="https://kit.fontawesome.com/06a987762e.js" crossorigin="anonymous"></script>
    </head>
    """
end

function nav(
    info::Dict{AbstractString,AbstractString},
    content::OrderedDict{AbstractString,Any},
    page::AbstractString
    )
    str =
    """
    <div class="top-bar">
      <button class="close-button" aria-label="Close menu" type="button" data-close>
        <span aria-hidden="true">&times;</span>
      </button>
      <ul class="vertical dropdown menu" id="menu" data-dropdown-menu>
        <img src="img/$(info["avatar"])" alt="$(info["title"])" class="avatar">
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

    str *=
    """
        <li><a href="files/cv.pdf">C.V. (download)</a></li>
        <li><a href="#">Icon: RG etc</a></li>
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
