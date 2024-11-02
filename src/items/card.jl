"""
    Card

A `Card` structure to fill a `Deck` item.
"""
struct Card <: AbstractItem
    first::AbstractString
    second::AbstractString
    title::AbstractString
    content::AbstractString
end

"""
    Deck

A `Deck` item, composed of cards.
"""
struct Deck
    cards::Vector{Card}
    color::CardColor
end

"""
    Deck(color::CardColor, args...)
    Deck(args...; color::CardColor=card_blue)

Construct a `Deck` with the cards in `args`. The `Deck` color can be set to: `card_blue`, `card_green`, `card_red`, `card_orange`, `card_julia_blue`, `card_julia_green`, `card_julia_purple`, `card_julia_red`.
"""
Deck(color::CardColor, args...) = Deck([card for card in args], color)
Deck(args...; color::CardColor = card_blue) = Deck([card for card in args], color)

function to_html(deck::Deck)
    color = color_to_card[deck.color]
    str = """
          <ul class="ul-card">
          """

    for c in deck.cards
        str *= """
               <li>
                   <div class="cardx">
                       <span class="any $(color[1])">$(c.first)</span>
               """
        if !isempty(c.second)
            str *= """
                       <span class="second any $(color[2])">$(c.second)</span>
                   """
        end
        str *= """
                   </div>
                   <div class="description">
                       <p class="cardtitle">$(c.title)</p>
                       <p class="cardcontent literal">$(c.content)</p>
                   </div>
               </li>
               """
    end

    return str *= """
                  </ul>
                  """
end
