//
//  DraggableViewsCoordinator.swift
//  ToDoGame
//
//  Created by Дарья Селезнёва on 21.08.2021.
//

import UIKit

class DraggableViewsCoordinator {
    
    var contentView: UIView
    var upperView: UIView
    var lowerView: UIView
    
    var distance: CGFloat
    
    let panGestureRecognizer = UIPanGestureRecognizer()
    
    var showFullWidth: Bool = false
    
    init(contentView: UIView, upperView: UIView, lowerView: UIView, distance: CGFloat) {
        self.contentView = contentView
        self.upperView = upperView
        self.lowerView = lowerView
        self.distance = distance
        upperView.addGestureRecognizer(panGestureRecognizer)
        panGestureRecognizer.addTarget(self, action: #selector(dragged(sender:)))
    }
    
    @objc func dragged(sender: UIPanGestureRecognizer) {
        print("gets called")
        if sender.state == .changed {
            let translation = sender.translation(in: self.contentView)
            upperView.center = CGPoint(x: upperView.center.x + translation.x, y: upperView.center.y)
            let positionAdjustment = abs(self.contentView.center.x - upperView.center.x)
            lowerView.center = CGPoint(x: lowerView.center.x + translation.x, y: lowerView.center.y)
            sender.setTranslation(CGPoint.zero, in: self.contentView)
            showFullWidth = positionAdjustment > (distance / 2)
        }
        if sender.state == .ended {
            if showFullWidth {
                UIView.animate(withDuration: 0.2, delay: 0.1, options: [.curveEaseOut], animations: {
                    self.upperView.frame = CGRect(x: self.distance, y: 0, width: self.upperView.frame.width, height: self.upperView.frame.height)
                    self.lowerView.frame = CGRect(x: self.contentView.frame.width - self.lowerView.frame.width, y: 0, width: self.lowerView.frame.width, height: self.lowerView.frame.height)
                }, completion: nil)
            }
            else {
                restoreFrame()
            }
        }
        else {
            restoreFrame()
        }
    }
    
    func restoreFrame() {
        UIView.animate(withDuration: 0.3, delay: 0.1, options: [.curveEaseOut], animations: {
            self.upperView.frame = CGRect(x: 0, y: 0, width: self.upperView.frame.width, height: self.upperView.frame.height)
            self.lowerView.frame = CGRect(x: self.contentView.frame.width, y: 0, width: self.lowerView.frame.width, height: self.lowerView.frame.height)
        }, completion: nil)
    }
}

