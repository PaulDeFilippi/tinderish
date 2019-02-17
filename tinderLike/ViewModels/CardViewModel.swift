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

// ViewModel is meant to represent the state of our view
class CardViewModel {
    // we'll define the properties that our view will display / render out
    let imageNames: [String]
    let attributedString: NSAttributedString
    let textAlignment: NSTextAlignment
    
    init(imageNames: [String], attributedString: NSAttributedString, textAlignment: NSTextAlignment) {
        self.imageNames = imageNames
        self.attributedString = attributedString
        self.textAlignment = textAlignment
    }
    
    fileprivate var imageIndex = 0 {
        didSet {
            let imageName = imageNames[imageIndex]
            let image = UIImage(named: imageName)
            immageIndexObserver?(imageIndex, image)
        }
    }
    
    // Reactive Programming
    
    var immageIndexObserver: ((Int, UIImage?) -> ())?
    
    func advanceToNextPhoto() {
        imageIndex = min(imageIndex + 1, imageNames.count - 1)
    }
    
    func goToPreviousImage() {
        imageIndex = max(0, imageIndex - 1)
    }
}

