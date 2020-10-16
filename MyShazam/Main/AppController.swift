//
//  PagesController.swift
//  PlayingWithUIKit
//
//  Created by Shimon Azulay on 14/10/2020.
//

import UIKit

class AppController: UIPageViewController
{
    var pagerPresenter: PagerPresenterProtocol?
    
    var currentIndex = 0
    
    override func viewDidLoad()
    {
        self.delegate = self
        self.dataSource = self
        
        guard let pagerPresenter = self.pagerPresenter else {
            return
        }
        let initialPage = pagerPresenter.initialPage
        self.setViewControllers([self.pageController(for: initialPage)], direction: .forward, animated: true)
    }
}

extension AppController: UIPageViewControllerDataSource, UIPageViewControllerDelegate
{
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        
        guard let currentVC = viewController as? PageVC else {
            return nil
        }
        
        guard let pageBefore = self.pagerPresenter?.pageBefore(currentVC.page) else {
            return nil
        }
        
        return self.pageController(for: pageBefore)
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        
        guard let currentVC = viewController as? PageVC else {
            return nil
        }
        
        guard let pageAfter = self.pagerPresenter?.pageAfter(currentVC.page) else {
            return nil
        }
        
        return self.pageController(for: pageAfter)
    }
    
    func presentationCount(for pageViewController: UIPageViewController) -> Int
    {
        guard let numberOfPages = self.pagerPresenter?.numberOfPages else {
            return 0
        }
        
        return numberOfPages
    }
    
    func presentationIndex(for pageViewController: UIPageViewController) -> Int
    {
        guard let currentVC = pageViewController.viewControllers?.first as? PageVC else {
            return 0
        }
        
        return currentVC.page.index
    }
}

extension AppController
{
    private func pageController(for pageModel: PageModel) -> PageVC
    {
        return PageVC(with: pageModel)
    }
}
