//
//  ViewController.swift
//  todoApp
//
//  Created by Yash Patel on 16/11/17.
//  Copyright © 2017 Yash Patel. All rights reserved.
//

import UIKit
import Macaw
import FanMenu
import TextFieldEffects
import GhostTypewriter

class ViewController: UIViewController {
    
    @IBOutlet weak var add_button: UIButton!
    @IBOutlet weak var listView: UIScrollView!
    @IBOutlet weak var menuOpener_Icon: UIButton!
    @IBOutlet weak var flag_button_background: UIButton!
    @IBOutlet weak var flag_button_image: UIImageView!
    @IBOutlet weak var trash_buttton_background: UIButton!
    @IBOutlet weak var trash_button_image: UIImageView!
    @IBOutlet weak var complete_button_background: UIButton!
    @IBOutlet weak var complete_button_image: UIImageView!
    var listY : [Int] = [50]
    var listViewHieght: CGFloat = 0
    var menu : UIView = UIView(frame: CGRect(x: 26, y: 60, width: 0, height: 0))
    var objectAtIndex : Int = 0
    var cells : [[UIView]] = [] // Cell, ColorCell, TitleCell
    var openSideMenu: Bool = true
    var openedMenu : [UIView] = []
    var list : [[AnyObject]] = []
    var descision = FanMenu(frame: CGRect(x: 0, y: 525, width: 0, height: 0))
    var menu_bg = UIVisualEffectView(effect: UIBlurEffect(style: UIBlurEffectStyle.dark))
    var did_say_there_is_nothing_there : Bool = false
    //var leftButton : UIButton = UIButton(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
    //var rightButton : UIButton = UIButton(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
    //var exitbutton : UIButton = UIButton(frame: CGRect(x: 0, y: 0, width: 64, height: 64))
    
    @objc func moveToAddController(_ sender: UIButton!) {
        let transition = UIView(frame: CGRect(x: add_button.center.x, y: add_button.center.y, width: 0.1, height: 0.1))
        transition.backgroundColor = add_button.backgroundColor
        transition.layer.cornerRadius = (transition.frame.size.width / 4) + (transition.frame.size.height / 4)
        self.view.addSubview(transition)
        UIView.animate(withDuration: 2, delay: 0.0, options: UIViewAnimationOptions.curveEaseInOut, animations: { () -> Void in
            transition.transform = CGAffineTransform(scaleX: 31000, y: 31000)
        }, completion: { (finished: Bool) in
            let transition_two = UIView(frame: CGRect(x: self.add_button.center.x, y: self.add_button.center.y, width: 0.1, height: 0.1))
            transition_two.backgroundColor = UIColor.white
            transition_two.layer.cornerRadius = (transition_two.frame.size.width / 4) + (transition_two.frame.size.height / 4)
            self.view.addSubview(transition_two)
            UIView.animate(withDuration: 2, delay: 0.0, options: UIViewAnimationOptions.curveEaseInOut, animations: { () -> Void in
                transition_two.transform = CGAffineTransform(scaleX: 31000, y: 31000)
            }, completion: { (finished: Bool) in
                let AddController = self.storyboard?.instantiateViewController(withIdentifier: "AddController") as! AddController
                self.present(AddController, animated: false, completion: nil)
            })
        })
    }
    
