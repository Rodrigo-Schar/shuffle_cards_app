//
//  AlertManager.swift
//  shuffle_cards_app
//
//  Created by admin on 6/14/22.
//

import Foundation
import UIKit

class AlertManager {
    
    static let instance = AlertManager()
    
    func showAlert(title: String, message: String) -> UIAlertController {
        let alert  = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { action in
            print("Ok")
        }))
        return alert
    }
}
