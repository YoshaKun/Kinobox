//
//  File.swift
//  Kinobox
//
//  Created by Yosha Kun on 09.09.2023.
//

import Foundation
import UIKit

class SecondViewController: UIViewController {
    
    var kinopoiskLabel = UILabel()
    var rateKinopoLabel = UILabel()
    var imdbLabel = UILabel()
    var rateImdb = UILabel()
    
    var imageFilm = UIImageView()
    
    var titleOfFilmRu = UILabel()
    var titleOfFilmEn = UILabel()
    var descripFilmLabel = UILabel()
    var yearOfFilm = UILabel()
    var durationOfFilm = UILabel()
    
    var labelStackView = UIStackView()
    var mainStackView = UIStackView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        configureViews()
        configureStackViews()
        configureConstraints()
    }
    
    private func configureViews() {
        kinopoiskLabel.font = .systemFont(ofSize: 16, weight: .semibold)
        kinopoiskLabel.text = "Kinopoisk"
        kinopoiskLabel.textColor = .black
        
        rateKinopoLabel.font = .systemFont(ofSize: 16, weight: .semibold)
        rateKinopoLabel.text = "рейтинг Kinopoisk"
        rateKinopoLabel.textColor = .black
        
        imdbLabel.font = .systemFont(ofSize: 16, weight: .semibold)
        imdbLabel.text = "IMDB"
        imdbLabel.textColor = .black
        
        rateImdb.font = .systemFont(ofSize: 16, weight: .semibold)
        rateImdb.text = "рейтинг IMDB"
        rateImdb.textColor = .black
        
        imageFilm.backgroundColor = .red
        
        titleOfFilmRu.font = .systemFont(ofSize: 24, weight: .bold)
        titleOfFilmRu.text = "Название фильма RU"
        titleOfFilmRu.numberOfLines = 0
        titleOfFilmRu.textAlignment = .center
        titleOfFilmRu.textColor = .black
        
        titleOfFilmEn.font = .systemFont(ofSize: 16, weight: .semibold)
        titleOfFilmEn.text = "Название фильма EN"
        titleOfFilmEn.numberOfLines = 0
        titleOfFilmEn.textAlignment = .center
        titleOfFilmEn.textColor = .systemGray
        
        descripFilmLabel.font = .systemFont(ofSize: 18, weight: .semibold)
        descripFilmLabel.text = "Описание фильма Описание фильма Описание фильма Описание фильма Описание фильма Описание фильма Описание фильма Описание фильма Описание фильма Описание фильма Описание фильма Описание фильма "
        descripFilmLabel.numberOfLines = 0
        descripFilmLabel.textColor = .black
        
        yearOfFilm.font = .systemFont(ofSize: 16, weight: .semibold)
        yearOfFilm.text = "Год производства\nгод_"
        yearOfFilm.numberOfLines = 0
        yearOfFilm.textColor = .black
        
        durationOfFilm.font = .systemFont(ofSize: 16, weight: .semibold)
        durationOfFilm.text = "Продолжительность\nвремя_мин."
        durationOfFilm.numberOfLines = 0
        durationOfFilm.textColor = .black
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
        labelStackView.addArrangedSubview(rateKinopoLabel)
        labelStackView.addArrangedSubview(imdbLabel)
        labelStackView.addArrangedSubview(rateImdb)
        mainStackView.addArrangedSubview(imageFilm)
        mainStackView.addArrangedSubview(labelStackView)
        view.addSubview(mainStackView)
        view.addSubview(titleOfFilmRu)
        view.addSubview(titleOfFilmEn)
        view.addSubview(descripFilmLabel)
        view.addSubview(yearOfFilm)
        view.addSubview(durationOfFilm)
        
        mainStackView.translatesAutoresizingMaskIntoConstraints = false
        imageFilm.translatesAutoresizingMaskIntoConstraints = false
        titleOfFilmRu.translatesAutoresizingMaskIntoConstraints = false
        titleOfFilmEn.translatesAutoresizingMaskIntoConstraints = false
        descripFilmLabel.translatesAutoresizingMaskIntoConstraints = false
        yearOfFilm.translatesAutoresizingMaskIntoConstraints = false
        durationOfFilm.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            mainStackView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 30),
            mainStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 30),
            mainStackView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -30),
            
            imageFilm.heightAnchor.constraint(equalToConstant: 200),
            imageFilm.widthAnchor.constraint(equalToConstant: 150),
            
            titleOfFilmRu.topAnchor.constraint(equalTo: mainStackView.bottomAnchor, constant: 30),
            titleOfFilmRu.centerXAnchor.constraint(equalTo: mainStackView.centerXAnchor),

            titleOfFilmEn.topAnchor.constraint(equalTo: titleOfFilmRu.bottomAnchor, constant: 15),
            titleOfFilmEn.centerXAnchor.constraint(equalTo: view.centerXAnchor),

            descripFilmLabel.topAnchor.constraint(equalTo: titleOfFilmEn.bottomAnchor, constant: 30),
            descripFilmLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 30),
            descripFilmLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -30),

            yearOfFilm.topAnchor.constraint(equalTo: descripFilmLabel.bottomAnchor, constant: 30),
            yearOfFilm.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 30),
            yearOfFilm.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -30),

            durationOfFilm.topAnchor.constraint(equalTo: yearOfFilm.bottomAnchor, constant: 15),
            durationOfFilm.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 30),
            durationOfFilm.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -30),
        ])
    }
    
}
