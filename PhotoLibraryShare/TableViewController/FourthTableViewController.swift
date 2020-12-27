//
//  FourthTableViewController.swift
//  PhotoLibraryShare
//
//  Created by Евгений on 30.09.2020.
//

import UIKit

class FourthTableViewController: UITableViewController {

    
    
    var namefuture: [Namefuture] = []
    var spinner: UIActivityIndicatorView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        spinner = UIActivityIndicatorView(style: .large) 
        spinner.color = .black
        spinner.translatesAutoresizingMaskIntoConstraints = false 
        spinner.hidesWhenStopped = true 
        spinner.startAnimating() 
        tableView.addSubview(spinner) 
        
        spinner.centerXAnchor.constraint(equalTo: tableView.centerXAnchor).isActive = true 
        spinner.centerYAnchor.constraint(equalTo: tableView.centerYAnchor).isActive = true
        
        UIView.animate(withDuration: 0, delay: 10, options: .curveEaseIn, animations: {self.tableView.alpha = 1})
        {(finished) in
            self.spinner.stopAnimating()
            self.view.isUserInteractionEnabled = true
        }
    }

    
   
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    
   
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return namefuture.count
    }
    
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell")
        cell?.textLabel!.text = namefuture[indexPath.row].name
        
        return cell!
    }
}
