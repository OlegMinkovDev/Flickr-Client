//
//  InterestingDetailsModel.swift
//  Flickr Client
//
//  Created by Oleh Minkov on 06.01.2023.
//

import UIKit

protocol InterestingDetailsModelProtocol {
    
    var image: UIImage { get set }
    var title: String { get set }
}

class InterestingDetailsModel: InterestingDetailsModelProtocol {

    var image: UIImage = UIImage()
    var title: String = ""
}
