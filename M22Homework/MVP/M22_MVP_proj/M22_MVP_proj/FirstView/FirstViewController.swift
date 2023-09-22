//
//  ViewController.swift
//  M22_MVP_proj
//
//  Created by Yosha Kun on 20.09.2023.
//

import UIKit
import SnapKit

protocol FirstViewControllerProtocol: AnyObject {
    func getTableView() -> UITableView
    func reloadTableView()
}

class FirstViewController: UIViewController {

    private let presenter: FirstPresenterProtocol = FirstPresenter()
    private let secondPresenter: SecondPresenterProtocol = SecondPresenter()
    private let customCell = "customCell"
    private let searchBar = UISearchBar()
    private let findButton = UIButton()
    private let updateButton = UIButton()
    
    private var mainTableView = UITableView(frame: CGRect.zero, style: UITableView.Style.grouped)
    
    private var searchBarDelegate: UISearchBarDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
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
        
        updateButton.layer.cornerRadius = 10
        updateButton.setTitle("Обновить", for: .normal)
        updateButton.backgroundColor = .systemBlue
        updateButton.addTarget(self, action: #selector(didTappedOnUpdateButton), for: .touchUpInside)
        
        mainTableView.register(CustomCell.self, forCellReuseIdentifier: customCell)
        mainTableView.dataSource = self
        mainTableView.delegate = self
        mainTableView.backgroundColor = .white
    }
    private func configureConstraints() {
        view.addSubview(searchBar)
        view.addSubview(findButton)
        view.addSubview(updateButton)
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
        
        updateButton.snp.makeConstraints { make in
            make.top.equalTo(findButton.snp.top)
            make.left.equalTo(findButton.snp.right).offset(30)
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
    
    @objc private func didTappedOnFindButton() {
        let textFromSearchBar = searchBar.text ?? "Форсаж"
        presenter.getFilms(text: textFromSearchBar)
    }
    
    @objc private func didTappedOnUpdateButton() {
        reloadTableView()
    }
}

extension FirstViewController: FirstViewControllerProtocol {
    
    func getTableView() -> UITableView {
        return mainTableView
    }
    
    func reloadTableView() {
        mainTableView.reloadData()
    }
}

extension FirstViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return presenter.numberOfSections()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.numberOfRowInSection(section)
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: customCell) as? CustomCell
        let viewModel = presenter.getModelArray(index: indexPath.row)
        cell?.configureCell(viewModel)
        cell?.backgroundColor = .white
        return cell ?? UITableViewCell()
    }
}

extension FirstViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let viewModel = presenter.getModelArray(index: indexPath.row)
        let vc = SecondViewController(titleOfFilmRu: viewModel.nameRu, imageFilm: viewModel.posterUrl, descripFilmLabel: viewModel.description)
        
        navigationController?.present(vc, animated: true, completion: nil)
    }
}