    @IBAction func circularTransition(_ sender: Any) {
        let transition = UIView(frame: CGRect(x: add_button.center.x, y: add_button.center.y, width: 0.1, height: 0.1))
        transition.backgroundColor = add_button.backgroundColor
        transition.layer.cornerRadius = (transition.frame.size.width / 4) + (transition.frame.size.height / 4)
        self.view.addSubview(transition)
        UIView.animate(withDuration: 2, delay: 0.0, options: UIViewAnimationOptions.curveEaseInOut, animations: { () -> Void in
            transition.transform = CGAffineTransform(scaleX: 31000, y: 31000)
        }, completion: { (finished: Bool) in
            let transition_two = UIView(frame: CGRect(x: self.add_button.center.x, y: self.add_button.center.y, width: 0.1, height: 0.1))
            transition_two.backgroundColor = UIColor.white
            transition_two.layer.cornerRadius = (transition_two.frame.size.width / 4) + (transition_two.frame.size.height / 4)
            self.view.addSubview(transition_two)
            UIView.animate(withDuration: 2, delay: 0.0, options: UIViewAnimationOptions.curveEaseInOut, animations: { () -> Void in
                transition_two.transform = CGAffineTransform(scaleX: 31000, y: 31000)
            }, completion: { (finished: Bool) in
                let AddController = self.storyboard?.instantiateViewController(withIdentifier: "AddController") as! AddController
                self.present(AddController, animated: false, completion: nil)
            })
        })
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.isUserInteractionEnabled = true
        
        for i in 0..<(toDoList?.count)! {
            if toDoList![i][3] as! String != "trash" {
                if toDoList![i][4] as! String != "completed" {
                    if toDoList![i][5] as! String != "flagged" {
                        list.append(toDoList![i])
                    }
                }
            }
        }
        
        menuOpener_Icon.transform = CGAffineTransform(scaleX: 0, y: 0)
        listViewHieght = self.listView.frame.size.height
        
        flag_button_background.layer.cornerRadius = flag_button_background.frame.size.width / 2
        trash_buttton_background.layer.cornerRadius = trash_buttton_background.frame.size.width / 2
        complete_button_background.layer.cornerRadius = complete_button_background.frame.size.width / 2
        
        flag_button_background.frame.origin.x = -75
        trash_buttton_background.frame.origin.x = -75
        complete_button_background.frame.origin.x = -75
        
        flag_button_image.center = flag_button_background.center
        trash_button_image.center = trash_buttton_background.center
        complete_button_image.center = complete_button_background.center
        
        flag_button_background.addTarget(self, action: #selector(move_Cell_To_Archive(_:)), for: UIControlEvents.touchUpInside)
        trash_buttton_background.addTarget(self, action: #selector(move_Cell_To_Trash(_:)), for: UIControlEvents.touchUpInside)
        complete_button_background.addTarget(self, action: #selector(move_Cell_To_Complete(_:)), for: UIControlEvents.touchUpInside)
        
        add_button.addTarget(self, action: #selector(ViewController.moveToAddController), for: UIControlEvents.touchUpInside)
    }
    override func viewDidAppear(_ animated: Bool) {
        if (toDoList?.count)! == 0 {
            self.add_button.frame.size = CGSize(width: 50, height: 50)
            self.add_button.frame.origin = CGPoint(x: -10, y: -10)
            self.add_button.center.x = self.view.center.x
            self.add_button.layer.cornerRadius = self.add_button.frame.size.height / 2
            self.add_button.transform = CGAffineTransform(scaleX: 0, y: 0)
            UIView.animate(withDuration: 0.8, delay: 0.0, options: UIViewAnimationOptions.curveEaseInOut, animations: { () -> Void in
                self.add_button.center.x = self.view.center.x
                self.add_button.center.y = self.view.center.y
                self.add_button.transform = CGAffineTransform.identity
            }, completion: nil)
        } else {
            self.listView.alpha = 1
            let flag_switcher : UIButton = UIButton(frame: CGRect(x: -17.5, y: self.view.frame.size.height - 125, width: 150, height: 150))
            flag_switcher.backgroundColor = UIColor(red: (66 / 255), green: (241 / 255), blue: (244 / 255), alpha: 1)
            flag_switcher.layer.cornerRadius = flag_switcher.frame.size.width / 2
            flag_switcher.addTarget(self, action: #selector(self.move_View_To_Archive(_:)), for: UIControlEvents.touchUpInside)
            flag_switcher.transform = CGAffineTransform(scaleX: 0, y: 0)
            self.view.addSubview(flag_switcher)
            let flag_switcher_image : UIImageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
            flag_switcher_image.center = CGPoint(x: 75, y: 75)
            flag_switcher_image.image = UIImage(named: "flag")
            flag_switcher_image.backgroundColor = UIColor.clear
            flag_switcher.addSubview(flag_switcher_image)
            let trash_switcher : UIButton = UIButton(frame: CGRect(x: 125 - 17.5, y: self.view.frame.size.height - 125, width: 150, height: 150))
            trash_switcher.center.x = self.view.center.x
            trash_switcher.backgroundColor = UIColor(red: (244 / 255), green: (66 / 255), blue: (66 / 255), alpha: 1)
            trash_switcher.layer.cornerRadius = trash_switcher.frame.size.width / 2
            trash_switcher.addTarget(self, action: #selector(self.move_View_To_Trash(_:)), for: UIControlEvents.touchUpInside)
            trash_switcher.transform = CGAffineTransform(scaleX: 0, y: 0)
            self.view.addSubview(trash_switcher)
            let trash_switcher_image : UIImageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
            trash_switcher_image.center = CGPoint(x: 75, y: 75)
            trash_switcher_image.image = UIImage(named: "trash")
            trash_switcher_image.backgroundColor = UIColor.clear
            trash_switcher.addSubview(trash_switcher_image)
            let complete_switcher : UIButton = UIButton(frame: CGRect(x: self.view.frame.size.width - 125, y: self.view.frame.size.height - 125, width: 150, height: 150))
            complete_switcher.backgroundColor = UIColor(red: (66 / 255), green: (244 / 255), blue: (209 / 255), alpha: 1)
            complete_switcher.layer.cornerRadius = complete_switcher.frame.size.height / 2
            complete_switcher.addTarget(self, action: #selector(self.move_View_To_Complete(_:)), for: UIControlEvents.touchUpInside)
            complete_switcher.transform = CGAffineTransform(scaleX: 0, y: 0)
            self.view.addSubview(complete_switcher)
            let complete_switcher_image : UIImageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
            complete_switcher_image.center = CGPoint(x: 75, y: 75)
            complete_switcher_image.image = UIImage(named: "check")
            complete_switcher_image.backgroundColor = UIColor.clear
            complete_switcher.addSubview(complete_switcher_image)
            UIView.animate(withDuration: 0.4, delay: 0.0, options: UIViewAnimationOptions.curveEaseInOut, animations: {
                flag_switcher.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
                trash_switcher.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
                complete_switcher.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
            }, completion: { (finished: Bool) in
                UIView.animate(withDuration: 0.1, delay: 0.0, options: UIViewAnimationOptions.curveEaseInOut, animations: {
                    flag_switcher.transform = CGAffineTransform.identity
                    trash_switcher.transform = CGAffineTransform.identity
                    complete_switcher.transform = CGAffineTransform.identity
                }, completion: nil)
            })
            activateMenuOpener()
            listView.alpha = 1
            self.add_button.transform = CGAffineTransform(scaleX: 0, y: 0)
            self.add_button.layer.cornerRadius = 25
            UIView.animate(withDuration: 0.8, delay: 0.0, options: UIViewAnimationOptions.curveEaseInOut, animations: { () -> Void in
                self.add_button.layer.cornerRadius = self.add_button.frame.size.height / 2
                self.add_button.transform = CGAffineTransform(scaleX: 1.2, y: 1.2)
            }, completion: { (finished: Bool) in
                UIView.animate(withDuration: 0.8, delay: 0.0, options: UIViewAnimationOptions.curveEaseInOut, animations: { () -> Void in
                    self.add_button.layer.cornerRadius = 25
                    self.add_button.transform = CGAffineTransform.identity
                }, completion: { (finished: Bool) in
                    self.add_button.layer.cornerRadius = 25
                    for i in 0..<self.list.count {
                        if CGFloat(self.listY[i]) > (self.listView.frame.size.height - 100) {
                            self.listViewHieght += 175
                            self.listView.contentSize.height = self.listViewHieght
                        }
                        let cell = UIView(frame: CGRect(x: 16, y: self.listY[i], width: Int(self.listView.frame.size.width - (16 * 2)), height: 100))
                        self.listY.append(Int(self.listY[i] + 100 + 20))
                        cell.layer.cornerRadius = cell.frame.size.height / 2
                        cell.backgroundColor = UIColor.init(red: (240 / 255), green: (240 / 255), blue: (240 / 255), alpha: 0.5)
                        cell.transform = CGAffineTransform(scaleX: 0, y: 0)
                        self.listView.addSubview(cell)
                        let colorCell = UIButton(frame: CGRect(x: self.view.frame.size.width, y: 0, width: 100, height: 100))
                        colorCell.alpha = 0
                        colorCell.layer.cornerRadius = colorCell.frame.size.height / 2
                        colorCell.backgroundColor = self.list[i][0] as? UIColor
                        colorCell.addTarget(self, action: #selector(self.switcher(_:)), for: UIControlEvents.touchUpInside)
                        cell.addSubview(colorCell)
                        let titleCell = UILabel(frame: CGRect(x: 100, y: 0, width: Int(self.listView.frame.size.width - 100), height: 100))
                        titleCell.layer.cornerRadius = titleCell.frame.size.height / 2
                        titleCell.transform = CGAffineTransform(scaleX: 0, y: 0)
                        titleCell.backgroundColor = UIColor.clear
                        titleCell.textAlignment = NSTextAlignment.center
                        titleCell.text = self.list[i][1] as? String
                        titleCell.font = UIFont(name: "VarelaRound-Regular", size: 20)
                        titleCell.textColor = UIColor.black
                        cell.addSubview(titleCell)
                        UIView.animate(withDuration: 0.5, delay: 0.2, options: UIViewAnimationOptions.curveEaseInOut, animations: {
                            cell.transform = CGAffineTransform(scaleX: 1.2, y: 1.2)
                        }, completion: { (finished: Bool) in
                            UIView.animate(withDuration: 0.2, delay: 0.0, options: UIViewAnimationOptions.curveEaseInOut, animations: {
                                cell.transform = CGAffineTransform.identity
                            }, completion: { (finished: Bool) in
                                colorCell.alpha = 1
                                UIView.animate(withDuration: 0.7, delay: 0.0, options: UIViewAnimationOptions.curveEaseInOut, animations: {
                                    colorCell.frame.origin.x = -15
                                }, completion: { (finished: Bool) in
                                    UIView.animate(withDuration: 0.15, delay: 0.0, options: UIViewAnimationOptions.curveEaseInOut, animations: {
                                        colorCell.frame.origin.x = 0
                                    }, completion: { (finished: Bool) in
                                        UIView.animate(withDuration: 0.7, delay: 0.0, options: UIViewAnimationOptions.curveEaseInOut, animations: {
                                            titleCell.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
                                        }, completion: { (finished: Bool) in
                                            UIView.animate(withDuration: 0.15, delay: 0.0, options: UIViewAnimationOptions.curveEaseInOut, animations: {
                                                titleCell.transform = CGAffineTransform.identity
                                            }, completion: { (finished: Bool) in
                                                self.cells.append([cell, colorCell, titleCell])
                                            })
                                        })
                                    })
                                })
                            })
                        })
                    }
                })
            })
        }
    }
    
    @objc func openMenu(_ sender: UIButton!) {
        self.menu_bg = UIVisualEffectView(effect: UIBlurEffect(style: UIBlurEffectStyle.dark))
        self.menu_bg.frame = view.bounds
        self.menu_bg.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        self.menu_bg.alpha = 0
        view.addSubview(self.menu_bg)
        UIView.animate(withDuration: 0.4, delay: 0.0, options: UIViewAnimationOptions.curveEaseInOut, animations: {
            self.menu_bg.alpha = 1
        }) { (finished: Bool) in
            self.menu = UIView(frame: CGRect(x: 26, y: 60, width: self.view.frame.size.width - 52, height: self.view.frame.size.height - 120))
            self.menu.backgroundColor = UIColor.init(red: (240 / 255), green: (240 / 255), blue: (240 / 255), alpha: 1)
            self.menu.layer.cornerRadius = 20
            self.menu.center = self.view.center
            self.menu.transform = CGAffineTransform(scaleX: 0, y: 0)
            self.view.addSubview(self.menu)
            UIView.animate(withDuration: 0.4, delay: 0.0, options: UIViewAnimationOptions.curveEaseInOut, animations: {
                self.menu.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
            }, completion: { (finished: Bool) in
                UIView.animate(withDuration: 0.15, delay: 0.0, options: UIViewAnimationOptions.curveEaseInOut, animations: {
                    self.menu.transform = CGAffineTransform.identity
                }, completion: { (finished: Bool) in
                    self.descision = FanMenu(frame: CGRect(x: 0, y: self.menu.frame.origin.y + self.menu.frame.size.height, width: self.view.frame.size.width, height: 250))
                    self.descision.center.y = self.menu.frame.size.height
                    self.descision.button = FanMenuButton(id: "main", image: "main", color: Color.rgba(r: 66, g: 244, b: 155, a: 1))
                    self.descision.items = [
                        FanMenuButton(id: "right_arrow", image: "right_arrow", color: Color.rgba(r: 255, g: 100, b: 50, a: 1)),
                        FanMenuButton(id: "exit", image: "close", color: Color.rgba(r: 244, g: 66, b: 66, a: 1)),
                        FanMenuButton(id: "left_arrow", image: "left_arrow", color: Color.rgba(r: 50, g: 255, b: 234, a: 1))
                    ]
                    self.descision.open()
                    self.descision.backgroundColor = UIColor.clear
                    self.descision.onItemDidClick = { button in
                        if button.id == "exit" {
                            self.closeMenu(self.descision)
                        } else if button.id == "right_arrow" {
                            self.changeMenuToTheRight(self.descision)
                        } else if button.id == "left_arrow" {
                            self.changeMenuToTheLeft(self.descision)
                        }
                    }
                    self.view.addSubview(self.descision)
                    let the_color : UIView = UIView(frame: CGRect(x: 10, y: 10, width: self.menu.frame.size.width - 20, height: 100))
                    the_color.backgroundColor = self.list[self.objectAtIndex][0] as? UIColor
                    the_color.layer.cornerRadius = 50
                    the_color.transform = CGAffineTransform(scaleX: 0, y: 0)
                    self.menu.addSubview(the_color)
                    UIView.animate(withDuration: 0.3, delay: 0.0, options: UIViewAnimationOptions.curveEaseInOut, animations: {
                        the_color.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
                    }, completion: { (finished: Bool) in
                        UIView.animate(withDuration: 0.1, delay: 0.0, options: UIViewAnimationOptions.curveEaseInOut, animations: {
                            the_color.transform = CGAffineTransform.identity
                        }, completion: { (finished: Bool) in
                            let title_label = TypewriterLabel(frame: CGRect(x: 0, y: 10, width: self.menu.frame.size.width, height: 100))
                            title_label.textAlignment = NSTextAlignment.center
                            title_label.text = self.list[self.objectAtIndex][1] as? String
                            title_label.font = UIFont(name: "VarelaRound-Regular", size: 35)
                            title_label.textColor = UIColor.white
                            title_label.backgroundColor = UIColor.clear
                            self.menu.addSubview(title_label)
                            title_label.startTypewritingAnimation(completion: {
                                let description_label = TypewriterLabel(frame: CGRect(x: 0, y: 50, width: self.menu.frame.size.width, height: 450))
                                description_label.backgroundColor = UIColor.clear
                                description_label.textColor = UIColor.white
                                description_label.textAlignment = NSTextAlignment.center
                                description_label.text = "Description: \(toDoList![self.objectAtIndex][2] as! String)"
                                description_label.numberOfLines = 20
                                description_label.font = UIFont(name: "VarelaRound-Regular", size: 40)
                                self.menu.addSubview(description_label)
                                description_label.startTypewritingAnimation(completion: nil)
                            })
                        })
                    })
                })
            })
        }
    }
    
    @objc func switchMenu(_ sender: UIButton!) {
        self.menu = UIView(frame: CGRect(x: 26, y: 60, width: self.view.frame.size.width - 52, height: self.view.frame.size.height - 120))
        self.menu.backgroundColor = UIColor.init(red: (240 / 255), green: (240 / 255), blue: (240 / 255), alpha: 1)
        self.menu.layer.cornerRadius = 20
        self.menu.center = self.view.center
        self.menu.transform = CGAffineTransform(scaleX: 0, y: 0)
        self.view.addSubview(self.menu)
        UIView.animate(withDuration: 0.4, delay: 0.0, options: UIViewAnimationOptions.curveEaseInOut, animations: {
            self.menu.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
        }, completion: { (finished: Bool) in
            UIView.animate(withDuration: 0.15, delay: 0.0, options: UIViewAnimationOptions.curveEaseInOut, animations: {
                self.menu.transform = CGAffineTransform.identity
            }, completion: { (finished: Bool) in
                self.descision = FanMenu(frame: CGRect(x: 0, y: self.menu.frame.origin.y + self.menu.frame.size.height, width: self.view.frame.size.width, height: 250))
                self.descision.center.y = self.menu.frame.size.height
                self.descision.button = FanMenuButton(id: "main", image: "main", color: Color.rgba(r: 66, g: 244, b: 155, a: 1))
                self.descision.items = [
                    FanMenuButton(id: "right_arrow", image: "right_arrow", color: Color.rgba(r: 255, g: 100, b: 50, a: 1)),
                    FanMenuButton(id: "exit", image: "close", color: Color.rgba(r: 244, g: 66, b: 66, a: 1)),
                    FanMenuButton(id: "left_arrow", image: "left_arrow", color: Color.rgba(r: 50, g: 255, b: 234, a: 1))
                ]
                self.descision.open()
                self.descision.backgroundColor = UIColor.clear
                self.descision.onItemDidClick = { button in
                    if button.id == "exit" {
                        self.closeMenu(self.descision)
                    } else if button.id == "right_arrow" {
                        self.changeMenuToTheRight(self.descision)
                    } else if button.id == "left_arrow" {
                        self.changeMenuToTheLeft(self.descision)
                    }
                }
                self.view.addSubview(self.descision)
                let the_color : UIView = UIView(frame: CGRect(x: 10, y: 10, width: self.menu.frame.size.width - 20, height: 100))
                the_color.backgroundColor = self.list[self.objectAtIndex][0] as? UIColor
                the_color.layer.cornerRadius = 50
                the_color.transform = CGAffineTransform(scaleX: 0, y: 0)
                self.menu.addSubview(the_color)
                UIView.animate(withDuration: 0.3, delay: 0.0, options: UIViewAnimationOptions.curveEaseInOut, animations: {
                    the_color.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
                }, completion: { (finished: Bool) in
                    UIView.animate(withDuration: 0.1, delay: 0.0, options: UIViewAnimationOptions.curveEaseInOut, animations: {
                        the_color.transform = CGAffineTransform.identity
                    }, completion: { (finished: Bool) in
                        let title_label = TypewriterLabel(frame: CGRect(x: 0, y: 10, width: self.menu.frame.size.width, height: 100))
                        title_label.textAlignment = NSTextAlignment.center
                        title_label.text = self.list[self.objectAtIndex][1] as? String
                        title_label.font = UIFont(name: "VarelaRound-Regular", size: 35)
                        title_label.textColor = UIColor.white
                        title_label.backgroundColor = UIColor.clear
                        self.menu.addSubview(title_label)
                        title_label.startTypewritingAnimation(completion: {
                            let description_label = TypewriterLabel(frame: CGRect(x: 0, y: 50, width: self.menu.frame.size.width, height: 450))
                            description_label.backgroundColor = UIColor.clear
                            description_label.textColor = UIColor.white
                            description_label.textAlignment = NSTextAlignment.center
                            description_label.text = "Description: \(toDoList![self.objectAtIndex][2] as! String)"
                            description_label.numberOfLines = 20
                            description_label.font = UIFont(name: "VarelaRound-Regular", size: 40)
                            self.menu.addSubview(description_label)
                            description_label.startTypewritingAnimation(completion: nil)
                        })
                    })
                })
            })
        })
    }
    
    func activateMenuOpener() {
        let menuOpener : UIButton = UIButton(frame: CGRect(x: 0, y: 0, width: 200, height: 200))
        menuOpener.center = CGPoint(x: self.view.frame.size.width - 5, y: 5)
        menuOpener.transform = CGAffineTransform(scaleX: 0, y: 0)
        menuOpener.backgroundColor = UIColor(red: (66 / 250), green: (244 / 250), blue: (160 / 250), alpha: 1)
        menuOpener.layer.cornerRadius = menuOpener.frame.size.width / 2
        menuOpener.addTarget(self, action: #selector(openMenu(_:)), for: UIControlEvents.touchUpInside)
        if list.count > 0 {
            menuOpener_Icon.addTarget(self, action: #selector(openMenu(_:)), for: UIControlEvents.touchUpInside)
        }
        self.view.addSubview(menuOpener)
        self.view.bringSubview(toFront: menuOpener_Icon)
        UIView.animate(withDuration: 0.3, delay: 0.0, options: UIViewAnimationOptions.curveEaseInOut, animations: {
            menuOpener.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
            menuOpener.layer.cornerRadius = menuOpener.frame.size.width / 2
        }, completion: { (finished: Bool) in
            UIView.animate(withDuration: 0.1, delay: 0.0, options: UIViewAnimationOptions.curveEaseInOut, animations: {
                menuOpener.transform = CGAffineTransform.identity
                menuOpener.layer.cornerRadius = menuOpener.frame.size.width / 2
            }, completion: { (finished: Bool) in
                UIView.animate(withDuration: 0.3, delay: 0.0, options: UIViewAnimationOptions.curveEaseInOut, animations: {
                    self.menuOpener_Icon.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
                }, completion: { (finished: Bool) in
                    UIView.animate(withDuration: 0.1, delay: 0.0, options: UIViewAnimationOptions.curveEaseInOut, animations: {
                        self.menuOpener_Icon.transform = CGAffineTransform.identity
                    }, completion: nil)
                })
            })
        })
    }
    
    func closeMenu(_ sender: FanMenu!) {
        UIView.animate(withDuration: 0.1, delay: 0.0, options: UIViewAnimationOptions.curveEaseInOut,       animations: {
            sender.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
        }, completion: { (finished: Bool) in
            UIView.animate(withDuration: 0.3, delay: 0.0, options: UIViewAnimationOptions.curveEaseInOut, animations: {
                sender.transform = CGAffineTransform(scaleX: 0, y: 0)
            }, completion: { (finished: Bool) in
                UIView.animate(withDuration: 0.7, delay: 0.0, options:  UIViewAnimationOptions.curveEaseInOut, animations: {
                    self.menu.transform = CGAffineTransform(rotationAngle: -0.15)
                    self.menu.frame.origin.y = self.view.frame.size.height + 250
                }, completion: { (finished: Bool) in
                    UIView.animate(withDuration: 0.4, delay: 0.0, options:  UIViewAnimationOptions.curveEaseInOut, animations: {
                        self.menu_bg.alpha = 0
                    }, completion: { (finished: Bool) in
                        self.did_say_there_is_nothing_there = false
                    })
                })
            })
        })
    }
    
    func changeMenuToTheRight(_ sender: FanMenu!) {
        if toDoList!.indices.contains(self.objectAtIndex + 1) == true {
            UIView.animate(withDuration: 0.1, delay: 0.0, options: UIViewAnimationOptions.curveEaseInOut,       animations: {
                sender.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
            }, completion: { (finished: Bool) in
                UIView.animate(withDuration: 0.3, delay: 0.0, options: UIViewAnimationOptions.curveEaseInOut, animations: {
                    sender.transform = CGAffineTransform(scaleX: 0, y: 0)
                }, completion: { (finished: Bool) in
                    UIView.animate(withDuration: 0.7, delay: 0.0, options:  UIViewAnimationOptions.curveEaseInOut, animations: {
                        self.menu.transform = CGAffineTransform(rotationAngle: -0.15)
                        self.menu.frame.origin.y = self.view.frame.size.height + 75
                    }, completion: { (finished: Bool) in
                        self.objectAtIndex += 1
                        self.switchMenu(self.menuOpener_Icon)
                    })
                })
            })
        } else if did_say_there_is_nothing_there == false {
            let errorlbl = UILabel(frame: CGRect(x: 0, y: (self.menu.subviews[0].frame.origin.y + self.menu.subviews[0].frame.size.height) + 20, width: self.menu.frame.size.width, height: 30))
            errorlbl.textAlignment = NSTextAlignment.center
            errorlbl.font = UIFont(name: "VarelaRound-Regular", size: 20)
            errorlbl.textColor = UIColor(red: (244 / 255), green: (66 / 255), blue: (66 / 255), alpha: 1)
            errorlbl.text = "There is nothing else there!"
            errorlbl.transform = CGAffineTransform(scaleX: 0, y: 0)
            self.menu.addSubview(errorlbl)
            UIView.animate(withDuration: 0.5, delay: 0.0, options: UIViewAnimationOptions.curveEaseInOut, animations: {
                errorlbl.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
            }) { (finished: Bool) in
                UIView.animate(withDuration: 0.5, delay: 0.0, options: UIViewAnimationOptions.curveEaseInOut, animations: {
                    errorlbl.transform = CGAffineTransform.identity
                }, completion: { (finished: Bool) in
                    self.did_say_there_is_nothing_there = true
                })
            }
        }
    }
    func changeMenuToTheLeft(_ sender: FanMenu!) {
        if toDoList!.indices.contains(self.objectAtIndex - 1) == true {
            UIView.animate(withDuration: 0.1, delay: 0.0, options: UIViewAnimationOptions.curveEaseInOut,       animations: {
                sender.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
            }, completion: { (finished: Bool) in
                UIView.animate(withDuration: 0.3, delay: 0.0, options: UIViewAnimationOptions.curveEaseInOut, animations: {
                    sender.transform = CGAffineTransform(scaleX: 0, y: 0)
                }, completion: { (finished: Bool) in
                    UIView.animate(withDuration: 0.7, delay: 0.0, options:  UIViewAnimationOptions.curveEaseInOut, animations: {
                        self.menu.transform = CGAffineTransform(rotationAngle: -0.15)
                        self.menu.frame.origin.y = self.view.frame.size.height + 75
                    }, completion: { (finished: Bool) in
                        self.objectAtIndex -= 1
                        self.switchMenu(self.menuOpener_Icon)
                    })
                })
            })
        } else if did_say_there_is_nothing_there == false {
            let errorlbl = UILabel(frame: CGRect(x: 0, y: (self.menu.subviews[0].frame.origin.y + self.menu.subviews[0].frame.size.height) + 20, width: self.menu.frame.size.width, height: 30))
            errorlbl.textAlignment = NSTextAlignment.center
            errorlbl.font = UIFont(name: "VarelaRound-Regular", size: 20)
            errorlbl.textColor = UIColor(red: (244 / 255), green: (66 / 255), blue: (66 / 255), alpha: 1)
            errorlbl.text = "There is nothing else there!"
            errorlbl.transform = CGAffineTransform(scaleX: 0, y: 0)
            self.menu.addSubview(errorlbl)
            UIView.animate(withDuration: 0.5, delay: 0.0, options: UIViewAnimationOptions.curveEaseInOut, animations: {
                errorlbl.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
            }) { (finished: Bool) in
                UIView.animate(withDuration: 0.5, delay: 0.0, options: UIViewAnimationOptions.curveEaseInOut, animations: {
                    errorlbl.transform = CGAffineTransform.identity
                }, completion: { (finished: Bool) in
                    self.did_say_there_is_nothing_there = true
                })
            }
        }
    }

    @objc func switcher(_ sender: UIButton!) {
        if openSideMenu == true {
            let exit_button : UIButton = UIButton(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
            exit_button.backgroundColor = UIColor.clear
            exit_button.setBackgroundImage(UIImage(named: "icon_close"), for: UIControlState.normal)
            exit_button.alpha = 0.25
            exit_button.transform = CGAffineTransform(scaleX: 0, y: 0)
            exit_button.addTarget(self, action: #selector(close_switcher(_:)), for: UIControlEvents.touchUpInside)
            sender.addSubview(exit_button)
            trash_buttton_background.center.y = (self.view.frame.size.height - self.listView.frame.size.height) + (sender.superview?.center.y)!
            flag_button_background.center.y = (self.view.frame.size.height - self.listView.frame.size.height) + (sender.superview?.center.y)!
            complete_button_background.center.y = (self.view.frame.size.height - self.listView.frame.size.height) + (sender.superview?.center.y)!
            flag_button_image.center = flag_button_background.center
            trash_button_image.center = trash_buttton_background.center
            complete_button_image.center = complete_button_background.center
            UIView.animate(withDuration: 0.5, delay: 0.0, options: UIViewAnimationOptions.allowUserInteraction, animations: {
                sender.superview?.frame.origin.x = self.view.frame.size.width - 105
                exit_button.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
                self.flag_button_background.frame.origin.x = 35
                self.trash_buttton_background.frame.origin.x = 115
                self.complete_button_background.frame.origin.x = 195
                self.flag_button_image.center = self.flag_button_background.center
                self.trash_button_image.center = self.trash_buttton_background.center
                self.complete_button_image.center = self.complete_button_background.center
            }, completion: { (finished: Bool) in
                UIView.animate(withDuration: 0.4, delay: 0.0, options: UIViewAnimationOptions.allowUserInteraction, animations: {
                    exit_button.transform = CGAffineTransform.identity
                    self.flag_button_background.frame.origin.x = 20
                    self.trash_buttton_background.frame.origin.x = 100
                    self.complete_button_background.frame.origin.x = 180
                    self.flag_button_image.center = self.flag_button_background.center
                    self.trash_button_image.center = self.trash_buttton_background.center
                    self.complete_button_image.center = self.complete_button_background.center
                }, completion: { (finished: Bool) in
                    UIView.animate(withDuration: 0.4, delay: 0.0, options: UIViewAnimationOptions.allowUserInteraction, animations: {
                        self.flag_button_background.frame.origin.x = 25
                        self.trash_buttton_background.frame.origin.x = 105
                        self.complete_button_background.frame.origin.x = 185
                        self.flag_button_image.center = self.flag_button_background.center
                        self.trash_button_image.center = self.trash_buttton_background.center
                        self.complete_button_image.center = self.complete_button_background.center
                    }, completion: { (finished: Bool) in
                        for i in 0..<self.cells.count {
                            if self.cells[i][0] == sender.superview {
                                self.openedMenu = self.cells[i]
                            }
                        }
                        self.openSideMenu = false
                        return
                    })
                })
            })
        } else if openSideMenu == false {
            return
        }
    }
    
    @objc func close_switcher(_ sender: UIButton!) {
        UIView.animate(withDuration: 0.4, delay: 0.0, options: UIViewAnimationOptions.curveEaseInOut, animations: {
            self.flag_button_background.frame.origin.x = 20
            self.trash_buttton_background.frame.origin.x = 100
            self.complete_button_background.frame.origin.x = 180
            self.flag_button_image.center = self.flag_button_background.center
            self.trash_button_image.center = self.trash_buttton_background.center
            self.complete_button_image.center = self.complete_button_background.center
        }, completion: { (finished: Bool) in
            UIView.animate(withDuration: 0.4, delay: 0.0, options: UIViewAnimationOptions.curveEaseInOut, animations: {
                self.flag_button_background.frame.origin.x = 35
                self.trash_buttton_background.frame.origin.x = 115
                self.complete_button_background.frame.origin.x = 195
                self.flag_button_image.center = self.flag_button_background.center
                self.trash_button_image.center = self.trash_buttton_background.center
                self.complete_button_image.center = self.complete_button_background.center
            }, completion: { (finished: Bool) in
                UIView.animate(withDuration: 0.4, delay: 0.0, options: UIViewAnimationOptions.curveEaseInOut, animations: {
                    self.flag_button_background.frame.origin.x = 20
                    self.trash_buttton_background.frame.origin.x = 100
                    self.complete_button_background.frame.origin.x = 180
                    self.flag_button_image.center = self.flag_button_background.center
                    self.trash_button_image.center = self.trash_buttton_background.center
                    self.complete_button_image.center = self.complete_button_background.center
                }, completion: { (finished: Bool) in
                    UIView.animate(withDuration: 0.4, delay: 0.0, options: UIViewAnimationOptions.curveEaseInOut, animations: {
                        self.flag_button_background.frame.origin.x = -75
                        self.trash_buttton_background.frame.origin.x = -75
                        self.complete_button_background.frame.origin.x = -75
                        self.flag_button_image.center = self.flag_button_background.center
                        self.trash_button_image.center = self.trash_buttton_background.center
                        self.complete_button_image.center = self.complete_button_background.center
                    }, completion: { (finished: Bool) in
                        UIView.animate(withDuration: 0.15, delay: 0.0, options: UIViewAnimationOptions.curveEaseInOut, animations: {
                            sender.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
                        }, completion: { (finished: Bool) in
                            UIView.animate(withDuration: 0.5, delay: 0.0, options: UIViewAnimationOptions.curveEaseInOut, animations: {
                                sender.transform = CGAffineTransform(scaleX: 0, y: 0)
                                sender.superview?.superview?.frame.origin.x = -16
                            }, completion: { (finished: Bool) in
                                UIView.animate(withDuration: 0.15, delay: 0.0, options: UIViewAnimationOptions.curveEaseInOut, animations: {
                                    sender.superview?.superview?.frame.origin.x = 16
                                }, completion: { (finished: Bool) in
                                    sender.removeFromSuperview()
                                    self.openedMenu = []
                                    self.openSideMenu = true
                                })
                            })
                        })
                    })
                })
            })
        })
    }
    
    @objc func move_View_To_Trash(_ sender: UIButton!) {
        let transition = UIView(frame: CGRect(x: sender.center.x, y: sender.center.y, width: 0.1, height: 0.1))
        transition.backgroundColor = sender.backgroundColor
        transition.layer.cornerRadius = (transition.frame.size.width / 4) + (transition.frame.size.height / 4)
        self.view.addSubview(transition)
        UIView.animate(withDuration: 2, delay: 0.0, options: UIViewAnimationOptions.curveEaseInOut, animations: { () -> Void in
            transition.transform = CGAffineTransform(scaleX: 31000, y: 31000)
        }, completion: { (finished: Bool) in
            let transition_two = UIView(frame: CGRect(x: sender.center.x, y: sender.center.y, width: 0.1, height: 0.1))
            transition_two.backgroundColor = UIColor.white
            transition_two.layer.cornerRadius = (transition_two.frame.size.width / 4) + (transition_two.frame.size.height / 4)
            self.view.addSubview(transition_two)
            UIView.animate(withDuration: 2, delay: 0.0, options: UIViewAnimationOptions.curveEaseInOut, animations: { () -> Void in
                transition_two.transform = CGAffineTransform(scaleX: 31000, y: 31000)
            }, completion: { (finished: Bool) in
                let TrashController = self.storyboard?.instantiateViewController(withIdentifier: "TrashViewController") as! TrashViewController
                self.present(TrashController, animated: false, completion: nil)
            })
        })
    }
    @objc func move_View_To_Complete(_ sender: UIButton!) {
        let transition = UIView(frame: CGRect(x: sender.center.x, y: sender.center.y, width: 0.1, height: 0.1))
        transition.backgroundColor = sender.backgroundColor
        transition.layer.cornerRadius = (transition.frame.size.width / 4) + (transition.frame.size.height / 4)
        self.view.addSubview(transition)
        UIView.animate(withDuration: 2, delay: 0.0, options: UIViewAnimationOptions.curveEaseInOut, animations: { () -> Void in
            transition.transform = CGAffineTransform(scaleX: 33000, y: 33000)
        }, completion: { (finished: Bool) in
            let transition_two = UIView(frame: CGRect(x: sender.center.x, y: sender.center.y, width: 0.1, height: 0.1))
            transition_two.backgroundColor = UIColor.white
            transition_two.layer.cornerRadius = (transition_two.frame.size.width / 4) + (transition_two.frame.size.height / 4)
            self.view.addSubview(transition_two)
            UIView.animate(withDuration: 2, delay: 0.0, options: UIViewAnimationOptions.curveEaseInOut, animations: { () -> Void in
                transition_two.transform = CGAffineTransform(scaleX: 33000, y: 33000)
            }, completion: { (finished: Bool) in
                let CompleteController = self.storyboard?.instantiateViewController(withIdentifier: "CompleteViewController") as! CompleteViewController
                self.present(CompleteController, animated: false, completion: nil)
            })
        })
    }
    @objc func move_View_To_Archive(_ sender: UIButton!) {
        let transition = UIView(frame: CGRect(x: sender.center.x, y: sender.center.y, width: 0.1, height: 0.1))
        transition.backgroundColor = sender.backgroundColor
        transition.layer.cornerRadius = (transition.frame.size.width / 4) + (transition.frame.size.height / 4)
        self.view.addSubview(transition)
        UIView.animate(withDuration: 2, delay: 0.0, options: UIViewAnimationOptions.curveEaseInOut, animations: { () -> Void in
            transition.transform = CGAffineTransform(scaleX: 36000, y: 36000)
        }, completion: { (finished: Bool) in
            let transition_two = UIView(frame: CGRect(x: sender.center.x, y: sender.center.y, width: 0.1, height: 0.1))
            transition_two.backgroundColor = UIColor.white
            transition_two.layer.cornerRadius = (transition_two.frame.size.width / 4) + (transition_two.frame.size.height / 4)
            self.view.addSubview(transition_two)
            UIView.animate(withDuration: 2, delay: 0.0, options: UIViewAnimationOptions.curveEaseInOut, animations: { () -> Void in
                transition_two.transform = CGAffineTransform(scaleX: 36000, y: 36000)
            }, completion: { (finished: Bool) in
                let ArchiveController = self.storyboard?.instantiateViewController(withIdentifier: "ArchivedViewController") as! ArchivedViewController
                self.present(ArchiveController, animated: false, completion: nil)
            })
        })
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touchLocation = touches.first?.location(in: self.view)
        if trash_button_image.frame.contains(touchLocation!) {
            // move_to_trash
        } else if complete_button_image.frame.contains(touchLocation!) {
            // move_to_complete
        } else if flag_button_image.frame.contains(touchLocation!) {
            // move_to_flag
        }
    }
    
    @objc func move_Cell_To_Trash(_ sender: UIButton!) {
        for i in 0..<(toDoList?.count)! {
            if toDoList![i][0] as? UIColor == self.openedMenu[1].backgroundColor {
                toDoList![i][3] = "trash" as AnyObject
            }
        }
        let transition = UIView(frame: CGRect(x: sender.center.x, y: sender.center.y, width: 0.1, height: 0.1))
        transition.backgroundColor = sender.backgroundColor
        transition.layer.cornerRadius = (transition.frame.size.width / 4) + (transition.frame.size.height / 4)
        self.view.addSubview(transition)
        UIView.animate(withDuration: 2, delay: 0.0, options: UIViewAnimationOptions.curveEaseInOut, animations: { () -> Void in
            transition.transform = CGAffineTransform(scaleX: 30000, y: 30000)
        }, completion: { (finished: Bool) in
            let transition_two = UIView(frame: CGRect(x: sender.center.x, y: sender.center.y, width: 0.1, height: 0.1))
            transition_two.backgroundColor = UIColor.white
            transition_two.layer.cornerRadius = (transition_two.frame.size.width / 4) + (transition_two.frame.size.height / 4)
            self.view.addSubview(transition_two)
            UIView.animate(withDuration: 2, delay: 0.0, options: UIViewAnimationOptions.curveEaseInOut, animations: { () -> Void in
                transition_two.transform = CGAffineTransform(scaleX: 30000, y: 30000)
            }, completion: { (finished: Bool) in
                let TrashController = self.storyboard?.instantiateViewController(withIdentifier: "TrashViewController") as! TrashViewController
                self.present(TrashController, animated: false, completion: nil)
            })
        })
    }
    
    @objc func move_Cell_To_Complete(_ sender: UIButton!) {
        for i in 0..<(toDoList?.count)! {
            if toDoList![i][0] as? UIColor == self.openedMenu[1].backgroundColor {
                toDoList![i][4] = "completed" as AnyObject
            }
        }
        let transition = UIView(frame: CGRect(x: sender.center.x, y: sender.center.y, width: 0.1, height: 0.1))
        transition.backgroundColor = sender.backgroundColor
        transition.layer.cornerRadius = (transition.frame.size.width / 4) + (transition.frame.size.height / 4)
        self.view.addSubview(transition)
        UIView.animate(withDuration: 2, delay: 0.0, options: UIViewAnimationOptions.curveEaseInOut, animations: { () -> Void in
            transition.transform = CGAffineTransform(scaleX: 30000, y: 30000)
        }, completion: { (finished: Bool) in
            let transition_two = UIView(frame: CGRect(x: sender.center.x, y: sender.center.y, width: 0.1, height: 0.1))
            transition_two.backgroundColor = UIColor.white
            transition_two.layer.cornerRadius = (transition_two.frame.size.width / 4) + (transition_two.frame.size.height / 4)
            self.view.addSubview(transition_two)
            UIView.animate(withDuration: 2, delay: 0.0, options: UIViewAnimationOptions.curveEaseInOut, animations: { () -> Void in
                transition_two.transform = CGAffineTransform(scaleX: 30000, y: 30000)
            }, completion: { (finished: Bool) in
                let CompleteController = self.storyboard?.instantiateViewController(withIdentifier: "CompleteViewController") as! CompleteViewController
                self.present(CompleteController, animated: false, completion: nil)
            })
        })
    }
    
    @objc func move_Cell_To_Archive(_ sender: UIButton!) {
        for i in 0..<(toDoList?.count)! {
            if toDoList![i][0] as? UIColor == self.openedMenu[1].backgroundColor {
                toDoList![i][5] = "flagged" as AnyObject
            }
        }
        let transition = UIView(frame: CGRect(x: sender.center.x, y: sender.center.y, width: 0.1, height: 0.1))
        transition.backgroundColor = sender.backgroundColor
        transition.layer.cornerRadius = (transition.frame.size.width / 4) + (transition.frame.size.height / 4)
        self.view.addSubview(transition)
        UIView.animate(withDuration: 2, delay: 0.0, options: UIViewAnimationOptions.curveEaseInOut, animations: { () -> Void in
            transition.transform = CGAffineTransform(scaleX: 30000, y: 30000)
        }, completion: { (finished: Bool) in
            let transition_two = UIView(frame: CGRect(x: sender.center.x, y: sender.center.y, width: 0.1, height: 0.1))
            transition_two.backgroundColor = UIColor.white
            transition_two.layer.cornerRadius = (transition_two.frame.size.width / 4) + (transition_two.frame.size.height / 4)
            self.view.addSubview(transition_two)
            UIView.animate(withDuration: 2, delay: 0.0, options: UIViewAnimationOptions.curveEaseInOut, animations: { () -> Void in
                transition_two.transform = CGAffineTransform(scaleX: 30000, y:30000)
            }, completion: { (finished: Bool) in
                let ArchiveController = self.storyboard?.instantiateViewController(withIdentifier: "ArchivedViewController") as! ArchivedViewController
                self.present(ArchiveController, animated: false, completion: nil)
            })
        })
    }
}
