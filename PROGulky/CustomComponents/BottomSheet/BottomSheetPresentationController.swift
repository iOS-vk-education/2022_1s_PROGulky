//
//  BottomSheetPresentationController.swift
//  PROGulky
//
//  Created by Semyon Pyatkov on 29.03.2023.
//

import UIKit

// MARK: - BottomSheetModalDismissalHandler

public protocol BottomSheetModalDismissalHandler {
    func performDismissal(animated: Bool)
}

// MARK: - BottomSheetPresentationControllerFactory

public protocol BottomSheetPresentationControllerFactory {
    func makeBottomSheetPresentationController(
        presentedViewController: UIViewController,
        presentingViewController: UIViewController?
    ) -> BottomSheetPresentationController
}

// MARK: - BottomSheetPresentationController

public final class BottomSheetPresentationController: UIPresentationController {
    private let dismissalHandler: BottomSheetModalDismissalHandler

    // MARK: - Nested types

    private enum State {
        case dismissed
        case presenting
        case presented
        case dismissing
    }

    private enum Style {
        static let cornerRadius: CGFloat = 10
        static let pullBarHeight = Style.cornerRadius * 2
    }

    var interactiveTransitioning: UIViewControllerInteractiveTransitioning? {
        interactionController
    }

    // MARK: - Private properties

    private var state: State = .dismissed

    private var isInteractiveTransitionCanBeHandled: Bool {
        isDragging
    }

    private var isDragging = false {
        didSet {
            if isDragging {
                assert(interactionController == nil)
            }
        }
    }

    private var overlayTranslation: CGFloat = 0
    private var scrollViewTranslation: CGFloat = 0
    private var lastContentOffsetBeforeDragging: CGPoint = .zero
    private var didStartDragging = false

    private var interactionController: UIPercentDrivenInteractiveTransition?

    private var shadingView: UIView?
    public var pullBar: PullBar?

    // MARK: - UIPresentationController

    override public func presentationTransitionDidEnd(_ completed: Bool) {
        if completed {
            setupGesturesForPresentedView()

            state = .presented
        } else {
            state = .dismissed
        }
    }

    public init(
        presentedViewController: UIViewController,
        presentingViewController: UIViewController?,
        dismissalHandler: BottomSheetModalDismissalHandler
    ) {
        self.dismissalHandler = dismissalHandler
        super.init(presentedViewController: presentedViewController, presenting: presentingViewController)
    }

    private func setupGesturesForPresentedView() {
        setupPanGesture(for: presentedView)
        setupPanGesture(for: pullBar)
    }

