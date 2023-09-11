//
//  ViewController.swift
//  Kinobox
//
//  Created by Yosha Kun on 09.09.2023.
//

import Foundation
import UIKit

class FirstViewController: UIViewController {
    
    let customCell = "customCell"
    
    var filmModels: [FindFilmsModel] = [FindFilmsModel(filmID: 2, nameRu: "ТЕСТОВАЯ ЯЧЕЙКА", posterUrl: "sgsg", nameOriginal: "dsgsdg", ratingKinopoisk: 0.1, ratingImdb: 0.2, year: 3000, filmLength: 111, description: "dfsvsdvljfslkgfrkslnglkwnvksnfgkvjnesdjkvnljrsgnvljkdfngvljsfnxgvjnfdslbsfdngvnылвораылолорвлытпжшырапжшмдочыадрподвалымisjfglvjshfgv;sn;rfidgj;sdfihjgnaserfdg;oijnszetfboijztgb'jaetibgjdt;gbijetg8935hg9iuh;szertg08i;ne54g;0ioaetg;9oijsnrtdgh;iojetgh;9ihonszdrth;0ijnagt0'i;jzsgt;ihjzedg;hezdg;0ihjzetg;ihzedg;890hsrtyh;809sjrztg'08;ijdztrh0;ijosdrthg;0ijzegth'0;9ijdfsvsdvljfslkgfrkslnglkwnvksnfgkvjnesdjkvnljrsgnvljkdfngvljsfnxgvjnfdslbnvfdngvnылвораылолорвлытпжшырапжшмдочыадрподвалымisjfglvjshfgv;sn;rfidgj;sdfihjgnaserfdg;oijnszetfboijztgb'jaetibgjdt;gbijetg8935hg9iuh;szertg08i;ne54g;0ioaetg;9oijsnrtdgh;iojetgh;9ihonszdrth;0ijnagt0'i;jzsgt;ihjzedg;hezdg;0ihjzetg;ihzedg;890hsrtyh;809sjrztg'08;ijdztrh0;ijosdrthg;0ijzegth'0;9ijtghedg;hezdg;0ihjzetg;ihzedg;890hsrtyh;809sjrztg'08;ijdztrh0;ijosdrthg;0ijzegth'0;9ijdfsvsdvljfslkgfrkslnglkwnvksnfgkvjnesdjkvnljrsgnvljkdfngvljsfnxgvjnfdslbnvfdngvnылвораылолорвлытпжшырапжшмдочыадрподвалымisjfglvjshfgv;sn;rfidgj;sdfihjgnaserfdg;oijnszetfboijztgb'jaetibgjdt;gbijetg8935hg9iuh;szertg08i;ne54g;0ioaetg;9oijsnrtdgh;iojetgh;9ihonszdrth;0ijnagt0'i;jzsgt;ihjzedg;hezdg;0ihjzetg;ihzedg;890hsrtyh;809sjrztg'08;ijdztrh0;ijosdrthg;0ijzegth'0;9ijtghedg;hezdg;0ihjzetg;ihzedg;890hsrtyh;809sjrztg'08;ijdztrh0;ijosdrthg;0ijzegth'0;9ijdfsvsdvljfslkgfrkslnglkwnvksnfgkvjnesdjkvnljrsgnvljkdfngvljsfnxgvjnfdslbnvfdngvnылвораылолорвлытпжшырапжшмдочыадрподвалымisjfglvjshfgv;sn;rfidgj;sdfihjgnaserfdg;oijnszetfboijztgb'jaetibgjdt;gbijetg8935hg9iuh;szertg08i;ne54g;0ioaetg;9oijsnrtdgh;iojetgh;9ihonszdrth;0ijnagt0'i;jzsgt;ihjzedg;hezdg;0ihjzetg;ihzedg;890hsrtyh;809sjrztg'08;ijdztrh0;ijosdrthg;0ijzegth'0;9ijtgh")]
    
