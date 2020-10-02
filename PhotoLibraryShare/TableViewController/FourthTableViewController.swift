//
//  FourthTableViewController.swift
//  PhotoLibraryShare
//
//  Created by Евгений on 30.09.2020.
//

import UIKit

class FourthTableViewController: UITableViewController {

    
    // MARK: - VAR, LET, ARRAY CONSTANT
    var namefuture: [Namefuture] = []
    var spinner: UIActivityIndicatorView!
    
    
    // MARK: - METHOD VIEW DID LOAD
    override func viewDidLoad() {
        super.viewDidLoad()
        spinner = UIActivityIndicatorView(style: .large) // задаем стиль ActivityIndicator
        spinner.color = .black
        spinner.translatesAutoresizingMaskIntoConstraints = false // свойство, которое не дает XCODE самостоятельно установить привязку элемента к экрану
        spinner.hidesWhenStopped = true // свойство, которое прячет наш ActivityIndicator после того, как он закончил вращаться
        spinner.startAnimating() // метод, анимация старта ActivityIndicator
        tableView.addSubview(spinner) // добавляем наш ActivityIndicator в нащ TableView
        
        spinner.centerXAnchor.constraint(equalTo: tableView.centerXAnchor).isActive = true // добавляем констрейнт от ACtivityIndicator к нашему TableView и говорим,что он активный
        spinner.centerYAnchor.constraint(equalTo: tableView.centerYAnchor).isActive = true
        
        UIView.animate(withDuration: 0, delay: 10, options: .curveEaseIn, animations: {self.tableView.alpha = 1})
        {(finished) in
            self.spinner.stopAnimating()
            self.view.isUserInteractionEnabled = true
        }
    }

    
    // MARK: - TABLE METHOD NUMBER OF SECTIONS
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    
    // MARK: - TABLE METHOD NUMBER OF ROWS IN SECTION
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return namefuture.count
    }
    
    
    // MARK: - TABLE METHOD DID SELECT ROW AT
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell")
        cell?.textLabel!.text = namefuture[indexPath.row].name
        
        return cell!
    }
}
