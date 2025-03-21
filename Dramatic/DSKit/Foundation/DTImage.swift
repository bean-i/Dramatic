//
//  DTImage.swift
//  Dramatic
//
//  Created by 김도형 on 3/21/25.
//

import UIKit

enum DTImage: String {
    case plusApp = "plus.app"
    case checkmarkSquareFill = "checkmark.square.fill"
    case eyeFill = "eye.fill"
    case pencilCircle = "pencil.circle"
    case starCircle = "star.circle"
    
    var uiImage: UIImage? {
        switch self {
        case .plusApp:
            return UIImage(systemName: rawValue)
        case .checkmarkSquareFill:
            return UIImage(systemName: rawValue)
        case .eyeFill:
            return UIImage(systemName: rawValue)
        case .pencilCircle:
            return UIImage(systemName: rawValue)
        case .starCircle:
            return UIImage(systemName: rawValue)
        }
    }
}

import SwiftUI

@available(iOS 17.0, *)
#Preview {
    VStack(spacing: 20) {
        HStack { Spacer() }
        Group {
            Image(uiImage: .dt(.plusApp)!)
                .resizable()
                .aspectRatio(contentMode: .fit)
            
            Image(uiImage: .dt(.checkmarkSquareFill)!)
                .resizable()
                .aspectRatio(contentMode: .fit)
            
            Image(uiImage: .dt(.eyeFill)!)
                .resizable()
                .aspectRatio(contentMode: .fit)
            
            Image(uiImage: .dt(.pencilCircle)!)
                .resizable()
                .aspectRatio(contentMode: .fit)
            
            Image(uiImage: .dt(.starCircle)!)
                .resizable()
                .aspectRatio(contentMode: .fit)
        }
        .frame(width: 40, height: 40)
    }
}
