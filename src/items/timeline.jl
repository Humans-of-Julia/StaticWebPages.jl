struct Dot <: AbstractItem
    date::AbstractString
    content::AbstractString
    text::AbstractString
end

struct TimeLine 
    dots::Vector{Dot}
    color::TimeLineColor

    TimeLine(color::TimeLineColor, args::Dot...) = new([dot for dot in args], color)
    TimeLine(args::Dot...; color = tl_blue) = new([dot for dot in args], color)
end

function to_html(tl::TimeLine)
    color = color_to_timeline[tl.color]
    str =
    """
    <ul class="timeline">
    """

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

    str *=
    """
    </ul>
    """
end