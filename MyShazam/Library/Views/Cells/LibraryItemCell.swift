//
//  LibraryItemCell.swift
//  PlayingWithUIKit
//
//  Created by Shimon Azulay on 08/10/2020.
//

import UIKit

class LibraryItemCell: UICollectionViewListCell
{
    @IBOutlet weak var icon: UIButton!
    @IBOutlet weak var libraryName: UILabel!
    @IBOutlet weak var libraryItemNum: UILabel!
        
    override func willMove(toSuperview newSuperview: UIView?)
    {
        self.prepareUI()
    }
}

extension LibraryItemCell: CollectionViewCellProtocol
{
    func populateCell(itemModel: CollectionSectionItemModelProtocol)
    {
        guard let libraryItemModel = itemModel as? LibraryItem else {
            return
        }
        
        self.libraryName.text = libraryItemModel.libraryName
    }
}

extension LibraryItemCell
{
    private func prepareUI()
    {
        self.accessories = [.disclosureIndicator()]
    }
}
