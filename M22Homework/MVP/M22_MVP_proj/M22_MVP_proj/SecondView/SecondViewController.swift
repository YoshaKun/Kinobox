//
//  File.swift
//  Kinobox
//
//  Created by Yosha Kun on 09.09.2023.
//

import Foundation
import UIKit
import SnapKit

protocol SecondViewControllerProtocol: AnyObject {
//    func setupImage(data: Data)
}

class SecondViewController: UIViewController {
    // MARK: - Presenter
    
    private let presenter: SecondPresenterProtocol = SecondPresenter()
    
    // MARK: - Переменные для инициализатора
    
    var titleOfFilmRu = UILabel()
    var imageFilm = UIImageView()
    var textView = UITextView()
    
    var imageUrl = String()
    
    // MARK: - Initialisator
    
    init(titleOfFilmRu: String?,
         imageFilm: String?,
         descripFilmLabel: String?) {

        self.titleOfFilmRu.text = titleOfFilmRu ?? "0"
        self.imageUrl = imageFilm ?? "0"
        self.textView.text = descripFilmLabel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        configureViews()
        configureConstraints()
//        imageFilm.image = presenter.getImage(from: imageUrl)
        // MARK: - Download film's Image
        downloadingImageForSecondVC()
        
    }
    
    private func configureViews() {
        
        imageFilm.backgroundColor = .red
        
        titleOfFilmRu.font = .systemFont(ofSize: 24, weight: .bold)
        titleOfFilmRu.numberOfLines = 0
        titleOfFilmRu.textAlignment = .center
        titleOfFilmRu.textColor = .black

        textView.font = .systemFont(ofSize: 18, weight: .semibold)
        textView.textColor = .black
        textView.backgroundColor = .white
    }
    
    private func configureConstraints() {
        view.addSubview(imageFilm)
        view.addSubview(titleOfFilmRu)
        view.addSubview(textView)
        
        imageFilm.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(30)
            make.centerX.equalTo(view.snp.centerX)
            make.height.equalTo(400)
            make.width.equalTo(250)
        }
        
        titleOfFilmRu.snp.makeConstraints { make in
            make.left.equalTo(view.snp.left).offset(30)
            make.top.equalTo(imageFilm.snp.bottom).offset(30)
            make.right.equalTo(view.snp.right).offset(-30)
        }
        
        textView.snp.makeConstraints { make in
            make.left.equalTo(view.snp.left).offset(30)
            make.top.equalTo(titleOfFilmRu.snp.bottom).offset(30)
            make.right.equalTo(view.snp.right).offset(-30)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
        }
    }
    
    // MARK: - Download Image by URL
    
    private func getData(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
    }
    private func downloadImage(from url: URL) {
        print("Download Started")
        getData(from: url) { data, response, error in
            guard let data = data, error == nil else { return }
            print(response?.suggestedFilename ?? url.lastPathComponent)
            print("Download Finished")
            // always update the UI from the main thread
            DispatchQueue.main.async() { [weak self] in
                self?.imageFilm.image = UIImage(data: data)
            }
        }
    }
    private func downloadingImageForSecondVC() {
        let url = URL(string: imageUrl ?? "https://kinopoiskapiunofficial.tech/images/posters/kp/2213.jpg")
        downloadImage(from: url!)
    }
}

extension SecondViewController: SecondViewControllerProtocol {
    
//    func setupImage(data: Data) {
//        DispatchQueue.main.async {
//            self.imageFilm.image = UIImage(data: data)
//            print("Установка картинки для SecondVC")
//        }
//    }
}
