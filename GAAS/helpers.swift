//
//  Utils.swift
//  Pairso-Staging
//
//  Created by Gifton Okoronkwo on 3/17/18.
//  Copyright © 2018 Gifton Okoronkwo. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
    
    static let backButton : UIButton = {
        let bt = UIButton()
        bt.setImage(#imageLiteral(resourceName: "cross"), for: .normal)
        bt.backgroundColor = .mainGreen
        bt.layer.cornerRadius = 12.5
        
        return bt
    }()
    
    
    func setCellShadow() {
        self.layer.shadowColor = UIColor.lightGray.cgColor
        self.layer.shadowOffset = CGSize(width: 10, height: 8)
        self.layer.shadowOpacity = 0.85
        self.layer.shadowRadius = 2.0
        self.layer.masksToBounds = false
        self.clipsToBounds = false
        self.layer.cornerRadius = 4
    }
    
    func removeShadow() {
        self.layer.masksToBounds = false
        self.layer.shadowColor = .none
        self.clipsToBounds = true
    }
    //make any UIView have a sircular border
    func makeCircle(size: CGFloat) {
        self.heightAnchor.constraint(equalToConstant: size).isActive = true
        self.widthAnchor.constraint(equalToConstant: size).isActive = true
        self.layer.cornerRadius = size / 2
        self.clipsToBounds = true
    }
    //standard gradient and return a
    func createGradient(view: UIView){
        var gradient : CAGradientLayer!
        gradient = CAGradientLayer()
        gradient.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: 100)
        gradient.colors = [UIColor.mainGray.cgColor, UIColor.mainBlue.cgColor]
        view.layer.addSublayer(gradient)
    }
    //set gradient with chosen colors
    func gradientBackgorund(colors : [UIColor]) {
        var internalColor : [CGColor] = []
        for item in colors {
            let inputColor = item.cgColor
            internalColor.append(inputColor)
        }
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = bounds
        gradientLayer.colors = [internalColor]
        gradientLayer.locations = [0.0, 1.0]
        gradientLayer.startPoint = CGPoint(x: 1.0, y: 1.0)
        gradientLayer.endPoint = CGPoint(x: 0.0, y: 0.0)
        layer.insertSublayer(gradientLayer, at: 0)
    }
}

extension UIView {
    //set height and width easily
    func setHeightWidth(width: CGFloat?, height: CGFloat?) {
        if let width = width {
            self.widthAnchor.constraint(equalToConstant: width).isActive = true
        }
        if let height = height {
            self.heightAnchor.constraint(equalToConstant: height).isActive = true
        }
    }
    
    func setAnchor(top: NSLayoutYAxisAnchor?, leading: NSLayoutXAxisAnchor?,
                   bottom: NSLayoutYAxisAnchor?, trailing: NSLayoutXAxisAnchor?,
                   paddingTop: CGFloat, paddingLeading: CGFloat, paddingBottom: CGFloat,
                   paddingTrailing: CGFloat, width: CGFloat = 0, height: CGFloat = 0) {
        
        self.translatesAutoresizingMaskIntoConstraints = false
        
        if let top = top {
            self.topAnchor.constraint(equalTo: top, constant: paddingTop).isActive = true
        }
        
        if let leading = leading {
            self.leadingAnchor.constraint(equalTo: leading, constant: paddingLeading).isActive = true
        }
        
        if let bottom = bottom {
            self.bottomAnchor.constraint(equalTo: bottom, constant: -paddingBottom).isActive = true
        }
        
        if let trailing = trailing {
            self.trailingAnchor.constraint(equalTo: trailing, constant: -paddingTrailing).isActive = true
        }
        
        if width != 0 {
            self.widthAnchor.constraint(equalToConstant: width).isActive = true
        }
        
        if height != 0 {
            self.heightAnchor.constraint(equalToConstant: height).isActive = true
        }
    }
    
