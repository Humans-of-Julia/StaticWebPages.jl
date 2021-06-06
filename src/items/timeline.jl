struct Dot <: AbstractItem
    date::AbstractString
    content::AbstractString
    text::AbstractString
end

struct TimeLine
    dots::Vector{Dot}
    color::TimeLineColor

    TimeLine(color::TimeLineColor, args::Dot...) = new([dot for dot in args], color)
    TimeLine(args::Dot...; color=tl_blue) = new([dot for dot in args], color)
end

function to_html(tl::TimeLine)
    str =
    """
    <ul class="timeline">
    """
    if tl.color == tl_julia
        for dot in tl.dots
            str *=
        """
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
            str *=
        """
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

    str *=
    """
    </ul>
    """
end
