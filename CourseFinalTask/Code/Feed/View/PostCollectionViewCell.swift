//
//  PostCollectionViewCell.swift
//  CourseFinalTask
//
//  Created by Nikita on 18.12.2021.
//

import UIKit

protocol PostCollectionViewCellDelegate: AnyObject {
    func tapOnLike(_ sender: UITapGestureRecognizer)
    func tapOnBigLike(_ sender: UITapGestureRecognizer)
    func tapOnLikeLabel(_ sender: UITapGestureRecognizer)
    func tapOnProfile(_ sender: UITapGestureRecognizer)
}

class PostCollectionViewCell: UICollectionViewCell {
    
    var delegate: PostCollectionViewCellDelegate?

    var postProfileImage: UIImageView = {
        let image = UIImageView(frame: .zero)
        image.contentMode = .scaleAspectFit
        image.isUserInteractionEnabled = true
        
        return image
    }()
    
    var postProfileLabel: UILabel = {
        let label = UILabel()
        label.text = "postLabel"
        label.font = UIFont.systemFont(ofSize: 14, weight: .semibold)
        label.textColor = .black
        label.isUserInteractionEnabled = true
        
        return label
    }()
    
    var postDateLabel: UILabel = {
        let label = UILabel()
        label.text = "postDateLabel"
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .black
        
        return label
    }()
    
    private var dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .medium
        dateFormatter.locale = Locale(identifier: "en_US")
        
