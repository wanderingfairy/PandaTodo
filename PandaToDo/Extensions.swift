//
//  Extensions.swift
//  PandaToDo
//
//  Created by 정의석 on 2020/02/12.
//  Copyright © 2020 pandaman. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
    func addSubviews(_ views: [UIView]) {
        views.forEach { addSubview($0) }
    }
}
