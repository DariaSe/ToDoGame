//
//  GradientViewController.swift
//  ToDoGame
//
//  Created by Дарья Селезнёва on 21.08.2021.
//

import UIKit

class GradientViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setGradientBackground()
    }
    
    func setGradientBackground() {
        let startColor =  UIColor.startGradientColor.cgColor
        let middleColor = UIColor.middleGradientColor.cgColor
        let endColor = UIColor.endGradientColor.cgColor
                    
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [startColor, middleColor, endColor]
        gradientLayer.locations = [0.05, 0.45, 0.95]
        gradientLayer.frame = CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.height)
        self.view.layer.insertSublayer(gradientLayer, at:0)
    }
    
    override func viewWillAppear(_ animated: Bool) {
       
        super.viewWillAppear(animated)
    }
}
