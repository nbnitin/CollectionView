//
//  Extensions.swift
//  Aliyah Media
//
//  Created by Nitin Bhatia on 11/01/18.
//  Copyright © 2018 Nitin Bhatia. All rights reserved.
//

import Foundation
import UIKit

private let borderWidth = CGFloat(5.0)
private let borderColor = UIColor.lightGray.cgColor



extension UIView{
    
    enum Position : Int {
        case TOP = 0
        case MIDDLE = 1
        case BOTTOM = 2
        case DEFAULT = 3
    }
    
    enum Length : Int {
        case LONG = 0
        case SHORT = 1
        case DEFAULT = 3
    }
    
    enum VerticalLocation: String {
        case bottom
        case top
    }

    func addShadow(location: VerticalLocation, color: UIColor = .black, opacity: Float = 0.3, radius: CGFloat = 5.0) {
        switch location {
        case .bottom:
            addShadow(offset: CGSize(width: 0, height: 10), color: color, opacity: opacity, radius: radius)
        case .top:
            addShadow(offset: CGSize(width: 0, height: -1), color: color, opacity: opacity, radius: radius)
        }
    }
    
    func addShadow(offset: CGSize, color: UIColor = .black, opacity: Float = 0.5, radius: CGFloat = 5.0) {
        self.layer.masksToBounds = false
        self.layer.shadowColor = color.cgColor
        self.layer.shadowOffset = offset
        self.layer.shadowOpacity = opacity
        self.layer.shadowRadius = radius
    }
    
    func addBottomBorder(){
        let view:UIView = self
        let borderBottom = CALayer()
        
        borderBottom.borderColor = borderColor
        borderBottom.frame = CGRect(x: 0, y: view.frame.height - 1.0, width: view.frame.width, height: view.frame.height - 1.0)
        borderBottom.borderWidth = borderWidth
        view.layer.addSublayer(borderBottom)
        view.layer.masksToBounds = true
        
    }
    
    func addBorderAround(corners:UIRectCorner,borderCol:CGColor=borderColor){
        // Add border to profile view
        // Add rounded corners
        let view:UIView = self
        let maskLayer = CAShapeLayer()
        
        maskLayer.frame = view.bounds
        maskLayer.path = UIBezierPath(roundedRect: view.bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: 10, height: 10)).cgPath
        view.layer.mask = maskLayer
        
