//
//  MovieListViewController.swift
//  MovieDB
//
//  Created by Rayo on 26/02/23.
//

import Kingfisher
import UIKit
import SnapKit

class MovieListViewController: UIViewController {
    
    // View
    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 172, height: 296)
        layout.minimumLineSpacing = 16
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .systemBackground
        collectionView.showsVerticalScrollIndicator = false
        return collectionView
    }()
    let refreshControl: UIRefreshControl = UIRefreshControl()
    var errorView: UIView = UIView()
    var errorLabel: UILabel = UILabel()
    
    // View Model
    let viewModel: MovieListViewModel = MovieListViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.getMovieList()
        view.backgroundColor = .systemBackground
        setupView()
        setupErrorView()
        setupConstraint()
        setupCallback()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        navigationController?.navigationBar.prefersLargeTitles = false
    }
    
    func setupView() {
        title = "Movie List"
        
        collectionView.register(MovieListCell.self, forCellWithReuseIdentifier: "Cell")
        collectionView.delegate = self
        collectionView.dataSource = self
        
        view.addSubview(collectionView)
        refreshControl.addTarget(self, action: #selector(didPullToRefresh(_:)), for: .valueChanged)
        collectionView.alwaysBounceVertical = true
        collectionView.refreshControl = refreshControl // iOS 10+
    }
    
    func setupErrorView() {
        view.addSubview(errorView)
        errorView.addSubview(errorLabel)
        errorView.backgroundColor = .systemBackground
        errorLabel.font = .systemFont(ofSize: 16, weight: .medium)
        errorLabel.textAlignment = .center
        errorLabel.numberOfLines = 0
        
        setupErrorConstraint()
    }
    
    func setupConstraint() {
        collectionView.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
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
    }
    
    func setupCallback() {
        viewModel.didGetData = { [weak self] in
            self?.collectionView.reloadData()
            self?.refreshControl.endRefreshing()
        }

        viewModel.updateErrorView = { [weak self] in
            guard let self = self else { return }
            let isHidden = self.viewModel.getErrorMessage().isEmpty
            self.toggleErrorView(isHidden: isHidden)
        }
    }
    
    @objc private func didPullToRefresh(_ sender: Any) {
        viewModel.refresh()
    }
    
    func toggleErrorView(isHidden: Bool) {
        errorView.isHidden = isHidden
        errorLabel.text = viewModel.getErrorMessage()
    }
}

extension MovieListViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.getListCount()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView
            .dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as? MovieListCell else {
            return UICollectionViewCell()
        }
        
        guard let movies = viewModel.getMoviesData() else { return cell }
        
        let movie = movies[indexPath.row]
        cell.populate(imageURL: movie.posterPath, title: movie.title ?? "")
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        guard let movies = viewModel.getMoviesData() else { return }
        let movie = movies[indexPath.row]
        guard let movieID = movie.id else { return }
        
        let viewController = MovieDetailViewController()
        viewController.setMovieID(id: movieID)
        navigationController?.pushViewController(viewController, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if indexPath.row == viewModel.getListCount() - 5 {
            viewModel.loadNextPage()
        }
    }
}
