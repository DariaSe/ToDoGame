//
//  SingleTaskViewController.swift
//  ToDoGame
//
//  Created by Дарья Селезнёва on 07.05.2021.
//

import UIKit

class SingleTaskViewController: UIViewController, KeyboardHandler {
    
    weak var coordinator: SingleTaskCoordinator?
    
    var task: Task? {
        didSet {
            if let task = task {
                taskInputView.update(with: task)
            }
        }
    }
    
    let topLabel = UILabel()
    let closeButton = UIButton()
    
    let scrollView = UIScrollView()
    
    let taskInputView = TaskInputView()

    let shadowingView = UIView()
    let dropdownMenu = DropdownView()
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.backgroundColor
        registerForKeyboardNotifications(for: scrollView)
        
        view.pinToLayoutMargins(subview: scrollView)
        scrollView.pinToLayoutMargins(subview: topLabel, top: 10, bottom: nil)
        scrollView.pinToLayoutMargins(subview: closeButton, leading: nil, trailing: -10, top: 2, bottom: nil)
        scrollView.pinToEdges(subview: taskInputView, top: 70)
        taskInputView.setWidth(equalTo: scrollView)
        
        view.pinToEdges(subview: shadowingView)
        shadowingView.isHidden = true
        shadowingView.backgroundColor = UIColor.black.withAlphaComponent(0.2)
        
        view.addSubview(dropdownMenu)
        dropdownMenu.isHidden = true
        
        scrollView.delegate = self
        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissMenu))
        shadowingView.addGestureRecognizer(tapRecognizer)
        
        topLabel.text = Strings.newTask
        topLabel.font = UIFont.screenTitleFont
        topLabel.textAlignment = .center
        
        closeButton.widthAnchor.constraint(equalToConstant: 50).isActive = true
        closeButton.heightAnchor.constraint(equalTo: closeButton.widthAnchor).isActive = true
        let closeImage = UIImage(named: "Cross")?.withRenderingMode(.alwaysTemplate)
        closeButton.setImage(closeImage, for: .normal)
        closeButton.tintColor = UIColor.buttonColor
        closeButton.addTarget(self, action: #selector(closeButtonPressed), for: .touchUpInside)
      
    }
    
    
    
    @objc func closeButtonPressed() {
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func dismissMenu() {
        dropdownMenu.isHidden = true
        shadowingView.isHidden = true
    }
    
    func frameForDropdown(sender: UIButton, height: CGFloat) -> CGRect {
        let senderOrigin = sender.convert(CGPoint.zero, to: self.view)
        let senderHeight = sender.frame.height
        let width = sender.bounds.width
        if (UIScreen.main.bounds.height - senderOrigin.y - 44) < height {
            return CGRect(x: senderOrigin.x, y: senderOrigin.y + senderHeight - height, width: width, height: height)
        }
        else {
            return CGRect(x: senderOrigin.x, y: senderOrigin.y, width: width, height: height)
        }
    }
}

extension SingleTaskViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        view.endEditing(true)
    }
}

//extension SingleTaskViewController: DropdownDelegate {
//
//    func showDropdown(sender: UIButton) {
//        shadowingView.isHidden = false
//        dropdownMenu.isHidden = false
//        var options: [String]
//        switch sender {
//        case timeDropdownView.dropdownButton:
//            options = DropdownOptions.yesOrNo
//            dropdownMenu.selectedOption = timeDropdownOption
//            dropdownMenu.didSelectOption = { [unowned self] option in
//                dismissMenu()
//                timeDropdownView.dropdownButton.text = options[option]
//                timeDropdownOption = option
//                timePickerView.isHidden = option == 1
//            }
//        case repeatDropdownView.dropdownButton:
//            options = DropdownOptions.yesOrNo
//            dropdownMenu.selectedOption = repeatDropdownOption
//            dropdownMenu.didSelectOption = { [unowned self] option in
//                dismissMenu()
//                repeatDropdownView.dropdownButton.text = options[option]
//                repeatDropdownOption = option
//            }
//        case notificationDropdownView.dropdownButton:
//            options = DropdownOptions.yesOrNo
//            dropdownMenu.selectedOption = notificationDropdownOption
//            dropdownMenu.didSelectOption = { [unowned self] option in
//                dismissMenu()
//                notificationDropdownView.dropdownButton.text = options[option]
//                notificationDropdownOption = option
//            }
//        default:
//            options = DropdownOptions.noIntervalRecurrence
//            dropdownMenu.didSelectOption = { [unowned self] option in
//                dismissMenu()
//                timeDropdownView.dropdownButton.text = options[option]
//            }
//        }
//        let frame = frameForDropdown(sender: sender, height: CGFloat(44 * options.count))
//        dropdownMenu.frame = frame
//        dropdownMenu.options = options
//    }
//}