        let borderLayer = CAShapeLayer()
        borderLayer.path = maskLayer.path // Reuse the Bezier path
        borderLayer.fillColor = UIColor.clear.cgColor
        borderLayer.strokeColor = borderCol
        borderLayer.lineWidth = 1
        borderLayer.frame = view.bounds
        view.layer.addSublayer(borderLayer)
        
    }
    
    
    func addCornerRadius(corners:UIRectCorner,radius:CGFloat){
        let view:UIView = self
        let maskLayer = CAShapeLayer()
        
        maskLayer.frame = view.bounds
        maskLayer.path = UIBezierPath(roundedRect: view.bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius)).cgPath
        view.layer.mask = maskLayer
        view.layer.masksToBounds = true
    }
    
    //this below toast function works only in that screen only from where you are showing it, if that screen get dismissed then taost will not be shown anymore.
    //to use this, self.view.showToast(params)
    
    // to show global toast, I have create new class with showToast.swift use that , Toast.showToast(params)
    
    func showToast(message : String,position:Position,length:Length  ){
        
//        let view : UIView = self
//        let toastLabel : UITextView
//        
//        toastLabel   = UITextView(frame: CGRect(x: 0, y: 0, width: 100,  height : 100))
//        
//        
//        
//        
//        toastLabel.backgroundColor = UIColor.black
//        toastLabel.textColor = UIColor.white
//        toastLabel.textAlignment = NSTextAlignment.center;
//        toastLabel.font = UIFont.boldSystemFont(ofSize: 17.0)
//        view.addSubview(toastLabel)
//        toastLabel.text =  message
//        toastLabel.textAlignment = .center
//        toastLabel.alpha = 0.0
//        //toastLabel.lineBreakMode = .byTruncatingTail
//        // toastLabel.numberOfLines = 0
//        
//        
//        
//        let size = CGSize(width: 250, height: 1000)
//        let options = NSStringDrawingOptions.usesFontLeading.union(.usesLineFragmentOrigin)
//        let estimatedFrame = NSString(string: message).boundingRect(with: size, options: options, attributes: [NSAttributedStringKey.Font: UIFont.systemFont(ofSize: 17)], context: nil)
//        
//        
//        
//        switch position.rawValue {
//            
//        case 0:
//            toastLabel.frame = CGRect( x: view.frame.size.width/2 - ( estimatedFrame.width/2) , y: 50, width: estimatedFrame.width + 20, height: estimatedFrame.height + 20)
//        case 1:
//            toastLabel.frame = CGRect(x: view.frame.size.width/2 - (estimatedFrame.width/2), y: view.frame.size.height/2 - (toastLabel.frame.height/2), width: estimatedFrame.width + 20, height: estimatedFrame.height + 20)
//        case 2:
//            toastLabel.frame = CGRect(x: view.frame.size.width/2 - (estimatedFrame.width/2), y: view.frame.size.height-100, width: estimatedFrame.width + 20, height: estimatedFrame.height + 20)
//        default:
//            toastLabel.frame = CGRect(x: view.frame.size.width/2 - (estimatedFrame.width/2), y: view.frame.size.height/2 - (toastLabel.frame.height/2), width: estimatedFrame.width + 20, height: estimatedFrame.height + 20)
//        }
//        
//        
//        
//        
//        
//        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + .seconds(0), execute: { () -> Void in
//            
//            UIView.animate(withDuration: 1.0, delay: 0.0, options: UIViewAnimationOptions.curveEaseOut, animations: {
//                toastLabel.alpha = 1.0
//                
//            })
//        })
//        toastLabel.layer.cornerRadius = 10;
//        toastLabel.clipsToBounds  =  true
//        
//        var yourDelay = 3
//        let yourDuration = 1.0
//        
//        switch length.rawValue {
//        case 0:
//            yourDelay = 20
//        case 1:
//            yourDelay = 3
//        default:
//            yourDelay = 3
//        }
//        
//        
//        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + .seconds(yourDelay), execute: { () -> Void in
//            UIView.animate(withDuration: yourDuration, delay: 0, options: UIViewAnimationOptions.curveEaseOut, animations: {
//                toastLabel.alpha = 0.0
//                
//            })
//        })
    }
    
//    func showLoad(){
//        let view : UIView = self
//        let rect = CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height)
//        let loadingSubView =  Bundle.main.loadNibNamed("loadingView", owner: self, options: nil)?[0] as! LoadingView
//        loadingSubView.tag = 999
//        loadingSubView.alpha = 0.6
//        loadingSubView.frame = rect
//        loadingSubView.activityIndicator.startAnimating()
//        view.addSubview(loadingSubView)
//    }
//    
//    func hideLoad(){
//        //let view : UIView = self
//        let viewToRemove = viewWithTag(999)
//        
//        viewToRemove?.removeFromSuperview()
//    }
    
    //this will add warning message to views
    func addWarningMessage(message : String){
        let view : UIView = self
        let lblMessage : UILabel = UILabel()
        lblMessage.frame = CGRect(x:8 , y: view.frame.height/2, width: view.frame.width - 16, height: 60)
        lblMessage.text = message
        lblMessage.textColor = UIColor.white
        lblMessage.font = UIFont.boldSystemFont(ofSize:16)
        lblMessage.textAlignment = .center
        lblMessage.backgroundColor = UIColor.init(red: 242/255, green: 89/255, blue: 51/255, alpha: 1.0)
        lblMessage.addLabelCornerRadius(corners: .allCorners, cornerRadius: 5)
        view.addSubview(lblMessage)
    }
    
    
    
    
}

extension UITableView{
    
    func addCornerRadiusWithBorder(borderColor:CGColor,borderWidth:CGFloat = 1.0,cornerRadius:CGFloat = 10.0){
        let view : UITableView = self
        view.layer.cornerRadius = cornerRadius
        view.layer.masksToBounds = true
        view.layer.borderWidth = borderWidth
        view.layer.borderColor = borderColor
    }
}

