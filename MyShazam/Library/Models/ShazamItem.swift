//
//  ShazamItem.swift
//  PlayingWithUIKit
//
//  Created by Shimon Azulay on 10/10/2020.
//

import Foundation

struct ShazamItem: CollectionSectionItemModelProtocol {
    
    var identifier: String {
        "ShazamItemCell"
    }
    
    //var shazamImage: URL
    var shazamSongName: String
    var shazamArtistName: String
}

extension ShazamItem
{
    static func createData() -> [ShazamItem] {
        [ShazamItem(shazamSongName: "TKN", shazamArtistName: "ROSALIA & Travis Scott"),
         ShazamItem(shazamSongName: "Honey", shazamArtistName: "King gizzard & The Lizard Wizard"),
         ShazamItem(shazamSongName: "Freedom", shazamArtistName: "Pharrell Williams"),
         ShazamItem(shazamSongName: "Someone You Loved", shazamArtistName: "Lewis Capaldi"),
         ShazamItem(shazamSongName: "De Nada Sirve", shazamArtistName: "Moris"),
         ShazamItem(shazamSongName: "Into Dust", shazamArtistName: "Mazzy Star")]
    }
}
