//
//  ViewController.swift
//  Kinobox
//
//  Created by Yosha Kun on 09.09.2023.
//

import UIKit
import CoreData
import SnapKit

// MARK: - Keys for UserDefaults
enum Keys {
    static let indexOfSegmentedControl = "indexOfSegmentedControl"
}

class FirstViewController: UIViewController {
    
    private let persistentConteiner = NSPersistentContainer(name: "Model")
    
    // MARK: - varible for UserDefaults
    private var savedStateOfSort: Int = 0
    
    // MARK: - Константа fetchRequest
    private let fetchRequest = Artist.fetchRequest()
    
    // MARK: - TableView
    private var mainTableView = UITableView(frame: CGRect.zero, style: UITableView.Style.grouped)
    
    // MARK: - переключатель соритровки SegmentedControl
    private var namesOfSegments: [String] = ["A-Z", "Z-A"]
    private lazy var segmentedControl: UISegmentedControl = {
        let seg = UISegmentedControl(items: namesOfSegments)
                return seg
    }()
    
    // MARK: - fetchedResultsController
    private var fetchedResultsController = NSFetchedResultsController<Artist>()
    
    var artist: Artist?
    
    override func viewDidAppear(_ animated: Bool) {
        mainTableView.reloadData()
    }
    
    private func loadPersistentConteiner() {
        self.persistentConteiner.loadPersistentStores { (persistentStoreDescription, error) in
            if let error = error {
                print("Unable to Load Persistent Store")
                print("\(error), \(error.localizedDescription)")
                
            } else {
                do {
                    try self.fetchedResultsController.performFetch()
                } catch {
                    print(error)
                }
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        fetchUpSortResults()
        loadPersistentConteiner()
        
        savedStateOfSort = UserDefaults.standard.integer(forKey: Keys.indexOfSegmentedControl)
        print("savedStateOfSort = \(String(describing: savedStateOfSort))")
        
        configureViews()
        configureConstraints()
        sortingTableView(by: savedStateOfSort)
    }
    
    // MARK: - Функции для разной сортировки по фамилии исполнителя (от А до Я и наоборот)
    private func fetchUpSortResults() {
        let upSortDescriptor = NSSortDescriptor(key: "secondName", ascending: true)
        fetchRequest.sortDescriptors = [upSortDescriptor]
        fetchedResultsController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: self.persistentConteiner.viewContext, sectionNameKeyPath: nil, cacheName: nil)
        fetchedResultsController.delegate = self
    }
    private func fetchDownSortResults() {
        let downSortDescriptor = NSSortDescriptor(key: "secondName", ascending: false)
        fetchRequest.sortDescriptors = [downSortDescriptor]
        fetchedResultsController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: self.persistentConteiner.viewContext, sectionNameKeyPath: nil, cacheName: nil)
        fetchedResultsController.delegate = self
    }
    
    // MARK: - Метод сортировки полученных данных из CoreData с помощью SortDescriptors
    private func sortingTableView(by index: Int) {
        switch index {
        case 0:
            fetchUpSortResults()
            do {
                try self.fetchedResultsController.performFetch()
                print("выбран сегмент с индексом \(String(describing: savedStateOfSort))")
            } catch {
                print(error)
            }
            savedStateOfSort = 0
            print("сохранен индекс \(String(describing: savedStateOfSort))")
            UserDefaults.standard.set(savedStateOfSort, forKey: Keys.indexOfSegmentedControl)
        case 1:
            fetchDownSortResults()
            do {
                try self.fetchedResultsController.performFetch()
                print("выбран сегмент с индексом \(String(describing: savedStateOfSort))")
            } catch {
                print(error)
            }
            savedStateOfSort = 1
            print("сохранен индекс \(String(describing: savedStateOfSort))")
            UserDefaults.standard.set(savedStateOfSort, forKey: Keys.indexOfSegmentedControl)
        default:
            print("error switch segmentedControl")
        }
        self.mainTableView.reloadData()
    }
    
    // MARK: - Configure views and consstraints
    private func configureViews() {
        navigationItem.title = "Artists"
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Create", style: .plain, target: self, action: #selector(didTappedOnCreate))
        
        mainTableView.dataSource = self
        mainTableView.delegate = self
        mainTableView.backgroundColor = .white
        
        segmentedControl.addTarget(self, action: #selector(didTappedOnSegment), for: .valueChanged)
    }
    
    private func configureConstraints() {
        mainTableView.translatesAutoresizingMaskIntoConstraints = false
        segmentedControl.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(mainTableView)
        view.addSubview(segmentedControl)
        
        mainTableView.snp.makeConstraints { make in
            make.left.equalTo(16)
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.right.equalTo(-16)
            make.bottom.equalTo(segmentedControl.snp.top)
        }
        segmentedControl.snp.makeConstraints { make in
            make.left.equalTo(16)
            make.right.equalTo(-16)
            make.bottom.equalTo(-30)
        }
    }
        
    // MARK: - @objc functions for Button's actions
    @objc func didTappedOnCreate() {
        artist = Artist.init(entity: NSEntityDescription.entity(forEntityName: "Artist", in: persistentConteiner.viewContext)!, insertInto: persistentConteiner.viewContext)
        mainTableView.reloadData()
        print(persistentConteiner.viewContext)
    }
    
    @objc func didTappedOnSegment() {
        sortingTableView(by: segmentedControl.selectedSegmentIndex)
    }
}

extension FirstViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return fetchedResultsController.sections?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let sections = fetchedResultsController.sections {
            return sections[section].numberOfObjects
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let artist = fetchedResultsController.object(at: indexPath)
        let cell = UITableViewCell()
        cell.textLabel?.text = artist.secondName
        return cell
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let artist = fetchedResultsController.object(at: indexPath)
            persistentConteiner.viewContext.delete(artist)
            try? persistentConteiner.viewContext.save()
        }
    }
}

extension FirstViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = SecondViewController()
        vc.artist = fetchedResultsController.object(at: indexPath)
        navigationController?.pushViewController(vc, animated: true)
    }
}

extension FirstViewController: NSFetchedResultsControllerDelegate {
    
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        mainTableView.beginUpdates()
    }
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        mainTableView.endUpdates()
    }
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        switch type {
        case .insert:
            if let indexPath = newIndexPath {
                mainTableView.insertRows(at: [indexPath], with: .automatic)
                mainTableView.reloadData()
            }
        case .update:
            if let indexPath = indexPath {
                let artist = fetchedResultsController.object(at: indexPath)
                let cell = mainTableView.cellForRow(at: indexPath)
                cell!.textLabel?.text = artist.secondName
                mainTableView.reloadData()
            }
        case .move:
            if let indexPath = indexPath {
                mainTableView.deleteRows(at: [indexPath], with: .automatic)
            }
            if let newIndexPath = newIndexPath {
                mainTableView.insertRows(at: [newIndexPath], with: .automatic)
            }
        case .delete:
            if let indexPath = indexPath {
                mainTableView.deleteRows(at: [indexPath], with: .automatic)
            }
        @unknown default:
            fatalError()
        }
    }
}

