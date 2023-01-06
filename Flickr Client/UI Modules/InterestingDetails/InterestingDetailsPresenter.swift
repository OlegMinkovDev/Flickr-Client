//
//  InterestingDetailsPresenter.swift
//  Flickr Client
//
//  Created by Oleh Minkov on 06.01.2023.
//

import Foundation
import UIKit.UIImage

protocol InterestingDetailsPresenterProtocol {
    
    func viewIsLoaded()
}

class InterestingDetailsPresenter {
    
    weak var view: InterestingDetailsViewProtocol?
    var model: InterestingDetailsModelProtocol
    
    init(model: InterestingDetailsModelProtocol) {
        self.model = model
    }
}

extension InterestingDetailsPresenter: InterestingDetailsPresenterProtocol {
    
    func viewIsLoaded() {
        view?.show(image: model.image)
        view?.show(title: model.title)
    }
}