extension UITextField {
    func addCornerRadiusWithBorder(borderColor:CGColor,borderWidth:CGFloat = 1.0,cornerRadius:CGFloat = 10.0){
        let view : UITextField = self
        view.layer.cornerRadius = cornerRadius
        view.layer.masksToBounds = true
        view.layer.borderWidth = borderWidth
        view.layer.borderColor = borderColor
    }
}

extension UITextView{
    func addCornerRadiusWithBorder(borderColor:CGColor,borderWidth:CGFloat = 1.0,cornerRadius:CGFloat = 10.0){
        let view : UITextView = self
        view.layer.cornerRadius = cornerRadius
        view.layer.masksToBounds = true
        view.layer.borderWidth = borderWidth
        view.layer.borderColor = borderColor
    }
}

extension UIButton{
    func addCornerRadiusWithBorder(borderColor:CGColor,borderWidth:CGFloat = 1.0,cornerRadius:CGFloat = 10.0){
        let view : UIButton = self
        view.layer.cornerRadius = cornerRadius
        view.layer.masksToBounds = true
        view.layer.borderWidth = borderWidth
        view.layer.borderColor = borderColor
    }
}

extension UILabel{
    func addLabelCornerRadius(corners : UIRectCorner,cornerRadius : CGFloat){
        let view : UILabel = self
        view.layer.cornerRadius = cornerRadius
        view.layer.masksToBounds = true
        
    }
}


private let DimmingViewTag = 10001

//extension UIViewController: SWRevealViewControllerDelegate {
//
//    func setupMenuGestureRecognizer() {
//
//        revealViewController().delegate = self
//
//        view.addGestureRecognizer(revealViewController().panGestureRecognizer())
//        view.addGestureRecognizer(revealViewController().tapGestureRecognizer())
//    }
//
//    public func revealController(_ revealController: SWRevealViewController!, willMoveTo position: FrontViewPosition) {
//        if case .right = position {
//
//            let dimmingView = UIView(frame: view.frame)
//            dimmingView.tag = DimmingViewTag
//            dimmingView.backgroundColor = UIColor.black.withAlphaComponent(0.5)
//            view.addSubview(dimmingView)
//            view.bringSubview(toFront: dimmingView)
//            dimmingView.addGestureRecognizer(revealViewController().panGestureRecognizer())
//            dimmingView.addGestureRecognizer(revealViewController().tapGestureRecognizer())
//
//        } else {
//            view.viewWithTag(DimmingViewTag)?.removeFromSuperview()
//        }
//    }

    //MARK: - SWRevealViewControllerDelegate
    
    //    public func revealController(_ revealController: SWRevealViewController!, didMoveTo position: FrontViewPosition) {
    //         if case .right = position {
    //
    //            let dimmingView = UIView(frame: view.frame)
    //            dimmingView.tag = DimmingViewTag
    //            dimmingView.backgroundColor = UIColor.black.withAlphaComponent(0.5)
    //            view.addSubview(dimmingView)
    //            view.bringSubview(toFront: dimmingView)
    //           dimmingView.addGestureRecognizer(revealViewController().panGestureRecognizer())
    //            dimmingView.addGestureRecognizer(revealViewController().tapGestureRecognizer())
    //
    //        } else {
    //            view.viewWithTag(DimmingViewTag)?.removeFromSuperview()
    //        }
    //    }
    
    
//}

extension UICollectionViewCell{
    func addAllCornerRadiusToCell(radius: CGFloat) {
        self.contentView.layer.cornerRadius = radius
        self.contentView.layer.borderWidth = 1.0
        self.contentView.layer.borderColor = UIColor.clear.cgColor
        self.contentView.layer.masksToBounds = true
    }
    
    func addShadow(color:UIColor=UIColor.lightGray){
        self.layer.shadowColor = color.cgColor
        self.layer.shadowOffset = CGSize(width:0,height: 2.0)
        self.layer.shadowRadius = 2.0
        self.layer.shadowOpacity = 1.0
        self.layer.masksToBounds = false;
        self.layer.shadowPath = UIBezierPath(roundedRect:self.bounds, cornerRadius:self.contentView.layer.cornerRadius).cgPath

    }
}
