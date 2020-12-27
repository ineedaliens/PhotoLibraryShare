//
//  FiveTableViewController.swift
//  PhotoLibraryShare
//
//  Created by Евгений on 30.09.2020.
//

import UIKit

class FiveTableViewController: UITableViewController {
    
    
    
    var sectionHeader = ["Вы можете найти нас по: ","Наши социальные сети"]
    var sectionContent = [["youtube","VK","Telegram"],["vk.com","youtube.com"]]
    var firstSectionLinks = ["youtube.com","https://vk.com/ineedaliens","https://t.me/ineedalienschannel"]
    
        
   
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.tableFooterView = UIView(frame: CGRect.zero)
    }

    
   
    override func numberOfSections(in tableView: UITableView) -> Int {
        return sectionHeader.count
    }

    
   
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sectionContent[section].count
    }
    
    
   
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell5")
        cell?.textLabel?.text = sectionContent[indexPath.section][indexPath.row] 
        
        return cell!
    }
    
    
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sectionHeader[section]
    }
    
    
   
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.section {
        case 0:
            switch indexPath.row {
            case 0..<firstSectionLinks.count: performSegue(withIdentifier: "showWebPage", sender: self)
            default: break
            }
        default:
            break
        }
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showWebPage" {
            if let indexPath = tableView.indexPathForSelectedRow {
                let dvc = segue.destination as? FourthViewController
                dvc!.url = URL(string: firstSectionLinks[indexPath.row])
            }
        }
    }
}
