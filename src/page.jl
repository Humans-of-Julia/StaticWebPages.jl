abstract type AbstractPage end

hide(p::AbstractPage) = true
sections(p::AbstractPage) = Vector{AbstractSection}()

"""
    Page

A structure to store a page information.
"""
struct Page <: AbstractPage
    background::BackgroundColor
    hide::Bool
    sections::Vector{<:AbstractSection}
    title::String

    function Page(
        background::BackgroundColor,
        hide::Bool,
        sections::Vector{<:AbstractSection},
        title::String,
    )
        return new(background, hide, sections, title)
    end
end

"""
    page(; keyargs...)

Constructor for `Page`.
- `background::BackgroundColor=bg_grey`: by default, the first section of a page has a grey background.
- `hide::Bool=false`: an hidden page is not generated. However, it will appear in the navigation menu.
- `sections::Vector{<:AbstractSection}=Vector{<:AbstractSection}()`: list of sections that composes this page.
- `title::String=""`: Page's title, can be left empty.
"""
function page(;
    background::BackgroundColor=bg_grey,
    hide::Bool=false,
    sections::Vector{<:AbstractSection}=Vector{AbstractSection}(),
    title::String=""
)
    return content[title] = Page(background, hide, sections, title)
end

hide(p::Page) = p.hide
sections(p::Page) = p.sections

function to_html(p::Page, opt_in::Bool, date = nothing)
    nav_width = get!(info, "nav_width", "250")
    str = """
          <!doctype html>
          <!-- This code was generated using the StaticWebPages.jl site generator that is under the GPLv2 license. More info at https://github.com/Humans-of-Julia/StaticWebPages.jl -->
          <html class="no-js" lang="$(info["lang"])">
          $(head(info, p.title))

          <body>
              <div class="title-bar show-for-small-only">
                  <button class="menu-icon" type="button" data-toggle="offCanvas"></button>
                  <div class="title-bar-title">Menu</div>
              </div>
              <div class="off-canvas position-left reveal-for-medium" id="offCanvas" data-off-canvas data-transition="overlap" style="width:$(nav_width)px">
                  $(nav(info, content, p.title, opt_in))
              </div>

              <div class="off-canvas-content" data-off-canvas-content>
          """

    x = 2 # <hx> title level
    odd = p.background == bg_grey # starting background color

    for section in content[p.title] |> sections
        if !section.hide
            centered = x == 2 ? "" : " centered"
            oddness = odd ? "content-odd" : "content-even"
            str *= """
                   <div class="grid-x grid-margin-x content $centered $oddness">
                        $(to_html(section, x, date))
                   </div>
                   """
        end
        if x == 2
            x += 1
        end
        odd = !odd
    end

    str *= """
               </div>

               $(js())
           </body>
           </html>
           """
    return str
end
