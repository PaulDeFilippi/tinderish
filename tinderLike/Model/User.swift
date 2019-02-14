//
//  User.swift
//  tinderLike
//
//  Created by Paul Defilippi on 2/9/19.
//  Copyright © 2019 Paul Defilippi. All rights reserved.
//

import UIKit

struct User: CardViewModelProduceable {
    
    // defining our properties for our model layer which are the properties
    // we need for each user on our cards
    let name: String
    let age: Int
    let profession: String
    let imageNames: [String]
    
    func toCardViewModel() -> CardViewModel {
        let attributedText = NSMutableAttributedString(string: name, attributes: [.font: UIFont.systemFont(ofSize: 32, weight: .heavy)])
        attributedText.append(NSMutableAttributedString(string: "  \(age)", attributes: [.font: UIFont.systemFont(ofSize: 24, weight: .regular)]))
        attributedText.append(NSMutableAttributedString(string: "\n\(profession)", attributes: [.font: UIFont.systemFont(ofSize: 20, weight: .regular)]))
        return CardViewModel(imageNames: imageNames, attributedString: attributedText, textAlignment: .left)
    }


}
