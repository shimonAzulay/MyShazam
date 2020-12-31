//
//  PagerViewController.swift
//  PlayingWithUIKit
//
//  Created by Shimon Azulay on 14/10/2020.
//

import UIKit

protocol PagerViewControllerDelegate
{
    func moveToPageAfter(_ page: PageModel)
    func moveToPageBefore(_ page: PageModel)
}

protocol PageViewControllerProtocol: UIViewController
{
    var model: PageModel? { get set }
    var pagerViewControllerDelegate: PagerViewControllerDelegate? { get set }
}

class PagerViewController: UIPageViewController
{
    var pagerPresenter: PagerPresenterProtocol?
    
    init(pagerPresenter: PagerPresenterProtocol, transitionStyle style: UIPageViewController.TransitionStyle, navigationOrientation: UIPageViewController.NavigationOrientation, options: [UIPageViewController.OptionsKey : Any]? = nil)
    {
        self.pagerPresenter = pagerPresenter
        super.init(transitionStyle: style, navigationOrientation: navigationOrientation, options: options)
    }
    
    required init?(coder: NSCoder)
    {
        super.init(coder: coder)
    }
    
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
    func moveToPageAfter(_ page: PageModel)
    {
        guard let pageAfter = self.pagerPresenter?.pageAfter(page) else {
            return
        }
        
        guard let vc = self.pageController(for: pageAfter) else { return }
        
        DispatchQueue.main.async { [weak self] in
            self?.setViewControllers([vc], direction: .forward, animated: true)
        }

    }
    
    func moveToPageBefore(_ page: PageModel)
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
        case 0:
            guard let vc = UIStoryboard(name: "LibraryStoryboard", bundle: nil).instantiateViewController(withIdentifier: "LibraryCollectionViewController") as? LibraryViewController else { return nil }
            vc.libraryPresenter = LibraryPresenter()
            vc.model = pageModel
            vc.pagerViewControllerDelegate = self
            return vc
        case 1:
            guard let vc = UIStoryboard(name: "ShazamStoryboard", bundle: nil).instantiateViewController(withIdentifier: "ShazamViewController") as? PageViewControllerProtocol else { return nil }
            vc.model = pageModel
            vc.pagerViewControllerDelegate = self
            return vc
        default:
            guard let vc = UIStoryboard(name: "ChartsStoryboard", bundle: nil).instantiateViewController(withIdentifier: "ChartsViewController") as? ChartsViewController else { return nil }
            vc.chartsPresenter = ChartsPresenter()
            vc.model = pageModel
            vc.pagerViewControllerDelegate = self
            return vc
        }
    }
    
    private func preparePagesBeforeAndAfter(_ page: PageModel)
    {
        // MARK: TODO
    }
}
