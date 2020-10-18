//
//  ShazamViewController.swift
//  MyShazam
//
//  Created by Shimon Azulay on 16/10/2020.
//

import UIKit

class ShazamViewController: UIViewController, PageViewControllerProtocol
{
    var model: PageModel?
    var pagerViewControllerDelegate: PagerViewControllerDelegate?
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
    }
    
    @IBAction func chartsTapped(_ sender: Any)
    {
        guard let pageModel = self.model else {
            return
        }
        
        self.pagerViewControllerDelegate?.moveToPageAfter(pageModel)
    }
    
    @IBAction func libraryTapped(_ sender: Any)
    {
        guard let pageModel = self.model else {
            return
        }
        
        self.pagerViewControllerDelegate?.moveToPageBefore(pageModel)
    }
}

extension ShazamViewController
{
    func loadPageData() {}
}
