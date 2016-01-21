//
//  ViewController.swift
//  pageBasedYachtmanager
//
//  Created by Reinier on 20-01-16.
//  Copyright © 2016 Reinier. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UIPageViewControllerDataSource {
    
    var pageViewController: UIPageViewController!
    var yachtModels = Array<YachtModel>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.pageViewController = self.storyboard?.instantiateViewControllerWithIdentifier("pageViewController") as! UIPageViewController
        
        self.pageViewController.dataSource = self
        //test json call
        
        let restApi = RestApiManager()
        
        restApi.httpRequestWithAccessToken("yachts",token:"vg48AeVddfWh_hqHzFk8v4WvMq4IX_ng") { (yachtModels) -> Void in
            self.yachtModels.removeAll()
            print(yachtModels)
            for yacht in yachtModels{
                self.yachtModels.append(yacht)
            }
            
            dispatch_async(dispatch_get_main_queue()) {
                self.setupUI()
            }
            
        }
    }
    
    private func setupUI(){
    let startVc = self.viewControllerAtIndex(0)
    
    let viewControllers = NSArray(object: startVc)
    
    self.pageViewController.setViewControllers(viewControllers as! [YachtViewController], direction: .Forward, animated: true, completion: nil)
    
    self.pageViewController.view.frame = CGRectMake(0, 30, self.view.frame.width, CGFloat(self.view.frame.size.height))
    
    self.addChildViewController(self.pageViewController)
    self.view.addSubview(self.pageViewController.view)
    self.pageViewController.didMoveToParentViewController(self)
    }
    
    func viewControllerAtIndex(index: Int) -> YachtViewController {
        print("yachtModels count \(self.yachtModels.count)")
        print("looking for yachtModel at index \(index)")
        if self.yachtModels.count == 0 || index >= self.yachtModels.count {
            return YachtViewController()
        }
        
        let viewController: YachtViewController = self.storyboard?.instantiateViewControllerWithIdentifier("yachtViewController") as! YachtViewController
        viewController.index = index
        viewController.model = self.yachtModels[index]
        return viewController
        
    }
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerBeforeViewController viewController: UIViewController) -> UIViewController? {
        
        let vc = viewController as! YachtViewController
        var index = vc.index as Int
        
        if (index == 0) || (index == NSNotFound) {
            return nil
        }
        
        index--
        return self.viewControllerAtIndex(index)
    }
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerAfterViewController viewController: UIViewController) -> UIViewController? {
        let vc = viewController as! YachtViewController
        var index = vc.index as Int
        
        if index == NSNotFound {
            return nil
        }
        
        index++
        if index == self.yachtModels.count {
            return nil
        }
        print(index)
        return self.viewControllerAtIndex(index)
    }
    
    func presentationIndexForPageViewController(pageViewController: UIPageViewController) -> Int {
        return 0;
    }
    
}

