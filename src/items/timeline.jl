struct Dot <: AbstractItem
    date::AbstractString
    content::AbstractString
    text::AbstractString
end

struct TimeLine 
    dots::Vector{Dot}
    TimeLine(args::Dot...) = new([dot for dot in args])
end

function to_html(tl::TimeLine)
    str =
    """
    <ul class="timeline">
    """

    for dot in tl.dots
        str *=
        """
        <li>
            <div class="date">$(dot.date)</div>
            <div class="circle"></div>
            <div class="tldata">
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