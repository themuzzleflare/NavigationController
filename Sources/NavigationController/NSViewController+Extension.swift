import AppKit

extension NSViewController {
  private struct OBJCAssociationKey {
    static var navigationController = "cloud.tavitian.navigationcontroller"
  }
  
  public var navigationController: NSNavigationController? {
    get {
      return ObjCAssociation.value(from: self, forKey: &OBJCAssociationKey.navigationController)
    }
    set {
      ObjCAssociation.setAssign(value: newValue, to: self, forKey: &OBJCAssociationKey.navigationController)
    }
  }
  
  public func embedChildViewController(_ vc: NSViewController, container: NSView? = nil) {
    addChild(vc)
    vc.view.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height)
    vc.view.autoresizingMask = [.height, .width]
    (container ?? view).addSubview(vc.view)
  }
  
  public func unembedChildViewController(_ vc: NSViewController) {
    vc.view.removeFromSuperview()
    vc.removeFromParent()
  }
}
