//
//  UIVIewController Extension.swift
//  
//


import UIKit
//import Kingfisher
//import FlagPhoneNumber

extension UIViewController{
    
    
    func showLoading(){
        //view.addSubview(loadingView)
        let blurView = UIView(frame: view.superview?.frame ?? view.frame)
        blurView.backgroundColor = .black
        blurView.alpha = 0.6
        blurView.tag = 100
        
        let loadingIndicator = UIActivityIndicatorView(frame: CGRect(origin: CGPoint(x: view.center.x - 15, y: view.center.y - 15), size: CGSize(width: 40, height: 40)))
        loadingIndicator.hidesWhenStopped = true
        loadingIndicator.style = UIActivityIndicatorView.Style.white
        
        loadingIndicator.tag = 101
        loadingIndicator.center = view.center
        loadingIndicator.alpha = 1
        loadingIndicator.startAnimating()
        view.addSubview(blurView)
        view.addSubview(loadingIndicator)
        
    }
    
    func hideLoading(){
        let blurView = view.viewWithTag(100)
        let indicator = view.viewWithTag(101) as? UIActivityIndicatorView
        if indicator != nil{
            indicator!.stopAnimating()
            indicator!.removeFromSuperview()
        }
        if blurView != nil{
            UIView.animate(withDuration: 0.3) {
                blurView!.alpha = 0
            }
            blurView!.removeFromSuperview()
        }
    }
    
    func removeLoading(){
        if let loadingView = view.viewWithTag(1){
            loadingView.removeFromSuperview()
        }
    }
    
    func showErrorView(_ message: String, _ selector: Selector){
        let errorView = UIView(frame: CGRect(origin: .zero, size: self.view.frame.size))
        errorView.backgroundColor = .white
        view.addSubview(errorView)
        let button = UIButton(frame: CGRect(origin: .zero, size: CGSize(width: UIScreen.main.bounds.width - 60, height: 44)))
        button.setTitle("Retry", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.addTarget(self, action: selector, for: .touchUpInside)
        button.center = errorView.center
        button.backgroundColor = .black
        button.layer.cornerRadius = 10
        button.center = view.center
        errorView.addSubview(button)
        errorView.tag = 2
        
        let msgLabel = UILabel(frame: CGRect(origin: CGPoint(x: view.frame.origin.x, y: button.frame.origin.y - 60), size: CGSize(width: self.view.frame.width, height: 60)))
        msgLabel.textAlignment = .center
       
        msgLabel.text = message
        
        errorView.addSubview(msgLabel)
        view.addSubview(errorView)
    }
    
    func removeError(){
        if let errorView = view.viewWithTag(2){
            errorView.removeFromSuperview()
        }
    }
    
    
    func hidesKeyboardOnTap() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    @discardableResult
    func presentErrorAlert(with message: String) -> UIAlertController{
        let alert = UIAlertController(title: "Alert", message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "Ok", style: .default, handler: nil)
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
        return alert
    }
    
    
    func presentAlert(with message: String, title: String) -> (){
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "Ok", style: .default, handler: nil)
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
        
    }
    
    class func topViewController(controller: UIViewController? = UIApplication.shared.keyWindow?.rootViewController) -> UIViewController? {
        if let navigationController = controller as? UINavigationController {
            return topViewController(controller: navigationController.visibleViewController)
        }
        if let tabController = controller as? UITabBarController {
            if let selected = tabController.selectedViewController {
                return topViewController(controller: selected)
            }
        }
        if let presented = controller?.presentedViewController {
            return topViewController(controller: presented)
        }
        return controller
    }
    
   
    
    
    
}

extension UIView {
    
    /// Flip view horizontally.
    func flipX() {
        transform = CGAffineTransform(scaleX: -transform.a, y: transform.d)
    }
    
    /// Flip view vertically.
    func flipY() {
        transform = CGAffineTransform(scaleX: transform.a, y: -transform.d)
    }
    
    func shadow(radius : CGFloat, opacity : Float, color : UIColor){
        layer.shadowColor = color.cgColor
        layer.shadowRadius = radius
        layer.shadowOpacity = opacity
        layer.shadowOffset = CGSize.zero
        layer.masksToBounds = false
    }
   
    
    
    
    
}

extension UIApplication {
    class func topViewController(controller: UIViewController? = UIApplication.shared.keyWindow?.rootViewController) -> UIViewController? {
        if let navigationController = controller as? UINavigationController {
            return topViewController(controller: navigationController.visibleViewController)
        }
        if let tabController = controller as? UITabBarController {
            if let selected = tabController.selectedViewController {
                return topViewController(controller: selected)
            }
        }
        if let presented = controller?.presentedViewController {
            return topViewController(controller: presented)
        }
        return controller
    }
}

//extension UIImage{
//    static func imageFromColor(color: UIColor) -> UIImage {
//        let rect = CGRect(x: 0, y: 0, width: 1, height: 1)
//
//        // create a 1 by 1 pixel context
//        UIGraphicsBeginImageContextWithOptions(rect.size, false, 0)
//        color.setFill()
//        UIRectFill(rect)
//
//        let image = UIGraphicsGetImageFromCurrentImageContext()
//        UIGraphicsEndImageContext()
//        return image!
//
//    }
//}


