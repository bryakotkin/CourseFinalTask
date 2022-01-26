//
//  MainTabBarViewController.swift
//  CourseFinalTask
//
//  Created by Nikita on 18.12.2021.
//

import UIKit
import DataProvider

class MainTabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let feedViewController = FeedViewController()
        feedViewController.title = "Feed"
        let feedImage = UIImage(named: "feed")
        
        let profileViewController = ProfileViewController()
        profileViewController.title = "Profile"
        profileViewController.userID = DataProviders.shared.usersDataProvider.currentUser().id
        let profileImage = UIImage(named: "profile")

        viewControllers = [
            toNavigationController(feedViewController, "Feed", feedImage!),
            toNavigationController(profileViewController, "Profile", profileImage!)
        ]
    }
    
    private func toNavigationController(_ viewController: UIViewController, _ title: String, _ image: UIImage) -> UIViewController {
        let navController = UINavigationController(rootViewController: viewController)
        navController.tabBarItem.title = title
        navController.tabBarItem.image = image
        
        return navController
    }
}
