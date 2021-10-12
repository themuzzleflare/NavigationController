import AppKit

extension NSViewController {
  private struct OBJCAssociationKey {
    static var navigationController = "com.mc.navigationController"
  }
  
  public var navigationController: NSNavigationController? {
    get {
      return ObjCAssociation.value(from: self, forKey: &OBJCAssociationKey.navigationController)
    }
    set {
      ObjCAssociation.setAssign(value: newValue, to: self, forKey: &OBJCAssociationKey.navigationController)
    }
  }
}

extension NSViewController {
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

struct ObjCAssociation {
  static func value<T>(from object: AnyObject, forKey key: UnsafeRawPointer) -> T? {
    return objc_getAssociatedObject(object, key) as? T
  }
  
  static func setAssign<T>(value: T?, to object: Any, forKey key: UnsafeRawPointer) {
    objc_setAssociatedObject(object, key, value, .OBJC_ASSOCIATION_ASSIGN)
  }
  
  static func setRetainNonAtomic<T>(value: T?, to object: Any, forKey key: UnsafeRawPointer) {
    objc_setAssociatedObject(object, key, value, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
  }
  
  static func setCopyNonAtomic<T>(value: T?, to object: Any, forKey key: UnsafeRawPointer) {
    objc_setAssociatedObject(object, key, value, .OBJC_ASSOCIATION_COPY_NONATOMIC)
  }
  
  static func setRetain<T>(value: T?, to object: Any, forKey key: UnsafeRawPointer) {
    objc_setAssociatedObject(object, key, value, .OBJC_ASSOCIATION_RETAIN)
  }
  
  static func setCopy<T>(value: T?, to object: Any, forKey key: UnsafeRawPointer) {
    objc_setAssociatedObject(object, key, value, .OBJC_ASSOCIATION_COPY)
  }
}
