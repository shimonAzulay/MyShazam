//
//  LibraryCollectionPresenter.swift
//  PlayingWithUIKit
//
//  Created by Shimon Azulay on 10/10/2020.
//

import Foundation

protocol LibraryPresenterProtocol
{
    var title: String { get }
    func retrieveData(complition: ((_ collectionModel: CollectionModel) -> Void)?)
}

class LibraryPresenter: LibraryPresenterProtocol
{
    private var libraryModel: CollectionModel?
    
    var title: String = "Library"
        
    func retrieveData(complition: ((_ collectionModel: CollectionModel) -> Void)?)
    {
        DataSource.getLibraryData { collectionModel in
            self.libraryModel = collectionModel
            complition?(collectionModel)
        }
    }
}
