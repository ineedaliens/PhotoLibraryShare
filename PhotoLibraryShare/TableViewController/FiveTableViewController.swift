//
//  FiveTableViewController.swift
//  PhotoLibraryShare
//
//  Created by Евгений on 30.09.2020.
//

import UIKit

class FiveTableViewController: UITableViewController {
    
    
    // MARK: - VAR, LET, ARRAY CONSTANT
    var sectionHeader = ["Вы можете найти нас по: ","Наши социальные сети"]
    var sectionContent = [["youtube","VK","Telegram"],["vk.com","youtube.com"]]
    var firstSectionLinks = ["youtube.com","https://vk.com/ineedaliens","https://t.me/ineedalienschannel"]
    
        
    // MARK: - METHOD VIEW DID LOAD
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.tableFooterView = UIView(frame: CGRect.zero)
    }

    
    // MARK: - TABLE METHOD NUMBER OF SECTIONS
    override func numberOfSections(in tableView: UITableView) -> Int {
        return sectionHeader.count
    }

    
    // MARK: - TABLE METHOD NUMBER OF ROWS IN SECTIONS
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sectionContent[section].count
    }
    
    
    // MARK: - TABLE METHOD CELL FOR ROW AT INDEX PATH
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell5")
        cell?.textLabel?.text = sectionContent[indexPath.section][indexPath.row] // получаем номер секции: либо 0 либо 1 исходя из какой мы секции, затем добираемся до конкретного элемента
        
        return cell!
    }
    
    
    // MARK: - TABLE METHOD TITLE FOR HEADER IN SECTION
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sectionHeader[section]
    }
    
    
    // MARK: - TABLE METHOD DID SELECT ROW AT
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
