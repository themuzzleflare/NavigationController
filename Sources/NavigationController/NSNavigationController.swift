import AppKit

public class NSNavigationController: NSViewController {
  public private (set) var viewControllers: [NSViewController] = []
  
  open override func loadView() {
    view = NSView()
    view.wantsLayer = true
  }
  
  public init(rootViewController: NSViewController) {
    super.init(nibName: nil, bundle: nil)
    pushViewController(rootViewController, animated: false)
  }
  
  public required init?(coder: NSCoder) {
    fatalError()
  }
}

extension NSNavigationController {
  public var topViewController: NSViewController? {
    return viewControllers.last
  }
  
  public func pushViewControllerAnimated(_ viewController: NSViewController) {
    pushViewController(viewController, animated: true)
  }
  
  public func pushViewController(_ viewController: NSViewController, animated: Bool) {
    viewController.navigationController = self
    viewController.view.wantsLayer = true
    if animated, let oldVC = topViewController {
      embedChildViewController(viewController)
      let endFrame = oldVC.view.frame
      let startFrame = endFrame.offsetBy(dx: endFrame.width, dy: 0)
      viewController.view.frame = startFrame
      viewController.view.alphaValue = 0.85
      viewControllers.append(viewController)
      NSAnimationContext.runAnimationGroup({ context in
        context.duration = 0.2
        context.allowsImplicitAnimation = true
        context.timingFunction = CAMediaTimingFunction(name: .easeOut)
        viewController.view.animator().frame = endFrame
        viewController.view.animator().alphaValue = 1
        oldVC.view.animator().alphaValue = 0.25
      }) {
        oldVC.view.alphaValue = 1
        oldVC.view.removeFromSuperview()
      }
    } else {
      embedChildViewController(viewController)
      viewControllers.append(viewController)
    }
  }
  
  @discardableResult
  public func popViewControllerAnimated() -> NSViewController? {
    return popViewController(animated: true)
  }
  
  @discardableResult
  public func popViewController(animated: Bool) -> NSViewController? {
    guard let oldVC = viewControllers.popLast() else {
      return nil
    }
    
    if animated, let newVC = topViewController {
      let endFrame = oldVC.view.frame.offsetBy(dx: oldVC.view.frame.width, dy: 0)
      view.addSubview(newVC.view, positioned: .below, relativeTo: oldVC.view)
      NSAnimationContext.runAnimationGroup({ context in
        context.duration = 0.23
        context.allowsImplicitAnimation = true
        context.timingFunction = CAMediaTimingFunction(name: .easeIn)
        oldVC.view.animator().frame = endFrame
        oldVC.view.animator().alphaValue = 0.85
      }) {
        self.unembedChildViewController(oldVC)
      }
    } else {
      unembedChildViewController(oldVC)
    }
    return oldVC
  }
}
