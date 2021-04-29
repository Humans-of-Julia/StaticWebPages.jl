struct Card <: AbstractItem
    first::AbstractString
    second::AbstractString
    title::AbstractString
    content::AbstractString
end

struct Deck
    cards::Vector{Card}
    color::CardColor

    Deck(color::CardColor, args...) = new([card for card in args], color)
    Deck(args...; color::CardColor = card_blue) = new([card for card in args], color)
end

function to_html(deck::Deck)
    color = color_to_card[deck.color]
    str =
    """
    <ul class="ul-card">
    """

    for c in deck.cards
        str *=
        """
        <li>
            <div class="cardx">
                <span class="any $(color[1])">$(c.first)</span>
        """
        if !isempty(c.second)
            str *=
            """
                <span class="second any $(color[2])">$(c.second)</span>
            """
        end
        str *=
        """
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