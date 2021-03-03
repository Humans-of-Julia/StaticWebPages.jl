function make_tree!(ts, item::Item, parent)
    str = replace(String(Symbol(typeof(item))), "StaticWebPages." => "")
    push!(ts, (str,), parent)
end

function make_tree!(ts, nest::Nest, parent)
    nest = push!(ts, ("Nest",), parent)
    foreach(item -> make_tree!(ts, item, nest), nest.list)
end

function make_tree!(ts, s::Section, parent)
    section = push!(ts, (s.title,), parent)
    make_tree!(ts, s.items, section)
end

function make_tree!(ts, s::Double, parent)
    double = push!(ts, ("Double",), parent)
    make_tree!(ts, s.first, double)
    make_tree!(ts, s.second, double)
end

function make_tree!(ts, x)
    for (key, val) in x
        page = push!(ts, (val.title,))
        foreach(section -> make_tree!(ts, section, page), val.sections)
    end
end

set_subtitle!(widget, str) = set_gtk_property!(widget, :subtitle, str)

function choose_project_folder(win)
    dir = open_dialog("Select content.jl folder", win, action=GtkFileChooserAction.SELECT_FOLDER)
    if isdir(dir)
        set_subtitle!(header, "$(pwd())")
    end
end

function ui()
    ts = GtkTreeStore(String)
    info = push!(ts,("Informations",))
    tv = GtkTreeView(GtkTreeModel(ts))
    r1 = GtkCellRendererText()
    c1 = GtkTreeViewColumn("Content", r1, Dict([("text",0)]))
    push!(tv,c1)

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

    showall(win)

    # make_tree!(ts, content)

    return win
end
