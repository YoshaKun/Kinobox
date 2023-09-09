//
//  ViewController.swift
//  M18_RestAPI
//
//  Created by Yosha Kun on 05.09.2023.
//

import UIKit
import SnapKit
import Alamofire

class ViewController: UIViewController {
    
    public let textField = UITextField()
    
    private let urlButton = UIButton()
    private let alamofireButton = UIButton()
    private let textView = UITextView()
    
    private var mainStack = UIStackView()
    private var secondStack = UIStackView()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureViews()
        configureStackViews()
        configureConstraints()
    }
    
    private func configureViews() {
        textField.backgroundColor = .white
        textField.placeholder = "тут пользовательский текст"
        textField.borderStyle = .roundedRect
        
        urlButton.layer.cornerRadius = 10
        urlButton.setTitle("URLSession", for: .normal)
        urlButton.backgroundColor = .systemBlue
        urlButton.addTarget(self, action: #selector(didTappedUrlButton), for: .touchUpInside)
        
        alamofireButton.layer.cornerRadius = 10
        alamofireButton.setTitle("Alamofire", for: .normal)
        alamofireButton.backgroundColor = .systemBlue
        alamofireButton.addTarget(self, action: #selector(didTappedAlamofireButton), for: .touchUpInside)
        
        textView.layer.cornerRadius = 10
        textView.text = "тут результат"
        textView.backgroundColor = .systemGray5
    }
    
    private func configureStackViews() {
        secondStack.axis = .horizontal
        secondStack.distribution = .equalCentering
        secondStack.spacing = 20
        
        mainStack.axis = .vertical
        mainStack.spacing = 30
    }
    
    private func configureConstraints() {
        view.addSubview(mainStack)
        
        mainStack.addArrangedSubview(textField)
        mainStack.addArrangedSubview(secondStack)
        secondStack.addArrangedSubview(urlButton)
        secondStack.addArrangedSubview(alamofireButton)
        mainStack.addArrangedSubview(textView)
        
        mainStack.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.left.equalTo(30)
            make.right.equalTo(-30)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
        }
        textField.snp.makeConstraints { make in
            make.height.equalTo(40)
        }
        secondStack.snp.makeConstraints { make in
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.height.equalTo(40)
        }
        urlButton.snp.makeConstraints { make in
            make.width.equalTo(110)
        }
        alamofireButton.snp.makeConstraints { make in
            make.width.equalTo(110)
        }
        textView.snp.makeConstraints { make in
            make.width.equalToSuperview()
        }
    }
    
    @objc private func didTappedUrlButton() {
        view.backgroundColor = .red
        getURLRequest()
    }
    
    @objc private func didTappedAlamofireButton() {
        view.backgroundColor = .yellow
        getAlamofireRequest()
    }
    
    private func getURLRequest() {
        let query = textField.text ?? "форсаж"
        
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "kinopoiskapiunofficial.tech"
        urlComponents.path = "/api/v2.1/films/search-by-keyword"
        let queryItems: [URLQueryItem] = [URLQueryItem(name: "keyword", value: query)]
        urlComponents.queryItems = queryItems

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
                    print(response ?? "default")
                    if let data = data, let json = try? JSONSerialization.jsonObject(with: data, options: []) {
                        let convertedString = String(data: data, encoding: .utf8)
                        print(convertedString ?? "Default value of JSON")
                        DispatchQueue.main.async {
                        self.textView.text = convertedString
                        }
                    }
                }
            }
        }
        task.resume()
    }
    
    private func getAlamofireRequest() {
        let query = textField.text ?? "форсаж"
        
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "kinopoiskapiunofficial.tech"
        urlComponents.path = "/api/v2.1/films/search-by-keyword"
        let queryItems: [URLQueryItem] = [URLQueryItem(name: "keyword", value: query)]
        urlComponents.queryItems = queryItems

        guard let url = urlComponents.url else {
            print("Ошибка URL")
            return
        }

        print("URL: \(url)")
        
        let headers: HTTPHeaders = ["X-API-KEY": "86b4c0f0-dc3d-4e28-be90-2547c22ce832"]

        AF.request(url, headers: headers).responseString { response in
            DispatchQueue.global(qos: .background).async {
                if let error = response.error {
                    DispatchQueue.main.async {
                        print(error)
                    }
                } else {
                    print(response)
                    if let data = response.data, let json = try? JSONSerialization.jsonObject(with: data, options: []) {
                        let convertedString = String(data: data, encoding: .utf8)
                        print(convertedString ?? "Default value of JSON")
                        DispatchQueue.main.async {
                        self.textView.text = convertedString
                        }
                    }
                }
            }
        }
    }
}

