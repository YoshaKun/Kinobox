//
//  ViewController.swift
//  M22_MVP_proj
//
//  Created by Yosha Kun on 20.09.2023.
//

import UIKit
import SnapKit

class FirstViewController: UIViewController, UISearchBarDelegate {

    private let customCell = "customCell"
    private let searchBar = UISearchBar()
    private let findButton = UIButton()
    
    private var viewModel: FirstViewModelProtocol = FirstViewModel()
    
    private var mainTableView = UITableView(frame: CGRect.zero, style: UITableView.Style.grouped)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        viewModel.updateView = { [weak self] in
            self?.mainTableView.reloadData()
        }
        
        searchBar.delegate = self
        configureViews()
        configureConstraints()
    }

    private func configureViews() {
        searchBar.placeholder = "Тут пользовательский текст"
        searchBar.layer.cornerRadius = 10
        
        findButton.layer.cornerRadius = 10
        findButton.setTitle("Поиск", for: .normal)
        findButton.backgroundColor = .systemBlue
        findButton.addTarget(self, action: #selector(didTappedOnFindButton), for: .touchUpInside)
        
        mainTableView.register(CustomCell.self, forCellReuseIdentifier: customCell)
        mainTableView.dataSource = self
        mainTableView.delegate = self
        mainTableView.backgroundColor = .white
    }
    private func configureConstraints() {
        view.addSubview(searchBar)
        view.addSubview(findButton)
        view.addSubview(mainTableView)
        
        searchBar.snp.makeConstraints { make in
            make.left.equalTo(30)
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(16)
            make.right.equalTo(30)
            make.height.equalTo(40)
        }
        
        findButton.snp.makeConstraints { make in
            make.top.equalTo(searchBar.snp.bottom).offset(30)
            make.centerX.equalTo(view.snp.centerX)
            make.height.equalTo(40)
            make.width.equalTo(110)
        }
        
        mainTableView.snp.makeConstraints { make in
            make.left.equalTo(view.snp.left).offset(30)
            make.top.equalTo(findButton.snp.bottom).offset(30)
            make.right.equalTo(view.snp.right).offset(-30)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(-16)
        }
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        viewModel.getFilms(text: searchText)
    }
    
    @objc private func didTappedOnFindButton() {
        
        let textFromSearchBar = searchBar.text ?? "Форсаж"
        mainTableView.reloadData()
    }
}

extension FirstViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.numberOfSections
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRowsInSection(section)
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: customCell) as? CustomCell
        let viewModel = viewModel.getModelArray(index: indexPath.row)
        cell?.configureCell(viewModel)
        cell?.backgroundColor = .white
        return cell ?? UITableViewCell()
    }
}

extension FirstViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let viewModel = viewModel.getModelArray(index: indexPath.row)
        let vc = SecondViewController(titleOfFilmRu: viewModel.nameRu, imageFilm: viewModel.posterUrl, descripFilmLabel: viewModel.description)
        
        navigationController?.present(vc, animated: true, completion: nil)
    }
}

