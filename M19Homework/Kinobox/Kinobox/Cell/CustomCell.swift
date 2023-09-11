//
//  CustomCell.swift
//  Kinobox
//
//  Created by Yosha Kun on 09.09.2023.
//

import UIKit

class CustomCell: UITableViewCell {
    
    public var filmIDforCell = Int()
    
    private var nameOfFilm = UILabel()
    private var image = UIImageView()
    private var stackView = UIStackView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(stackView)
        configureViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureViews() {
        nameOfFilm.font = .systemFont(ofSize: 16, weight: .semibold)
        nameOfFilm.textColor = .black
        
        image.widthAnchor.constraint(equalToConstant: 70).isActive = true
        image.heightAnchor.constraint(equalToConstant: 100).isActive = true
        image.backgroundColor = .red
        
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.spacing = 30
    }
    
    private func setupConstraints() {
        nameOfFilm.translatesAutoresizingMaskIntoConstraints = false
        image.translatesAutoresizingMaskIntoConstraints = false
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        stackView.addArrangedSubview(image)
        stackView.addArrangedSubview(nameOfFilm)
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16),
            stackView.leftAnchor.constraint(equalTo: leftAnchor, constant: 16),
            stackView.rightAnchor.constraint(equalTo: rightAnchor, constant: -16),
        ])
    }
    // MARK: - Get Image from URL (viewModel.posterUrl)
    
    func getData(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
    }
    func downloadImage(from url: URL) {
        print("Download Started")
        getData(from: url) { data, response, error in
            guard let data = data, error == nil else { return }
            print(response?.suggestedFilename ?? url.lastPathComponent)
            print("Download Finished")
            // always update the UI from the main thread
            DispatchQueue.main.async() { [weak self] in
                self?.image.image = UIImage(data: data)
            }
        }
    }
    
    func configureCell(_ viewModel: FindFilmsModel) {
        filmIDforCell = viewModel.filmID ?? 000
        print("Сработал метод configure из модуля CustomCell")
        let url = URL(string: viewModel.posterUrl ?? "https://kinopoiskapiunofficial.tech/images/posters/kp/2213.jpg")
        downloadImage(from: url!)
        nameOfFilm.text = viewModel.nameRu
    }
}

