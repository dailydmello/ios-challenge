import XCTest
@testable import RoombaChallenge

/// The spec for `Roomba`, as tests — mirroring the Android source's
/// `RoombaTest`. Every test fails until `turnRight()` and `moveForward()`
/// are implemented in `Roomba.swift`.
final class RoombaTests: XCTestCase {

    // MARK: - Starting state

    func testInitialPositionAndDirection() {
        let roomba = Roomba()
        XCTAssertEqual(roomba.position, Position(x: 0, y: 0))
        XCTAssertEqual(roomba.direction, .north)
    }

    // MARK: - Turning

    func testTurnRightCyclesThroughAllDirections() {
        var roomba = Roomba()
        roomba.turnRight()
        XCTAssertEqual(roomba.direction, .east)
        roomba.turnRight()
        XCTAssertEqual(roomba.direction, .south)
        roomba.turnRight()
        XCTAssertEqual(roomba.direction, .west)
        roomba.turnRight()
        XCTAssertEqual(roomba.direction, .north)
    }

    func testTurnRightDoesNotMove() {
        var roomba = Roomba(start: Position(x: 3, y: 4))
        roomba.turnRight()
        XCTAssertEqual(roomba.position, Position(x: 3, y: 4))
    }

    // MARK: - Moving forward (no wall)

    func testMoveForwardFacingNorthIncreasesY() {
        var roomba = Roomba()
        roomba.moveForward()
        XCTAssertEqual(roomba.position, Position(x: 0, y: 1))
        XCTAssertEqual(roomba.direction, .north)
    }

    func testMoveForwardFacingEastIncreasesX() {
        var roomba = Roomba(start: Position(x: 2, y: 2), direction: .east)
        roomba.moveForward()
        XCTAssertEqual(roomba.position, Position(x: 3, y: 2))
    }

    func testMoveForwardFacingSouthDecreasesY() {
        var roomba = Roomba(start: Position(x: 2, y: 2), direction: .south)
        roomba.moveForward()
        XCTAssertEqual(roomba.position, Position(x: 2, y: 1))
    }

    func testMoveForwardFacingWestDecreasesX() {
        var roomba = Roomba(start: Position(x: 2, y: 2), direction: .west)
        roomba.moveForward()
        XCTAssertEqual(roomba.position, Position(x: 1, y: 2))
    }

    // MARK: - Walls: turn right instead of moving

    func testHittingNorthWallTurnsRightInsteadOfMoving() {
        var roomba = Roomba(start: Position(x: 0, y: 9), direction: .north)
        roomba.moveForward()
        XCTAssertEqual(roomba.position, Position(x: 0, y: 9))
        XCTAssertEqual(roomba.direction, .east)
    }

    func testHittingEastWallTurnsRightInsteadOfMoving() {
        var roomba = Roomba(start: Position(x: 9, y: 5), direction: .east)
        roomba.moveForward()
        XCTAssertEqual(roomba.position, Position(x: 9, y: 5))
        XCTAssertEqual(roomba.direction, .south)
    }

    func testHittingSouthWallTurnsRightInsteadOfMoving() {
        var roomba = Roomba(start: Position(x: 5, y: 0), direction: .south)
        roomba.moveForward()
        XCTAssertEqual(roomba.position, Position(x: 5, y: 0))
        XCTAssertEqual(roomba.direction, .west)
    }

    func testHittingWestWallTurnsRightInsteadOfMoving() {
        var roomba = Roomba(start: Position(x: 0, y: 5), direction: .west)
        roomba.moveForward()
        XCTAssertEqual(roomba.position, Position(x: 0, y: 5))
        XCTAssertEqual(roomba.direction, .north)
    }

    // MARK: - Sequences

    func testSequenceOfMovesAndTurns() {
        var roomba = Roomba()
        roomba.moveForward() // (0, 1) north
        roomba.moveForward() // (0, 2) north
        roomba.turnRight()   // east
        roomba.moveForward() // (1, 2) east
        XCTAssertEqual(roomba.position, Position(x: 1, y: 2))
        XCTAssertEqual(roomba.direction, .east)
    }

    func testAfterWallTurnNextForwardMovesInNewDirection() {
        var roomba = Roomba(start: Position(x: 0, y: 9), direction: .north)
        roomba.moveForward() // wall: turns east, stays at (0, 9)
        roomba.moveForward() // now moves east
        XCTAssertEqual(roomba.position, Position(x: 1, y: 9))
        XCTAssertEqual(roomba.direction, .east)
    }
}
