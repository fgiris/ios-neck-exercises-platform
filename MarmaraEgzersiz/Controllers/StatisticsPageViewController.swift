//
//  StatisticsPageViewController.swift
//  MarmaraEgzersiz
//
//  Created by Muhendis on 9.05.2018.
//  Copyright © 2018 Muhendis. All rights reserved.
//

import UIKit

class StatisticsPageViewController: UIPageViewController,UIPageViewControllerDataSource, UIPageViewControllerDelegate {
    

    @IBOutlet weak var logoutBarItem: UIBarButtonItem!
    
    var currentIndex: Int?
    private var pendingIndex: Int?
    
    required init?(coder aDecoder: NSCoder) {
        super.init(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        dataSource = self
        delegate = self
        self.title = "İstatisliklerim"
        if ControllerFunctionsHelper.isLanguageEnglish(){
            self.title = "My Statistics"
        }
        
       
        
        
        if let firstViewController = orderedViewControllers.first {
            setViewControllers([firstViewController],
                               direction: .forward,
                               animated: true,
                               completion: nil)
        }

        //view.bringSubview(toFront: pageControl)
        //pageControl.numberOfPages = 2
        //pageControl.currentPage = 0
        
        /*let appearance = UIPageControl.appearance()
        appearance.pageIndicatorTintColor = UIColor.red
        appearance.currentPageIndicatorTintColor = UIColor.white
        appearance.backgroundColor = UIColor.darkGray
        appearance.layer.position.y = 100
        appearance.layer.position.x = 100*/
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
   
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let viewControllerIndex = orderedViewControllers.index(of:viewController) else {
            return nil
        }
        
        let previousIndex = viewControllerIndex - 1
        
        guard previousIndex >= 0 else {
            return nil
        }
        
        guard orderedViewControllers.count > previousIndex else {
            return nil
        }
        
        return orderedViewControllers[previousIndex]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let viewControllerIndex = orderedViewControllers.index(of:viewController) else {
            return nil
        }
        
        let nextIndex = viewControllerIndex + 1
        let orderedViewControllersCount = orderedViewControllers.count
        
        guard orderedViewControllersCount != nextIndex else {
            return nil
        }
        
        guard orderedViewControllersCount > nextIndex else {
            return nil
        }
        
        return orderedViewControllers[nextIndex]
    }
    
    /*func presentationCountForPageViewController(pageViewController: UIPageViewController) -> Int {
        return orderedViewControllers.count
    }
    
    func presentationIndexForPageViewController(pageViewController: UIPageViewController) -> Int {
        guard let firstViewController = viewControllers?.first,
            let firstViewControllerIndex = orderedViewControllers.index(of:firstViewController) else {
                return 0
        }
        
        return firstViewControllerIndex
    }*/
    
    private(set) lazy var orderedViewControllers: [UIViewController] = {
        return [self.newStatisticsViewController(identifier: Identifiers.DAILY_STATISTICS_VIEW_CONTROLLER),
                self.newStatisticsViewController(identifier: Identifiers.WEEKLY_STATISTICS_VIEW_CONTROLLER)]
    }()
    
    private func newStatisticsViewController(identifier: String) -> UIViewController {
        return UIStoryboard(name: "Main", bundle: nil) .
            instantiateViewController(withIdentifier: identifier)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
