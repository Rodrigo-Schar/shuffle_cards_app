//
//  DetailCardViewController.swift
//  shuffle_cards_app
//
//  Created by admin on 6/9/22.
//

import UIKit

class DetailCardViewController: UIViewController {
    @IBOutlet weak var detailImageView: UIImageView!
    var card: Cards?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if let card = card {
            detailImageView.image = ImageManager.instance.readUrl(urlStr: card.image)
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?)
        {
            let touch = touches.first
            if touch?.view != self
            { self.dismiss(animated: true, completion: nil) }
        }

}
