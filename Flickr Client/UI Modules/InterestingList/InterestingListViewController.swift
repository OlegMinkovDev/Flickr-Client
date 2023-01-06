//
//  InterestingListViewController.swift
//  Flickr Client
//
//  Created by Oleh Minkov on 04.01.2023.
//

import UIKit

protocol InterestingListViewProtocol: AnyObject {
    
    func show(photos: [PhotoListViewModel])
    func show(loading: Bool)
    func show(error: String)
    func push(module viewController: UIViewController)
}

class InterestingListViewController: UIViewController {
    
    var presenter: InterestingListPresenterProtocol?
    
    private let tableView = UITableView()
    private let activityIndicatorView = UIActivityIndicatorView(style: .large)
    
    private var photos: [PhotoListViewModel] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        
        presenter?.viewIsLoaded()
    }
    
    private func setupViews() {
        view.backgroundColor = .white
        title = "Flickr's interestingness"
        
        activityIndicatorView.alpha = 1.0
        activityIndicatorView.tintColor = .gray
        activityIndicatorView.startAnimating()
        activityIndicatorView.hidesWhenStopped = true
        activityIndicatorView.translatesAutoresizingMaskIntoConstraints = false
        
        tableView.alpha = 0.0
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(InterestingListCell.self, forCellReuseIdentifier: "InterestingListCell")
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(activityIndicatorView)
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            activityIndicatorView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            activityIndicatorView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}

extension InterestingListViewController: InterestingListViewProtocol {
    
    func show(photos: [PhotoListViewModel]) {
        self.photos = photos
        self.tableView.reloadData()
    }
    
    func show(loading isVisible: Bool) {
        UIView.animate(withDuration: 0.25) {
            self.activityIndicatorView.alpha = isVisible ? 1.0 : 0.0
            self.tableView.alpha = isVisible ? 0.0 : 1.0
        }
    }
    
    func show(error: String) {
        let errorView = InterestingListErrorView()
        errorView.errorLabel.text = error
        
        tableView.backgroundView = errorView
    }
    
    func push(module viewController: UIViewController) {
        navigationController?.pushViewController(viewController, animated: true)
    }
}

extension InterestingListViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return photos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "InterestingListCell") as? InterestingListCell else { return UITableViewCell() }
    
        cell.photoView.image = photos[indexPath.row].image
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let height = CGFloat(photos[indexPath.row].height)
        let width = CGFloat(photos[indexPath.row].width)
        let ratio = height / width
        let screenWidth = UIScreen.main.bounds.width
        let cellHeight = screenWidth * ratio
        
        return cellHeight
    }
}

extension InterestingListViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter?.didSelectPhoto(by: indexPath.row)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
            let offsetY = scrollView.contentOffset.y
            let contentHeight = scrollView.contentSize.height

            if (offsetY > contentHeight - scrollView.frame.height) {
                presenter?.loadMorePhotos()
            }
        }
}
