import Foundation

enum Direction: CaseIterable, Sendable {
    case north, east, south, west

    var turnedRight: Direction {
        switch self {
        case .north: .east
        case .east: .south
        case .south: .west
        case .west: .north
        }
    }

    var step: (dx: Int, dy: Int) {
        switch self {
        case .north: (0, 1)
        case .east: (1, 0)
        case .south: (0, -1)
        case .west: (-1, 0)
        }
    }
}

// x runs 0 (left) to gridSize - 1 (right); y runs 0 (bottom) to gridSize - 1 (top).
struct Position: Hashable, Sendable {
    var x: Int
    var y: Int
}

struct Roomba: Equatable, Sendable {
    static let gridSize = 10

    private(set) var position: Position
    private(set) var direction: Direction

    init(start: Position = Position(x: 0, y: 0), direction: Direction = .north) {
        self.position = start
        self.direction = direction
    }

    mutating func turnRight() {
        direction = direction.turnedRight
    }

    // The grid edge is a wall: when the next cell is outside, turn right in place.
    mutating func moveForward() {
        let step = direction.step
        let next = Position(x: position.x + step.dx, y: position.y + step.dy)
        guard Self.isOnGrid(next) else {
            turnRight()
            return
        }
        position = next
    }

    static func isOnGrid(_ position: Position) -> Bool {
        (0..<gridSize).contains(position.x) && (0..<gridSize).contains(position.y)
    }
}
