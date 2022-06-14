//
//  ImageManager.swift
//  shuffle_cards_app
//
//  Created by admin on 6/10/22.
//

import Foundation
import UIKit

class ImageManager {
    
    static let instance = ImageManager()
    
    func readUrl(urlStr: String) -> UIImage? {
        let url = URL(string: urlStr)
        let data = try? Data(contentsOf: url!)
        let image = UIImage(data: data!)
        
        return image
    }
}
