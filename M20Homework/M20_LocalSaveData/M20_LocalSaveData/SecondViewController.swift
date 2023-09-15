//
//  File.swift
//  Kinobox
//
//  Created by Yosha Kun on 09.09.2023.
//

import Foundation
import UIKit
import CoreData
import SnapKit

class SecondViewController: UIViewController {

    private let firstNameTF = UITextField()
    private let secondNameTF = UITextField()
    private let dateOfBornTF = UITextField()
    private let countryTF = UITextField()
    
    var artist: Artist?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        self.navigationItem.title = "Settings"
        
        if let artist = artist {
            firstNameTF.text = artist.firstName
            secondNameTF.text = artist.secondName
            dateOfBornTF.text = artist.dateOfBorn
            countryTF.text = artist.country
        }
        
        configureViews()
        configureConstraints()
    }
    
    private func configureViews() {
        navigationItem.title = "Create an Artist"
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save", style: .plain, target: self, action: #selector(saveData))
        
        firstNameTF.backgroundColor = .white
        firstNameTF.placeholder = "Имя артиста"
        firstNameTF.textColor = .black
        firstNameTF.borderStyle = .roundedRect
        
        secondNameTF.backgroundColor = .white
        secondNameTF.placeholder = "Фамилия артиста"
        secondNameTF.textColor = .black
        secondNameTF.borderStyle = .roundedRect
        
        dateOfBornTF.backgroundColor = .white
        dateOfBornTF.placeholder = "дата рождения артиста"
        dateOfBornTF.textColor = .black
        dateOfBornTF.borderStyle = .roundedRect
        
        countryTF.backgroundColor = .white
        countryTF.placeholder = "Страна артиста"
        countryTF.textColor = .black
        countryTF.borderStyle = .roundedRect
    }
    
    private func configureConstraints() {
        view.addSubview(firstNameTF)
        view.addSubview(secondNameTF)
        view.addSubview(dateOfBornTF)
        view.addSubview(countryTF)
    
        firstNameTF.translatesAutoresizingMaskIntoConstraints = false
        secondNameTF.translatesAutoresizingMaskIntoConstraints = false
        dateOfBornTF.translatesAutoresizingMaskIntoConstraints = false
        countryTF.translatesAutoresizingMaskIntoConstraints = false
        
        firstNameTF.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.left.equalTo(16)
            make.right.equalTo(-16)
            make.height.equalTo(60)
        }
        secondNameTF.snp.makeConstraints { make in
            make.top.equalTo(firstNameTF.snp.bottom)
            make.left.equalTo(16)
            make.right.equalTo(-16)
            make.height.equalTo(60)
        }
        dateOfBornTF.snp.makeConstraints { make in
            make.top.equalTo(secondNameTF.snp.bottom)
            make.left.equalTo(16)
            make.right.equalTo(-16)
            make.height.equalTo(60)
        }
        countryTF.snp.makeConstraints { make in
            make.top.equalTo(dateOfBornTF.snp.bottom)
            make.left.equalTo(16)
            make.right.equalTo(-16)
            make.height.equalTo(60)
        }
    }
    
    @objc func saveData() {
        artist?.firstName = firstNameTF.text
        artist?.secondName = secondNameTF.text
        artist?.dateOfBorn = dateOfBornTF.text
        artist?.country = countryTF.text
        
        DispatchQueue.main.async {
            if (try? self.artist?.managedObjectContext?.save()) != nil {
                print("saveData completed")
            } else {
                try? self.artist?.managedObjectContext?.save()
                print("didn't worked func saveData")
            }
        }
        navigationController?.popViewController(animated: true)
    }
}