    private let textField = UITextField()
    private let findButton = UIButton()
    private let popFilmsButton = UIButton()
    private var mainTableView = UITableView(frame: CGRect.zero, style: UITableView.Style.grouped)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        configureViews()
        configureConstraints()
    }
    
    private func configureViews() {
        textField.backgroundColor = .black
        textField.placeholder = "Тут пользовательский текст"
        textField.textColor = .white
        textField.borderStyle = .roundedRect
        
        findButton.layer.cornerRadius = 10
        findButton.setTitle("Поиск", for: .normal)
        findButton.backgroundColor = .systemBlue
        findButton.addTarget(self, action: #selector(didTappedOnFindButton), for: .touchUpInside)
        
        popFilmsButton.layer.cornerRadius = 10
        popFilmsButton.setTitle("Популярные фильмы", for: .normal)
        popFilmsButton.backgroundColor = .systemBlue
        popFilmsButton.addTarget(self, action: #selector(didTappedOnPopFilmsButton), for: .touchUpInside)
        
        mainTableView.register(CustomCell.self, forCellReuseIdentifier: customCell)
        mainTableView.dataSource = self
        mainTableView.delegate = self
        mainTableView.backgroundColor = .white
    }
    
    private func configureConstraints() {
        textField.translatesAutoresizingMaskIntoConstraints = false
        findButton.translatesAutoresizingMaskIntoConstraints = false
        popFilmsButton.translatesAutoresizingMaskIntoConstraints = false
        mainTableView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(textField)
        view.addSubview(findButton)
        view.addSubview(popFilmsButton)
        view.addSubview(mainTableView)
        
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
            
            mainTableView.topAnchor.constraint(equalTo: popFilmsButton.bottomAnchor, constant: 30),
            mainTableView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 30),
            mainTableView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -30),
            mainTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -16)
        ])
    }
    
    @objc private func didTappedOnFindButton() {
        getFilmInformation()
    }
    
    @objc private func didTappedOnPopFilmsButton() {
        getTopHundredFilms()
    }
}

extension FirstViewController {
    
