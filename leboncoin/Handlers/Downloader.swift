//
//  Downloader.swift
//  leboncoin
//
//  Created by Kandara Marouene on 05/11/2022.
//

import Foundation
import UIKit

class Downloader {
    class func downloadImage(_ imageView : UIImageView, link: String, contentMode mode: UIView.ContentMode = .scaleAspectFit) {
        guard let url = URL(string: link) else { return }
        Downloader().downloadImage(imageView, url: url, contentMode: mode)
    }
    
    private func downloadImage(_ imageView : UIImageView, url: URL, contentMode mode: UIView.ContentMode = .scaleAspectFit) {
        imageView.contentMode = mode
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)
            else {
                DispatchQueue.main.async() { [weak imageView] in
                    imageView?.image = UIImage.init(named: "placehold")
                }
                return
            }
            DispatchQueue.main.async() { [weak imageView] in
                imageView?.image = image
            }
        }.resume()
    }
    
}
