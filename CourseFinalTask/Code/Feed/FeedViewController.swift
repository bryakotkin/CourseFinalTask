//
//  FeedViewController.swift
//  CourseFinalTask
//
//  Created by Nikita on 18.12.2021.
//

import UIKit
import DataProvider

class FeedViewController: UIViewController {

    var provider: PostsDataProviderProtocol!
    
    var collection: UICollectionView!
    var posts: [Post]!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        provider = DataProviders.shared.postsDataProvider
        posts = provider.feed()
        
        setupCollectionView()
    }
    
    private func setupCollectionView() {
        collection = UICollectionView(frame: view.bounds, collectionViewLayout: UICollectionViewFlowLayout())
        collection.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        collection.register(PostCollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        view.addSubview(collection)
        
        collection.dataSource = self
        collection.delegate = self
    }
}

// MARK: - UICollectionViewDelegate, UICollectionViewDataSource
extension FeedViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return posts.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! PostCollectionViewCell
        
        let post = posts[indexPath.row]
        
        cell.postProfileImage.image = post.authorAvatar!
        cell.postProfileLabel.text = post.authorUsername
        cell.postLikeImage.tintColor = post.currentUserLikesThisPost ? .systemBlue : .lightGray
        cell.postLikeLabel.text = "Likes: \(post.likedByCount.description)"
        cell.postImage.image = post.image
        cell.setDate(post.createdTime)
        cell.postCommentLabel.text = post.description
        
        cell.delegate = self
        
        return cell
    }
}

// MARK: UICollectionViewDelegateFlowLayout
extension FeedViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return .init(width: collectionView.bounds.width, height: collectionView.bounds.width + 139)
    }
}

// MARK: PostCollectionViewCellDelegate
extension FeedViewController: PostCollectionViewCellDelegate {
    
    func tapOnBigLike(_ sender: UITapGestureRecognizer) {
        guard let index = getIndexOfLocation(sender) else { return }
        guard !posts[index.row].currentUserLikesThisPost else { return }
        guard let cell = collection.cellForItem(at: index)! as? PostCollectionViewCell else { return }
        
        let animate = CAKeyframeAnimation(keyPath: "opacity")
        
        let firstKeyTime = NSNumber(value: 0.1 / 0.6)
        let secondKeyTime = NSNumber(value: 0.3 / 0.6)
        
        animate.values = [0, 1, 1, 0]
        animate.keyTimes = [0, firstKeyTime, secondKeyTime, 1]
        animate.timingFunctions = [
            CAMediaTimingFunction(name: .linear),
            CAMediaTimingFunction(name: .linear),
            CAMediaTimingFunction(name: .easeOut)
        ]
        animate.duration = 0.6
        cell.postBigLikeImage.layer.add(animate, forKey: "opacity")
        
        let _ = provider.likePost(with: posts[index.row].id)
        
        Timer.scheduledTimer(timeInterval: animate.duration, target: self, selector: #selector(updateDataOfPosts), userInfo: nil, repeats: false)
    }
    
    func tapOnProfile(_ sender: UITapGestureRecognizer) {
        guard let index = getIndexOfLocation(sender) else { return }
        let post = posts[index.row]
        
        let profileVC = ProfileViewController()
        profileVC.userID = post.author
        
        navigationController?.pushViewController(profileVC, animated: true)
    }
    
    func tapOnLike(_ sender: UITapGestureRecognizer) {
        guard let index = getIndexOfLocation(sender) else { return }
        let post = posts[index.row]
        
        let _ = post.currentUserLikesThisPost ? provider.unlikePost(with: post.id) : provider.likePost(with: post.id)
        updateDataOfPosts()
    }
    
    func tapOnLikeLabel(_ sender: UITapGestureRecognizer) {
        guard let index = getIndexOfLocation(sender) else { return }
        let postID = posts[index.row].id
        
        let likesVC = ListViewController()
        
        var users = [User]()
        let usersID = provider.usersLikedPost(with: postID)!
        
        for userID in usersID {
            guard let user = DataProviders.shared.usersDataProvider.user(with: userID) else { return }
            users.append(user)
        }
        
        likesVC.users = users
        likesVC.title = "Likes"
        navigationController?.pushViewController(likesVC, animated: true)
    }
    
    @objc
    private func updateDataOfPosts() {
        posts = provider.feed()
        collection.reloadData()
    }
    
    private func getIndexOfLocation(_ sender: UITapGestureRecognizer) -> IndexPath? {
        let location = sender.location(in: collection)
        
        return collection.indexPathForItem(at: location)
    }
}

