//
//  Cards.swift
//  shuffle_cards_app
//
//  Created by admin on 6/10/22.
//

import Foundation

struct Cards: Decodable {
    let code: String
    let image: String
    let images: Images
    let value: String
    let suit: String
    
    enum CodingKeys: String, CodingKey {
        case code = "code"
        case image = "image"
        case images = "images"
        case value = "value"
        case suit = "suit"
    }
}

struct Images: Decodable {
    let svg: String
    let png: String
    
    enum CodingKeys: String, CodingKey {
        case svg = "svg"
        case png = "png"
    }
}

