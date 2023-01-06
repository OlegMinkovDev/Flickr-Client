//
//  InterestingListPresenter.swift
//  Flickr Client
//
//  Created by Oleh Minkov on 05.01.2023.
//

import Foundation
import UIKit.UIImage

struct PhotoListViewModel {
    
    let image: UIImage
    let height: Int
    let width: Int
}

protocol InterestingListPresenterProtocol {
    
    func viewIsLoaded()
    func loadMorePhotos()
    func didSelectPhoto(by: Int)
}

class InterestingListPresenter {
    
    weak var view: InterestingListViewProtocol?
    var model: InterestingListModelProtocol
    
    private var photosViewModel: [PhotoListViewModel] = []
    private var isLoading = false
    
    init(model: InterestingListModelProtocol) {
        self.model = model
    }
    
    private func getInterestingPhotos(page: Int) {
        isLoading = true
        model.getInterestingList(page: page) { [weak self] result in
            self?.isLoading = false

            switch result {
            case let .success(response):
                self?.handle(response)
            case let .failure(error):
                DispatchQueue.main.async { [weak self] in
                    self?.view?.show(loading: false)
                    self?.view?.show(error: error.localizedDescription)
                }
            }
        }
    }
    
    private func handle(_ response: PhotosResponse) {
        model.photos.append(contentsOf: response.photos.photo)
        model.page = response.photos.page
        model.pages = response.photos.pages
        
        DispatchQueue.global().async { [weak self] in
            for photo in response.photos.photo {
                guard let url = URL(string: photo.url),
                      let data = try? Data(contentsOf: url),
                      let image = UIImage(data: data) else { return }
                
                self?.photosViewModel.append(PhotoListViewModel(image: image, height: photo.height, width: photo.width))
            }
            
            DispatchQueue.main.async { [weak self] in
                guard let self = self else { return }
                
                self.view?.show(loading: false)
                self.view?.show(photos: self.photosViewModel)
            }
        }
    }
}

extension InterestingListPresenter: InterestingListPresenterProtocol {
    
    func viewIsLoaded() {
        view?.show(loading: true)
        getInterestingPhotos(page: model.page)
    }
    
    func loadMorePhotos() {
        if model.page < model.pages, !isLoading {
            model.page += 1
            getInterestingPhotos(page: model.page)
        }
    }
    
    func didSelectPhoto(by index: Int) {
        let image = photosViewModel[index].image
        let title = model.photos[index].title
        
        let module = InterestingDetailsBuilder.createModule(image: image, title: title)
        view?.push(module: module)
    }
}
