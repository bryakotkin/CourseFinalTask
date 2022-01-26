//
//  ProfileView.swift
//  CourseFinalTask
//
//  Created by Nikita on 21.12.2021.
//

import UIKit

protocol ProfileViewDelegate: AnyObject {
    func tapOnFollowers()
    func tapOnFollowing()
}

class ProfileView: UIView {
    
    var delegate: ProfileViewDelegate?
    
    let imageView: UIImageView = {
        let image = UIImageView()
        image.backgroundColor = .blue
        image.layer.masksToBounds = true
        return image
    }()
    
    let accountLabel: UILabel = {
        let label = UILabel()
        label.text = "accountLabel"
        label.font = UIFont.systemFont(ofSize: 14)
        label.tintColor = .black
        
        return label
    }()
    
    let followersLabel: UILabel = {
        let label = UILabel()
        label.text = "Followers: 0"
        label.font = UIFont.systemFont(ofSize: 14, weight: .semibold)
        label.tintColor = .black
        label.isUserInteractionEnabled = true
        
        return label
    }()
    
    let followingLabel: UILabel = {
        let label = UILabel()
        label.text = "Following: 0"
        label.font = UIFont.systemFont(ofSize: 14, weight: .semibold)
        label.tintColor = .black
        label.isUserInteractionEnabled = true
        
        return label
    }()
    
    let collection: UICollectionView = {
        let collection = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        collection.register(ProfileCollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        
        return collection
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .white
        
        addSubview(imageView)
        addSubview(accountLabel)
        addSubview(collection)
        addSubview(followersLabel)
        addSubview(followingLabel)
        
        setupConstraints()
        setupActions()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupConstraints() {
        var constraints = [NSLayoutConstraint]()
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        accountLabel.translatesAutoresizingMaskIntoConstraints = false
        followingLabel.translatesAutoresizingMaskIntoConstraints = false
        followersLabel.translatesAutoresizingMaskIntoConstraints = false
        collection.translatesAutoresizingMaskIntoConstraints = false
        
        let imageViewConstraint = [
            imageView.leftAnchor.constraint(equalTo: leftAnchor, constant: 8),
            imageView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 8),
            imageView.heightAnchor.constraint(equalToConstant: 70),
            imageView.widthAnchor.constraint(equalTo: imageView.heightAnchor)
        ]
        
        let accountLabelConstraint = [
            accountLabel.leftAnchor.constraint(equalTo: imageView.rightAnchor, constant: 8),
            accountLabel.topAnchor.constraint(equalTo: imageView.topAnchor)
        ]
        
        let collectionConstraint = [
            collection.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 8),
            collection.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
            collection.leftAnchor.constraint(equalTo: leftAnchor),
            collection.rightAnchor.constraint(equalTo: rightAnchor)
        ]
        
        let followersLabelConstraint = [
            followersLabel.leftAnchor.constraint(equalTo: accountLabel.leftAnchor),
            followersLabel.bottomAnchor.constraint(equalTo: collection.topAnchor, constant: -8)
        ]
        
        let followingLabelConstraint = [
            followingLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -16),
            followingLabel.bottomAnchor.constraint(equalTo: collection.topAnchor, constant: -8)
        ]
        
        constraints.append(contentsOf: imageViewConstraint)
        constraints.append(contentsOf: accountLabelConstraint)
        constraints.append(contentsOf: collectionConstraint)
        constraints.append(contentsOf: followersLabelConstraint)
        constraints.append(contentsOf: followingLabelConstraint)
        
        NSLayoutConstraint.activate(constraints)
    }
    
    private func setupActions() {
        let followersRecognizer = UITapGestureRecognizer(target: self, action: #selector(tapOnFollowers))
        let followingRecognizer = UITapGestureRecognizer(target: self, action: #selector(tapOnFollowing))
        
        followersLabel.addGestureRecognizer(followersRecognizer)
        followingLabel.addGestureRecognizer(followingRecognizer)
    }
    
    @objc
    private func tapOnFollowers() {
        delegate?.tapOnFollowers()
    }
    
    @objc
    private func tapOnFollowing() {
        delegate?.tapOnFollowing()
    }
}
