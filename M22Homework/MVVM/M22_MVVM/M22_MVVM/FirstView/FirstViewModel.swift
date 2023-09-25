//
//  FirstViewModel.swift
//  M22_MVVM
//
//  Created by Yosha Kun on 25.09.2023.
//

import Foundation
import UIKit

protocol FirstViewModelProtocol {
    var numberOfSections: Int { get }
    var numberOfRowsInSection: (_ section: Int) -> Int { get }
    var updateView: (() -> Void)? { get set }
    func getFilms(text: String?)
    func getModelArray(index: Int) -> FindFilmsModel
}

final class FirstViewModel: FirstViewModelProtocol {
    
    var numberOfSections: Int = 1
    
    lazy var numberOfRowsInSection: (Int) -> Int = getNumberOfRowsInSection
    
    var updateView: (() -> Void)?
    
    private var model: FirstModel = FirstModel()
    
    private func getNumberOfRowsInSection(_ section: Int) -> Int {
        return model.filmModels.count
    }
    
    func getFilms(text: String?) {

        model.getFilmInformation(text: text)
        print("Сработал метод getFilms")
    }
    
    func getModelArray(index: Int) -> FindFilmsModel {
        
        let memberOfArray = model.filmModels[index]
        print("сработал метод getModelArray \(memberOfArray)")
        return memberOfArray
    }
}
