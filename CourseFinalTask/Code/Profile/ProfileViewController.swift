//
//  ProfileViewController.swift
//  CourseFinalTask
//
//  Created by Nikita on 18.12.2021.
//

import UIKit
import DataProvider

class ProfileViewController: UIViewController {
    
    var userProvider: UsersDataProviderProtocol!
    var dataProvider: PostsDataProviderProtocol!
    var userPosts: [Post]!
    
    var userID: User.Identifier!
    
    var mainView: ProfileView {
        return view as! ProfileView
    }
    
    override func loadView() {
        let view = ProfileView()
        self.view = view
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        userProvider = DataProviders.shared.usersDataProvider
        dataProvider = DataProviders.shared.postsDataProvider
        let user = userProvider.user(with: userID)!
        userPosts = dataProvider.findPosts(by: userID)!
        
        navigationItem.title = user.username
        
        mainView.accountLabel.text = user.fullName
        mainView.followingLabel.text = "Following: \(user.followsCount.description)"
        mainView.followersLabel.text = "Followers: \(user.followedByCount.description)"
        
        mainView.imageView.image = user.avatar ?? UIImage(named: "profile")
        
        mainView.delegate = self
        mainView.collection.delegate = self
        mainView.collection.dataSource = self
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        mainView.imageView.layer.cornerRadius = mainView.imageView.bounds.width / 2
    }
}

// MARK: - UICollectionViewDelegate, UICollectionViewDataSource
extension ProfileViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return userPosts.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = mainView.collection.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! ProfileCollectionViewCell
        cell.imageView.image = userPosts[indexPath.row].image
        
        return cell
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension ProfileViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let bounds = CGFloat(mainView.bounds.width / 3)
        
        return CGSize(width: bounds, height: bounds)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}

// MARK: - ProfileViewController: ProfileViewDelegate
extension ProfileViewController: ProfileViewDelegate {
    func tapOnFollowers() {
        let listVC = ListViewController()
        listVC.users = userProvider.usersFollowingUser(with: userID)!
        listVC.title = "Followers"
        
        navigationController?.pushViewController(listVC, animated: true)
    }
    
    func tapOnFollowing() {
        let listVC = ListViewController()
        listVC.users = userProvider.usersFollowedByUser(with: userID)!
        listVC.title = "Following"
        
        navigationController?.pushViewController(listVC, animated: true)
    }
}
