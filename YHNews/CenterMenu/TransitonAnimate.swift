//
//  TransitonAnimate.swift
//  YHNews
//
//  Created by lay on 2018/3/30.
//  Copyright © 2018年 YH. All rights reserved.
//

import Foundation
import UIKit

class TransitonAnimate: NSObject {
    private var isPresentation: Bool = false
    init( isPresentation: Bool) {
        self.isPresentation = isPresentation
        super.init()
    }
}

extension TransitonAnimate: UIViewControllerAnimatedTransitioning,CAAnimationDelegate {

    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.3
    }
        
        func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
            // 1

            let toController = transitionContext.viewController(forKey:UITransitionContextViewControllerKey.to)!
            let fromController = transitionContext.viewController(forKey:UITransitionContextViewControllerKey.from)!

            // 3
            let presentedFrame = transitionContext.finalFrame(for: toController)
            var dismissedFrame = presentedFrame
            dismissedFrame.origin.x = -presentedFrame.width


            // 4
//            let initialFrame = isPresentation ? dismissedFrame : presentedFrame
//            let finalFrame = isPresentation ? presentedFrame : dismissedFrame

            // 5
            var destTransfrom :CGAffineTransform = CGAffineTransform()

            let width:CGFloat = (screenWidth)*(2.0/3.0)
            if isPresentation {
                //            destView = toController.view
                destTransfrom = CGAffineTransform(translationX: width, y:0)
//                transitionContext.containerView.addSubview(fromController.view)
                transitionContext.containerView.addSubview(toController.view)

            } else {
                destTransfrom = CGAffineTransform(translationX: 0, y: 0)
                transitionContext.containerView.addSubview(fromController.view)
//                transitionContext.containerView.insertSubview(toController.view, belowSubview: fromController.view)

            }

            let animationDuration = transitionDuration(using: transitionContext)
//            toController.view.frame = initialFrame
            UIView.animate(withDuration: animationDuration, animations: {
                toController.view.transform = destTransfrom
                fromController.view.transform = destTransfrom

            }) { finished in
                transitionContext.completeTransition(finished)
            }

        }
    
//    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
//        
//        // 1
//        let key = isPresentation ? UITransitionContextViewControllerKey.to
//            : UITransitionContextViewControllerKey.from
//        
//        let controller = transitionContext.viewController(forKey: key)!
//
//        
//        // 2
//        if isPresentation {
//            transitionContext.containerView.addSubview(controller.view)
//        }
//        
//        // 3
//        let presentedFrame = transitionContext.finalFrame(for: controller)
//        var dismissedFrame = presentedFrame
//        dismissedFrame.origin.x = -presentedFrame.width
//        
//        
//        // 4
//        let initialFrame = isPresentation ? dismissedFrame : presentedFrame
//        let finalFrame = isPresentation ? presentedFrame : dismissedFrame
//        
//        // 5
//        let animationDuration = transitionDuration(using: transitionContext)
//        controller.view.frame = initialFrame
//        UIView.animate(withDuration: animationDuration, animations: {
//            controller.view.frame = finalFrame
//        }) { finished in
//            transitionContext.completeTransition(finished)
//        }
//    }

    
}