    var safeTopAnchor: NSLayoutYAxisAnchor {
        if #available(iOS 11.0, *) {
            return safeAreaLayoutGuide.topAnchor
        }
        return topAnchor
    }
    
    var safeLeadingAnchor: NSLayoutXAxisAnchor {
        if #available(iOS 11.0, *) {
            return safeAreaLayoutGuide.leadingAnchor
        }
        return leadingAnchor
    }
    
    var safeBottomAnchor: NSLayoutYAxisAnchor {
        if #available(iOS 11.0, *) {
            return safeAreaLayoutGuide.bottomAnchor
        }
        return bottomAnchor
    }
    
    var safeTrailingAnchor: NSLayoutXAxisAnchor {
        if #available(iOS 11.0, *) {
            return safeAreaLayoutGuide.trailingAnchor
        }
        return trailingAnchor
    }
    
    @discardableResult func createRating(rating: Int, AutoConstraint: Bool) -> UIStackView {
        let starStackBuild = UIStackView(frame: CGRect(x: 10, y: 10, width: 100, height: 30))
        starStackBuild.axis = .horizontal
        starStackBuild.spacing = 5
        starStackBuild.distribution = .fillEqually
        if AutoConstraint == false {
            starStackBuild.translatesAutoresizingMaskIntoConstraints = false
        } else {
            starStackBuild.translatesAutoresizingMaskIntoConstraints = true
        }
        starStackBuild.axis = .horizontal
        starStackBuild.distribution = .fillEqually
        for _ in 1...rating{
            let star : UIImageView = {
                let iv = UIImageView()
                iv.image = #imageLiteral(resourceName: "star_gold")
                iv.contentMode = UIViewContentMode.scaleAspectFit
                return iv
            }()
            starStackBuild.addArrangedSubview(star)
        }
        let remaining : Int = 5 - rating
        if remaining > 0{
            for _ in 1...remaining {
                let star : UIImageView = {
                    let iv = UIImageView()
                    iv.image = #imageLiteral(resourceName: "star_empty")
                    iv.contentMode = UIViewContentMode.scaleAspectFit
                    return iv
                }()
                starStackBuild.addArrangedSubview(star)
            }
        } else {
            print ("Unable to get ratings...")
        }
        
        return starStackBuild
    }
    
    @discardableResult func addBorders(edges: UIRectEdge, color: UIColor = .mainGray, thickness: CGFloat = 1.0) -> [UIView] {
        
        var borders = [UIView]()
        
        func border() -> UIView {
            let border = UIView(frame: CGRect.zero)
            border.backgroundColor = color
            border.translatesAutoresizingMaskIntoConstraints = false
            return border
        }
        
        if edges.contains(.top) || edges.contains(.all) {
            let top = border()
            addSubview(top)
            addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-(0)-[top(==thickness)]",
                                                          options: [],
                                                          metrics: ["thickness": thickness],
                                                          views: ["top": top]))
            addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-(0)-[top]-(0)-|",
                                                          options: [],
                                                          metrics: nil,
                                                          views: ["top": top]))
            borders.append(top)
        }
        
        if edges.contains(.left) || edges.contains(.all) {
            let left = border()
            addSubview(left)
            addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-(0)-[left(==thickness)]",
                                                          options: [],
                                                          metrics: ["thickness": thickness],
                                                          views: ["left": left]))
            addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-(0)-[left]-(0)-|",
                                                          options: [],
                                                          metrics: nil,
                                                          views: ["left": left]))
            borders.append(left)
        }
        
        if edges.contains(.right) || edges.contains(.all) {
            let right = border()
            addSubview(right)
            addConstraints(
                NSLayoutConstraint.constraints(withVisualFormat: "H:[right(==thickness)]-(0)-|",
                                               options: [],
                                               metrics: ["thickness": thickness],
                                               views: ["right": right]))
            addConstraints(
                NSLayoutConstraint.constraints(withVisualFormat: "V:|-(0)-[right]-(0)-|",
                                               options: [],
                                               metrics: nil,
                                               views: ["right": right]))
            borders.append(right)
        }
        
        if edges.contains(.bottom) || edges.contains(.all) {
            let bottom = border()
            addSubview(bottom)
            addConstraints(
                NSLayoutConstraint.constraints(withVisualFormat: "V:[bottom(==thickness)]-(0)-|",
                                               options: [],
                                               metrics: ["thickness": thickness],
                                               views: ["bottom": bottom]))
            addConstraints(
                NSLayoutConstraint.constraints(withVisualFormat: "H:|-(0)-[bottom]-(0)-|",
                                               options: [],
                                               metrics: nil,
                                               views: ["bottom": bottom]))
            borders.append(bottom)
        }
        
        return borders
    }
    
    @discardableResult func randomViewWithGradient(translate : Bool, gradient : ([UIColor])) -> UIView {
        let testView : UIView = {
            let view = UIView()
            view.gradientBackgorund(colors: gradient)
            if translate == false {
                view.translatesAutoresizingMaskIntoConstraints = false
            }
            return view
        }()
        return testView
    }
    func randomView(translate : Bool, color : UIColor, border : Bool) -> UIView{
        let testView : UIView = {
            let view = UIView()
            view.backgroundColor = color
            if translate == false {
                view.translatesAutoresizingMaskIntoConstraints = false
                print ("its off now")
            }
            if border == true {
                view.addBorders(edges: [.all])
            }
            
            return view
        }()
        
        return testView
    }
    
    static var username : String = ""
    
    func addContent(_ label : UILabel) {
        self.addSubview(label)
        label.frame = .zero
    }
    
}

