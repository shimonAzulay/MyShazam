//
//  LibraryCollectionPresenter.swift
//  PlayingWithUIKit
//
//  Created by Shimon Azulay on 10/10/2020.
//

import Foundation

class LibraryPresenter: CollectionPresenterProtocol
{
    private var libraryModel: CollectionModel?
    
    var numberOfSections: Int { self.libraryModel?.sections.count ?? 0 }
        
    func retrieveData(complition: (() -> Void)?)
    {
        guard libraryModel == nil else {
            complition?()
            return
        }
        DataSource.getLibraryData { collectionModel in
            self.libraryModel = collectionModel
            complition?()
        }
    }
    
    func numberOfItems(in section: Int) -> Int
    {
        guard section < self.numberOfSections else {
            return 0
        }
        
        return self.libraryModel?.sections[section].sectionItems.count ?? 0
    }
    
    func item(for index: CollectionIndex) -> CollectionSectionItemModelProtocol?
    {
        guard index.section < self.numberOfSections else  {
            return nil
        }
        
        guard index.row < self.numberOfItems(in: index.section) else {
            return nil
        }
        
        guard let item = self.libraryModel?.sections[index.section].sectionItems[index.row] else {
            return nil
        }
        
        return item
    }
}
