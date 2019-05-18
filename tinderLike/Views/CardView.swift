//
//  CardView.swift
//  tinderLike
//
//  Created by Paul Defilippi on 12/31/18.
//  Copyright © 2018 Paul Defilippi. All rights reserved.
//

import UIKit
import SDWebImage

class CardView: UIView {
    
    var cardViewModel: CardViewModel! {
        didSet {
            // let imageName = cardViewModel.imageNames[0] - this works but app will crash if there is no [0] index
            // needed to unwrap the imageNames variable after we changed it to an Array of images
            let imageName = cardViewModel.imageNames.first ?? ""
            // imageView.image = UIImage(named: imageName)
            // load image using some kind of url instead
            if let url = URL(string: imageName) {
                imageView.sd_setImage(with: url)
            }

            informationLabel.attributedText = cardViewModel.attributedString
            informationLabel.textAlignment = cardViewModel.textAlignment
            
            (0..<cardViewModel.imageNames.count).forEach { (_) in
                let barView = UIView()
                barView.backgroundColor = barDeselectedColor
                barStackView.addArrangedSubview(barView)
            }
            barStackView.arrangedSubviews.first?.backgroundColor = .white
            
            setupImageIndexObserver()
        }
    }
    
    fileprivate func setupImageIndexObserver() {
        cardViewModel.immageIndexObserver = { [weak self] (idx, imageUrl) in
            print("Changing Image from view model")
            if let url = URL(string: imageUrl ?? "") {
                self?.imageView.sd_setImage(with: url)
            }
            
            self?.barStackView.arrangedSubviews.forEach({ (v) in
                v.backgroundColor = self?.barDeselectedColor
            })
            self?.barStackView.arrangedSubviews[idx].backgroundColor = .white
        }
    }
    
    // Encapsulation
    fileprivate let imageView = UIImageView(image: #imageLiteral(resourceName: "lady5c"))
    fileprivate let gradientLayer = CAGradientLayer()
    fileprivate let informationLabel = UILabel()
    
    // Configurations
    fileprivate let threshold: CGFloat = 80
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupLayout()
        
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(handlePan))
        addGestureRecognizer(panGesture)
        
        addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleTap)))
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //var imageIndex = 0
    fileprivate let barDeselectedColor = UIColor(white: 0, alpha: 0.1)
    
    fileprivate func setupLayout() {
        // custom drawing code
        layer.cornerRadius = 10
        clipsToBounds = true
        
        imageView.contentMode = .scaleAspectFill
        addSubview(imageView)
        imageView.fillSuperview()
        
        setupBarsStackView()
        
        // add gradient layer - take into account z-index when adding a subview
        setupGradientLayer()
        
        addSubview(informationLabel)
        informationLabel.anchor(top: nil, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor, padding: .init(top: 0, left: 15, bottom: 15, right: 15))
        informationLabel.textColor = .white
        informationLabel.font = UIFont.systemFont(ofSize: 34, weight: .heavy)
        informationLabel.numberOfLines = 0
    }
    

    
    @objc fileprivate func handleTap(gesture: UITapGestureRecognizer) {
        print("tap tap tap !!!")
        let tapLocation = gesture.location(in: nil)
        let shouldAdvanceNextPhoto = tapLocation.x > frame.width / 2 ? true : false
        
        if shouldAdvanceNextPhoto {
            cardViewModel.advanceToNextPhoto()
        } else {
            cardViewModel.goToPreviousImage()
        }
    }
    
    fileprivate let barStackView = UIStackView()
    
    fileprivate func setupBarsStackView() {
        addSubview(barStackView)
        barStackView.anchor(top: topAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor, padding: .init(top: 8, left: 8, bottom: 0, right: 8), size: .init(width: 0, height: 4))
        barStackView.spacing = 4
        barStackView.distribution = .fillEqually
    }
    
    fileprivate func setupGradientLayer() {
        // draw gradient
        gradientLayer.colors = [UIColor.clear.cgColor, UIColor.black.cgColor]
        gradientLayer.locations = [0.5, 1.1]
        layer.addSublayer(gradientLayer)
    }
    
    override func layoutSubviews() {
        // in here you know what your cardView frame will be
        gradientLayer.frame = self.frame
    }

    
    @objc fileprivate func handlePan(gesture: UIPanGestureRecognizer) {

        switch gesture.state {
            // use remove all animations function when you have quick animations happening in your UI
        case .began:
            superview?.subviews.forEach({ (subview) in
                subview.layer.removeAllAnimations()
            })
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
        })
    }
    
}