extension UITabBarController {
    
    func createNavController(vc: UIViewController, selected: UIImage, unselected: UIImage) -> UINavigationController {
        let viewController = vc
        let navController = UINavigationController(rootViewController: viewController)
        
        navController.tabBarItem.image = unselected
        navController.tabBarItem.selectedImage = selected
        return navController
    }
}


//pairso colorways
public extension UIColor {
    static var mainGray = UIColor(red:0.96, green:0.96, blue:0.97, alpha:1.0)
    static var mainBlue = UIColor(red:0.38, green:0.44, blue:0.99, alpha:1.0)
    static var mutedBlue = UIColor(red:0.60, green:0.62, blue:0.69, alpha:1.0)
    static var mainYellow = UIColor(red:0.99, green:0.85, blue:0.38, alpha:1.0)
    static var mainGreen = UIColor(red:0.31, green:0.89, blue:0.76, alpha:1.0)
    static var mainOrange = UIColor(red:0.99, green:0.63, blue:0.48, alpha:1.0)
    static var secondaryGreen = UIColor(red:0.40, green:0.69, blue:0.23, alpha:1.0)
    static var offWhite = UIColor(red:0.98, green:0.98, blue:0.99, alpha:1.0)
    static var offGray = UIColor(red:0.27, green:0.27, blue:0.27, alpha:1.0)
    static var randomRed = UIColor(red:0.60, green:0.00, blue:0.20, alpha:1.0)
    static var darkGray = UIColor(red:0.29, green:0.29, blue:0.29, alpha:1.0)
    
    //opacity 50%
    static var mainBlueHalf = UIColor(red:0.38, green:0.44, blue:0.99, alpha:0.5)
    static var mainGrayHalf = UIColor(red:0.96, green:0.96, blue:0.97, alpha:1.0)
    static var mainGreenHalf = UIColor(red:0.31, green:0.89, blue:0.76 , alpha:0.5)
    static var mainOrangeHalf = UIColor(red:0.99, green:0.63, blue:0.48, alpha:0.5)
    static var mainYellowHalf = UIColor(red:0.99, green:0.85, blue:0.38, alpha:0.5)
    static var mainPurpleHalf = UIColor(red:0.48, green:0.23, blue:0.79, alpha:0.5)
    public convenience init(r: CGFloat, g: CGFloat, b: CGFloat) {
        self.init(red: r/255, green: g/255, blue: b/255, alpha: 1)
    }
}

//font size
enum fontSize : CGFloat {
    case small = 12.0
    case medium = 14.0
    case large = 16.0
    case xLarge = 18.0
    case xXLarge = 20.0
    case xXXLarge = 32.0
}


//display messages for users
enum warningMessage : String{
    
    case validPassword = "Please enter a valid password."
    case validPhoneNumber = "Please enter a valid phone number"
    case validName = "Please enter a valid name"
    case validEmailAddress = "Please enter a valid email address."
    case restYourPassword = "An email was sent to you to rest your password"
    case changePassword = "Your password has been changed successfully"
    case logoutMsg = "You've been logged out successfully."
    case network = "please check network connectivity"
    
}
struct ScreenSize {
    static let SCREEN_WIDTH = UIScreen.main.bounds.size.width
    static let SCREEN_HEIGHT = UIScreen.main.bounds.size.height
    static let SCREEN_MAX_LENGTH = max(ScreenSize.SCREEN_WIDTH, ScreenSize.SCREEN_HEIGHT)
    static let SCREEN_MIN_LENGTH = min(ScreenSize.SCREEN_WIDTH, ScreenSize.SCREEN_HEIGHT)
    static let SCALE = UIScreen.main.scale
    static let ratio1619 = (0.5625 * ScreenSize.SCREEN_WIDTH)
}
//header logic
let offset_HeaderStop:CGFloat = 200 - 64  // At this offset the Header stops its transformations
let distance_W_LabelHeader:CGFloat = 30.0

extension String {
    func password(string: String) -> Int {
        let capitalRegex = ".*[A-Z]+.*"
        let capitalTest = NSPredicate(format: "SELF MATCHES %@", capitalRegex)
        let numberRegEx  = "[0-9]+"
        let numberTest = NSPredicate(format: "SELF MATCHES %@", numberRegEx)
        if string.count <= 7 {
            return 1
        } else if capitalTest.evaluate(with: string) == false {
            return 2
        } else if numberTest.evaluate(with: string) == false {
            return 3
        }
        return 0
    }
}




