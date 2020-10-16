//
//  LibraryItem.swift
//  PlayingWithUIKit
//
//  Created by Shimon Azulay on 07/10/2020.
//
import Foundation

struct LibraryItem: CollectionSectionItemModelProtocol
{
    var identifier: String {
        "LibraryItemCell"
    }
    
    //var libraryIcon: URL
    var libraryName: String
}

extension LibraryItem
{
    static func createData() -> [LibraryItem] {
        [LibraryItem(libraryName: "Shazams"),
         LibraryItem(libraryName: "Artists"),
         LibraryItem(libraryName: "Playlists for you")]
    }
}
