//
//  ViewController.swift
//  shuffle_cards_app
//
//  Created by admin on 6/8/22.
//

import UIKit
import SVProgressHUD

class ViewController: UIViewController {
    
    @IBOutlet weak var cardsCollectionView: UICollectionView!
    var cardsList: [Cards] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        cardsCollectionView.delegate = self
        cardsCollectionView.dataSource = self
    }

    @IBAction func shuffleCards(_ sender: Any) {
        loadId()
    }
    
    func loadId(){
        guard let url = URL(string:UrlManager.instance.urlShuffle) else { return }
        
        NetworkManager.shared.get(Shuffle.self, from: url) { result in
            switch result {
                case .success(let deckid):
                    self.loadCards(id: deckid.deck_id)
                case .failure(let error):
                    print(error)
                    let alert = AlertManager.instance.showAlert(title: "Error", message: error.localizedDescription)
                self.present(alert, animated: true, completion: nil)
                }
            }
    }
    
    func loadCards(id: String){
        guard let url = URL(string:UrlManager.instance.urlDeck(text: id)) else { return }
        
        NetworkManager.shared.get(Deck.self, from: url) { result in
            switch result {
                case .success(let deck):
                    self.cardsList = deck.cards
                    self.cardsCollectionView.reloadData()
                case .failure(let error):
                    print(error)
                    let alert = AlertManager.instance.showAlert(title: "Error", message: error.localizedDescription)
                self.present(alert, animated: true, completion: nil)
                }
        }
    }
}

extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cardsList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MyCell", for: indexPath as IndexPath) as? cardCollectionViewCell ?? cardCollectionViewCell()
        
        let card = cardsList[indexPath.row]
        cell.cardImageView.image = ImageManager.instance.readUrl(urlStr: card.image)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let DetailCard = DetailCardViewController()
        DetailCard.card = cardsList[indexPath.row]
        showDetailViewController(DetailCard, sender: nil)
    }
}

