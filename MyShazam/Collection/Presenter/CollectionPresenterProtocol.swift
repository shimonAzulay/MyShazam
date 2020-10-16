//
//  CollectionPresenterProtocol.swift
//  PlayingWithUIKit
//
//  Created by Shimon Azulay on 10/10/2020.
//

struct CollectionIndex
{
    var section: Int
    var row: Int
}

protocol CollectionPresenterProtocol: class
{
    var numberOfSections: Int { get }
    
    func retrieveData(complition: (() -> Void)?)
    func numberOfItems(in section: Int) -> Int
    func item(for index: CollectionIndex) -> CollectionSectionItemModelProtocol?
}
