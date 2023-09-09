//
//  ViewController.swift
//  Kinobox
//
//  Created by Yosha Kun on 09.09.2023.
//

import Foundation
import UIKit

class FirstViewController: UIViewController {
    
    private let textField = UITextField()
    private let findButton = UIButton()
    private let popFilmsButton = UIButton()
    private lazy var tableView = UITableView(frame: CGRect.zero, style: UITableView.Style.grouped)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        configureViews()
        configureTableView()
        configureConstraints()
    }
    
    private func configureViews() {
        textField.backgroundColor = .lightGray
        textField.placeholder = "Тут пользовательский текст"
        textField.borderStyle = .roundedRect
        
        findButton.layer.cornerRadius = 10
        findButton.setTitle("Поиск", for: .normal)
        findButton.backgroundColor = .systemBlue
        findButton.addTarget(self, action: #selector(didTappedOnCell), for: .touchUpInside)
        
        popFilmsButton.layer.cornerRadius = 10
        popFilmsButton.setTitle("Популярные фильмы", for: .normal)
        popFilmsButton.backgroundColor = .systemBlue
        popFilmsButton.addTarget(self, action: #selector(didTappedOnCell), for: .touchUpInside)
    }
    
    private func configureTableView() {
        
    }
    
    private func configureConstraints() {
        textField.translatesAutoresizingMaskIntoConstraints = false
        findButton.translatesAutoresizingMaskIntoConstraints = false
        popFilmsButton.translatesAutoresizingMaskIntoConstraints = false
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(textField)
        view.addSubview(findButton)
        view.addSubview(popFilmsButton)
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            textField.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 30),
            textField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            textField.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -30),
            textField.heightAnchor.constraint(equalToConstant: 40),
    
            findButton.topAnchor.constraint(equalTo: textField.bottomAnchor, constant: 30),
            findButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            findButton.heightAnchor.constraint(equalToConstant: 40),
            findButton.widthAnchor.constraint(equalToConstant: 110),
            
            popFilmsButton.topAnchor.constraint(equalTo: findButton.bottomAnchor, constant: 30),
            popFilmsButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            popFilmsButton.heightAnchor.constraint(equalToConstant: 40),
            popFilmsButton.widthAnchor.constraint(equalToConstant: 210),
            
            tableView.topAnchor.constraint(equalTo: popFilmsButton.bottomAnchor, constant: 30),
            tableView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 30),
            tableView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -30),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -16)
        ])
    }
    
    @objc private func didTappedOnCell() {
        let vc = SecondViewController()
        navigationController?.present(vc, animated: true, completion: nil)
    }


}

