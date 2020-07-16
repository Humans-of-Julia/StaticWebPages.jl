######################################
# General informations
######################################

info["avatar"] = "pic.jpg"
info["cv"] = "cv.pdf"
info["lang"] = "en"
info["name"] = "Jean-François BAFFIER"
info["title"] = "Baffier"
info["email"] = "jf@baffier.fr"

## Social Networks (comment/delete lines to unwanted social network, input your personal info for the others)
info["researchgate"] = "https://www.researchgate.net/profile/Jean_Francois_Baffier"
info["googlescholar"] = "https://scholar.google.fr/citations?user=zo7FgSIAAAAJ&hl=fr"
info["orcid"] = "https://orcid.org/0000-0002-8800-6356"
info["dblp"] = "https://dblp.org/pid/139/8142"
info["linkedin"] = "https://www.linkedin.com/in/jeanfrancoisbaffier/"
info["github"] = "https://github.com/Azzaare"

######################################
# Contributors user name => real name
######################################
user_to_name["azzaare"] = "Jean-François Baffier"
user_to_name["nicill"] = "Yago Diez"
user_to_name["matiaskorman"] = "Matias Korman"

######################################
# index.html
# biography
# academic positions
# education and training
# honors, awards, and grants
######################################
page(
    title="index",
    sections=[
        Section(
            title="Biography",
            items=Block(
                paragraphs(
                """
               Jean-François Baffier is an academic researcher at the RIKEN Center for Advanced Intelligence Project (AIP), and a consultant in Artificial Intelligence, Big Data Science, Data Structures, and Algorithms. As an academic, he gives back to society through fundamental research in computer science supplemented by open source libraries and softwares.
                """,
                """
                Jean-François graduated Master course at University Paris-Sud and got his Ph.D. from the University of Tokyo. He was a member of the ERATO Kawarabayashi Large Project in Tokyo and Sendai, and a JSPS-CNRS research fellow hosted at the Tokyo Institute of Technology (Japan). He also was a JFLI member from October 2011 to August 2018.
                """,
                """
                His current $(link("research project", "research.hmtl")) involves the study of the “Analysis of information networks,” the “Smart compression for high-scalability of data structures,” and “Explainable Artificial Intelligence.” Other topic of interest covers modeling of failures and routing in Networks, Game Analysis, and AI for Games.
                """,
                """
                Jean-François implemented the StaticWebPages.jl package that was used to generate this website using a simple content file. This is a dummy email: $(email("dummy@example.purpose"))
                """
                ),
                images(
                    Image("cs.png", "Compressed Stack"),
                    Image("knowledge.png", "Flow of Knowledge")
                )
            )
        ),
        Double(
            Section(
                title="Academic positions",
                items=Deck(
                    Card(
                        "2020",
                        "current",
                        "Consultant",
                        "Data Science and Optimization"
                    ),
                    Card(
                        "2019",
                        "current",
                        "Postdoctoral Researcher",
                        "RIKEN Center for Advanced Intelligence (AIP)"
                        ),
                    Card(
                        "2017",
                        "2019",
                        "International Research Fellow",
                        "Japan Society for the Promotion of Science (hosted at the Tokyo Institute of Technology)"
                    ),
                    Card(
                        "2015",
                        "2017",
                        "Postdoctoral Researcher",
                        "National Institute of Informatics (JST-ERATO Kawarabayashi Large Graph Project)"
                    ),
                    Card(
                        "2012",
                        "2014",
                        "Teaching Assistant",
                        "The University of Tokyo"
                    ),
                    Card(
                        "2009",
                        "2010",
                        "Mathematics Teacher",
                        "Junior High-School (French Ministry of Education)"
                    )
                )
            ),
            Section(
                title="Education and training",
                items=Deck(
                    Card(
                        "Ph.D.",
                        "2015",
                        "Ph.D. of Information Science",
                        "The University of Tokyo"
                    ),
                    Card(
                        "M.Sc.",
                        "2011",
                        "Master of Science (Informatics)",
                        "Paris-Sud University"
                    ),
                    Card(
                        "2008",
                        "2009",
                        "Visiting Master Student",
                        "Paris-Diderot University"
                    ),
                    Card(
                        "B.Sc.",
                        "2007",
                        "Bachelor of Informatics-Mathematics",
                        "Paris-Sud University"
                    ),
                    Card(
                        "2003",
                        "2005",
                        "Higher School Preparatory Classes (Sciences)",
                        "École nationale de chimie physique et biologie de Paris (ENCPB)"
                    ),
                    Card(
                        "Bac.",
                        "2003",
                        "Baccalauréat of Science",
                        "Lycée Louis-le-Grand"
                    )
                )    
            )
        ),
        Section(
            title="Honors, awards, and grants",
            items=TimeLine(
                Dot(
                    "2017-2019",
                    "JSPS-CNRS fellowship",
                    "Competitive fellowship with an associated grant (KAKENHI 17F17727 ) for international researchers in Japan."
                ),
                Dot(
                    "2012-2015",
                    "MEXT Scholarship",
                    "The Monbukagakusho Scholarship is an academic scholarship offered by the Japanese Ministry of Education, Culture, Sports, Science and Technology (MEXT)."
                )
            )
        )
    ]
)

