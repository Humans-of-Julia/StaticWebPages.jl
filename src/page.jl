struct Page
    background::BackgroundColor
    hide::Bool
    sections::Vector{<:AbstractSection}
    title::String

    function Page(
        background::BackgroundColor,
        hide::Bool,
        sections::Vector{<:AbstractSection},
        title::String
        )
        new(background, hide, sections, title)
    end
end

function page(;
    background::BackgroundColor=bg_grey,
    hide::Bool=false,
    sections::Vector{<:AbstractSection}=Vector{<:AbstractSection}(),
    title::String=""
    )
    content[title] = Page(background, hide, sections, title)
end

function to_html(p::Page, opt_in::Bool)
    str =
    """
    <!doctype html>
    <!-- This code was generated using the StaticWebPages.jl site generator that is under the GPLv2 license. More info at https://github.com/Azzaare/StaticWebPages.jl -->
    <html class="no-js" lang="$(info["lang"])">
    $(head(info, p.title))

    <body>
        <div class="title-bar" data-hide-for="medium">
            <button class="menu-icon" type="button" data-toggle="offCanvas"></button>
            <div class="title-bar-title">Menu</div>
        </div>
        <div class="off-canvas position-left reveal-for-medium" id="offCanvas" data-off-canvas>
            $(nav(info, content, p.title, opt_in))
        </div>

        <div class="off-canvas-content" data-off-canvas-content>
    """

    x = 2 # <hx> title level
    odd = p.background == bg_grey # starting background color

    for section in content[p.title].sections
        if !section.hide
            centered = x == 2 ? "" : " centered"
            oddness = odd ? "content-odd" : "content-even"
            str *=
            """
            <div class="grid-x grid-margin-x content $centered $oddness">
                $(to_html(section, x))
            </div>
            """
        end
        if x == 2
            x += 1
        end
        odd = !odd
    end

    str *=
    """
        </div>

        $(js())
    </body>
    </html>
    """
    return str
end
