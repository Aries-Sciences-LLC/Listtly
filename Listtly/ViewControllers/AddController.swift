//
//  AddController.swift
//  todoApp
//
//  Created by Yash Patel on 16/11/17.
//  Copyright © 2017 Yash Patel. All rights reserved.
//

import UIKit
import TextFieldEffects

class AddController: UIViewController, CircleMenuDelegate, UITextFieldDelegate {
    
    @IBOutlet weak var add_Pressed: UIButton!
    @IBOutlet weak var color_setter: CircleMenu!
    
    let items: [(icon: String, color: UIColor)] = [
        ("icon_home", UIColor(red: 0.19, green: 0.57, blue: 1, alpha: 1)),
        ("icon_search", UIColor(red: 0.22, green: 0.74, blue: 0, alpha: 1)),
        ("notifications-btn", UIColor(red: 0.96, green: 0.23, blue: 0.21, alpha: 1)),
        ("settings-btn", UIColor(red: 0.51, green: 0.15, blue: 1, alpha: 1)),
        ("nearby-btn", UIColor(red: 1, green: 0.39, blue: 0, alpha: 1)),
        ]
    
    let titleField : HoshiTextField = HoshiTextField()
    let descriptionField : HoshiTextField = HoshiTextField()
    var theColor : UIColor = UIColor.clear
    
    override func viewWillAppear(_ animated: Bool) {
        titleField.delegate = self
        descriptionField.delegate = self
        add_Pressed.layer.cornerRadius = 25
        add_Pressed.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
        add_Pressed.frame.origin.y = self.view.frame.size.height
        add_Pressed.frame.size.height = (self.view.frame.size.height - add_Pressed.frame.origin.y) + 100
        add_Pressed.frame.size.width = self.view.frame.size.width
        add_Pressed.frame.origin.x = 0
        
        color_setter.layer.cornerRadius = (color_setter.frame.size.width / 4) + (color_setter.frame.size.height / 4)
        color_setter.clipsToBounds = true
        
        UIView.animate(withDuration: 0.5, delay: 0.2, options: UIView.AnimationOptions.curveEaseInOut, animations: {
            self.titleField.frame.origin.y = 44
        }, completion: { (finished: Bool) in
            UIView.animate(withDuration: 0.15, delay: 0.0, options: UIView.AnimationOptions.curveEaseInOut, animations: {
            self.titleField.frame.origin.y = 24
            }, completion: { (finished: Bool) in
                UIView.animate(withDuration: 0.5, delay: 0.2, options: UIView.AnimationOptions.curveEaseInOut, animations: {
                    self.descriptionField.frame.origin.x = 36
                }, completion: { (finished: Bool) in
                    UIView.animate(withDuration: 0.15, delay: 0.0, options: UIView.AnimationOptions.curveEaseInOut, animations: {
                        self.descriptionField.frame.origin.x = 16
                    }, completion: { (finished: Bool) in
                        UIView.animate(withDuration: 0.5, delay: 0.2, options: UIView.AnimationOptions.curveEaseInOut, animations: {
                            self.color_setter.alpha = 1
                        }, completion: nil)
                    })
                })
            })
        })
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        color_setter.delegate = self
        color_setter.alpha = 0
        
        titleField.frame = CGRect(x: 16, y: -250, width: self.view.frame.size.width - 32, height: 250)
        titleField.textColor = .black
        titleField.placeholderColor = UIColor.darkGray
        titleField.placeholderFontScale = 2
        titleField.font = UIFont(name: "VarelaRound-Regular", size: 50)
        titleField.textAlignment = NSTextAlignment.center
        titleField.placeholder = "Title"
        self.view.addSubview(titleField)
        
        descriptionField.frame = CGRect(x: (self.view.frame.size.width - 32) * -1, y: 0, width: self.view.frame.size.width - 32, height: 175)
        descriptionField.center.y = self.view.center.y
        descriptionField.textColor = .black
        descriptionField.placeholderColor = UIColor.darkGray
        descriptionField.placeholderFontScale = 1.2
        descriptionField.font = UIFont(name: "VarelaRound-Regular", size: 25)
        descriptionField.placeholder = "Description"
        descriptionField.textAlignment = NSTextAlignment.center
        self.view.addSubview(descriptionField)
    }
    @IBAction func addPressed(_ sender: UIButton) {
        if (titleField.text != nil) && titleField.text != "" {
            if (descriptionField.text != nil) && descriptionField.text != "" {
                toDoList?.append(Item(title: titleField.text!, description: descriptionField.text!, color: .from(color: theColor), section: .main)) // [theColor, titleField.text! as AnyObject, descriptionField.text! as AnyObject, "not trash" as AnyObject, "not completed" as AnyObject, "not flagged" as AnyObject]
                self.dismiss(animated: true, completion: nil)
            }
        }
    }
    
    func activate_Button() {
        UIView.animate(withDuration: 0.4, delay: 0.0, options: UIView.AnimationOptions.curveEaseInOut, animations: {
            self.add_Pressed.frame.origin.y = self.view.frame.size.height - 67 - 25
        }, completion: { (finished: Bool) in
            UIView.animate(withDuration: 0.2, delay: 0.0, options: UIView.AnimationOptions.curveEaseInOut, animations: {
                self.add_Pressed.frame.origin.y = self.view.frame.size.height - 67
            }, completion: nil)
        })
    }
    
    func deactivate_Button() {
        if self.add_Pressed.frame.origin.y != self.view.frame.size.height {
            UIView.animate(withDuration: 0.2, delay: 0.0, options: UIView.AnimationOptions.curveEaseInOut, animations: {
                self.add_Pressed.frame.origin.y = self.view.frame.size.height - self.add_Pressed.frame.size.height - 25
            }, completion: { (finished: Bool) in
                UIView.animate(withDuration: 0.4, delay: 0.0, options: UIView.AnimationOptions.curveEaseInOut, animations: {
                    self.add_Pressed.frame.origin.y = self.view.frame.size.height
                }, completion: nil)
            })
        }
    }
    
    func circleMenu(_: CircleMenu, willDisplay button: UIButton, atIndex: Int) {
        button.backgroundColor = self.items[atIndex].color
        deactivate_Button()
    }
    
    func circleMenu(_ circleMenu: CircleMenu, buttonWillSelected button: UIButton, atIndex: Int) {
        self.add_Pressed.backgroundColor = button.backgroundColor
        self.theColor = button.backgroundColor!
    }
    
    func circleMenu(_ circleMenu: CircleMenu, buttonDidSelected button: UIButton, atIndex: Int) {
        activate_Button()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        //let touchLocation = touches.first?.location(in: self.view)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
}
