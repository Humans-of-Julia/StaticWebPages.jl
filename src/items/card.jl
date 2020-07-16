struct Card <: AbstractItem
    first::AbstractString
    second::AbstractString
    title::AbstractString
    content::AbstractString
end

struct Deck
    cards::Vector{Card}

    Deck(args...) = new([card for card in args])
end

function to_html(deck::Deck)
    str =
    """
    <ul class="ul-card">
    """

    for c in deck.cards
        str *=
        """
        <li>
            <div class="cardx">
                <span class="first any">$(c.first)</span>
                <span class="second any">$(c.second)</span>
            </div>
            <div class="description">
                <p class="cardtitle">$(c.title)</p>
                <p class="cardcontent literal">$(c.content)</p>
            </div>
        </li>
        """
    end

    str *=
    """
    </ul>
    """
end