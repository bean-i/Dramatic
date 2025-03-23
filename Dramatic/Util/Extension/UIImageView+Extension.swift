//
//  UIImageView+.swift
//  Dramatic
//
//  Created by 이빈 on 3/21/25.
//

import UIKit

extension UIImageView {
    
    func setImage(with url: String?) {
        guard let url,
              let imageUrl = URL(string: url) else { return }
        
        ImageClient.shared.requestImage(with: imageUrl) { response in
            switch response {
            case .success(let data):
                self.image = UIImage(data: data)
            case .failure(_):
                self.image = UIImage(systemName: "arrow.down.app.dashed.trianglebadge.exclamationmark")
            }
        }
    }
    
}
