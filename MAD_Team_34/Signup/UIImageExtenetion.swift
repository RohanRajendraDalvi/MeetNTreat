//
//  UIImageExtenetion.swift
//  MAD_Team_34
//
//  Created by Student 2 on 11/15/25.
//

import UIKit

extension UIImage {
    func fixOrientationAndResize(maxDimension: CGFloat) -> UIImage {
        let maxSide = max(size.width, size.height)
        let scale = maxSide > maxDimension ? (maxDimension / maxSide) : 1.0
        let newSize = CGSize(width: size.width * scale, height: size.height * scale)

        UIGraphicsBeginImageContextWithOptions(newSize, false, 0.8)
        draw(in: CGRect(origin: .zero, size: newSize))
        let resized = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return resized ?? self
    }
}
