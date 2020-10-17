//
//  ChartCell.swift
//  MyShazam
//
//  Created by Shimon Azulay on 17/10/2020.
//

import UIKit

class ChartCell: UICollectionViewCell
{
    @IBOutlet weak var playAllButton: UIButton!
    @IBOutlet weak var chartName: UILabel!
    
    // MARK: TODO - move to a view
    @IBOutlet weak var firstChartSong: UIImageView!
    @IBOutlet weak var firstChartSongName: UILabel!
    @IBOutlet weak var firstChartSongArtistName: UILabel!
    
    @IBOutlet weak var secondChartSong: UIImageView!
    @IBOutlet weak var secondChartSongName: UILabel!
    @IBOutlet weak var secondChartSongArtistName: UILabel!
    
    @IBOutlet weak var thirdChartSong: UIImageView!
    @IBOutlet weak var thirdChartSongName: UILabel!
    @IBOutlet weak var thirdChartSongArtistName: UILabel!
    
    override func willMove(toSuperview newSuperview: UIView?)
    {
        prepareUI()
    }
}

extension ChartCell: CollectionViewCellProtocol
{
    func populateCell(itemModel: CollectionSectionItemModelProtocol)
    {
        guard let chartItemModel = itemModel as? ChartsItem else {
            return
        }
        
        self.chartName.text = chartItemModel.chartName
        
        self.firstChartSongName.text = chartItemModel.firstChartSongName
        self.firstChartSongArtistName.text = chartItemModel.firstChartSongArtistName
        
        self.secondChartSongName.text = chartItemModel.secondChartSongName
        self.secondChartSongArtistName.text = chartItemModel.secondChartSongArtistName
        
        self.thirdChartSongName.text = chartItemModel.thirdChartSongName
        self.thirdChartSongArtistName.text = chartItemModel.thirdChartSongArtistName
    }
}

extension ChartCell
{
    private func prepareUI()
    {
        self.playAllButton.layer.cornerRadius = self.playAllButton.frame.height / 2
        self.cornerRadius(for: self.firstChartSong)
        self.cornerRadius(for: self.secondChartSong)
        self.cornerRadius(for: self.thirdChartSong)
    }
    
    private func cornerRadius(for image: UIImageView)
    {
        image.layer.cornerRadius = 10.0
        image.layer.masksToBounds = true
    }
}
