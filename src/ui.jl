module UI

using Gtk
# using GtkReactive

import ..content

export ui

tree_dict(content, dict) = nothing

tree_dict(x) = tree_dict(x, Dict{String, Any}())

set_subtitle!(widget, str) = set_gtk_property!(widget, :subtitle, str)

function ui()
    ts = GtkTreeStore(String)
    info = push!(ts,("Informations",))
    tv = GtkTreeView(GtkTreeModel(ts))
    r1 = GtkCellRendererText()
    c1 = GtkTreeViewColumn("Content", r1, Dict([("text",0)]))
    push!(tv,c1)

    for page in keys(content)
        push!(ts, (page,))
    end
    
    uifile = joinpath(@__DIR__, "builder", "StaticWebPages.glade")
    builder = GtkBuilder(filename=uifile)

    # Associates widgets from GtkBuilder
    win = builder["window"]
    header = builder["header"]
    actions = builder["actions"]
    build = builder["build"]
    ftp = builder["ftp"]
    push = builder["push"]
    open_ = builder["open_project"]
    new_ = builder["new_project"]
    shokupan = builder["shokupan"]
    flow = builder["flow"]

    push!(shokupan, tv)

    set_subtitle!(header, "$(pwd())")

    showall(win)

    return win
end

end