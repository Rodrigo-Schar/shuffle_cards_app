//
//  Deck.swift
//  shuffle_cards_app
//
//  Created by admin on 6/10/22.
//

import Foundation

struct Deck: Decodable {
    let success: Bool
    let deck_id: String
    let cards: [Cards]
    let remaining: Int
    
    enum CodingKeys: String, CodingKey {
        case success = "success"
        case deck_id = "deck_id"
        case cards = "cards"
        case remaining = "remaining"
    }
}
