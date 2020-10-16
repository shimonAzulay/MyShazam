//
//  PagerViewController.swift
//  PlayingWithUIKit
//
//  Created by Shimon Azulay on 14/10/2020.
//

import UIKit

protocol PagerViewControllerDelegate
{
    func moveToPagerAfter(_ page: PageModel)
    func moveToPagerBefore(_ page: PageModel)
}

class PagerViewController: UIPageViewController
{
    var pagerPresenter: PagerPresenterProtocol?

    override func viewDidLoad()
    {
        self.delegate = self
        self.dataSource = self
        
        guard let pagerPresenter = self.pagerPresenter else {
            return
        }
        let initialPage = pagerPresenter.initialPage
        guard let initialVC = self.pageController(for: initialPage) else {
            return
        }
        self.setViewControllers([initialVC], direction: .forward, animated: true)
    }
}

extension PagerViewController: UIPageViewControllerDataSource, UIPageViewControllerDelegate
{
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        
        guard let currentVC = viewController as? PageViewControllerProtocol else {
            return nil
        }
        
        guard let pageModel = currentVC.model else {
            return nil
        }
        
        guard let pageBefore = self.pagerPresenter?.pageBefore(pageModel) else {
            return nil
        }
        
        return self.pageController(for: pageBefore)
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        
        guard let currentVC = viewController as? PageViewControllerProtocol else {
            return nil
        }
        
        guard let pageModel = currentVC.model else {
            return nil
        }
        
        guard let pageAfter = self.pagerPresenter?.pageAfter(pageModel) else {
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
        guard let currentVC = pageViewController.viewControllers?.first as? PageViewControllerProtocol else {
            return 0
        }
        
        guard let pageModel = currentVC.model else {
            return 0
        }
        
        return pageModel.index
    }
}

extension PagerViewController: PagerViewControllerDelegate
{
    func moveToPagerAfter(_ page: PageModel)
    {
        guard let pageAfter = self.pagerPresenter?.pageAfter(page) else {
            return
        }
        
        guard let vc = self.pageController(for: pageAfter) else { return }
        
        DispatchQueue.main.async { [weak self] in
            self?.setViewControllers([vc], direction: .forward, animated: true)
        }

    }
    
    func moveToPagerBefore(_ page: PageModel)
    {
        guard let pageBefore = self.pagerPresenter?.pageBefore(page) else {
            return
        }
        
        guard let vc = self.pageController(for: pageBefore) else { return }
        
        DispatchQueue.main.async { [weak self] in
            self?.setViewControllers([vc], direction: .reverse, animated: true)
        }
    }
}

// MARK: Page related
extension PagerViewController
{
    private func pageController(for pageModel: PageModel) -> PageViewControllerProtocol?
    {
        // MARK: TODO - Need to create a getter
        
        switch pageModel.index {
        case 1:
            guard let vc = UIStoryboard(name: "ShazamStoryboard", bundle: nil).instantiateViewController(withIdentifier: "ShazamViewController") as? PageViewControllerProtocol else { return nil }
            vc.model = pageModel
            vc.pagerViewControllerDelegate = self
            return vc
        default:
            let vc = LibraryCollectionViewController(collectionViewLayout: UICollectionViewLayout())
            vc.model = pageModel
            vc.pagerViewControllerDelegate = self
            vc.libraryCollectionPresenter = LibraryCollectionPresenter()
            return vc
        }
    }
    
    private func preparePagesBeforeAndAfter(_ page: PageModel)
    {
        // MARK: TODO
    }
}