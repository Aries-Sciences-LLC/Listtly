import Foundation

open class DropShadow: Effect {

    public let radius: Double
    public let offset: Point
    public let color: Color
    public let input: Effect?

    public init(radius: Double = 0, offset: Point = Point.origin, color: Color = Color.black, input: Effect? = nil) {
        self.radius = radius
        self.offset = offset
        self.color = color
        self.input = input
    }
}
