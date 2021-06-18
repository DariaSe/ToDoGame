//
//  Colors.swift
//  ToDoGame
//
//  Created by Дарья Селезнёва on 19.05.2021.
//

import UIKit

extension UIColor {
    convenience init(red: Int, green: Int, blue: Int) {
        self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
    }
    convenience init(netHex:Int) {
        self.init(red:(netHex >> 16) & 0xff, green:(netHex >> 8) & 0xff, blue:netHex & 0xff)
    }
}

extension UIColor {
    
    static var backgroundColor: UIColor = UIColor.white
    static var borderColor: UIColor = UIColor.lightGray
    
    static var textColor: UIColor = UIColor.darkGray
    
    static var buttonColor: UIColor = UIColor.TagColors.darkGreen
    
    static var textControlsBGColor = UIColor(netHex: 0xF2F2F7)
    
    static var destructiveColor = UIColor(netHex: 0xbe4c48)
    
    struct TagColors {
        //1
        static let orange = UIColor(netHex: 0xf5932a)
        //2
        static let brickRed = UIColor(netHex: 0xb44d07)
        //3
        static let red = UIColor(netHex: 0xbe4c48)
        //4
        static let yellow = UIColor(netHex: 0xd8c55b)
        //5
        static let darkGreen = UIColor(netHex: 0x014f34)
        //6
        static let green = UIColor(netHex: 0x216367)
        //7
        static let mint = UIColor(netHex: 0x67bb9f)
        //8
        static let blue = UIColor(netHex: 0x23639a)
        //9
        static let purple = UIColor(netHex: 0x4c3e86)
        //10
        static let lilac = UIColor(netHex: 0x813d6f)
        //11
        static let gray = UIColor(netHex: 0x7b7b6a)
        //12
        static let brown = UIColor(netHex: 0x4b2828)
     
    }
    
    static var tagColors: [UIColor] { return [UIColor.TagColors.orange, UIColor.TagColors.brickRed, UIColor.TagColors.red, UIColor.TagColors.yellow, UIColor.TagColors.darkGreen, UIColor.TagColors.green, UIColor.TagColors.mint,  UIColor.TagColors.blue, UIColor.TagColors.purple, UIColor.TagColors.lilac, UIColor.TagColors.gray, UIColor.TagColors.brown] }

}


extension UIColor {
    static func randomTagColor() -> UIColor {
        let randomInt = Int.random(in: 0...11)
        return tagColors[randomInt]
    }
}

extension UIColor {
    static func tagColor(index: Int) -> UIColor {
        return tagColors[index]
    }
}
