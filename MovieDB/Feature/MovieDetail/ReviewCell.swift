//
//  ReviewCell.swift
//  MovieDB
//
//  Created by Rayo on 27/02/23.
//

import UIKit
import SnapKit

class ReviewCell: UICollectionViewCell {
    // View
    var containerView: UIView = UIView()
    var authorAvatar: UIImageView = UIImageView()
    var authorNameLabel: UILabel = UILabel()
    var scoreLabel: UILabel = UILabel()
    var reviewLabel: UILabel = UILabel()

    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
        setupView()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
        setupView()
    }

    func commonInit() {
        contentView.addSubview(containerView)
        containerView.addSubview(authorAvatar)
        containerView.addSubview(authorNameLabel)
        containerView.addSubview(scoreLabel)
        containerView.addSubview(reviewLabel)

        setupConstraints()
        layoutIfNeeded()
    }

    func setupView() {
        
        containerView.backgroundColor = .systemBackground
        containerView.layer.cornerRadius = 16
        containerView.layer.borderColor = UIColor.tertiaryLabel.cgColor
        containerView.layer.borderWidth = 1
        
        authorAvatar.layer.cornerRadius = 16
        authorAvatar.clipsToBounds = true

        authorNameLabel.font = .systemFont(ofSize: 18, weight: .medium)
        authorNameLabel.numberOfLines = 1
        
        scoreLabel.font = .systemFont(ofSize: 16, weight: .regular)
        scoreLabel.numberOfLines = 1
        
        reviewLabel.font = .systemFont(ofSize: 16, weight: .regular)
        reviewLabel.numberOfLines = 0

        layoutIfNeeded()
    }

    func setupConstraints() {
        containerView.snp.makeConstraints { make in
            make.center.size.equalToSuperview()
        }
        
        authorAvatar.snp.makeConstraints { make in
            make.top.leading.equalToSuperview().offset(16)
            make.height.width.equalTo(32)
        }
        
        authorNameLabel.snp.makeConstraints { make in
            make.centerY.equalTo(authorAvatar.snp.centerY)
            make.leading.equalTo(authorAvatar.snp.trailing).offset(16)
            make.trailing.equalToSuperview().offset(-16)
        }
        
        scoreLabel.snp.makeConstraints { make in
            make.top.equalTo(authorAvatar.snp.bottom).offset(16)
            make.leading.equalTo(containerView).offset(16)
            make.trailing.equalTo(containerView).offset(-16)
            make.height.equalTo(20)
        }
        
        reviewLabel.snp.makeConstraints { make in
            make.top.equalTo(scoreLabel.snp.bottom).offset(16)
            make.leading.equalTo(containerView).offset(16)
            make.trailing.equalTo(containerView).offset(-16)
            make.bottom.equalTo(containerView).offset(-16)
        }
    }

    func populate(avatarURL: String?, authorName: String, score: String, review: String) {
        
        if let imageURL = avatarURL {
            let url = URL(string: "http://image.tmdb.org/t/p/w500\(imageURL)")
            authorAvatar.kf.setImage(with: url)
        }
        
        authorNameLabel.text = authorName
        scoreLabel.text = "Rating: \(score)"
        reviewLabel.text = review
        
    }
}

