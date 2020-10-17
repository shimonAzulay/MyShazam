//
//  ChartsItem.swift
//  MyShazam
//
//  Created by Shimon Azulay on 17/10/2020.
//

struct ChartsItem: CollectionSectionItemModelProtocol
{
    var identifier: String {
        "ChartsItemCell"
    }
    
    var chartName: String
    // var firstChartSong: URL
    var firstChartSongName: String
    var firstChartSongArtistName: String
    
    // var secondChartSong: URL
    var secondChartSongName: String
    var secondChartSongArtistName: String
    
    // var thirdChartSong: URL
    var thirdChartSongName: String
    var thirdChartSongArtistName: String
}

extension ChartsItem
{
    static func createData() -> [ChartsItem]
    {
        [ChartsItem(chartName: "ISRAELI CHART", firstChartSongName: "TKN", firstChartSongArtistName: "ROSALIA & Travis Scott", secondChartSongName: "Honey", secondChartSongArtistName: "King gizzard & The Lizard Wizard", thirdChartSongName: "Freedom", thirdChartSongArtistName: "Pharrell Williams"),
         ChartsItem(chartName: "GLOBAL CHART", firstChartSongName: "TKN", firstChartSongArtistName: "ROSALIA & Travis Scott", secondChartSongName: "Honey", secondChartSongArtistName: "King gizzard & The Lizard Wizard", thirdChartSongName: "Freedom", thirdChartSongArtistName: "Pharrell Williams"),
         ChartsItem(chartName: "NEW YORK CITY CHART", firstChartSongName: "TKN", firstChartSongArtistName: "ROSALIA & Travis Scott", secondChartSongName: "Honey", secondChartSongArtistName: "King gizzard & The Lizard Wizard", thirdChartSongName: "Freedom", thirdChartSongArtistName: "Pharrell Williams")]
    }
}
