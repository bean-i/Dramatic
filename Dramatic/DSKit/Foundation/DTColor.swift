//
//  DTColor.swift
//  Dramatic
//
//  Created by 김도형 on 3/21/25.
//

import UIKit

enum DTColor {
    case primitive(Primitive)
    case semantic(Semantic)
    
    var uiColor: UIColor {
        switch self {
        case .primitive(let primitive):
            return primitive.uiColor
        case .semantic(let semantic):
            return semantic.uiColor
        }
    }
}

extension DTColor {
    enum Primitive {
        case black
        case gray
        case white
        case yellow
        
        var uiColor: UIColor {
            switch self {
            case .black: return .dtBlack
            case .gray: return .dtGray
            case .white: return .dtWhite
            case .yellow: return .dtYellow
            }
        }
    }
    
    enum Semantic {
        case bg(Scale)
        case text(Scale)
        case border(Scale)
        case icon(Scale)
        
        enum Scale {
            case brand
            case primary
            case secondary
            case tertiary
        }
        
        var uiColor: UIColor {
            switch self {
            case .bg(let scale):
                switch scale {
                case .brand: return Primitive.yellow.uiColor
                case .primary: return Primitive.black.uiColor
                case .secondary: return Primitive.gray.uiColor
                case .tertiary: return Primitive.white.uiColor
                }
            case .text(let scale):
                switch scale {
                case .brand: return Primitive.yellow.uiColor
                case .primary: return Primitive.white.uiColor
                case .secondary: return Primitive.gray.uiColor
                case .tertiary: return Primitive.black.uiColor
                }
            case .border(let scale):
                switch scale {
                case .brand: return Primitive.yellow.uiColor
                case .primary: return Primitive.white.uiColor
                case .secondary: return Primitive.gray.uiColor
                case .tertiary: return Primitive.black.uiColor
                }
            case .icon(let scale):
                switch scale {
                case .brand: return Primitive.yellow.uiColor
                case .primary: return Primitive.white.uiColor
                case .secondary: return Primitive.gray.uiColor
                case .tertiary: return Primitive.black.uiColor
                }
            }
        }
    }
}

import SwiftUI

@available(iOS 17.0, *)
#Preview {
    List {
        Section {
            Text("background")
            Color(uiColor: .dt(.semantic(.bg(.brand))))
            Color(uiColor: .dt(.semantic(.bg(.primary))))
            Color(uiColor: .dt(.semantic(.bg(.secondary))))
            Color(uiColor: .dt(.semantic(.bg(.tertiary))))
        }
        
        
        Section {
            Text("text")
            Color(uiColor: .dt(.semantic(.text(.brand))))
            Color(uiColor: .dt(.semantic(.text(.primary))))
            Color(uiColor: .dt(.semantic(.text(.secondary))))
            Color(uiColor: .dt(.semantic(.text(.tertiary))))
        }
        
        
        Section {
            Text("border")
            Color(uiColor: .dt(.semantic(.border(.brand))))
            Color(uiColor: .dt(.semantic(.border(.primary))))
            Color(uiColor: .dt(.semantic(.border(.secondary))))
            Color(uiColor: .dt(.semantic(.border(.tertiary))))
        }
        
        
        Section {
            Text("icon")
            Color(uiColor: .dt(.semantic(.icon(.brand))))
            Color(uiColor: .dt(.semantic(.icon(.primary))))
            Color(uiColor: .dt(.semantic(.icon(.secondary))))
            Color(uiColor: .dt(.semantic(.icon(.tertiary))))
        }
    }
}
