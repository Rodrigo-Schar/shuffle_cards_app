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
    @IBOutlet weak var suitSearchBar: UISearchBar!
    var cardsList: [Cards] = []
    var filterCardList: [Cards] = []
    var isSearching = false

    override func viewDidLoad() {
        super.viewDidLoad()
        cardsCollectionView.delegate = self
        cardsCollectionView.dataSource = self
        suitSearchBar.delegate = self
    }

    @IBAction func shuffleCards(_ sender: Any) {
        getDeckId()
    }
    
    func getDeckId() {
        guard let url = URL(string:UrlManager.instance.urlShuffle) else { return }
        
        SVProgressHUD.show()
        NetworkManager.shared.get(Shuffle.self, from: url) { result in
            switch result {
                case .success(let deckid):
                    self.getCardsBydeckId(deckId: deckid.deck_id)
                    SVProgressHUD.dismiss()
                case .failure(let error):
                    print(error)
                    let alert = AlertManager.instance.showAlert(title: "Error", message: error.localizedDescription)
                    SVProgressHUD.dismiss()
                self.present(alert, animated: true, completion: nil)
                }
            }
    }
    
    func getCardsBydeckId(deckId: String) {
        guard let url = URL(string:UrlManager.instance.urlDeck(text: deckId)) else { return }
        
        SVProgressHUD.show()
        NetworkManager.shared.get(Deck.self, from: url) { result in
            switch result {
                case .success(let deck):
                    self.cardsList = deck.cards
                    self.cardsCollectionView.reloadData()
                    SVProgressHUD.dismiss()
                case .failure(let error):
                    print(error)
                    let alert = AlertManager.instance.showAlert(title: "Error", message: error.localizedDescription)
                    SVProgressHUD.dismiss()
                self.present(alert, animated: true, completion: nil)
            }
        }
    }
}

extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if isSearching {
            return filterCardList.count
        } else {
            return cardsList.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MyCell", for: indexPath as IndexPath) as? CardCollectionViewCell ?? CardCollectionViewCell()
        let card: Cards
        
        if isSearching {
            card = filterCardList[indexPath.row]
        } else {
            card = cardsList[indexPath.row]
        }
        cell.cardImageView.image = ImageManager.instance.readUrl(urlStr: card.image)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let DetailCard = DetailCardViewController()
        
        if isSearching {
            DetailCard.card = filterCardList[indexPath.row]
        } else {
            DetailCard.card = cardsList[indexPath.row]
        }
        
        showDetailViewController(DetailCard, sender: nil)
    }
}

extension ViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        if cardsList.count == 0 {
            let alert = AlertManager.instance.showAlert(title: "Error", message: "You have to shuffle cards first")
            self.present(alert, animated: true, completion: nil)
        }
        
        filterCardList = cardsList.filter({ $0.suit.lowercased().prefix(searchText.count) == searchText.lowercased() })
        isSearching = true
        cardsCollectionView.reloadData()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        isSearching = false
        searchBar.text = ""
        cardsCollectionView.reloadData()
    }
}

