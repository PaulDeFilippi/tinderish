//
//  ViewController.swift
//  tinderLike
//
//  Created by Paul Defilippi on 12/25/18.
//  Copyright © 2018 Paul Defilippi. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
    
    let topStackView = TopNavigationStackView()
    let cardsDeckView = UIView()
    let buttonStackView = HomeBottomControlsStackView()
    
//    let users = [
//        User(name: "Catherine", age: 23, profession: "Disc Jockey", imageName: "lady5c"),
//        User(name: "Samantha", age: 29, profession: "Teacher", imageName: "lady4c")
//    ]
    
//    let cardViewModels = ([
//        User(name: "Catherine", age: 23, profession: "Disc Jockey", imageName: "lady5c"),
//        User(name: "Samantha", age: 29, profession: "Teacher", imageName: "lady4c"),
//        Advertiser(title: "Slide Out Menu", brandName: "Code44", posterPhotoName: "slide_out_menu_poster")
//        ] as [CardViewModelProduceable]).map { (producer) -> CardViewModel in
//            return producer.toCardViewModel()
//    }
    
    let cardViewModels: [CardViewModel] = {
        let producers = [
            User(name: "Catherine", age: 23, profession: "Disc Jockey", imageName: "lady5c"),
            User(name: "Samantha", age: 29, profession: "Teacher", imageName: "lady4c"),
            Advertiser(title: "Slide Out Menu", brandName: "Code44", posterPhotoName: "slide_out_menu_poster")
        ] as [CardViewModelProduceable]
        
        let viewModels = producers.map({return $0.toCardViewModel()})
        return viewModels
        
        
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupLayout()
        setupDummyCards()
    }
    
    // MARK:- Fileprivate
    
    fileprivate func setupDummyCards() {
        cardViewModels.forEach { (cardVM) in
            let cardView = CardView(frame: .zero)
            
            cardView.cardViewModel = cardVM
            
//            cardView.imageView.image = UIImage(named: cardVM.imageName)
//            cardView.informationLabel.attributedText = cardVM.attributedString
//            cardView.informationLabel.textAlignment = cardVM.textAlignment
            cardsDeckView.addSubview(cardView)
            cardView.fillSuperview()
        }
//        users.forEach { (user) in
//            let cardView = CardView(frame: .zero)
//            cardView.imageView.image = UIImage(named: user.imageName)
//            cardView.informationLabel.text = "\(user.name) \(user.age)\n\(user.profession)"
//
//            let attributedText = NSMutableAttributedString(string: user.name, attributes: [.font: UIFont.systemFont(ofSize: 32, weight: .heavy)])
//            attributedText.append(NSMutableAttributedString(string: "  \(user.age)", attributes: [.font: UIFont.systemFont(ofSize: 24, weight: .regular)]))
//            attributedText.append(NSMutableAttributedString(string: "\n\(user.profession)", attributes: [.font: UIFont.systemFont(ofSize: 20, weight: .regular)]))
//
//            cardView.informationLabel.attributedText = attributedText
//
//            cardsDeckView.addSubview(cardView)
//            cardView.fillSuperview()
//        }
    }
    
    fileprivate func setupLayout() {
        let overallStackView = UIStackView(arrangedSubviews: [topStackView, cardsDeckView, buttonStackView])
        overallStackView.axis = .vertical
        view.addSubview(overallStackView)
        overallStackView.anchor(top: view.safeAreaLayoutGuide.topAnchor, leading: view.leadingAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, trailing: view.trailingAnchor)
        overallStackView.isLayoutMarginsRelativeArrangement = true
        overallStackView.layoutMargins = .init(top: 0, left: 12, bottom: 0, right: 12)
        
        overallStackView.bringSubviewToFront(cardsDeckView)
    }

}

