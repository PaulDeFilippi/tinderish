//
//  Bindable.swift
//  tinderLike
//
//  Created by Paul Defilippi on 3/24/19.
//  Copyright © 2019 Paul Defilippi. All rights reserved.
//

import Foundation

class Bindable<T> {
    var value: T? {
        didSet {
            observer?(value)
        }
    }
    
    var observer: ((T?) -> ())?
    
    func bind(observer: @escaping (T?) -> ()) {
        self.observer = observer
    }
}
