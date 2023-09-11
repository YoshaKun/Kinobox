//
//  File.swift
//  Kinobox
//
//  Created by Yosha Kun on 09.09.2023.
//

import Foundation
import UIKit

class SecondViewController: UIViewController {
    // MARK: - Константы
    
    let kinopoiskLabel = UILabel()
    let imdbLabel = UILabel()
    
    // MARK: - Переменные для инициализатора
    
    var titleOfFilmRu = UILabel()
    var titleOfFilmEn = UILabel()
    var imageFilm = UIImageView()
    var rateKinopoisk = UILabel()
    var rateImdb = UILabel()
    var yearLabel = UILabel()
    var lengthOfFilmLabel = UILabel()
    var textView = UITextView()
    
    var imageUrl = String()
    
    // MARK: - StackViews
    
    var labelStackView = UIStackView()
    var mainStackView = UIStackView()
    
    // MARK: - Initialisator
    
    init(titleOfFilmRu: String?,
         titleOfFilmEn: String?,
         imageFilm: String?,
         rateKinopoisk: Double?,
         rateImdb: Double?,
         yearLabel: Int?,
         lengthOfFilmLabel: Int?,
         descripFilmLabel: String?) {

        self.titleOfFilmRu.text = titleOfFilmRu ?? "0"
        self.titleOfFilmEn.text = titleOfFilmEn ?? "0"
        self.imageUrl = imageFilm ?? "0"
        self.rateKinopoisk.text = String(rateKinopoisk ?? 0)
        self.rateImdb.text = String(rateImdb ?? 0)
        self.yearLabel.text = "Год производства:\n\(yearLabel ?? 0)"
        self.lengthOfFilmLabel.text = "Продолжительность:\n\(lengthOfFilmLabel ?? 0)"
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
        configureStackViews()
        configureConstraints()
        downloadingImageForSecondVC()
    }
    
    private func configureViews() {
        kinopoiskLabel.font = .systemFont(ofSize: 16, weight: .semibold)
        kinopoiskLabel.text = "Kinopoisk"
        kinopoiskLabel.textColor = .black
        
        rateKinopoisk.font = .systemFont(ofSize: 16, weight: .semibold)
        rateKinopoisk.textColor = .black
        
        imdbLabel.font = .systemFont(ofSize: 16, weight: .semibold)
        imdbLabel.text = "IMDB"
        imdbLabel.textColor = .black
        
        rateImdb.font = .systemFont(ofSize: 16, weight: .semibold)
        rateImdb.textColor = .black
        
        imageFilm.backgroundColor = .red
        
        titleOfFilmRu.font = .systemFont(ofSize: 24, weight: .bold)
        titleOfFilmRu.numberOfLines = 0
        titleOfFilmRu.textAlignment = .center
        titleOfFilmRu.textColor = .black
        
        titleOfFilmEn.font = .systemFont(ofSize: 16, weight: .semibold)
        titleOfFilmEn.numberOfLines = 0
        titleOfFilmEn.textAlignment = .center
        titleOfFilmEn.textColor = .systemGray
        
        textView.font = .systemFont(ofSize: 18, weight: .semibold)
        textView.textColor = .black
        textView.backgroundColor = .white
        
        yearLabel.font = .systemFont(ofSize: 16, weight: .semibold)
        yearLabel.numberOfLines = 0
        yearLabel.textColor = .black
        
        lengthOfFilmLabel.font = .systemFont(ofSize: 16, weight: .semibold)
        lengthOfFilmLabel.numberOfLines = 0
        lengthOfFilmLabel.textColor = .black
    }
    
    private func configureStackViews() {
        labelStackView.axis = .vertical
        labelStackView.distribution = .fillEqually
        labelStackView.alignment = .center
        labelStackView.spacing = 16
        
        mainStackView.axis = .horizontal
        mainStackView.spacing = 40
    }
    
    private func configureConstraints() {
        labelStackView.addArrangedSubview(kinopoiskLabel)
        labelStackView.addArrangedSubview(rateKinopoisk)
        labelStackView.addArrangedSubview(imdbLabel)
        labelStackView.addArrangedSubview(rateImdb)
        mainStackView.addArrangedSubview(imageFilm)
        mainStackView.addArrangedSubview(labelStackView)
        view.addSubview(mainStackView)
        view.addSubview(titleOfFilmRu)
        view.addSubview(titleOfFilmEn)
        view.addSubview(textView)
        view.addSubview(yearLabel)
        view.addSubview(lengthOfFilmLabel)
        
        mainStackView.translatesAutoresizingMaskIntoConstraints = false
        imageFilm.translatesAutoresizingMaskIntoConstraints = false
        titleOfFilmRu.translatesAutoresizingMaskIntoConstraints = false
        titleOfFilmEn.translatesAutoresizingMaskIntoConstraints = false
        textView.translatesAutoresizingMaskIntoConstraints = false
        yearLabel.translatesAutoresizingMaskIntoConstraints = false
        lengthOfFilmLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            mainStackView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 30),
            mainStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 30),
            mainStackView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -30),
            
            imageFilm.heightAnchor.constraint(equalToConstant: 200),
            imageFilm.widthAnchor.constraint(equalToConstant: 150),
            
            titleOfFilmRu.topAnchor.constraint(equalTo: mainStackView.bottomAnchor, constant: 30),
            titleOfFilmRu.centerXAnchor.constraint(equalTo: mainStackView.centerXAnchor),
            titleOfFilmRu.widthAnchor.constraint(equalTo: mainStackView.widthAnchor),

            titleOfFilmEn.topAnchor.constraint(equalTo: titleOfFilmRu.bottomAnchor, constant: 15),
            titleOfFilmEn.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            lengthOfFilmLabel.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -15),
            lengthOfFilmLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 30),
            lengthOfFilmLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -30),

            yearLabel.bottomAnchor.constraint(equalTo: lengthOfFilmLabel.topAnchor, constant: -30),
            yearLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 30),
            yearLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -30),

            textView.topAnchor.constraint(equalTo: titleOfFilmEn.bottomAnchor, constant: 30),
            textView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 30),
            textView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -30),
            textView.bottomAnchor.constraint(equalTo: yearLabel.topAnchor, constant: -30),
        ])
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
