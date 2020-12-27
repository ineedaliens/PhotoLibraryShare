//
//  ViewController.swift
//  PhotoLibraryShare
//
//  Created by Евгений on 27.09.2020.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var rateButton: UIButton!
    @IBOutlet weak var mapButton: UIButton!
    @IBOutlet weak var img: UIImageView!
    
    
  
    @IBAction func UnwindSegue(segue: UIStoryboardSegue) {
        guard let svc = segue.source as? SecondViewController else { return } 
        guard let rating = svc.restRating else { return } 
        rateButton.setTitle(rating, for: .normal) 
    }
    
    
 
    var nameofsfuture: Namefuture! 
    
    
   
    override func viewWillAppear(_ animated: Bool) { 
        navigationController?.hidesBarsOnSwipe = false
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let buttons = [rateButton, mapButton]
        for button in buttons { 
            guard let button = button else { break } 
            button.layer.cornerRadius = 5
            button.layer.borderWidth = 1
            button.layer.borderColor = UIColor.white.cgColor
        }
        img.contentMode = .scaleAspectFill 
        img.clipsToBounds = true 
        img.image = UIImage(data: nameofsfuture.images! as Data)
        tableView.backgroundColor = .white
        tableView.separatorColor = .black 
        tableView.tableFooterView = UIView(frame: CGRect.zero)
        title = nameofsfuture.name 
        tableView.estimatedRowHeight = 38 
        tableView.rowHeight = UITableView.automaticDimension 
    }
    
    
   
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    
   
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    
   
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell { 
        let cell1 = tableView.dequeueReusableCell(withIdentifier: "Cell1", for: indexPath) as! SecondTableViewCell
        cell1.keyLabel.textColor = .black
        cell1.valueLabel.textColor = .black
        switch indexPath.row { 
        case 0: cell1.keyLabel.text = "Имя"
            cell1.valueLabel.text = nameofsfuture.name
        case 1:
            cell1.keyLabel.text = "Тип"
            cell1.valueLabel.text = nameofsfuture.type
        case 2:
            cell1.keyLabel.text = "Адрес"
            cell1.valueLabel.text = nameofsfuture.location
        case 3:
            cell1.keyLabel.text = "Я был тут?"
            cell1.valueLabel.text = nameofsfuture.visited ? "Да" : "Нет"
        default:
            break
        }
        cell1.backgroundColor = .clear 
        return cell1
    }
    
   
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) { 
        tableView.deselectRow(at: indexPath, animated: true) 
    }
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) { 
        if segue.identifier == "show3" {
            let dvc = segue.destination as? ThirdViewController
            dvc?.namefutures = self.nameofsfuture 
        }
    }
}


