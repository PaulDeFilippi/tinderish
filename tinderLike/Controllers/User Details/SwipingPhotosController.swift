//
//  SwipingPhotosController.swift
//  tinderLike
//
//  Created by Paul Defilippi on 6/29/19.
//  Copyright © 2019 Paul Defilippi. All rights reserved.
//

import UIKit

class SwipingPhotosController: UIPageViewController, UIPageViewControllerDataSource, UIPageViewControllerDelegate {
    
    var cardViewModel: CardViewModel! {
        didSet {
            print(cardViewModel.attributedString)
            controllers = cardViewModel.imageUrls.map({ (imageUrl) -> UIViewController in
                let photoController = PhotoController(imageUrl: imageUrl)
                return photoController
            })
            
            setViewControllers([controllers.first!], direction: .forward, animated: false)
            
            setupBarViews()
        }
    }
    
    fileprivate let barStackView = UIStackView(arrangedSubviews: [])
    fileprivate let deselectedBarColor = UIColor(white: 0, alpha: 0.1)
    
    fileprivate func setupBarViews() {
        cardViewModel.imageUrls.forEach { (_) in
            let barView = UIView()
            barView.backgroundColor = deselectedBarColor
            barView.layer.cornerRadius = 2
            barStackView.addArrangedSubview(barView)
            
        }
        
        barStackView.arrangedSubviews.first?.backgroundColor = .white
        barStackView.spacing = 4
        barStackView.distribution = .fillEqually
        view.addSubview(barStackView)
        let paddingTop = UIApplication.shared.statusBarFrame.height + 8
        barStackView.anchor(top: view.topAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, padding: .init(top: paddingTop, left: 8, bottom: 0, right: 8), size: .init(width: 0, height: 4))
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        
        
        let currentPhotoController = viewControllers?.first
        if let index = controllers.firstIndex(where: {$0 == currentPhotoController}) {
            barStackView.arrangedSubviews.forEach({$0.backgroundColor = deselectedBarColor})
            barStackView.arrangedSubviews[index].backgroundColor = .white
            
        }
        
        
        print("Page transition completed")
    }

    var controllers = [UIViewController]() // blank array
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dataSource = self
        delegate = self
        
        view.backgroundColor = .white
        
        
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        let index = self.controllers.firstIndex(where: {$0 == viewController}) ?? 0
        if index == controllers.count - 1 { return nil }
        return controllers[index + 1]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        let index = self.controllers.firstIndex(where: {$0 == viewController}) ?? 0
        if index == 0 { return nil }
        return controllers[index - 1]
    }

}

class PhotoController: UIViewController {
    
    let imageView = UIImageView(image: #imageLiteral(resourceName: "kelly1"))
    
    init(imageUrl: String) {
        if let url = URL(string: imageUrl) {
            imageView.sd_setImage(with: url)
        }
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(imageView)
        imageView.fillSuperview()
        imageView.contentMode = .scaleAspectFill
    }
}
