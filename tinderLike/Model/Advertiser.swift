//
//  Advertiser.swift
//  tinderLike
//
//  Created by Paul Defilippi on 2/10/19.
//  Copyright © 2019 Paul Defilippi. All rights reserved.
//

import UIKit

struct Advertiser: CardViewModelProduceable {
    let title: String
    let brandName: String
    let posterPhotoName: String
    
    func toCardViewModel() -> CardViewModel {
        
        let attributedString = NSMutableAttributedString(string: title, attributes: [.font: UIFont.systemFont(ofSize: 34, weight: .heavy)])
        attributedString.append(NSAttributedString(string: "\n" + brandName, attributes: [.font: UIFont.systemFont(ofSize: 24, weight: .bold)]))
        return CardViewModel(imageNames: [posterPhotoName], attributedString: attributedString, textAlignment: .center)
    }
    
}

