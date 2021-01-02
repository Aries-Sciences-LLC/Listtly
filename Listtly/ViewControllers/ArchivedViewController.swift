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
    var list : [Item] = []
    var openSideMenu: Bool = true
    var openedMenu : [UIView] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        archivedLbl.frame.origin.x = self.view.frame.size.width
        
        for i in 0..<(toDoList?.count)! {
            if toDoList![i].section == .flagged {
                list.append(toDoList![i])
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
        
        flag_button_background.addTarget(self, action: #selector(move_Cell_To_Archive(_:)), for: UIControl.Event.touchUpInside)
        trash_buttton_background.addTarget(self, action: #selector(move_Cell_To_Trash(_:)), for: UIControl.Event.touchUpInside)
        complete_button_background.addTarget(self, action: #selector(move_Cell_To_Complete(_:)), for: UIControl.Event.touchUpInside)
    }
    override func viewDidAppear(_ animated: Bool) {
        UIView.animate(withDuration: 0.5, delay: 0.0, options: UIView.AnimationOptions.curveEaseInOut, animations: {
            self.nothing_here_label.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
        }) { (finished: Bool) in
            UIView.animate(withDuration: 0.2, delay: 0.0, options: UIView.AnimationOptions.curveEaseInOut, animations: {
                self.nothing_here_label.transform = CGAffineTransform.identity
            }, completion: { (finished: Bool) in
                UIView.animate(withDuration: 0.5, delay: 0.0, options: UIView.AnimationOptions.curveEaseInOut, animations: {
                    self.archivedLbl.center.x = self.view.center.x - 25
                }, completion: { (finished: Bool) in
                    UIView.animate(withDuration: 0.2, delay: 0.0, options: UIView.AnimationOptions.curveEaseInOut, animations: {
                        self.archivedLbl.center.x = self.view.frame.size.width / 2
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
                        colorCell.backgroundColor = self.list[i].color.color
                        colorCell.addTarget(self, action: #selector(self.switcher(_:)), for: UIControl.Event.touchUpInside)
                        cell.addSubview(colorCell)
                        let titleCell = UILabel(frame: CGRect(x: 100, y: 0, width: Int(self.listView.frame.size.width - 100), height: 100))
                        titleCell.layer.cornerRadius = titleCell.frame.size.height / 2
                        titleCell.transform = CGAffineTransform(scaleX: 0, y: 0)
                        titleCell.backgroundColor = UIColor.clear
                        titleCell.textAlignment = NSTextAlignment.center
                        titleCell.text = self.list[i].title
                        titleCell.font = UIFont(name: "VarelaRound-Regular", size: 20)
                        titleCell.textColor = UIColor.black
                        cell.addSubview(titleCell)
                        UIView.animate(withDuration: 0.5, delay: 0.2, options: UIView.AnimationOptions.curveEaseInOut, animations: {
                            cell.transform = CGAffineTransform(scaleX: 1.2, y: 1.2)
                        }, completion: { (finished: Bool) in
                            UIView.animate(withDuration: 0.2, delay: 0.0, options: UIView.AnimationOptions.curveEaseInOut, animations: {
                                cell.transform = CGAffineTransform.identity
                            }, completion: { (finished: Bool) in
                                colorCell.alpha = 1
                                UIView.animate(withDuration: 0.7, delay: 0.0, options: UIView.AnimationOptions.curveEaseInOut, animations: {
                                    colorCell.frame.origin.x = -15
                                }, completion: { (finished: Bool) in
                                    UIView.animate(withDuration: 0.15, delay: 0.0, options: UIView.AnimationOptions.curveEaseInOut, animations: {
                                        colorCell.frame.origin.x = 0
                                    }, completion: { (finished: Bool) in
                                        UIView.animate(withDuration: 0.7, delay: 0.0, options: UIView.AnimationOptions.curveEaseInOut, animations: {
                                            titleCell.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
                                        }, completion: { (finished: Bool) in
                                            UIView.animate(withDuration: 0.15, delay: 0.0, options: UIView.AnimationOptions.curveEaseInOut, animations: {
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
    
    @IBAction func hide(_ sender: Any!) {
        let HomeController = self.storyboard?.instantiateViewController(withIdentifier: "ViewController") as! ViewController
        HomeController.modalPresentationStyle = .fullScreen
        self.present(HomeController, animated: false, completion: nil)
    }
    
    @objc func switcher(_ sender: UIButton!) {
        if openSideMenu == true {
            for i in 0..<self.cells.count {
                if self.cells[i][0] == sender.superview {
                    self.openedMenu = self.cells[i]
                }
            }
            let exit_button : UIButton = UIButton(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
            exit_button.backgroundColor = UIColor.clear
            exit_button.setBackgroundImage(UIImage(named: "icon_close"), for: UIControl.State.normal)
            exit_button.alpha = 0.25
            exit_button.transform = CGAffineTransform(scaleX: 0, y: 0)
            exit_button.addTarget(self, action: #selector(close_switcher(_:)), for: UIControl.Event.touchUpInside)
            sender.addSubview(exit_button)
            trash_buttton_background.center.y = (sender.superview?.center.y)!
            flag_button_background.center.y = (sender.superview?.center.y)!
            complete_button_background.center.y = (sender.superview?.center.y)!
            flag_button_image.center = flag_button_background.center
            trash_button_image.center = trash_buttton_background.center
            complete_button_image.center = complete_button_background.center
            UIView.animate(withDuration: 0.5, delay: 0.0, options: UIView.AnimationOptions.allowUserInteraction, animations: {
                sender.superview?.frame.origin.x = self.view.frame.size.width - 105
                exit_button.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
                self.flag_button_background.frame.origin.x = 35
                self.trash_buttton_background.frame.origin.x = 115
                self.complete_button_background.frame.origin.x = 195
                self.flag_button_image.center = self.flag_button_background.center
                self.trash_button_image.center = self.trash_buttton_background.center
                self.complete_button_image.center = self.complete_button_background.center
            }, completion: { (finished: Bool) in
                UIView.animate(withDuration: 0.4, delay: 0.0, options: UIView.AnimationOptions.allowUserInteraction, animations: {
                    exit_button.transform = CGAffineTransform.identity
                    self.flag_button_background.frame.origin.x = 20
                    self.trash_buttton_background.frame.origin.x = 100
                    self.complete_button_background.frame.origin.x = 180
                    self.flag_button_image.center = self.flag_button_background.center
                    self.trash_button_image.center = self.trash_buttton_background.center
                    self.complete_button_image.center = self.complete_button_background.center
                }, completion: { (finished: Bool) in
                    UIView.animate(withDuration: 0.4, delay: 0.0, options: UIView.AnimationOptions.allowUserInteraction, animations: {
                        self.flag_button_background.frame.origin.x = 25
                        self.trash_buttton_background.frame.origin.x = 105
                        self.complete_button_background.frame.origin.x = 185
                        self.flag_button_image.center = self.flag_button_background.center
                        self.trash_button_image.center = self.trash_buttton_background.center
                        self.complete_button_image.center = self.complete_button_background.center
                    }, completion: { (finished: Bool) in
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
        UIView.animate(withDuration: 0.4, delay: 0.0, options: UIView.AnimationOptions.curveEaseInOut, animations: {
            self.flag_button_background.frame.origin.x = 20
            self.trash_buttton_background.frame.origin.x = 100
            self.complete_button_background.frame.origin.x = 180
            self.flag_button_image.center = self.flag_button_background.center
            self.trash_button_image.center = self.trash_buttton_background.center
            self.complete_button_image.center = self.complete_button_background.center
        }, completion: { (finished: Bool) in
            UIView.animate(withDuration: 0.4, delay: 0.0, options: UIView.AnimationOptions.curveEaseInOut, animations: {
                self.flag_button_background.frame.origin.x = 35
                self.trash_buttton_background.frame.origin.x = 115
                self.complete_button_background.frame.origin.x = 195
                self.flag_button_image.center = self.flag_button_background.center
                self.trash_button_image.center = self.trash_buttton_background.center
                self.complete_button_image.center = self.complete_button_background.center
            }, completion: { (finished: Bool) in
                UIView.animate(withDuration: 0.4, delay: 0.0, options: UIView.AnimationOptions.curveEaseInOut, animations: {
                    self.flag_button_background.frame.origin.x = 20
                    self.trash_buttton_background.frame.origin.x = 100
                    self.complete_button_background.frame.origin.x = 180
                    self.flag_button_image.center = self.flag_button_background.center
                    self.trash_button_image.center = self.trash_buttton_background.center
                    self.complete_button_image.center = self.complete_button_background.center
                }, completion: { (finished: Bool) in
                    UIView.animate(withDuration: 0.4, delay: 0.0, options: UIView.AnimationOptions.curveEaseInOut, animations: {
                        self.flag_button_background.frame.origin.x = -75
                        self.trash_buttton_background.frame.origin.x = -75
                        self.complete_button_background.frame.origin.x = -75
                        self.flag_button_image.center = self.flag_button_background.center
                        self.trash_button_image.center = self.trash_buttton_background.center
                        self.complete_button_image.center = self.complete_button_background.center
                    }, completion: { (finished: Bool) in
                        UIView.animate(withDuration: 0.15, delay: 0.0, options: UIView.AnimationOptions.curveEaseInOut, animations: {
                            sender.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
                        }, completion: { (finished: Bool) in
                            UIView.animate(withDuration: 0.5, delay: 0.0, options: UIView.AnimationOptions.curveEaseInOut, animations: {
                                sender.transform = CGAffineTransform(scaleX: 0, y: 0)
                                sender.superview?.superview?.frame.origin.x = -16
                            }, completion: { (finished: Bool) in
                                UIView.animate(withDuration: 0.15, delay: 0.0, options: UIView.AnimationOptions.curveEaseInOut, animations: {
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
        if !openedMenu.isEmpty {
            for i in 0..<(toDoList!.count) {
                if toDoList![i].title == (self.openedMenu[2] as! UILabel).text && toDoList![i].color.color == self.openedMenu[1].backgroundColor {
                    toDoList![i].section = .trash
                }
            }
            let TrashController = self.storyboard?.instantiateViewController(withIdentifier: "TrashViewController") as! TrashViewController
            TrashController.modalPresentationStyle = .fullScreen
            self.present(TrashController, animated: true, completion: nil)
        }
    }
    
    @objc func move_Cell_To_Complete(_ sender: UIButton!) {
        if !openedMenu.isEmpty {
            for i in 0..<(toDoList!.count) {
                if toDoList![i].title == (self.openedMenu[2] as! UILabel).text && toDoList![i].color.color == self.openedMenu[1].backgroundColor {
                    toDoList![i].section = .completed
                }
            }
            let CompleteController = self.storyboard?.instantiateViewController(withIdentifier: "CompleteViewController") as! CompleteViewController
            CompleteController.modalPresentationStyle = .fullScreen
            self.present(CompleteController, animated: true, completion: nil)
        }
    }
    
    @objc func move_Cell_To_Archive(_ sender: UIButton!) {
        if !openedMenu.isEmpty {
            for i in 0..<(toDoList!.count) {
                if toDoList![i].title == (self.openedMenu[2] as! UILabel).text && toDoList![i].color.color == self.openedMenu[1].backgroundColor {
                    toDoList![i].section = .main
                }
            }
            let ArchiveController = self.storyboard?.instantiateViewController(withIdentifier: "ViewController") as! ViewController
            ArchiveController.modalPresentationStyle = .fullScreen
            self.present(ArchiveController, animated: true, completion: nil)
        }
    }
}
