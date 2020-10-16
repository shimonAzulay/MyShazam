//
//  MyStuffCollectionViewCell.swift
//  PlayingWithUIKit
//
//  Created by Shimon Azulay on 07/10/2020.
//
import UIKit

class MyStuffTableViewCell: UITableViewCell
{
    @IBOutlet weak var numberOfStuff: UILabel!
    @IBOutlet weak var stuffName: UILabel!
    @IBOutlet weak var icon: UIButton!
    
    override func prepareForReuse()
    {
        self.numberOfStuff.text = ""
        self.stuffName.text = ""
    }
}
