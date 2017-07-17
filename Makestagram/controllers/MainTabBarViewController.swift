//
//  MainTabBarViewController.swift
//  Makestagram
//
//  Created by Anika Kablan on 6/30/17.
//  Copyright © 2017 Anika Kablan. All rights reserved.
//

import UIKit

class MainTabBarViewController: UITabBarController {
    let photoHelper = MGPhotoHelper()

    override func viewDidLoad() {

        super.viewDidLoad()
            
        photoHelper.completionHandler = { image in
            PostService.create(for: image)
        }

        
        delegate = self
        
        tabBar.unselectedItemTintColor = .black

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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

extension MainTabBarViewController: UITabBarControllerDelegate{
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool{
        if viewController.tabBarItem.tag == 1{
            photoHelper.presentActionSheet(from: self)
            return false
        }
        return true
        
    }
}