    private func getFilmInformation() {
        let query = textField.text ?? "форсаж"
        let scheme = "https"
        let host = "kinopoiskapiunofficial.tech"
        let path = "/api/v2.1/films/search-by-keyword"
        let keyWord = "keyword"
        
        var urlComponents = URLComponents()
        urlComponents.scheme = scheme
        urlComponents.host = host
        urlComponents.path = path
        let queryItems: [URLQueryItem] = [URLQueryItem(name: keyWord, value: query)]
        urlComponents.queryItems = queryItems

        guard let url = urlComponents.url else {
            print("Ошибка URL")
            return
        }
        self.filmModels.removeAll()
        self.mainTableView.reloadData()
        
        print("URL: \(url)")
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = ["X-API-KEY": "86b4c0f0-dc3d-4e28-be90-2547c22ce832"]
        request.httpBody = nil
        
        let dispatchGroup = DispatchGroup()
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            DispatchQueue.global(qos: .background).async {
                if let error = error {
                    DispatchQueue.main.async {
                        print(error)
                    }
                } else {
                    if let data = data, let json = try? JSONSerialization.jsonObject(with: data, options: []) {
                        let jsonDict = json as? [String: Any]
                        let filmsID = jsonDict?["films"] as? [[String: Any]]
                        
                        filmsID?.forEach({ film in
                            let fetchedFilm = FindFilmsModel(
                                filmID: film["filmId"] as? Int,
                                nameRu: film["nameRu"] as? String,
                                posterUrl: film["posterUrl"] as? String,
                                nameOriginal: nil,
                                ratingKinopoisk: nil,
                                ratingImdb: nil,
                                year: nil,
                                filmLength: nil,
                                description: nil
                            )
                            self.getFilmFromId(id: fetchedFilm.filmID)
                        })
                        
                    }
                }
            }
            
        }
        task.resume()
    }
    
    private func getTopHundredFilms() {
        
        let scheme = "https"
        let host = "kinopoiskapiunofficial.tech"
        let path = "/api/v2.2/films/top"
        let keyWord = "type"
        
        var urlComponents = URLComponents()
        urlComponents.scheme = scheme
        urlComponents.host = host
        urlComponents.path = path
        let queryItems: [URLQueryItem] = [URLQueryItem(name: keyWord, value: "TOP_100_POPULAR_FILMS")]
        urlComponents.queryItems = queryItems

        guard let url = urlComponents.url else {
            print("Ошибка URL")
            return
        }

        self.filmModels.removeAll()
        self.mainTableView.reloadData()
        
        print("URL: \(url)")
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = ["X-API-KEY": "86b4c0f0-dc3d-4e28-be90-2547c22ce832"]
        request.httpBody = nil
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            DispatchQueue.global(qos: .background).async {
                if let error = error {
                    DispatchQueue.main.async {
                        print(error)
                    }
                } else {
                    if let data = data, let json = try? JSONSerialization.jsonObject(with: data, options: []) {
                        let jsonDict = json as? [String: Any]
                        let filmsID = jsonDict?["films"] as? [[String: Any]]
                        
                        filmsID?.forEach({ film in
                            let fetchedFilm = FindFilmsModel(
                                filmID: film["filmId"] as? Int,
                                nameRu: film["nameRu"] as? String,
                                posterUrl: film["posterUrl"] as? String,
                                nameOriginal: nil,
                                ratingKinopoisk: nil,
                                ratingImdb: nil,
                                year: nil,
                                filmLength: nil,
                                description: nil
                            )
                            self.getFilmFromId(id: fetchedFilm.filmID)
                        })
                        
                    }
                }
            }
            
        }
        task.resume()
    }
    
    private func getFilmFromId(id filmID: Int?) {
        
        let scheme = "https"
        let host = "kinopoiskapiunofficial.tech"
        let path = "/api/v2.2/films/\(String(filmID ?? 666))"
        
        var urlComponents = URLComponents()
        urlComponents.scheme = scheme
        urlComponents.host = host
        urlComponents.path = path

        guard let url = urlComponents.url else {
            print("Ошибка URL")
            return
        }
        print("URL: \(url)")
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = ["X-API-KEY": "86b4c0f0-dc3d-4e28-be90-2547c22ce832"]
        request.httpBody = nil
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            DispatchQueue.global(qos: .background).async { [weak self] in
                if let error = error {
                    DispatchQueue.main.async {
                        print(error)
                    }
                } else {
                    if let data = data, let json = try? JSONSerialization.jsonObject(with: data, options: []) {
                        guard let jsonDict = json as? [String: Any] else { return }
                        
                        let newDict = FindFilmsModel(
                            filmID: jsonDict["kinopoiskId"] as? Int,
                            nameRu: jsonDict["nameRu"] as? String,
                            posterUrl: jsonDict["posterUrl"] as? String,
                            nameOriginal: jsonDict["nameOriginal"] as? String,
                            ratingKinopoisk: jsonDict["ratingKinopoisk"] as? Double,
                            ratingImdb: jsonDict["ratingImdb"] as? Double,
                            year: jsonDict["year"] as? Int,
                            filmLength: jsonDict["filmLength"] as? Int,
                            description: jsonDict["description"] as? String
                        )
                        
                        DispatchQueue.main.async {
                            self?.filmModels.append(newDict)
                            print("Добавлен \(newDict) в массив filmModels")
                        }
                    }
                    DispatchQueue.main.async {
                        self?.mainTableView.reloadData()
                        print("получено " + (self?.filmModels.count.description ?? "0") + " фильмов")
                        print("таблица обновлена")
                    }
                }
            }
        }
        task.resume()
    }
}

extension FirstViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        filmModels.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: customCell) as? CustomCell
        let viewModel = filmModels[indexPath.row]
        cell?.configureCell(viewModel)
        cell?.backgroundColor = .white
        return cell ?? UITableViewCell()
    }
}

extension FirstViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let viewModel = filmModels[indexPath.row]
        let vc = SecondViewController(titleOfFilmRu: viewModel.nameRu, titleOfFilmEn: viewModel.nameOriginal, imageFilm: viewModel.posterUrl, rateKinopoisk: viewModel.ratingKinopoisk, rateImdb: viewModel.ratingImdb, yearLabel: viewModel.year, lengthOfFilmLabel: viewModel.filmLength, descripFilmLabel: viewModel.description)
        
        navigationController?.present(vc, animated: true, completion: nil)
    }
}

