//
//  CollectionViewControllerProtocol.swift
//  PlayingWithUIKit
//
//  Created by Shimon Azulay on 10/10/2020.
//

protocol CollectionViewControllerProtocol: class
{
    func dataModelRetrieved(data: CollectionModel)
    func sectionModelRetrieved(section: CollectionSectionModel)
    func itemModelRetrieved(item: CollectionSectionItemModelProtocol, section: Int)
}
