//
//  AroundTheWorldChartsCell.swift
//  MyShazam
//
//  Created by Shimon Azulay on 17/10/2020.
//

import UIKit

class AroundTheWorldChartsCell: UICollectionViewCell {}

extension AroundTheWorldChartsCell: CollectionViewCellProtocol
{
    static var nibName: String {
        "AroundTheWorldChartsCell"
    }
    
    static var resuableId: String {
        "AroundTheWorldChartsCell"
    }
    
    func populateCell(itemModel: CollectionSectionItemModelProtocol) {}
}
