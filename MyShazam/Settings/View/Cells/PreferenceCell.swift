//
//  PreferenceCell.swift
//  MyShazam
//
//  Created by Shimon Azulay on 23/10/2020.
//

import UIKit

class PreferenceCell: UICollectionViewCell
{
    @IBOutlet weak var preferenceName: UILabel!
}

extension PreferenceCell: CollectionViewCellProtocol
{
    static var nibName: String {
        "PreferenceCell"
    }
    
    static var resuableId: String {
        String(describing: Self.self)
    }
    
    func populateCell(itemModel: CollectionSectionItemModelProtocol)
    {
        guard let preferenceModel = itemModel as? PreferenceModel else {
            return
        }
        
        self.preferenceName.text = preferenceModel.perferenceName
    }
}

extension PreferenceCell
{
    private func prepareUI()
    {
    }
}