    private func setupPanGesture(for view: UIView?) {
        guard let view = view else {
            return
        }

        let panRecognizer = UIPanGestureRecognizer(target: self, action: #selector(handlePanGesture(_:)))
        view.addGestureRecognizer(panRecognizer)
    }

    @objc
    private func handlePanGesture(_ panGesture: UIPanGestureRecognizer) {
        switch panGesture.state {
        case .began:
            processPanGestureBegan(panGesture)
        case .changed:
            processPanGestureChanged(panGesture)
        case .ended:
            processPanGestureEnded(panGesture)
        case .cancelled:
            processPanGestureCancelled(panGesture)
        default:
            break
        }
    }

    private func processPanGestureBegan(_ panGesture: UIPanGestureRecognizer) {
        startInteractiveTransition()
    }

    private func processPanGestureChanged(_ panGesture: UIPanGestureRecognizer) {
        let translation = panGesture.translation(in: nil)
        updateInteractionControllerProgress(verticalTranslation: translation.y)
    }

    private func processPanGestureEnded(_ panGesture: UIPanGestureRecognizer) {
        let velocity = panGesture.velocity(in: presentedView)
        let translation = panGesture.translation(in: presentedView)
        endInteractiveTransition(verticalVelocity: velocity.y, verticalTranslation: translation.y)
    }

    private func processPanGestureCancelled(_ panGesture: UIPanGestureRecognizer) {
        endInteractiveTransition(isCancelled: true)
    }

    private func startInteractiveTransition() {
        interactionController = UIPercentDrivenInteractiveTransition()

        presentingViewController.dismiss(animated: true) { [weak self] in
            guard let self = self else { return }

            if self.presentingViewController.presentedViewController !== self.presentedViewController {
                self.dismissalHandler.performDismissal(animated: true)
            }
        }
    }

    private func updateInteractionControllerProgress(verticalTranslation: CGFloat) {
        guard let presentedView = presentedView else {
            return
        }

        let progress = verticalTranslation / presentedView.bounds.height
        interactionController?.update(progress)
    }

    private func endInteractiveTransition(verticalVelocity: CGFloat, verticalTranslation: CGFloat) {
        guard let presentedView = presentedView else {
            return
        }

        let deceleration = 800.0 * (verticalVelocity > 0 ? -1.0 : 1.0)
        let finalProgress = (verticalTranslation - 0.5 * verticalVelocity * verticalVelocity / CGFloat(deceleration))
            / presentedView.bounds.height
        let isThresholdPassed = finalProgress < 0.5

        endInteractiveTransition(isCancelled: isThresholdPassed)
    }

    private func endInteractiveTransition(isCancelled: Bool) {
        if isCancelled {
            interactionController?.cancel()
        } else {
            interactionController?.finish()
        }
        interactionController = nil
    }

    override public func presentationTransitionWillBegin() {
        state = .presenting

        addSubviews()
    }

    override public func dismissalTransitionDidEnd(_ completed: Bool) {
        if completed {
            removeSubviews()

            state = .dismissed
        } else {
            state = .presented
        }
    }

    private func addSubviews() {
        guard let containerView = containerView else {
            assertionFailure()
            return
        }

        setupShadingView(containerView: containerView)
        setupPullBar(containerView: containerView)
    }

    private func setupPullBar(containerView: UIView) {
        let pullBar = PullBar()
        pullBar.frame.size = CGSize(width: containerView.frame.width, height: Style.pullBarHeight)
        containerView.addSubview(pullBar)

        self.pullBar = pullBar
    }

    private func setupShadingView(containerView: UIView) {
        let shadingView = UIView()
        containerView.addSubview(shadingView)
        shadingView.backgroundColor = UIColor.black.withAlphaComponent(0.6)
        shadingView.frame = containerView.bounds

        let tapGesture = UITapGestureRecognizer()
        shadingView.addGestureRecognizer(tapGesture)

        tapGesture.addTarget(self, action: #selector(handleShadingViewTapGesture))
        self.shadingView = shadingView
    }

    @objc
    private func handleShadingViewTapGesture() {
        dismissIfPossible()
    }

    private func removeSubviews() {
        shadingView?.removeFromSuperview()
        shadingView = nil
        pullBar?.removeFromSuperview()
        pullBar = nil
    }

    private func dismissIfPossible() {
        let canBeDismissed = state == .presented

        if canBeDismissed {
            dismissalHandler.performDismissal(animated: true)
        }
    }

    private func targetFrameForPresentedView() -> CGRect {
        guard let containerView = containerView else {
            return .zero
        }

        let windowInsets = presentedView?.window?.safeAreaInsets ?? .zero

        let preferredHeight = presentedViewController.preferredContentSize.height + windowInsets.bottom
        let maxHeight = containerView.bounds.height - windowInsets.top
        let height = min(preferredHeight, maxHeight)

        return .init(
            x: 0,
            y: (containerView.bounds.height - height).pixelCeiled,
            width: containerView.bounds.width,
            height: height.pixelCeiled
        )
    }

    override public var shouldPresentInFullscreen: Bool {
        false
    }

    override public var frameOfPresentedViewInContainerView: CGRect {
        targetFrameForPresentedView()
    }

    override public func preferredContentSizeDidChange(forChildContentContainer container: UIContentContainer) {
        updatePresentedViewSize()
    }

    private func updatePresentedViewSize() {
        guard let presentedView = presentedView else {
            return
        }

        let oldFrame = presentedView.frame
        let targetFrame = targetFrameForPresentedView()
        if !oldFrame.isAlmostEqual(to: targetFrame) {
            presentedView.frame = targetFrame
            pullBar?.frame.origin.y = presentedView.frame.minY - Style.pullBarHeight + pixelSize
        }
    }
}

// MARK: UIViewControllerAnimatedTransitioning

extension BottomSheetPresentationController: UIViewControllerAnimatedTransitioning {
    public func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        0.3
    }

    private func applyStyle() {
        guard presentedViewController.isViewLoaded else {
            assertionFailure()
            return
        }

        presentedViewController.view.clipsToBounds = true

//        pullBar?.layer.mask = nil
        presentedViewController.view.layer.cornerRadius = 20
        presentedViewController.view.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
    }

    public func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard
            let sourceViewController = transitionContext.viewController(forKey: .from),
            let destinationViewController = transitionContext.viewController(forKey: .to),
            let sourceView = sourceViewController.view,
            let destinationView = destinationViewController.view
        else {
            return
        }

        let isPresenting = destinationViewController.isBeingPresented
        let presentedView = isPresenting ? destinationView : sourceView
        let containerView = transitionContext.containerView
        if isPresenting {
            containerView.addSubview(destinationView)

            destinationView.frame = containerView.bounds
        }

        sourceView.layoutIfNeeded()
        destinationView.layoutIfNeeded()

        let frameInContainer = frameOfPresentedViewInContainerView
        let offscreenFrame = CGRect(
            origin: CGPoint(
                x: 0,
                y: containerView.bounds.height
            ),
            size: sourceView.frame.size
        )

        presentedView.frame = isPresenting ? offscreenFrame : frameInContainer
        pullBar?.frame.origin.y = presentedView.frame.minY - Style.pullBarHeight + pixelSize
        shadingView?.alpha = isPresenting ? 0 : 1

        applyStyle()

        let animations = {
            presentedView.frame = isPresenting ? frameInContainer : offscreenFrame
            self.pullBar?.frame.origin.y = presentedView.frame.minY - Style.pullBarHeight + pixelSize
            self.shadingView?.alpha = isPresenting ? 1 : 0
        }

        let completion = { (completed: Bool) in
            transitionContext.completeTransition(completed && !transitionContext.transitionWasCancelled)
        }

        let options: UIView.AnimationOptions = transitionContext.isInteractive ? .curveLinear : .curveEaseInOut
        let transitionDurationValue = transitionDuration(using: transitionContext)
        UIView.animate(withDuration: transitionDurationValue, delay: 0, options: options, animations: animations, completion: completion)
    }
}
