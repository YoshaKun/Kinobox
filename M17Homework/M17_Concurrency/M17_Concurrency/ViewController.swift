//
//  ViewController.swift
//  M17_Concurrency
//
//  Created by Maxim NIkolaev on 08.12.2021.
//

import UIKit
import SnapKit

class ViewController: UIViewController {
    
    let service = Service()
    
    private var arrayImages: [UIImage] = []
    
    private lazy var activityIndicator: UIActivityIndicatorView = {
        let view = UIActivityIndicatorView(frame: CGRect(x: 220, y: 220, width: 140, height: 140))
        return view
    }()
    
    private let stackView = UIStackView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureConstraints()
        configureStackView()
        configureViews()
        
        onLoad()
    }
    
    private func configureConstraints() {
        view.addSubview(stackView)
        
        stackView.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
        }
        stackView.addArrangedSubview(activityIndicator)
    }
    
    private func configureStackView() {
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.spacing = 20
    }
    
    private func configureViews() {
        activityIndicator.startAnimating()
    }

    private func onLoad() {
        let dispatchGroup = DispatchGroup()
        for _ in 0...4 {
            dispatchGroup.enter()
            DispatchQueue.global(qos: .userInitiated).async {
                self.service.getImageURL { urlString, error in
                    guard let urlString = urlString else { return }
                    
                    let image = self.service.loadImage(urlString: urlString)
                    self.arrayImages.append(image ?? UIImage())
                    dispatchGroup.leave()
                }
            }
        }
        dispatchGroup.notify(queue: DispatchQueue.main) { [weak self] in
            guard let self = self else { return }
            self.activityIndicator.stopAnimating()
            self.stackView.removeArrangedSubview(self.activityIndicator)
            for i in 0...4 {
                self.addImage(loadedImage: self.arrayImages[i])
            }
        }
    }

    private func addImage(loadedImage: UIImage) {
        let view = UIImageView(frame: CGRect(x: 0, y: 0, width: 200, height: 200))
        view.image = loadedImage
        view.contentMode = .scaleAspectFit
        self.stackView.addArrangedSubview(view)
    }
}

