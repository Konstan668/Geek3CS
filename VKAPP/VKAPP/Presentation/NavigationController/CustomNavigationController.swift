//
//  CustomNavigationController.swift
//  VKAPP
//
//  Created by Konstantin on 09.10.2021.
//

import UIKit

class CustomNavigationController: UINavigationController, UINavigationControllerDelegate {
    
    let interactivaTransition = CustomInteractiveTransition()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        delegate = self
    }
    
    func navigationController(_ navigationController: UINavigationController, interactionControllerFor animationController: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        return interactivaTransition.hasStarted ? interactivaTransition : nil
    }

    
    func navigationController(_ navigationController: UINavigationController,
                              animationControllerFor operation:
                                UINavigationController.Operation,
                              from fromVC: UIViewController,
                              to toVC: UIViewController)
                              -> UIViewControllerAnimatedTransitioning? {
        
        if operation == .push {
            self.interactivaTransition.viewController = toVC
            return CustomPushAnimator()
        } else if operation == .pop {
            if navigationController.viewControllers.first != toVC {
                self.interactivaTransition.viewController = toVC
            }
        return CustomPopAnimator()
        }
        return nil
    }
}

