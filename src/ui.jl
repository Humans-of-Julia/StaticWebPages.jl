function make_tree!(ts, item::Item, parent)
    str = replace(String(Symbol(typeof(item))), "StaticWebPages." => "")
    Gtk4.TreeStore.append(ts, parent, Dict(:text => str))
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

function populate_tree_view(content)
    ts = Gtk4.TreeStore(String)
    make_tree!(ts, content)
    tree_view = Gtk4.TreeView(ts)

    r1 = Gtk4.CellRendererText()
    c1 = Gtk4.TreeViewColumn("Content", Dict(:text => r1))
    Gtk4.TreeView.append_column(tree_view, c1)

    return tree_view
end

function ui()
    # ts = GtkTreeStore(String)
    # info = GtkTreeStore.append(ts, Dict(:text => "Informations"))
    # tv = populate_tree_view(content)

    # # Update the path to your Glade file
    # uifile = joinpath(@__DIR__, "builder", "StaticWebPages.glade")
    # builder = Gtk4.Builder(filename=uifile)

    # # Associates widgets from GtkBuilder
    # win = builder["window"]
    # header = builder["header"]
    # actions = builder["actions"]
    # build = builder["build"]
    # ftp = builder["ftp"]
    # push = builder["push"]
    # open_ = builder["open_project"]
    # new_ = builder["new_project"]
    # shokupan = builder["shokupan"]
    # flow = builder["flow"]

    # Gtk4.Box.append(shokupan, tv)

    # Gtk4.show(win)

    # return win
end