        return dateFormatter
    }()
    
    var postLikeLabel: UILabel = {
        let label = UILabel()
        label.text = "Likes: 0"
        label.font = UIFont.systemFont(ofSize: 14, weight: .semibold)
        label.textColor = .black
        label.isUserInteractionEnabled = true
        
        return label
    }()
    
    var postCommentLabel: UILabel = {
        let label = UILabel()
        label.text = "postCommentLabel"
        label.font = UIFont.systemFont(ofSize: 14)
        label.numberOfLines = 2
        label.textColor = .black
        
        return label
    }()
    
    var postLikeImage: UIImageView = {
        let image = UIImageView(image: UIImage(named: "like"))
        image.contentMode = .center
        image.tintColor = .lightGray
        image.isUserInteractionEnabled = true
        
        return image
    }()
    
    var postImage: UIImageView = {
        let image = UIImageView(frame: .zero)
        image.contentMode = .scaleAspectFit
        image.isUserInteractionEnabled = true
        
        return image
    }()
    
    var postBigLikeImage: UIImageView = {
        let image = UIImageView(frame: .zero)
        image.image = UIImage(named: "bigLike")
        image.layer.opacity = 0
        
        return image
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.addSubview(postProfileLabel)
        contentView.addSubview(postProfileImage)
        contentView.addSubview(postDateLabel)
        contentView.addSubview(postLikeLabel)
        contentView.addSubview(postLikeImage)
        contentView.addSubview(postCommentLabel)
        contentView.addSubview(postImage)
        contentView.addSubview(postBigLikeImage)
        
        setupConstraints()
        setupActions()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupConstraints() {
        var constraints = [NSLayoutConstraint]()
        
        postProfileImage.translatesAutoresizingMaskIntoConstraints = false
        postProfileLabel.translatesAutoresizingMaskIntoConstraints = false
        postDateLabel.translatesAutoresizingMaskIntoConstraints = false
        postImage.translatesAutoresizingMaskIntoConstraints = false
        postCommentLabel.translatesAutoresizingMaskIntoConstraints = false
        postLikeLabel.translatesAutoresizingMaskIntoConstraints = false
        postLikeImage.translatesAutoresizingMaskIntoConstraints = false
        postBigLikeImage.translatesAutoresizingMaskIntoConstraints = false
        
        let postProfileImageConstraint = [
            postProfileImage.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 15),
            postProfileImage.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            postProfileImage.widthAnchor.constraint(equalToConstant: 35),
            postProfileImage.heightAnchor.constraint(equalTo: postProfileImage.widthAnchor)
        ]
        
        let postProfileLabelConstraint = [
            postProfileLabel.topAnchor.constraint(equalTo: postProfileImage.topAnchor),
            postProfileLabel.leftAnchor.constraint(equalTo: postProfileImage.rightAnchor, constant: 8)
        ]
        
        let postDateLabelConstraint = [
            postDateLabel.leftAnchor.constraint(equalTo: postProfileLabel.leftAnchor),
            postDateLabel.bottomAnchor.constraint(equalTo: postImage.topAnchor, constant: -8)
        ]
        
        let postImageConstraint = [
            postImage.leftAnchor.constraint(equalTo: contentView.leftAnchor),
            postImage.topAnchor.constraint(equalTo: postProfileImage.bottomAnchor, constant: 8),
            postImage.widthAnchor.constraint(equalTo: contentView.widthAnchor),
            postImage.heightAnchor.constraint(equalTo: postImage.widthAnchor),
        ]
        
        let postLikeImageConstraint = [
            postLikeImage.topAnchor.constraint(equalTo: postImage.bottomAnchor),
            postLikeImage.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -16),
            postLikeImage.heightAnchor.constraint(equalToConstant: 44),
            postLikeImage.widthAnchor.constraint(equalTo: postLikeImage.heightAnchor)
        ]
        
        let postLikeLabelConstraint = [
            postLikeLabel.centerYAnchor.constraint(equalTo: postLikeImage.centerYAnchor),
            postLikeLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 16)
        ]
        
        let postCommentLabelConstraint = [
            postCommentLabel.leftAnchor.constraint(equalTo: postLikeLabel.leftAnchor),
            postCommentLabel.rightAnchor.constraint(equalTo: postLikeImage.rightAnchor),
            postCommentLabel.topAnchor.constraint(equalTo: postLikeImage.bottomAnchor),
            postCommentLabel.heightAnchor.constraint(equalToConstant: 44)
        ]
        
        let postBigLikeImageConstraint = [
            postBigLikeImage.centerXAnchor.constraint(equalTo: postImage.centerXAnchor),
            postBigLikeImage.centerYAnchor.constraint(equalTo: postImage.centerYAnchor)
        ]
        
        constraints.append(contentsOf: postProfileImageConstraint)
        constraints.append(contentsOf: postProfileLabelConstraint)
        constraints.append(contentsOf: postDateLabelConstraint)
        constraints.append(contentsOf: postImageConstraint)
        constraints.append(contentsOf: postCommentLabelConstraint)
        constraints.append(contentsOf: postLikeLabelConstraint)
        constraints.append(contentsOf: postLikeImageConstraint)
        constraints.append(contentsOf: postBigLikeImageConstraint)
        
        
        NSLayoutConstraint.activate(constraints)
    }
    
    private func setupActions() {
        let profileLabelGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(tapOnProfile))
        let profileImageGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(tapOnProfile))
        let bigLikeGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(tapOnBigLike))
        bigLikeGestureRecognizer.numberOfTapsRequired = 2
        let likeGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(tapOnLike))
        let likeLabelGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(tapOnLikeLabel))
        
        postProfileLabel.addGestureRecognizer(profileLabelGestureRecognizer)
        postProfileImage.addGestureRecognizer(profileImageGestureRecognizer)
        postImage.addGestureRecognizer(bigLikeGestureRecognizer)
        postLikeImage.addGestureRecognizer(likeGestureRecognizer)
        postLikeLabel.addGestureRecognizer(likeLabelGestureRecognizer)
    }
    
    func setDate(_ date: Date) {
        postDateLabel.text = dateFormatter.string(from: date)
    }
    
    @objc
    private func tapOnProfile(_ sender: UITapGestureRecognizer) {
        delegate?.tapOnProfile(sender)
    }
    
    @objc
    private func tapOnLike(_ sender: UITapGestureRecognizer) {
        delegate?.tapOnLike(sender)
    }
    
    @objc
    private func tapOnBigLike(_ sender: UITapGestureRecognizer) {
        delegate?.tapOnBigLike(sender)
    }
    
    @objc
    private func tapOnLikeLabel(_ sender: UITapGestureRecognizer) {
        delegate?.tapOnLikeLabel(sender)
    }
}
