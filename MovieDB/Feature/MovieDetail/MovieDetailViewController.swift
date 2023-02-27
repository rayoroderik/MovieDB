//
//  MovieDetailViewController.swift
//  MovieDB
//
//  Created by Rayo on 26/02/23.
//

import UIKit
import youtube_ios_player_helper

class MovieDetailViewController: UIViewController {
    
    // View
    var scrollView: UIScrollView = UIScrollView()
    var contentView: UIView = UIView()
    var imageView: UIImageView = UIImageView()
    var titleLabel: UILabel = UILabel()
    var synopsisTitleLabel: UILabel = UILabel()
    var synopsisLabel: UILabel = UILabel()
    var errorView: UIView = UIView()
    var errorLabel: UILabel = UILabel()
    
    var reviewTitleLabel: UILabel = UILabel()
    var reviewCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: 320, height: 240)
        layout.minimumInteritemSpacing = 32
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .systemBackground
        collectionView.showsHorizontalScrollIndicator = false
        return collectionView
    }()
    var reviewErrorView: UIView = UIView()
    var reviewErrorLabel: UILabel = UILabel()
    
    var trailerTitleLabel: UILabel = UILabel()
    var youtubePlayer: YTPlayerView = YTPlayerView()
    var trailerErrorView: UIView = UIView()
    var trailerErrorLabel: UILabel = UILabel()
    
    // View Model
    let viewModel: MovieDetailViewModel = MovieDetailViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.getMovieDetail()
        setupView()
        setupErrorView()
        setupConstraint()
        setupCallback()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.navigationBar.prefersLargeTitles = false
    }
    
    func setupView() {
        title = "Movie Detail"
        view.backgroundColor = .systemBackground
        
        reviewCollectionView.register(ReviewCell.self, forCellWithReuseIdentifier: "Cell")
        reviewCollectionView.delegate = self
        reviewCollectionView.dataSource = self
        
        view.addSubview(scrollView)
        contentView.addSubview(imageView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(synopsisTitleLabel)
        contentView.addSubview(synopsisLabel)
        contentView.addSubview(reviewTitleLabel)
        contentView.addSubview(reviewCollectionView)
        contentView.addSubview(trailerTitleLabel)
        contentView.addSubview(youtubePlayer)
        scrollView.addSubview(contentView)
        
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        
        titleLabel.font = .systemFont(ofSize: 24, weight: .medium)
        titleLabel.numberOfLines = 1
        titleLabel.textColor = .label
        titleLabel.clipsToBounds = false
        
        synopsisTitleLabel.font = .systemFont(ofSize: 20, weight: .medium)
        synopsisTitleLabel.numberOfLines = 1
        synopsisTitleLabel.text = "Synopsis"
        
        synopsisLabel.font = .systemFont(ofSize: 16, weight: .regular)
        synopsisLabel.numberOfLines = 0
        
        reviewTitleLabel.font = .systemFont(ofSize: 20, weight: .medium)
        reviewTitleLabel.numberOfLines = 1
        reviewTitleLabel.text = "Review"
        
        reviewCollectionView.clipsToBounds = false
        
        trailerTitleLabel.font = .systemFont(ofSize: 20, weight: .medium)
        trailerTitleLabel.numberOfLines = 1
        trailerTitleLabel.text = "Trailer"
        
        youtubePlayer.layer.cornerRadius = 16
        youtubePlayer.clipsToBounds = true
        youtubePlayer.delegate = self
    }
    
    func setupErrorView() {
        view.addSubview(errorView)
        errorView.addSubview(errorLabel)
        
        contentView.addSubview(reviewErrorView)
        reviewErrorView.addSubview(reviewErrorLabel)
        
        contentView.addSubview(trailerErrorView)
        trailerErrorView.addSubview(trailerErrorLabel)
        
        errorView.backgroundColor = .systemBackground
        errorLabel.font = .systemFont(ofSize: 16, weight: .medium)
        errorLabel.textAlignment = .center
        errorLabel.numberOfLines = 0
        
        reviewErrorView.backgroundColor = .systemBackground
        reviewErrorLabel.font = .systemFont(ofSize: 16, weight: .medium)
        reviewErrorLabel.textAlignment = .center
        reviewErrorLabel.numberOfLines = 1
        reviewErrorLabel.text = "No Review Found."
        
        trailerErrorView.backgroundColor = .systemBackground
        trailerErrorLabel.font = .systemFont(ofSize: 16, weight: .medium)
        trailerErrorLabel.textAlignment = .center
        trailerErrorLabel.numberOfLines = 1
        trailerErrorLabel.text = "No Trailer Found."
        
        setupErrorConstraint()
    }
    
    func setupConstraint() {
        scrollView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        contentView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            make.width.equalToSuperview()
        }
        
        imageView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.trailing.equalToSuperview()
            make.width.equalToSuperview()
            make.height.equalTo(contentView.snp.width).multipliedBy(1.5)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(imageView.snp.bottom).offset(16)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.height.equalTo(28)
        }
        
        synopsisTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(16)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.height.equalTo(24)
        }
        
        synopsisLabel.snp.makeConstraints { make in
            make.top.equalTo(synopsisTitleLabel.snp.bottom).offset(16)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.height.equalTo(80)
        }
        
        reviewTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(synopsisLabel.snp.bottom).offset(16)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.height.equalTo(24)
        }
        
        reviewCollectionView.snp.makeConstraints { make in
            make.top.equalTo(reviewTitleLabel.snp.bottom).offset(16)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.height.equalTo(240)
        }
        
        trailerTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(reviewCollectionView.snp.bottom).offset(16)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.height.equalTo(24)
        }
        
        youtubePlayer.snp.makeConstraints { make in
            make.top.equalTo(trailerTitleLabel.snp.bottom).offset(16)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.height.equalTo(contentView.snp.width).dividedBy(1.778)
            make.bottom.equalToSuperview().offset(-16)
        }
    }
    
    func setupErrorConstraint() {
        errorView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        errorLabel.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
        }
        
        reviewErrorView.snp.makeConstraints { make in
            make.edges.equalTo(reviewCollectionView)
        }
        
        reviewErrorLabel.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
        }
        
        trailerErrorView.snp.makeConstraints { make in
            make.edges.equalTo(youtubePlayer)
        }
        
        trailerErrorLabel.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
        }
    }
    
    func setupCallback() {
        viewModel.didGetData = { [weak self] in
            self?.updateView()
        }

        viewModel.updateErrorView = { [weak self] in
            guard let self = self else { return }
            let isHidden = self.viewModel.getErrorMessage().isEmpty
            self.toggleErrorView(isHidden: isHidden)
        }
    }
    
    func setMovieID(id: Int) {
        viewModel.setMovieID(id: id)
    }
    
    func updateView() {
        guard let movie = viewModel.getMovie(),
              let imageURL = movie.posterPath,
              let movieTitle = movie.title,
              let synopsis = movie.overview else { return }
        
        let url = URL(string: "http://image.tmdb.org/t/p/w500\(imageURL)")
        imageView.kf.setImage(with: url)
        
        titleLabel.text = movieTitle
        synopsisLabel.text = synopsis
        youtubePlayer.load(withVideoId: viewModel.getVideoID() ?? "")
        
        reviewCollectionView.reloadData()
    }
    
    func toggleErrorView(isHidden: Bool) {
        errorView.isHidden = isHidden
        errorLabel.text = viewModel.getErrorMessage()
        
        reviewErrorView.isHidden = !(viewModel.getReviews() ?? []).isEmpty
        trailerErrorView.isHidden = !(viewModel.getVideoID() ?? "").isEmpty
    }
}

extension MovieDetailViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.getReviewsCount()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView
            .dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as? ReviewCell else {
            return UICollectionViewCell()
        }
        
        guard let reviews = viewModel.getReviews() else { return cell }
        
        let review = reviews[indexPath.row]
        var scoreString = "-"
        if let score = review.authorDetails?.rating {
            scoreString = "\(score)"
        }
            
        cell.populate(avatarURL: review.authorDetails?.avatarPath,
                      authorName: review.author ?? "",
                      score: scoreString,
                      review: review.content ?? "")
        return cell
    }
}

extension MovieDetailViewController: YTPlayerViewDelegate {
    
}
