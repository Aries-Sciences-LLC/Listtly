import Foundation

#if os(iOS)
    import UIKit
#elseif os(OSX)
    import AppKit
#endif

func caTimingFunction(_ easing: Easing) -> CAMediaTimingFunction {
    switch easing {
    case .ease:
        return CAMediaTimingFunction(name: CAMediaTimingFunctionName.default)
    case .linear:
        return CAMediaTimingFunction(name: CAMediaTimingFunctionName.linear)
    case .easeIn:
        return CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeIn)
    case .easeOut:
        return CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeOut)
    case .easeInOut:
        return CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
    }
}

func progressForTimingFunction(_ easing: Easing, progress: Double) -> Double {
    let t = progress

    switch easing {
    case .ease:
        return t
    case .linear:
        return t
    case .easeIn:
        return t * t
    case .easeOut:
        return -(t * (t - 2))
    case .easeInOut:
        if t < 0.5 {
            return 2.0 * t * t
        } else {
            return -2.0 * t * t + 4.0 * t - 1.0
        }
    }
}
