//
//  NYTimesColor.swift
//  NYTimesApp
//
//  Created by Muhammad Iqbal on 02/02/2025.
//

import UIKit
import SwiftUI

enum NYTimesColor: String {
    case articleTitleColor = "articleTitleColor"
    case subTitleColor = "subTitleColor"
    case buttonBackgroundColor = "buttonBackgroundColor"
    case buttonTitleColor = "buttonTitleColor"
    
    var color: Color {
        Color(rawValue)
    }
    var uiColor: UIColor {
        UIColor(named: rawValue) ?? .red
    }
}
