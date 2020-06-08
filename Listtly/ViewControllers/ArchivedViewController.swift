//
//  ArchivedViewController.swift
//  Listtly
//
//  Created by Ozan Mirza on 4/7/18.
//  Copyright © 2018 Ozan Mirza. All rights reserved.
//

import UIKit

class ArchivedViewController: UIViewController {

    @IBOutlet weak var nothing_here_label: UILabel!
    @IBOutlet weak var listView: UIScrollView!
    @IBOutlet weak var exit: UIImageView!
    @IBOutlet weak var archivedLbl: UILabel!
    @IBOutlet weak var flag_button_background: UIButton!
    @IBOutlet weak var flag_button_image: UIImageView!
    @IBOutlet weak var trash_buttton_background: UIButton!
    @IBOutlet weak var trash_button_image: UIImageView!
    @IBOutlet weak var complete_button_background: UIButton!
    @IBOutlet weak var complete_button_image: UIImageView!
    
    var cells : [[UIView]] = [] // Cell, ColorCell, TitleCell
    var listY : [Int] = [50]
    var listViewHieght: CGFloat = 0
    var list : [[AnyObject]] = []
    var openSideMenu: Bool = true
    var openedMenu : [UIView] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        archivedLbl.frame.origin.x = self.view.frame.size.width
        exit.frame.origin.x = 0 - exit.frame.size.width
        
        for i in 0..<(toDoList?.count)! {
            if toDoList![i][3] as! String != "trash" {
                if toDoList![i][4] as! String != "completed" {
                    if toDoList![i][5] as! String == "flagged" {
                        list.append(toDoList![i])
                    }
                }
            }
        }
        
        if list.count > 0 {
            nothing_here_label.alpha = 0
        } else {
            nothing_here_label.transform = CGAffineTransform(scaleX: 0, y: 0)
        }
        
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
        
        self.exit.frame.origin.y = self.view.frame.size.height - self.exit.frame.size.height
    }
    override func viewDidAppear(_ animated: Bool) {
        self.exit.frame.origin.y = self.view.frame.size.height - self.exit.frame.size.height
        UIView.animate(withDuration: 0.5, delay: 0.0, options: UIViewAnimationOptions.curveEaseInOut, animations: {
            self.nothing_here_label.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
        }) { (finished: Bool) in
            UIView.animate(withDuration: 0.2, delay: 0.0, options: UIViewAnimationOptions.curveEaseInOut, animations: {
                self.nothing_here_label.transform = CGAffineTransform.identity
            }, completion: { (finished: Bool) in
                self.exit.frame.origin.y = self.view.frame.size.height - self.exit.frame.size.height
                UIView.animate(withDuration: 0.5, delay: 0.0, options: UIViewAnimationOptions.curveEaseInOut, animations: {
                    self.archivedLbl.center.x = self.view.center.x - 25
                    self.exit.frame.origin.x = self.view.frame.size.width / 2
                }, completion: { (finished: Bool) in
                    self.exit.frame.origin.y = self.view.frame.size.height - self.exit.frame.size.height
                    UIView.animate(withDuration: 0.2, delay: 0.0, options: UIViewAnimationOptions.curveEaseInOut, animations: {
                        self.archivedLbl.center.x = self.view.frame.size.width / 2
                        self.exit.center.x = self.view.frame.size.width / 2
                    }, completion: nil)
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
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = touches.first
        let location = touch?.location(in: self.view)
        self.exit.frame.origin.y = self.view.frame.size.height - self.exit.frame.size.height
        if exit.frame.contains(location!) == true {
            self.exit.frame.origin.y = self.view.frame.size.height - self.exit.frame.size.height
            let transition = UIView(frame: CGRect(x: exit.center.x, y: exit.center.y, width: 0.1, height: 0.1))
            transition.backgroundColor = archivedLbl.textColor
            transition.layer.cornerRadius = (transition.frame.size.width / 4) + (transition.frame.size.height / 4)
            self.view.addSubview(transition)
            UIView.animate(withDuration: 2, delay: 0.0, options: UIViewAnimationOptions.curveEaseInOut, animations: { () -> Void in
                self.exit.frame.origin.y = self.view.frame.size.height - self.exit.frame.size.height
                transition.transform = CGAffineTransform(scaleX: 29000, y: 29000)
            }, completion: { (finished: Bool) in
                let transition_two = UIView(frame: CGRect(x: self.exit.center.x, y: self.exit.center.y, width: 0.1, height: 0.1))
                transition_two.backgroundColor = UIColor.white
                transition_two.layer.cornerRadius = (transition_two.frame.size.width / 4) + (transition_two.frame.size.height / 4)
                self.view.addSubview(transition_two)
                UIView.animate(withDuration: 2, delay: 0.0, options: UIViewAnimationOptions.curveEaseInOut, animations: { () -> Void in
                    self.exit.frame.origin.y = self.view.frame.size.height - self.exit.frame.size.height
                    transition_two.transform = CGAffineTransform(scaleX: 29000, y: 29000)
                }, completion: { (finished: Bool) in
                    self.exit.frame.origin.y = self.view.frame.size.height - self.exit.frame.size.height
                    let AddController = self.storyboard?.instantiateViewController(withIdentifier: "ViewController") as! ViewController
                    self.present(AddController, animated: false, completion: nil)
                })
            })
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
            trash_buttton_background.center.y = (sender.superview?.center.y)!
            flag_button_background.center.y = (sender.superview?.center.y)!
            complete_button_background.center.y = (sender.superview?.center.y)!
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
                toDoList![i][5] = "not flagged" as AnyObject
            }
        }
        let transition = UIView(frame: CGRect(x: listView.frame.origin.x +  sender.center.x, y: listView.frame.origin.y + sender.center.y, width: 0.1, height: 0.1))
        transition.backgroundColor = sender.backgroundColor
        transition.layer.cornerRadius = (transition.frame.size.width / 4) + (transition.frame.size.height / 4)
        self.view.addSubview(transition)
        UIView.animate(withDuration: 2, delay: 0.0, options: UIViewAnimationOptions.curveEaseInOut, animations: { () -> Void in
            transition.transform = CGAffineTransform(scaleX: 30000, y: 30000)
        }, completion: { (finished: Bool) in
            let transition_two = UIView(frame: CGRect(x: self.listView.frame.origin.x +  sender.center.x, y: self.listView.frame.origin.y + sender.center.y, width: 0.1, height: 0.1))
            transition_two.backgroundColor = UIColor.white
            transition_two.layer.cornerRadius = (transition_two.frame.size.width / 4) + (transition_two.frame.size.height / 4)
            self.view.addSubview(transition_two)
            UIView.animate(withDuration: 2, delay: 0.0, options: UIViewAnimationOptions.curveEaseInOut, animations: { () -> Void in
                transition_two.transform = CGAffineTransform(scaleX: 30000, y: 30000)
            }, completion: { (finished: Bool) in
                let ArchiveController = self.storyboard?.instantiateViewController(withIdentifier: "ViewController") as! ViewController
                self.present(ArchiveController, animated: false, completion: nil)
            })
        })
    }
}
