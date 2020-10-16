//
//  LibraryCollectionPresenter.swift
//  PlayingWithUIKit
//
//  Created by Shimon Azulay on 10/10/2020.
//

import Foundation

class LibraryCollectionPresenter: CollectionPresenterProtocol
{
    private var collectionModel: CollectionModel?
    
    var numberOfSections: Int { self.collectionModel?.sections.count ?? 0 }
        
    func retrieveData(complition: (() -> Void)?)
    {
        DataSource.getData { collectionModel in
            self.collectionModel = collectionModel
            complition?()
        }
    }
    
    func numberOfItems(in section: Int) -> Int
    {
        guard section < self.numberOfSections else {
            return 0
        }
        
        return self.collectionModel?.sections[section].sectionItems.count ?? 0
    }
    
    func item(for index: CollectionIndex) -> CollectionSectionItemModelProtocol?
    {
        guard index.section < self.numberOfSections else  {
            return nil
        }
        
        guard index.row < self.numberOfItems(in: index.section) else {
            return nil
        }
        
        guard let item = self.collectionModel?.sections[index.section].sectionItems[index.row] else {
            return nil
        }
        
        return item
    }
}
