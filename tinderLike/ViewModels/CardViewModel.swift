//
//  CardViewModel.swift
//  tinderLike
//
//  Created by Paul Defilippi on 2/10/19.
//  Copyright © 2019 Paul Defilippi. All rights reserved.
//

import UIKit

protocol CardViewModelProduceable {
    func toCardViewModel() -> CardViewModel
}

struct CardViewModel {
    // we'll define the properties that our view will display / render out
    let imageName: String
    let attributedString: NSMutableAttributedString
    let textAlignment: NSTextAlignment
}

