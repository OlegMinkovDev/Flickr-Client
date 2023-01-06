//
//  InterestingListErrorView.swift
//  Flickr Client
//
//  Created by Oleh Minkov on 06.01.2023.
//

import UIKit

class InterestingListErrorView: UIView {
    
    let errorLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: UIScreen.main.bounds)
        
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        errorLabel.translatesAutoresizingMaskIntoConstraints = false
        errorLabel.textColor = .lightGray
        errorLabel.numberOfLines = 0
        errorLabel.textAlignment = .center
        
        addSubview(errorLabel)
        
        NSLayoutConstraint.activate([
            errorLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            errorLabel.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }
}
