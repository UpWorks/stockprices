//
//  TabBarController.swift
//  StockPrices
//
//  Created by Michael Updegraff on 6/14/15.
//  Copyright (c) 2015 Michael Updegraff. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class TabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        var stocksListViewController = StocksListViewController(nibName: "StocksListViewController", bundle: nil)
        
        var searchViewController = SearchViewController(nibName: "SearchViewController", bundle: nil)

        
        var viewControllers = [stocksListViewController,searchViewController]
        self.setViewControllers(viewControllers, animated: true)
        
        var imagesNames = ["StocksListIcon","SearchIcon"]
        
        let tabItems = tabBar.items as! [UITabBarItem]
        for (index, value) in enumerate(tabItems)
        {
            var imageName = imagesNames[index]
            value.image = UIImage(named: imageName)
            value.imageInsets = UIEdgeInsetsMake(5.0, 0, -5.0, 0)
        }
        
        self.edgesForExtendedLayout = UIRectEdge.None
        self.navigationItem.hidesBackButton = true
        self.tabBar.translucent = false

    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.setNavigationBarHidden(false, animated: false)
        self.navigationItem.title = "StockPrices"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func addStock(sender: AnyObject) {
        
        var alert = UIAlertController(title: "New stock",
            message: "Add a new Stock",
            preferredStyle: .Alert)
        
        let saveAction = UIAlertAction(title: "Save", style: .Default) { (action: UIAlertAction!) -> Void in
            
            let textField = alert.textFields![0] as! UITextField
            
            //self.saveStock(textField.text)
            
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .Default) { (action: UIAlertAction!) -> Void in
        }
        
        alert.addTextFieldWithConfigurationHandler {
            (textField: UITextField!) -> Void in
        }
        
        alert.addAction(saveAction)
        alert.addAction(cancelAction)
        
        presentViewController(alert,
            animated: true,
            completion: nil)
    }
}
