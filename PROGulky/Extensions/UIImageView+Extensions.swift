//
//  UIImageView+Extensions.swift
//  PROGulky
//
//  Created by Сергей Киселев on 18.05.2023.
//

import UIKit

extension UIImageView {
    func downloadedFrom(link: String) {
        guard let url = URL(string: link) else {
            return
        }
        URLSession.shared.dataTask(with: url, completionHandler: { data, _, error in
            guard let data = data, error == nil, let image = UIImage(data: data) else {
                return
            }
            DispatchQueue.main.async { () in

                self.image = image
            }
        }).resume()
    }
}
