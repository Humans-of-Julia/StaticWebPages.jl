"""
    Link

Structure to handle html links within an `<: AbstractItem`. Behaviour is similar to the `<a>` html markup.
"""
struct Link
    content::String
    href::String
end

"""
    link(content::String, href::String)
    link(l::Link)

Construct an html link within an `<: AbstractItem`. Behaviour is similar to the `<a>` html markup.
"""
function link(l::Link)
    str = """<a href="$(l.href)">$(l.content)</a>"""
    return str
end
link(content::String, href::String) = link(Link(content, href))

"""
    Email

Email inline `Item`. Can be obfuscated.
"""
struct Email
    address::String
    content::String
    obfuscated::Bool

    function Email(address::String, content::String, obfuscated::Bool)
        return new(address, content, obfuscated)
    end
end

"""
    email(address::String; content::String="contact", obfuscated::Bool=true)
    email(e::Email)

Construct an email link. Can be obfuscated (default) to avoid bots spams.
"""
function email(e::Email)
    if e.obfuscated
        return """<span class="obfuscate unselectable">$(reverse(e.address))</span>"""
    else
        return link(Link(e.content, "mailto:$(e.address)"))
    end
end

function email(address::String; content::String="contact", obfuscated::Bool=true)
    return email(Email(address, content, obfuscated))
end

struct List
    items::Vector{String}
    ordered::Bool
end

function list(l::List)
    lt = l.ordered ? "ol" : "ul"
    return """<$lt class=inline_list>$(join(["<li><div  class=inline_list_item>$(item)</div></li>" for item in l.items]))</$lt>"""
end

list(items; ordered = false) = list(List(items, ordered))
