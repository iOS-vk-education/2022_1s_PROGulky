//
//  BottomSheetTransitioningDelegate.swift
//  PROGulky
//
//  Created by Semyon Pyatkov on 29.03.2023.
//

import UIKit

public final class BottomSheetTransitioningDelegate: NSObject, UIViewControllerTransitioningDelegate {
    private weak var presentationController: BottomSheetPresentationController?
    private let factory: BottomSheetPresentationControllerFactory

    public init(factory: BottomSheetPresentationControllerFactory) {
        self.factory = factory
    }

    public func presentationController(
        forPresented presented: UIViewController,
        presenting: UIViewController?,
        source: UIViewController
    ) -> UIPresentationController? {
        _presentationController(forPresented: presented, presenting: presenting, source: source)
    }

    public func animationController(
        forPresented presented: UIViewController,
        presenting: UIViewController,
        source: UIViewController
    ) -> UIViewControllerAnimatedTransitioning? {
        _presentationController(forPresented: presented, presenting: presenting, source: source)
    }

    public func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        presentationController
    }

    private func _presentationController(
        forPresented presented: UIViewController,
        presenting: UIViewController?,
        source: UIViewController
    ) -> BottomSheetPresentationController {
        if let presentationController = presentationController {
            return presentationController
        }

        let controller = factory.makeBottomSheetPresentationController(
            presentedViewController: presented,
            presentingViewController: presenting
        )

        presentationController = controller

        return controller
    }

    public func interactionControllerForPresentation(using animator: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        presentationController?.interactiveTransitioning
    }

    public func interactionControllerForDismissal(using animator: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        presentationController?.interactiveTransitioning
    }
}
