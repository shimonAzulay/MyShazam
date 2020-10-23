//
//  DataSource.swift
//  PlayingWithUIKit
//
//  Created by Shimon Azulay on 10/10/2020.
//
import Foundation

struct DataSource {
    static func getLibraryData(_ callBack: @escaping (_ model: CollectionModel) -> Void)
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
    
    static func getChartsData(_ callBack: @escaping (_ model: CollectionModel) -> Void)
    {
        let aroundTheWorldChartsItems = AroundTheWorldChartsItem.createData()
        let chartsItems = ChartItem.createData()
        
        let sections = [CollectionSectionModel(sectionName: "Around The World Charts", sectionItems: aroundTheWorldChartsItems),
                       CollectionSectionModel(sectionName: "Charts", sectionItems: chartsItems)]
        
        let collectionModel = CollectionModel(sections: sections)
        //use delay to simulate network request
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            callBack(collectionModel)
        }
    }
    
    static func getSettingsData() -> CollectionModel
    {
        let streamingItems = StreamingModel.createData()
        let preferenceItems = PreferenceModel.createData()
        
        let sections = [CollectionSectionModel(sectionName: "Streaming", sectionItems: streamingItems),
                       CollectionSectionModel(sectionName: "Perferences", sectionItems: preferenceItems)]
        
        return CollectionModel(sections: sections)
        
    }
}
