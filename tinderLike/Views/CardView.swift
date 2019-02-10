//
//  CardView.swift
//  tinderLike
//
//  Created by Paul Defilippi on 12/31/18.
//  Copyright © 2018 Paul Defilippi. All rights reserved.
//

import UIKit

class CardView: UIView {
    
    let imageView = UIImageView(image: #imageLiteral(resourceName: "lady5c"))
    let informationLabel = UILabel()
    
    // Configurations
    fileprivate let threshold: CGFloat = 80
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        // custom drawing code
        layer.cornerRadius = 10
        clipsToBounds = true
        
        imageView.contentMode = .scaleAspectFill
        addSubview(imageView)
        imageView.fillSuperview()
        
        addSubview(informationLabel)
        //informationLabel.anchor(top: nil, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor)
        informationLabel.anchor(top: nil, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor, padding: .init(top: 0, left: 15, bottom: 15, right: 15))
        informationLabel.text = "TEST NAME TEST NAME AGE"
        informationLabel.textColor = .white
        informationLabel.font = UIFont.systemFont(ofSize: 34, weight: .heavy)
        informationLabel.numberOfLines = 0
        
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(handlePan))
        addGestureRecognizer(panGesture)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc fileprivate func handlePan(gesture: UIPanGestureRecognizer) {

        switch gesture.state {
        case .changed:
            handleChangedState(gesture)
        case .ended:
            handleEndedState(gesture)
        default:
            ()
        }
    }
    
    fileprivate func handleChangedState(_ gesture: UIPanGestureRecognizer) {
        let translation = gesture.translation(in: nil)

        // rotation - we need to convert radians to degrees in order to pass into creationAngle
        let degrees: CGFloat = translation.x / 20
        let angle = degrees * .pi / 180
        
        let rotationalTransformation = CGAffineTransform(rotationAngle: angle)
        self.transform = rotationalTransformation.translatedBy(x: translation.x, y: translation.y)
    }
    
    fileprivate func handleEndedState(_ gesture: UIPanGestureRecognizer) {
        let translationDirection: CGFloat = gesture.translation(in: nil).x > 0 ? 1 : -1
        let shouldDismissCard = abs(gesture.translation(in: nil).x) > threshold
        
        UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 0.6, initialSpringVelocity: 0.1, options: .curveEaseOut, animations: {
            
            if shouldDismissCard {
                self.frame = CGRect(x: 600 * translationDirection, y: 0, width: self.frame.width, height: self.frame.height)
            } else {
                self.transform = .identity
            }
            
        }, completion: { (_) in
            self.transform = .identity
            if shouldDismissCard {
                self.removeFromSuperview()
            }
            // forced unwrapped because superview will always exist
            // this line is what brings the card back on screen after animation is complete - that is why it is living in
            // the completion block
            //self.frame = CGRect(x: 0, y: 0, width: self.superview!.frame.width, height: self.superview!.frame.height)
        })
    }
    
}
