//
//  FirstModel.swift
//  M22_MVP_proj
//
//  Created by Yosha Kun on 20.09.2023.
//

import Foundation
import UIKit

class FirstModel {
    
    var filmModels: [FindFilmsModel] {
        return privateFilmModels
    }
    
    private var privateFilmModels: [FindFilmsModel] = []
    
    init() {
        setupDefaultFilms()
    }
    
    private func setupDefaultFilms() {
        let firstFilm = FindFilmsModel(filmID: 123,
                                       nameRu: "Russian name",
                                       posterUrl: "some url",
                                       description: "Description of film")
        let secondFilm = FindFilmsModel(filmID: 321,
                                        nameRu: "Russian name 2",
                                        posterUrl: "some url 2",
                                        description: "Description 2")
        
        
        privateFilmModels = ([firstFilm, secondFilm])
    }
    
    func getFilmInformation(text: String?, table: UITableView) {
        let query = text ?? "форсаж"
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
        privateFilmModels.removeAll()
        print(privateFilmModels.count)
        table.reloadData()
        
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
                                description: nil
                            )
                            self.getFilmFromId(id: fetchedFilm.filmID, table: table)
                        })
                    }
                }
            }
        }
        task.resume()
    }
    
    func getFilmFromId(id filmID: Int?, table: UITableView) {
        
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
            DispatchQueue.global(qos: .background).async {
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
                            description: jsonDict["description"] as? String
                        )
                        
                        DispatchQueue.main.async {
                            self.privateFilmModels.append(newDict)
                            print("Добавлен \(newDict) в массив filmModels")
                            print("Количество фильмов в модели: \(self.privateFilmModels.count)")
                        }
                    }
                }
            }
        }
        task.resume()
    }
}

struct FindFilmsModel {
    let filmID: Int?
    let nameRu: String?
    let posterUrl: String?
    let description: String?
}
