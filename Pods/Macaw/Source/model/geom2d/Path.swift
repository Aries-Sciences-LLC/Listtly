import Foundation

open class Path: Locus {

    public let segments: [PathSegment]

    public init(segments: [PathSegment] = []) {
        self.segments = segments
    }

    override open func bounds() -> Rect {
        return pathBounds(self)!
    }
}
