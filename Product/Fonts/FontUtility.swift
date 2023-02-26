//
//  FontUtility.swift
//  Product
//
//  Created by Sangat Baral on 26/02/23.
//

import Foundation
import UIKit


extension UIFont {
    static func latoBlack(size: CGFloat) -> UIFont {
        return UIFont.init(name: "Lato-Black", size: size)!
    }
    
    static func latoBold(size: CGFloat) -> UIFont {
        return UIFont.init(name: "Lato-Bold", size: size)!
    }
    
    static func latoRegular(size: CGFloat) -> UIFont {
        return UIFont.init(name: "Lato-Regular", size: size)!
    }
    
    static func latoLight(size: CGFloat) -> UIFont {
        return UIFont.init(name: "Lato-Light", size: size)!
    }
}
