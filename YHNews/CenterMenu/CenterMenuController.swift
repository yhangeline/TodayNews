//
//  CenterMenuController.swift
//  YHNews
//
//  Created by lay on 2018/3/26.
//  Copyright © 2018年 YH. All rights reserved.
//

import UIKit

class CenterMenuController : UIViewController {
    var mainView:CenterMenuView?
//    var transitionDelegate : CenterMenuDelegate = CenterMenuDelegate()

    override func viewDidLoad() {
//        self.transitioningDelegate = self.transitionDelegate
//        self.modalPresentationStyle = .custom
//        self.view.backgroundColor = UIColor.red
        
        mainView = CenterMenuView.init(frame: CGRect(x:0,y:0,width: screenWidth/3*2,height:screenHeight))
        self.view.addSubview(mainView!)
    }
}

class CenterMenuPresentationController: UIPresentationController {
    
    fileprivate var maskView: UIView!
    public var interactionController: UIPercentDrivenInteractiveTransition? = nil
    
    public override init(presentedViewController: UIViewController, presenting presentingViewController: UIViewController?) {
        super.init(presentedViewController: presentedViewController, presenting: presentingViewController)
        
        self.setupMaskView()
    }
    
    @objc func dismissByTap(tap:UITapGestureRecognizer) {
        presentedViewController.dismiss(animated: true) {

        }
        
    }
    
    @objc func dismissByPan(pan:UIPanGestureRecognizer){
        switch pan.state {
            
        case .began:
            self.interactionController = UIPercentDrivenInteractiveTransition()
            
            presentingViewController.dismiss(animated: true, completion: nil)
            
        case .changed:
            let width:CGFloat = (self.containerView?.bounds.size.width)!*(2.0/3.0)
            let translation = pan.translation(in: self.containerView)
            
            let completionProgress = translation.x/(-width)
            self.interactionController?.update(completionProgress)
            print(translation,completionProgress)
            
        case .ended:
            let width:CGFloat = (self.containerView?.bounds.size.width)!*(2.0/3.0)/2
            let completionProgress = pan.translation(in: self.containerView).x+width
            if (completionProgress < 0) {
                self.interactionController?.finish()
            } else {
                self.interactionController?.cancel()
            }
            self.interactionController = nil
            
        default:
            
            self.interactionController?.cancel()
            self.interactionController = nil
            
        }
    }
    
    
    override func presentationTransitionWillBegin() {
        containerView?.insertSubview(maskView, at: 0)
        
        //
        NSLayoutConstraint.activate( NSLayoutConstraint.constraints(withVisualFormat: "V:|[maskView]|", options: [], metrics: nil, views: ["maskView": maskView]))
        NSLayoutConstraint.activate( NSLayoutConstraint.constraints(withVisualFormat: "H:|[maskView]|", options: [], metrics: nil, views: ["maskView": maskView]))
        
        guard let coordinator = presentedViewController.transitionCoordinator else {
            
            maskView.alpha = 1.0
            return
        }
        
        coordinator.animate(alongsideTransition: { _ in
//            let width:CGFloat = (self.containerView?.bounds.size.width)!*(2.0/3.0)
//            self.presentingViewController.view?.transform = CGAffineTransform(translationX: width-1, y: 0)
            self.maskView.alpha = 1.0
        })
    }
    
    override func dismissalTransitionWillBegin() {
        guard let coordinator = presentedViewController.transitionCoordinator else {
            maskView.alpha = 0.0
            return
        }
        
        coordinator.animate(alongsideTransition: { _ in
//            self.presentingViewController.view?.transform = CGAffineTransform.identity
            self.maskView.alpha = 0.0
        })
    }
    
    override func size(forChildContentContainer container: UIContentContainer, withParentContainerSize parentSize: CGSize) -> CGSize {
        return CGSize(width: parentSize.width*(2.0/3.0), height: parentSize.height)
    }
    
    override func containerViewWillLayoutSubviews() {
        presentedView?.frame = frameOfPresentedViewInContainerView
    }
    override var frameOfPresentedViewInContainerView: CGRect {
        
        var frame: CGRect = .zero
        frame.size = size(forChildContentContainer: presentedViewController, withParentContainerSize: containerView!.bounds.size)
        frame.origin = .zero
        return frame
    }
    
}

private extension CenterMenuPresentationController {
    func setupMaskView() {
        maskView = UIView()
        maskView.backgroundColor = UIColor(white:0, alpha:0.5)
        maskView.isUserInteractionEnabled = true
        maskView.translatesAutoresizingMaskIntoConstraints = false
        
        let dismissTap = UITapGestureRecognizer(target: self, action: #selector(dismissByTap))
        maskView.addGestureRecognizer(dismissTap)
        
        let dismissPan = UIPanGestureRecognizer(target: self, action: #selector(dismissByPan))
        maskView.addGestureRecognizer(dismissPan)
    }

}

class CenterMenuDelegate: NSObject{
    
    var presentationVC:CenterMenuPresentationController? = nil

    
}
extension CenterMenuDelegate : UIViewControllerTransitioningDelegate{
    
    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        let presentationController =
            CenterMenuPresentationController.init(presentedViewController: presented, presenting: presenting)
        presentationVC = presentationController
        return presentationController
    }
    
    func animationController(forPresented presented: UIViewController,
                             presenting: UIViewController,
                             source: UIViewController) -> UIViewControllerAnimatedTransitioning? {

        return TransitonAnimate(isPresentation:true)
    }
    
    func animationController(forDismissed dismissed: UIViewController)
        -> UIViewControllerAnimatedTransitioning? {
        return TransitonAnimate(isPresentation:false)
    }
    
    func interactionControllerForPresentation(using animator: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        return presentationVC?.interactionController
    }

    func interactionControllerForDismissal(using animator: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        return presentationVC?.interactionController
    }
}


