//
//  SearchStep.swift
//  Dramatic
//
//  Created by 이빈 on 3/25/25.
//

import Foundation
import RxFlow

enum SearchStep: Step {
    case initialScreen
    case dramaDetail(id: Int)
}
