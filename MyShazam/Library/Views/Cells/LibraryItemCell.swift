//
//  LibraryItemCell.swift
//  PlayingWithUIKit
//
//  Created by Shimon Azulay on 08/10/2020.
//

import UIKit

class LibraryItemCell: UICollectionViewCell
{
    @IBOutlet weak var icon: UIButton!
    @IBOutlet weak var libraryName: UILabel!
    @IBOutlet weak var libraryItemNum: UILabel!
}

extension LibraryItemCell: CollectionViewCellProtocol
{
    static var nibName: String {
        "LibraryItemCell"
    }
    
    static var resuableId: String {
        "LibraryCell"
    }
    
    func populateCell(itemModel: CollectionSectionItemModelProtocol)
    {
        guard let libraryItemModel = itemModel as? LibraryItem else {
            return
        }
        
        self.libraryName.text = libraryItemModel.libraryName
    }
}
