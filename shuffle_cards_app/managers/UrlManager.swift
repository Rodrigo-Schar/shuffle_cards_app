//
//  UrlManager.swift
//  shuffle_cards_app
//
//  Created by admin on 6/14/22.
//

import Foundation

class UrlManager{
    static let instance = UrlManager()
    
    let urlShuffle = "https://deckofcardsapi.com/api/deck/new/shuffle/?deck_count=1"
    
    func urlDeck(text: String) -> String {
        let urlStr = "https://deckofcardsapi.com/api/deck/\(text)/draw/?count=52"
        return urlStr
    }
}
