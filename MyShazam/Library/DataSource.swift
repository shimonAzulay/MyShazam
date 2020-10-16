//
//  DataSource.swift
//  PlayingWithUIKit
//
//  Created by Shimon Azulay on 10/10/2020.
//
import Foundation

struct DataSource {
    static func getData(_ callBack: @escaping (_ model: CollectionModel) -> Void)
    {
        let libraries = LibraryItem.createData()
        let shazams = ShazamItem.createData()
        let actions = ActionItem.createData()
        
        let sections = [CollectionSectionModel(sectionName: "Library", sectionItems: libraries),
                       CollectionSectionModel(sectionName: "Recent Shazams", sectionItems: shazams),
                       CollectionSectionModel(sectionName: "Actions", sectionItems: actions)]
        
        let collectionModel = CollectionModel(sections: sections)
        //use delay to simulate network request
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            callBack(collectionModel)
        }
    }
}
