//
//  CollectionViewCellProtocol.swift
//  PlayingWithUIKit
//
//  Created by Shimon Azulay on 10/10/2020.
//

import Foundation

protocol CollectionViewCellProtocol
{
    static var nibName: String { get }
    static var resuableId: String { get }
    func populateCell(itemModel: CollectionSectionItemModelProtocol)
}
