//
//  ViewController.swift
//  Kinobox
//
//  Created by Yosha Kun on 09.09.2023.
//

import Foundation
import UIKit

class FirstViewController: UIViewController {

    let someButton = UIButton()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .red
        
        configureButton()
        configureConstraints()
    }
    
    private func configureButton() {
        someButton.layer.cornerRadius = 10
        someButton.setTitle("URLSession", for: .normal)
        someButton.backgroundColor = .systemBlue
        someButton.addTarget(self, action: #selector(didTappedSomeButton), for: .touchUpInside)
    }
    
    private func configureConstraints() {
        view.addSubview(someButton)
        someButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            someButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            someButton.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            someButton.widthAnchor.constraint(equalToConstant: 110),
            someButton.heightAnchor.constraint(equalToConstant: 40),
        ])
    }
    
    @objc private func didTappedSomeButton() {
        let vc = SecondViewController()
        navigationController?.present(vc, animated: true, completion: nil)
    }


}

