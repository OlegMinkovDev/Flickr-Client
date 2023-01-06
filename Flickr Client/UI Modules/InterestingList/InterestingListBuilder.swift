//
//  InterestingListBuilder.swift
//  Flickr Client
//
//  Created by Oleh Minkov on 05.01.2023.
//

import UIKit

class InterestingListBuilder {
    
    static func createModule() -> UIViewController {
        let model = InterestingListModel()
        let presenter = InterestingListPresenter(model: model)
        let view = InterestingListViewController()
        
        view.presenter = presenter
        presenter.view = view
        
        let navigation = UINavigationController(rootViewController: view)
        
        return navigation
    }
}
