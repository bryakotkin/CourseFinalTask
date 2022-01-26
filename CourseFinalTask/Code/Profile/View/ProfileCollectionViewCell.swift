//
//  ProfileCollectionViewCell.swift
//  CourseFinalTask
//
//  Created by Nikita on 21.12.2021.
//

import UIKit

class ProfileCollectionViewCell: UICollectionViewCell {
    
    let imageView = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.addSubview(imageView)
        
        setupConstraint()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupConstraint() {
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        let imageViewConstraint = [
            imageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            imageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            imageView.widthAnchor.constraint(equalToConstant: contentView.bounds.width),
            imageView.heightAnchor.constraint(equalToConstant: contentView.bounds.height),
        ]
        
        NSLayoutConstraint.activate(imageViewConstraint)
    }
}
