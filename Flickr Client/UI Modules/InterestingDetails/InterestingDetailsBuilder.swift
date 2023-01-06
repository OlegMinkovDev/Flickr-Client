//
//  InterestingDetailsBuilder.swift
//  Flickr Client
//
//  Created by Oleh Minkov on 06.01.2023.
//

import UIKit

class InterestingDetailsBuilder {
    
    static func createModule(image: UIImage, title: String) -> UIViewController {
        let model = InterestingDetailsModel()
        model.image = image
        model.title = title
        
        let presenter = InterestingDetailsPresenter(model: model)
        let view = InterestingDetailsViewController()
        
        view.presenter = presenter
        presenter.view = view
        
        return view
    }
}
