//
//  PageViewControllerProtocol.swift
//  MyShazam
//
//  Created by Shimon Azulay on 16/10/2020.
//

import UIKit

protocol PageViewControllerProtocol: UIViewController
{
    var model: PageModel? { get set }
    var pagerViewControllerDelegate: PagerViewControllerDelegate? { get set }
    func loadPageData()
}
