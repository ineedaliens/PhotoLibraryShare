//
//  TableViewCell.swift
//  PhotoLibraryShare
//
//  Created by Евгений on 27.09.2020.
//

import UIKit
// ПОСЛЕ СОЗДАНИЯ МОДЕЛИ COREDATA И ОПРЕДЕЛЕНИЯ ИЗОБРАЖЕНИЯ КАК DATA BINARY - ПО ПРОЕКТУ ПРИДЕТСЯ ИСПРАВЛЯТЬ ОШИБКИ. УДАЛЯТЬ СОЗДАННЫЙ ФАЙЛ СО СТРУКТУТОРОЙ НАШИХ СВОЙСТВ. ИЗОБРАЖЕНИЯ, КОТОРЫЕ ИМЕЕЮТ ВИД UIImage(named: namefuture[indexPath.row].images) НУЖНО ПРИВОДИТЬ К ТАКОМУ ВИДУ: UIImage(data: namefuture[indexPath.row].images! as Data), ТАК КАК НАШИ ИЗОБРАЖЕНИЯ ИМЕЮТ ФОРМАТ BINARY DATA
class TableViewCell: UITableViewCell {
    
    
    // MARK: - @IBOUTLETS - ELEMENTS
    @IBOutlet weak var amageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    
    
    // MARK: - METHOD AWAKE FROM NIB
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    
    // MARK: - METHOD SET SELECTED 
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
