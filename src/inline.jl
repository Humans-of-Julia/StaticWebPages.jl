struct Link
    content::String
    href::String
end

function link(l::Link)
    str = """<a href="$(l.href)">$(l.content)</a>"""
    return str
end
link(content::String, href::String) = link(Link(content, href))

struct Email
    address::String
    content::String
    obfuscated::Bool

    function Email(
        address::String,
        content::String,
        obfuscated::Bool
        )
        new(address, content, obfuscated)
    end
end

function email(e::Email)
    if e.obfuscated
        return """<span class="obfuscate unselectable">$(reverse(e.address))</span>"""
    else
        return link(Link(e.content, "mailto:$(e.address)"))
    end
end

function email(
    address::String;
    content::String="contact",
    obfuscated::Bool=true
    )
    email(Email(address, content, obfuscated))
end
