//
//  HomeController.swift
//  MeTube
//
//  Created by Stanley Pan on 8/30/16.
//  Copyright © 2016 Stanley Pan. All rights reserved.


import UIKit

class HomeController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    let cellId = "cellId"

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.translucent = false
        
        let titleLabel = UILabel(frame: CGRectMake(0, 0, view.frame.width - 32, view.frame.height))
        titleLabel.text = " Home"
        titleLabel.textColor = UIColor.whiteColor()
        titleLabel.font = UIFont.systemFontOfSize(20)
        navigationItem.titleView = titleLabel
        
        setupCollectionView()
        setupMenuBar()
        setupNavBarButtons()
    }
    
    func setupCollectionView() {
        
        if let flowLayout = collectionView?.collectionViewLayout as? UICollectionViewFlowLayout {
            flowLayout.scrollDirection = .Horizontal
            flowLayout.minimumLineSpacing = 0
        }
        
        collectionView?.backgroundColor = UIColor.whiteColor()
        
//        collectionView?.registerClass(VideoCell.self, forCellWithReuseIdentifier: "cellId")
//        collectionView?.registerClass(UICollectionViewCell.self, forCellWithReuseIdentifier: cellId)
        collectionView?.registerClass(FeedCell.self, forCellWithReuseIdentifier: cellId)
        
        collectionView?.contentInset = UIEdgeInsetsMake(50, 0, 0, 0)
        
        collectionView?.scrollIndicatorInsets = UIEdgeInsetsMake(50, 0, 0, 0)
        
        collectionView?.pagingEnabled = true
    }
    
    func setupNavBarButtons() {
        let searchImage = UIImage(named: "search")?.imageWithRenderingMode(.AlwaysOriginal)
        let searchBarButtonItem = UIBarButtonItem(image: searchImage, style: .Plain, target: self, action: #selector(handleSearch))
        
        let navigationMoreImage = UIImage(named: "navigationMore")?.imageWithRenderingMode(.AlwaysOriginal)
        let navigationMoreButtonItem = UIBarButtonItem(image: navigationMoreImage, style: .Plain, target: self, action: #selector(handleMore))
        navigationItem.rightBarButtonItems = [navigationMoreButtonItem, searchBarButtonItem]
    }
    
    lazy var settingsLauncher: SettingsLauncher = {
        let launcher = SettingsLauncher()
        launcher.homeController = self
        
        return launcher
    }()
    
    func handleMore() {
        settingsLauncher.showSettings()
    }
    
    func showControllerForSetting(setting: Setting) {
        let dummySettingsViewController = UIViewController()
        dummySettingsViewController.view.backgroundColor = UIColor.whiteColor()
        dummySettingsViewController.navigationItem.title = setting.name.rawValue
        navigationController?.navigationBar.tintColor = UIColor.whiteColor()
        navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.whiteColor()]
        navigationController?.pushViewController(dummySettingsViewController, animated: true)
    }
    
    func handleSearch() {
        scrollToMenuIndex(2)
    }
    
    func scrollToMenuIndex(menuIndex: Int) {
        let indexPath = NSIndexPath(forItem: menuIndex, inSection: 0)
        collectionView?.scrollToItemAtIndexPath(indexPath, atScrollPosition: .None, animated: true)
    }
    
    lazy var menuBar: MenuBar = {
        let mb = MenuBar()
        mb.homeController = self
        
        return mb
    }()
    
    private func setupMenuBar() {
        navigationController?.hidesBarsOnSwipe = true
        
        let redView = UIView()
        redView.backgroundColor = UIColor.rgb(230, green: 32, blue: 31)
        view.addSubview(redView)
        view.addConstraintsWithFormat("H:|[v0]|", views: redView)
        view.addConstraintsWithFormat("V:[v0(50)]", views: redView)
        
        view.addSubview(menuBar)
        view.addConstraintsWithFormat("H:|[v0]|", views: menuBar)
        view.addConstraintsWithFormat("V:[v0(50)]", views: menuBar)
        
        menuBar.topAnchor.constraintEqualToAnchor(topLayoutGuide.bottomAnchor).active = true
    }
    
    override func scrollViewDidScroll(scrollView: UIScrollView) {
        print(scrollView.contentOffset.x)
        
        menuBar.horizontalBarLeftAnchorConstraint?.constant = scrollView.contentOffset.x / 4
    }
    
    override func scrollViewWillEndDragging(scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        
        let index = targetContentOffset.memory.x / view.frame.width
        let indexPath = NSIndexPath(forItem: Int(index), inSection: 0)
        
        menuBar.collectionView.selectItemAtIndexPath(indexPath, animated: true, scrollPosition: .None)
//        print(targetContentOffset.memory.x)
    }
    
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(cellId, forIndexPath: indexPath)
       
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        
        return CGSizeMake(view.frame.width, view.frame.height)
    }
}