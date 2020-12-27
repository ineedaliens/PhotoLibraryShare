//
//  TableViewController.swift
//  PhotoLibraryShare
//
//  Created by Евгений on 27.09.2020.
//

import UIKit
import CoreData

class TableViewController: UITableViewController, NSFetchedResultsControllerDelegate {
    
    
   
    var fetchResultsController: NSFetchedResultsController<Namefuture>! 
    var searchController: UISearchController!
    var filteredResultArray: [Namefuture] = [] 
    var namessoffuture: [Namefuture] = []
    
    
    
    @IBAction func close(segue: UIStoryboardSegue) {
    }
    
    
  
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.hidesBarsOnSwipe = true
    }
    
    
   
    func filterContentFor( searchText text: String){ 
        filteredResultArray = namessoffuture.filter( { (Namefuture) -> Bool in 
            return (Namefuture.name?.lowercased().contains(text.lowercased()))! }) 
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "",style: .plain, target: nil ,action: nil) 
        tableView.estimatedRowHeight = 85
        tableView.rowHeight = UITableView.automaticDimension
       
        searchController = UISearchController(searchResultsController: nil) 
        searchController.searchResultsUpdater = self
        searchController.dimsBackgroundDuringPresentation = false 
        tableView.tableHeaderView = searchController.searchBar 
        searchController.delegate = self 
        definesPresentationContext = true 
        searchController.searchBar.backgroundColor = .white 
        searchController.searchBar.barTintColor = .white
        searchController.searchBar.tintColor = .black
    
        
      
        let fetchRequest: NSFetchRequest<Namefuture> = Namefuture.fetchRequest() 
        let sortDescriptor = NSSortDescriptor(key: "name", ascending: true) 
        fetchRequest.sortDescriptors = [sortDescriptor]
        
        if let context = (UIApplication.shared.delegate as? AppDelegate)?.coreDataStack.persistentContainer.viewContext { 
            fetchResultsController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: context, sectionNameKeyPath: nil, cacheName: nil)
            fetchResultsController.delegate = self
            
            do { 
                try fetchResultsController.performFetch()
                namessoffuture =  fetchResultsController.fetchedObjects! 
            } catch let error as NSError {
                print(error.localizedDescription)
            }
        }
    }

    
  
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        let userDefaults = UserDefaults.standard 
        let wasIntroWhatch = userDefaults.bool(forKey: "wasIntroWatch") 
        guard !wasIntroWhatch else { return } 
        if let pageViewController = storyboard?.instantiateViewController(identifier: "pageViewController") as? PageViewController { 
            present(pageViewController, animated: true, completion: nil)
            
        }
    }
    
    
   
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) { 
        tableView.beginUpdates() 
    }
    
    
   
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) { 
        switch type {
        case .insert: guard let indexPath = newIndexPath else { break }
            tableView.insertRows(at: [indexPath], with: .fade)
        case .delete: guard let indexPath = indexPath else {break}
            tableView.deleteRows(at: [indexPath], with: .fade)
        case .update: guard let indexPath = indexPath else {break}
            tableView.reloadRows(at: [indexPath], with: .fade)
        default:
            tableView.reloadData()
        }
        namessoffuture = controller.fetchedObjects as! [Namefuture]
    }
    
    
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) { 
        tableView.endUpdates()
    }
    
    
   
    override func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1 
    }
    
    
   
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if searchController.isActive && searchController.searchBar.text != "" { 
            return filteredResultArray.count 
        }
        return namessoffuture.count
    }
    
    
   
    func namesToDisplay(indexPath: IndexPath) -> Namefuture {
        let namefuture: Namefuture 
        if searchController.isActive && searchController.searchBar.text != "" { 
            namefuture = filteredResultArray[indexPath.row]
        } else {
            namefuture = namessoffuture[indexPath.row]
        }
        return namefuture
    }
    
    
   
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! TableViewCell 
        let namefuture = namesToDisplay(indexPath: indexPath)
        cell.amageView.image = UIImage(data: namefuture.images! as Data) 
        cell.amageView.layer.cornerRadius = 32.5 
        cell.amageView.clipsToBounds = true 
        cell.nameLabel.text = namefuture.name 
        cell.locationLabel.text = namefuture.location
        cell.typeLabel.text = namefuture.type
        
        cell.accessoryType = namefuture.visited ? .checkmark : .none 
        return cell
    }
    
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    
    
   
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) { 
        if editingStyle == .delete { 
            self.namessoffuture.remove(at: indexPath.row)
            if let context = (UIApplication.shared.delegate as? AppDelegate)?.coreDataStack.persistentContainer.viewContext { 
                let objectToDelete = self.fetchResultsController.object(at: indexPath) 
                context.delete(objectToDelete)
                do {                        
                    try context.save()
                } catch {
                    print(error.localizedDescription) 
                }
            }  
        }
    }
   

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "show" {
            if let indexPath = tableView.indexPathForSelectedRow {
                let vlc =  segue.destination as! ViewController
                vlc.nameofsfuture = namesToDisplay(indexPath: indexPath) 
            }
        }
    }
}



extension TableViewController: UISearchResultsUpdating { 
    func updateSearchResults(for searchController: UISearchController) {
        filterContentFor( searchText: searchController.searchBar.text!) 
        tableView.reloadData() 
    }
    
}



extension TableViewController: UISearchControllerDelegate {
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        if searchBar.text == ""{
            navigationController?.hidesBarsOnSwipe = false
        }
    }
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        navigationController?.hidesBarsOnSwipe = true
    }
}
