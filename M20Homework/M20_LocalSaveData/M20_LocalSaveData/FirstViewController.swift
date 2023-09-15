//
//  ViewController.swift
//  Kinobox
//
//  Created by Yosha Kun on 09.09.2023.
//

import UIKit
import CoreData
import SnapKit

class FirstViewController: UIViewController {
    
    private let persistentConteiner = NSPersistentContainer(name: "Model")
    
    private var mainTableView = UITableView(frame: CGRect.zero, style: UITableView.Style.grouped)
    private var namesOfSegments: [String] = ["A-Z", "Z-A"]

    private lazy var segmentedControl: UISegmentedControl = {
        let seg = UISegmentedControl(items: namesOfSegments)
                return seg
    }()
    
    private lazy var fetchedResultsController: NSFetchedResultsController<Artist> = {
        let fetchRequest = Artist.fetchRequest()
        let sortDescriptor = NSSortDescriptor(key: "secondName", ascending: true)
        fetchRequest.sortDescriptors = [sortDescriptor]
        let fetchedResultsController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: self.persistentConteiner.viewContext, sectionNameKeyPath: nil, cacheName: nil)
        fetchedResultsController.delegate = self
        return fetchedResultsController
    }()
    
    var artist: Artist?
    
    override func viewDidAppear(_ animated: Bool) {
        mainTableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        persistentConteiner.loadPersistentStores { (persistentStoreDescription, error) in
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
        
        view.backgroundColor = .white
        
        configureViews()
        configureConstraints()
    }
    
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
    
    @objc func didTappedOnCreate() {
        artist = Artist.init(entity: NSEntityDescription.entity(forEntityName: "Artist", in: persistentConteiner.viewContext)!, insertInto: persistentConteiner.viewContext)
        mainTableView.reloadData()
        print(persistentConteiner.viewContext)
    }
    
    @objc func didTappedOnSegment() {
        switch segmentedControl.selectedSegmentIndex {
        case 0:
            view.backgroundColor = .yellow
        case 1:
            view.backgroundColor = .cyan
        default:
            print("error switch segmentedControl")
        }
        self.mainTableView.reloadData()
        
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

