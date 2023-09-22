//
//  FirstPresenter.swift
//  M22_MVP_proj
//
//  Created by Yosha Kun on 20.09.2023.
//

import Foundation
import UIKit

protocol FirstPresenterProtocol: AnyObject {
    func setView(_ view: FirstViewControllerProtocol)
    func numberOfSections() -> Int
    func numberOfRowInSection(_ section: Int) -> Int
    func getFilms(text: String?)
    func getModelArray(index: Int) -> FindFilmsModel
}

final class FirstPresenter: FirstPresenterProtocol {
    
    private weak var view: FirstViewControllerProtocol?
    private var model: FirstModel = FirstModel()
    
    func setView(_ view: FirstViewControllerProtocol) {
        self.view = view
    }
    
    func numberOfSections() -> Int {
        return 1
    }
    
    func numberOfRowInSection(_ section: Int) -> Int {
        model.filmModels.count
    }
    
    func getFilms(text: String?) {
        let tableView = view?.getTableView() ?? UITableView()
        model.getFilmInformation(text: text, table: tableView)
        print("Сработал метод getFilms")
    }

    func getModelArray(index: Int) -> FindFilmsModel {
        let memberOfArray = model.filmModels[index]
        print("сработал метод getModelArray \(memberOfArray)")
        view?.reloadTableView()
        return memberOfArray
    }
}
