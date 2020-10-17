//
//  PagerPresenter.swift
//  PlayingWithUIKit
//
//  Created by Shimon Azulay on 16/10/2020.
//

protocol PagerPresenterProtocol
{
    var initialPage: PageModel { get }
    var numberOfPages: Int { get }
    
    func pageAfter(_ page: PageModel) -> PageModel?
    func pageBefore(_ page: PageModel) -> PageModel?
}

class PagerPresenter: PagerPresenterProtocol
{
    private var pages: [PageModel]
    
    var initialPage: PageModel { self.pages[1] }
    
    var numberOfPages: Int { self.pages.count }
    
    init(pages: [PageModel])
    {
        self.pages = pages
    }
    
    func pageAfter(_ page: PageModel) -> PageModel?
    {
        guard page.index < self.pages.count - 1 else {
            return nil
        }
        
        return self.pages[page.index + 1]
        
    }
    
    func pageBefore(_ page: PageModel) -> PageModel?
    {
        guard page.index > 0 else {
            return nil
        }
        
        return self.pages[page.index - 1]
    }
}
