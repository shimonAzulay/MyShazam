//
//  PageVC.swift
//  PageControllerTutorial
//
//  Created by Chris Larsen on 5/30/19.
//  Copyright © 2019 Tiger Bomb. All rights reserved.
//

import UIKit

class PageVC: UIViewController {
        
    var page: PageModel
    
    init(with page: PageModel) {
        self.page = page
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad()
    {
        switch self.page.index
        {
        case 0:
            self.view.backgroundColor = .red
        case 1:
            self.view.backgroundColor = .blue
        case 2:
            self.view.backgroundColor = .green
        default:
            self.view.backgroundColor = .yellow
        }
    }
}
