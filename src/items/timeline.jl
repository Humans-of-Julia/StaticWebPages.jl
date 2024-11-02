"""
    Dot

A structure for each `Dot` entry in a `TimeLine`.
"""
struct Dot <: AbstractItem
    date::AbstractString
    content::AbstractString
    text::AbstractString
end

"""
    TimeLine

A structure for a `TimeLine` item. It is compose of `Dot`s.
"""
struct TimeLine
    dots::Vector{Dot}
    color::TimeLineColor
end

"""
    TimeLine(color::TimeLineColor, args::Dot...)
    TimeLine(args::Dot...; color=tl_blue)

Construct a `TimeLime` with the dots in `args`. The `TimeLine` color can be set to: `tl_blue`, `tl_green`, `tl_red`, `tl_orange`, `tl_julia_blue`, `tl_julia_green`, `tl_julia_purple`, `tl_julia_red`, `tl_julia`.
"""
TimeLine(color::TimeLineColor, args::Dot...) = TimeLine([dot for dot in args], color)
TimeLine(args::Dot...; color = tl_blue) = TimeLine([dot for dot in args], color)

function to_html(tl::TimeLine)
    str = """
          <ul class="timeline">
          """
    if tl.color == tl_julia
        for dot in tl.dots
            str *= """
                   <li>
                       <div class="date julia-blue">$(dot.date)</div>
                       <div class="circle-julia julia-red"></div>
                       <div class="tldata julia-purple-border">
                           <div class="tlcontent">$(dot.content)</div>
                           <div class="tltext literal">$(dot.text)</div>
                       </div>
                   </li>
                   """
        end
    else
        color = color_to_timeline[tl.color]
        for dot in tl.dots
            str *= """
                   <li>
                       <div class="date $(color[1])">$(dot.date)</div>
                       <div class="circle $(color[1])"></div>
                       <div class="tldata $(color[2])">
                           <div class="tlcontent">$(dot.content)</div>
                           <div class="tltext literal">$(dot.text)</div>
                       </div>
                   </li>
                   """
        end
    end

    return str *= """
                  </ul>
                  """
end
