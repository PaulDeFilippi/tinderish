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
    
    let cardViewModels: [CardViewModel] = {
        let producers = [
            User(name: "Kelly", age: 23, profession: "Disc Jockey", imageNames: ["kelly1", "kelly2", "kelly3"]),
            User(name: "Jane", age: 29, profession: "Teacher", imageNames: ["jane1", "jane2", "jane3"]),
            Advertiser(title: "Slide Out Menu", brandName: "Code44", posterPhotoName: "slide_out_menu_poster")
        ] as [CardViewModelProduceable]
        
        let viewModels = producers.map({return $0.toCardViewModel()})
        return viewModels
        
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        topStackView.settingsButton.addTarget(self, action: #selector(handleSettings), for: .touchUpInside)
        
        setupLayout()
        setupDummyCards()
    }
    
    // MARK:- Fileprivate
    
    @objc func handleSettings() {
        print("Show reg page")
        let registrationViewController = RegistrationViewController()
        present(registrationViewController, animated: true)
    }
    
    fileprivate func setupDummyCards() {
        cardViewModels.forEach { (cardVM) in
            let cardView = CardView(frame: .zero)
            cardView.cardViewModel = cardVM
            cardsDeckView.addSubview(cardView)
            cardView.fillSuperview()
        }
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

