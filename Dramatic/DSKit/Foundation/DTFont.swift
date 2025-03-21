//
//  DTFont.swift
//  Dramatic
//
//  Created by 김도형 on 3/21/25.
//

import UIKit

enum DTFont {
    case largeTitle
    case title
    case headline
    case body
    
    var uiFont: UIFont {
        switch self {
        case .largeTitle:
            return .systemFont(ofSize: 24, weight: .bold)
        case .title:
            return .systemFont(ofSize: 24, weight: .medium)
        case .headline:
            return .systemFont(ofSize: 17, weight: .bold)
        case .body:
            return .systemFont(ofSize: 15, weight: .regular)
        }
    }
}

import SwiftUI

@available(iOS 17.0, *)
#Preview {
    VStack(spacing: 20) {
        HStack { Spacer() }
        
        Spacer()
        
        Text("LargeTitle")
            .font(Font(UIFont.dt(.largeTitle)))
            .foregroundStyle(Color(uiColor: .dt(.semantic(.text(.primary)))))
        
        Text("Title")
            .font(Font(UIFont.dt(.title)))
            .foregroundStyle(Color(uiColor: .dt(.semantic(.text(.primary)))))
        
        Text("Headline")
            .font(Font(UIFont.dt(.headline)))
            .foregroundStyle(Color(uiColor: .dt(.semantic(.text(.primary)))))
        
        Text("Body")
            .font(Font(UIFont.dt(.body)))
            .foregroundStyle(Color(uiColor: .dt(.semantic(.text(.primary)))))
        
        Group {
            var text: NSAttributedString = .dt(
            """
            Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Nisl tincidunt eget nullam non. Quis hendrerit dolor magna eget est lorem ipsum dolor sit. Volutpat odio facilisis mauris sit amet massa. Commodo odio aenean sed adipiscing diam donec adipiscing tristique. Mi eget mauris pharetra et. Non tellus orci ac auctor augue. Elit at imperdiet dui accumsan sit. Ornare arcu dui vivamus arcu felis. Egestas integer eget aliquet nibh praesent. In hac habitasse platea dictumst quisque sagittis purus. Pulvinar elementum integer enim neque volutpat ac.
            """,
            font: .largeTitle,
            attributes: [.foregroundColor: UIColor.dt(.primitive(.yellow))],
            at: "ipsum", "sit"
            )
            Text(AttributedString(text))
                .font(Font(UIFont.dt(.body)))
                .foregroundStyle(Color(uiColor: .dt(.semantic(.text(.secondary)))))
        }
        
        Spacer()
    }
    .background(Color(uiColor: .dt(.semantic(.bg(.primary)))))
}
