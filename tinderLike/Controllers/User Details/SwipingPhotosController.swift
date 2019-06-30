//
//  SwipingPhotosController.swift
//  tinderLike
//
//  Created by Paul Defilippi on 6/29/19.
//  Copyright © 2019 Paul Defilippi. All rights reserved.
//

import UIKit

class SwipingPhotosController: UIPageViewController, UIPageViewControllerDataSource {
    
    let controllers = [
        PhotoController(image: #imageLiteral(resourceName: "dismiss_circle")),
        PhotoController(image: #imageLiteral(resourceName: "like_circle")),
        PhotoController(image: #imageLiteral(resourceName: "refresh_circle")),
        PhotoController(image: #imageLiteral(resourceName: "super_like_circle")),
        PhotoController(image: #imageLiteral(resourceName: "boost_circle"))
    ]

    override func viewDidLoad() {
        super.viewDidLoad()
        
        dataSource = self
        
        view.backgroundColor = .white
        
        setViewControllers([controllers.first!], direction: .forward, animated: false)
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
    init(image: UIImage) {
        imageView.image = image
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(imageView)
        imageView.fillSuperview()
        imageView.contentMode = .scaleAspectFit
    }
}
