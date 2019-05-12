//
//  RegistrationViewModel.swift
//  tinderLike
//
//  Created by Paul Defilippi on 3/10/19.
//  Copyright © 2019 Paul Defilippi. All rights reserved.
//

import UIKit
import Firebase

class RegistrationViewModel {
    
    var bindableIsRegistering = Bindable<Bool>()
    var bindableImage = Bindable<UIImage>()
    var bindableIsFormValid = Bindable<Bool>()
    
    var fullName: String? {
        didSet {
            checkFormValidity()
        }
    }
    var email: String? { didSet { checkFormValidity() } }
    var password: String? { didSet { checkFormValidity() } }
    
    func performRegistration(completion: @escaping (Error?) -> ()) {
        
        guard let email = email, let password = password else { return }
        
        bindableIsRegistering.value = true
        
        Auth.auth().createUser(withEmail: email, password: password) { (result, error) in
            
            if let error = error {
                print(error)
                completion(error)
                return
            }
            
            print("Succesfully registered user:", result?.user.uid ?? "")
            
            self.saveImageToFirebase(completion: completion)
        }
        
    }
    
    fileprivate func saveImageToFirebase(completion: @escaping (Error?) -> ()) {
        
        let filename = UUID().uuidString
        
        let ref = Storage.storage().reference(withPath: "/images/\(filename)")
        
        let imageData = self.bindableImage.value?.jpegData(compressionQuality: 0.75) ?? Data()
        
        ref.putData(imageData, metadata: nil, completion: { (_, err) in
            
            if let err = err {
                completion(err)
                return // bail out of code
            }
            
            print("Finished uploading image to storage")
            ref.downloadURL(completion: { (url, err) in
                if let err = err {
                    completion(err)
                    return
                }
                
                self.bindableIsRegistering.value = false
                print("Download url is: ", url?.absoluteString ?? "")
                // store the download url into Firestore
                
                let imageUrl = url?.absoluteString ?? ""
                self.saveInfoToFirestore(imageUrl: imageUrl, completion: completion)
                
                
                completion(nil)
            })
        })
        
    }
    
    fileprivate func saveInfoToFirestore(imageUrl: String, completion: @escaping (Error?) -> ()) {
        let uid = Auth.auth().currentUser?.uid ?? ""
        let docData = ["fullName": fullName ?? "", "uid": uid, "imageUrl1": imageUrl]
        Firestore.firestore().collection("users").document(uid).setData(docData) { (err) in
            if let err = err {
                completion(err)
                return
            }
            completion(nil)
        }
        
    }
    
    fileprivate func checkFormValidity() {
        let isFormValid = fullName?.isEmpty == false && email?.isEmpty == false && password?.isEmpty == false
        bindableIsFormValid.value = isFormValid
    }
    
    // Code below was used in this filed and refactored - left for reference
    
    // Reactive programming
    //var isFormValidObserver: ((Bool) -> ())?
    
    //    var image: UIImage? {
    //        didSet {
    //            imageObserver?(image)
    //        }
    //    }
    //
    //    var imageObserver: ((UIImage?) -> ())?
}
