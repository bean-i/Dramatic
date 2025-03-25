//
//  DramaDetailStep.swift
//  Dramatic
//
//  Created by 이빈 on 3/25/25.
//

import Foundation
import RxFlow

enum DramaDetailStep: Step {
    case initialScreen(id: Int)
    case seasonDetail(info: Season)
}
