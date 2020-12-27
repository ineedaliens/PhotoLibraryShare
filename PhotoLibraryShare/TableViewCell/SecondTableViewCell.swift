//
//  SecondTableViewCell.swift
//  PhotoLibraryShare
//
//  Created by Евгений on 27.09.2020.
//

import UIKit

class SecondTableViewCell: UITableViewCell {
    
    
   
    @IBOutlet weak var keyLabel: UILabel!
    @IBOutlet weak var valueLabel: UILabel!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    
   
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
