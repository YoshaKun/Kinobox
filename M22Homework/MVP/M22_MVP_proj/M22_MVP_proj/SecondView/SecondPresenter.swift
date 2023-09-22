//
//  Jmlsmnvlsknfvb.swift
//  M22_MVP_proj
//
//  Created by Yosha Kun on 22.09.2023.
//

import Foundation
import UIKit

protocol SecondPresenterProtocol: AnyObject {
    func setView(_ view: SecondViewControllerProtocol)
//    func getImage(from url: String?) -> UIImage
}

final class SecondPresenter: SecondPresenterProtocol {
    
    private weak var view: SecondViewControllerProtocol?
    private var model: SecondModel = SecondModel()
    
    func setView(_ view: SecondViewControllerProtocol) {
        self.view = view
    }
    
//    func getImage(from url: String?) -> UIImage {
//        let urlFromString = URL(string: url ?? "https://kinopoiskapiunofficial.tech/images/posters/kp/2213.jpg" )
//
//        print("Сработал метод getImage \(urlFromString ?? URL(string: "https://kinopoiskapiunofficial.tech/images/posters/kp/2213.jpg"))")
//
//        model.downloadImage(from: urlFromString!)
//        print(model.imageView.description)
//
//        var image = UIImage()
//        DispatchQueue.main.async {
//            image = self.model.imageView
//        }
//        return image
//    }
  
}


