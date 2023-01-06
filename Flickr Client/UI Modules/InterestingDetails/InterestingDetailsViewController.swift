//
//  InterestingDetailsViewController.swift
//  Flickr Client
//
//  Created by Oleh Minkov on 06.01.2023.
//

import UIKit

protocol InterestingDetailsViewProtocol: AnyObject {
    
    func show(image: UIImage)
    func show(title: String)
}

class InterestingDetailsViewController: UIViewController {
    
    var presenter: InterestingDetailsPresenterProtocol?
    
    private let photoView = UIImageView()
    private let label = UILabel()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        
        presenter?.viewIsLoaded()
    }
    
    private func setupViews() {
        view.backgroundColor = .white
        title = "Interestingness details"
        
        photoView.contentMode = .scaleAspectFit
        photoView.translatesAutoresizingMaskIntoConstraints = false
        
        label.font = .systemFont(ofSize: 20.0, weight: .medium)
        label.numberOfLines = 0
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(photoView)
        view.addSubview(label)
        
        NSLayoutConstraint.activate([
            photoView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            photoView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            photoView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            photoView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.3),
            
            label.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16.0),
            label.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16.0),
            label.topAnchor.constraint(equalTo: photoView.bottomAnchor, constant: 16.0)
        ])
    }
}

extension InterestingDetailsViewController: InterestingDetailsViewProtocol {
    
    func show(image: UIImage) {
        photoView.image = image
    }
    
    func show(title: String) {
        label.text = title
    }
}