######################################
# publications.html
######################################
page(
    title = "publications",
    background = bg_white,
    sections = [
        Section(
            title = "Publications",
            items = Publications("publications.bib")
        )
    ]
)

######################################
# research.html
######################################
page(
    title = "research",
    sections = [
        Section(
            title = "Research topics",
            items = Block(
                paragraphs(
                    """
                    Principal Research Projects: Network Interdiction, Compressed Data Sructures, Modern Academics, Explainable AI. Other research interest includes Graph Theory, Geometry, Optimization, and Games.
                    """,
                    """
                    All of this research is supported by Open-Source Softwares and published as peer-review academic papers. 
                    """
                ),
                images()
            )
        ),
        Section(
            title = "Network Interdiction",
            items = Block(
                paragraphs(
                    """
                    A situation when a network flow is attacked can be modeled by a game between two players: an attacker who wants to remove a set of links that minimizes the flow value and a defender that wants to maximize the flow value. When the attacker (resp. defender) plays first, the problem is called network interdiction (resp. network adaptive flow). Most of those interdiction problems are intractable.
                    """,
                    """
                    We provide a general framework to solve or approximate interdiction problems in polynomial time, along with Bilevel Mixed-Integer Programs with high accuracy to improve the approximated instances. 
                    """
                ),
                images(
                    Image("bmilp.png","Bilevel Mix-Integer Programming")
                )
            )
        ),
        Section(
            title = "Compressed Data Sructures",
            items = Block(
                paragraphs(
                    """
                    External data compression is a compression technique where the explicit data is stored as an external source such as hard-disks, streams, or any combination of distributed devices. The local device stores, in memory or cache, a small amount of explicit data that are the most likely to be used in the future. It also stores information required to stream (by small chunks) the rest of the data from the external source. This last process is called reconstruction.
                    """,
                    """
                    We use time-space trade-off techniques to execute stack algorithms with external compression in a fashion that provides a linearly longer execution time linear compared to classical stacks while reducing the space used from several order of magnitude.
                    """,
                    """
                    Current work extends this technique to other type of containers while trying to reduce/erase the reconstruction time. All our algorithms are black-boxes, that is the user only selects a compression rate compared to the original algorithms.
                    """
                ),
                images(
                    Image("cs.png", "Compressed Stack")
                )
            )
        ),
        Section(
            title = "Modern Academics",
            items = Block(
                paragraphs(
                    """
                    context
                    """,
                    """
                    resutls
                    """
                ),
                images(
                    Image("knowledge.png", "Flow of Knowledge")
                )
            )
        ),
        Section(
            title = "Explainable Artificial Intelligence",
            items = Block(
                paragraphs(
                    """
                    context
                    """,
                    """
                    resutls
                    """
                ),
                images()
            )
        ),

    ]
)

######################################
# software.html
######################################
page(
    title = "software",
    background = bg_white,
    sections = [
        Section(
            title = "Software",
            hide = true,
            items = GitRepo(
                "Azzaare/CompressedStacks.cpp",
                "Azzaare/StaticWebPages.jl",
                "Azzaare/Bibliography.jl",
                "Azzaare/BibParser.jl",
                "Azzaare/BibInternal.jl",
                "JuliaGraphs/LightGraphs.jl",
                "JuliaGraphs/LightGraphsExtras.jl",
                "JuliaGraphs/SNAPDatasets.jl",
                "Azzaare/PackageStream.jl"
            ),
        )
    ]
)

######################################
# End of the entries
######################################
