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
        case background(Scale)
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
            case .background(let scale):
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
