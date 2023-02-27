//
//  MovieListCell.swift
//  MovieDB
//
//  Created by Rayo on 26/02/23.
//

import UIKit
import SnapKit

class MovieListCell: UICollectionViewCell {
    // View
    var containerView: UIView = UIView()
    var movieImageView: UIImageView = UIImageView()
    var movieTitleLabel: UILabel = UILabel()

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
        containerView.addSubview(movieImageView)
        containerView.addSubview(movieTitleLabel)

        setupConstraints()
        layoutIfNeeded()
    }

    func setupView() {
        containerView.backgroundColor = .systemBackground
        
        movieImageView.layer.cornerRadius = 16
        movieImageView.clipsToBounds = true

        movieTitleLabel.font = .systemFont(ofSize: 18, weight: .medium)
        movieTitleLabel.numberOfLines = 1

        layoutIfNeeded()
    }

    func setupConstraints() {
        containerView.snp.makeConstraints { make in
            make.center.size.equalToSuperview()
        }
        
        movieImageView.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
            make.height.equalTo(240)
        }
        
        movieTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(movieImageView.snp.bottom).offset(8)
            make.leading.equalTo(containerView).offset(8)
            make.trailing.equalTo(containerView).offset(-8)
            make.bottom.equalTo(containerView).offset(-16)
            
        }
    }

    func populate(imageURL: String?, title: String) {
        
        if let imageURL = imageURL {
            let url = URL(string: "http://image.tmdb.org/t/p/w500\(imageURL)")
            movieImageView.kf.setImage(with: url)
        }
        
    
        movieTitleLabel.text = title
    }
}
