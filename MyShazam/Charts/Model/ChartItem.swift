//
//  ChartsItem.swift
//  MyShazam
//
//  Created by Shimon Azulay on 17/10/2020.
//

struct ChartItem: CollectionSectionItemModelProtocol
{
    var identifier: String {
        "ChartItemCell"
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

extension ChartItem
{
    static func createData() -> [ChartItem]
    {
        [ChartItem(chartName: "ISRAELI CHART", firstChartSongName: "TKN", firstChartSongArtistName: "ROSALIA & Travis Scott", secondChartSongName: "Honey", secondChartSongArtistName: "King gizzard & The Lizard Wizard", thirdChartSongName: "Freedom", thirdChartSongArtistName: "Pharrell Williams"),
         ChartItem(chartName: "GLOBAL CHART", firstChartSongName: "TKN", firstChartSongArtistName: "ROSALIA & Travis Scott", secondChartSongName: "Honey", secondChartSongArtistName: "King gizzard & The Lizard Wizard", thirdChartSongName: "Freedom", thirdChartSongArtistName: "Pharrell Williams"),
         ChartItem(chartName: "NEW YORK CITY CHART", firstChartSongName: "TKN", firstChartSongArtistName: "ROSALIA & Travis Scott", secondChartSongName: "Honey", secondChartSongArtistName: "King gizzard & The Lizard Wizard", thirdChartSongName: "Freedom", thirdChartSongArtistName: "Pharrell Williams")]
    }
}
