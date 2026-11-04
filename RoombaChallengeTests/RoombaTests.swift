import Testing
@testable import RoombaChallenge

@Suite("Roomba model")
struct RoombaTests {

    // MARK: - Starting state

    @Test func startsAtOriginFacingNorth() {
        let roomba = Roomba()
        #expect(roomba.position == Position(x: 0, y: 0))
        #expect(roomba.direction == .north)
    }

    // MARK: - Turning

    @Test func turnRightCyclesClockwise() {
        var roomba = Roomba()
        var directions: [Direction] = []
        for _ in 0..<4 {
            roomba.turnRight()
            directions.append(roomba.direction)
        }
        #expect(directions == [.east, .south, .west, .north])
    }

    @Test func turnRightKeepsPosition() {
        var roomba = Roomba(start: Position(x: 3, y: 4))
        roomba.turnRight()
        #expect(roomba.position == Position(x: 3, y: 4))
    }

    // MARK: - Moving forward (no wall)

    @Test(arguments: [
        (Direction.north, Position(x: 2, y: 3)),
        (Direction.east, Position(x: 3, y: 2)),
        (Direction.south, Position(x: 2, y: 1)),
        (Direction.west, Position(x: 1, y: 2)),
    ])
    func moveForwardStepsOneCell(facing: Direction, expected: Position) {
        var roomba = Roomba(start: Position(x: 2, y: 2), direction: facing)
        roomba.moveForward()
        #expect(roomba.position == expected)
        #expect(roomba.direction == facing)
    }

    // MARK: - Walls: turn right instead of moving

    @Test(arguments: [
        (Position(x: 0, y: 9), Direction.north, Direction.east),
        (Position(x: 9, y: 5), Direction.east, Direction.south),
        (Position(x: 5, y: 0), Direction.south, Direction.west),
        (Position(x: 0, y: 5), Direction.west, Direction.north),
        (Position(x: 9, y: 9), Direction.east, Direction.south),
    ])
    func wallTurnsRightInPlace(start: Position, facing: Direction, expected: Direction) {
        var roomba = Roomba(start: start, direction: facing)
        roomba.moveForward()
        #expect(roomba.position == start)
        #expect(roomba.direction == expected)
    }

    // MARK: - Sequences

    @Test func moveTurnMoveSequence() {
        var roomba = Roomba()
        roomba.moveForward()
        roomba.moveForward()
        roomba.turnRight()
        roomba.moveForward()
        #expect(roomba.position == Position(x: 1, y: 2))
        #expect(roomba.direction == .east)
    }

    @Test func afterWallTurnNextMoveGoesInNewDirection() {
        var roomba = Roomba(start: Position(x: 0, y: 9), direction: .north)
        roomba.moveForward()
        roomba.moveForward()
        #expect(roomba.position == Position(x: 1, y: 9))
        #expect(roomba.direction == .east)
    }

    @Test func walkingNorthFromStartStopsAtTopWall() {
        var roomba = Roomba()
        for _ in 0..<9 { roomba.moveForward() }
        #expect(roomba.position == Position(x: 0, y: 9))
        #expect(roomba.direction == .north)

        roomba.moveForward()
        #expect(roomba.position == Position(x: 0, y: 9))
        #expect(roomba.direction == .east)
    }
}
