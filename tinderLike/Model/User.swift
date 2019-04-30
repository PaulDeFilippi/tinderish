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
    var name: String?
    var age: Int?
    var profession: String?
    var imageUrl1: String?
    var uid: String?
    
    init(dictionary: [String: Any]) {
        // we'll initialize our user here
        
        self.age = dictionary["age"] as? Int
        self.profession = dictionary["profession"] as? String
        
        self.name = dictionary["fullName"] as? String ?? ""
        self.imageUrl1 = dictionary["imagerUrl1"] as? String ?? ""
        self.uid = dictionary["uid"] as? String ?? ""

        
    }
    
    func toCardViewModel() -> CardViewModel {
        let attributedText = NSMutableAttributedString(string: name ?? "", attributes: [.font: UIFont.systemFont(ofSize: 32, weight: .heavy)])
        
        let ageString = age != nil ? "\(age!)" : "N\\A"
        
        attributedText.append(NSMutableAttributedString(string: "  \(ageString)", attributes: [.font: UIFont.systemFont(ofSize: 24, weight: .regular)]))
        
        let professionString = profession != nil ? profession! : "Not Available"
        
        attributedText.append(NSMutableAttributedString(string: "\n\(professionString)", attributes: [.font: UIFont.systemFont(ofSize: 20, weight: .regular)]))
        return CardViewModel(imageNames: [imageUrl1 ?? ""], attributedString: attributedText, textAlignment: .left)
    }


}
