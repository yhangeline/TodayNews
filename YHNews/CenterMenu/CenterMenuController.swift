//
//  CenterMenuController.swift
//  YHNews
//
//  Created by lay on 2018/3/26.
//  Copyright © 2018年 YH. All rights reserved.
//

import UIKit

class CenterMenuController: UIPresentationController {
    fileprivate var maskView: UIView!
    
    public override init(presentedViewController: UIViewController, presenting presentingViewController: UIViewController?) {
        super.init(presentedViewController: presentedViewController, presenting: presentingViewController)
        
        self.setupMaskView()
    }
    
    @objc dynamic func dismiss(tap:UITapGestureRecognizer) {
        presentedViewController.dismiss(animated: true) {
            
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
            self.presentingViewController.view?.transform = CGAffineTransform(translationX: (self.containerView?.bounds.size.width)!*(2.0/3.0)-1, y: 0)
            self.maskView.alpha = 1.0
        })
    }
    
    override func dismissalTransitionWillBegin() {
        guard let coordinator = presentedViewController.transitionCoordinator else {
            maskView.alpha = 0.0
            return
        }
        
        coordinator.animate(alongsideTransition: { _ in
            self.presentingViewController.view?.transform = CGAffineTransform.identity
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
        
        //1
        var frame: CGRect = .zero
        frame.size = size(forChildContentContainer: presentedViewController,
                          withParentContainerSize: containerView!.bounds.size)
        
        //2
        frame.origin = .zero
        return frame
    }
    
}

private extension CenterMenuController {
    func setupMaskView() {
        maskView = UIView()
        maskView.backgroundColor = UIColor(white:0, alpha:0.5)
        maskView.isUserInteractionEnabled = true
        maskView.translatesAutoresizingMaskIntoConstraints = false
        
        let dismissTap = UITapGestureRecognizer(target: self, action: #selector(dismiss))
        maskView.addGestureRecognizer(dismissTap)
    }

}
extension CenterMenuController : UIViewControllerTransitioningDelegate{
    
    public func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        let presentationController = CenterMenuController(presentedViewController: presented, presenting: presenting)
        return presentationController
    }
    func animationController(forPresented presented: UIViewController,
                             presenting: UIViewController,
                             source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return SlideInPresentationAnimator( isPresentation: true)
    }
    
    func animationController(forDismissed dismissed: UIViewController)
        -> UIViewControllerAnimatedTransitioning? {
            return SlideInPresentationAnimator( isPresentation: false)
    }


}

final class SlideInPresentationAnimator: NSObject {
  
    let isPresentation: Bool
    
    init(isPresentation: Bool) {
        self.isPresentation = isPresentation
        super.init()
    }
}

extension SlideInPresentationAnimator: UIViewControllerAnimatedTransitioning {
    func transitionDuration(
        using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.3
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        // 1
        let key = isPresentation ? UITransitionContextViewControllerKey.to
            : UITransitionContextViewControllerKey.from
        
        let controller = transitionContext.viewController(forKey: key)!
        
        // 2
        if isPresentation {
            transitionContext.containerView.addSubview(controller.view)
        }else{
            
        }
        
        // 3
        let presentedFrame = transitionContext.finalFrame(for: controller)
        var dismissedFrame = presentedFrame
        dismissedFrame.origin.x = -presentedFrame.width

        
        // 4
        let initialFrame = isPresentation ? dismissedFrame : presentedFrame
        let finalFrame = isPresentation ? presentedFrame : dismissedFrame
        
        // 5
        let animationDuration = transitionDuration(using: transitionContext)
        controller.view.frame = initialFrame
        UIView.animate(withDuration: animationDuration, animations: {
            controller.view.frame = finalFrame
        }) { finished in
            transitionContext.completeTransition(finished)
        }
    }
    
}
