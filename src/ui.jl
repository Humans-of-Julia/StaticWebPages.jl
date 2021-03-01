module UI

using Gtk
# using GtkReactive

export ui

set_subtitle!(widget, str) = set_gtk_property!(widget, :subtitle, str)

function ui()
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
    flow = builder["flow"]
    tree = builder["tree"]

    set_subtitle!(header, "$(pwd())")

    ls = GtkTreeStore(String)
    info = push!(ls, ("Information",))
    index = push!(ls, ("Index",))
    test = push!(ls, ("Test",), index)

    showall(win)

    return win
end

end