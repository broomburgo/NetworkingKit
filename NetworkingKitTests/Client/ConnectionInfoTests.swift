import XCTest
import Abstract
import SwiftCheck
import Nimble
import NetworkingKit

class ConnectionInfoTests: XCTestCase {
	func testMonoidLaws() {
		property("ConnectionInfo composition is neutral to empty") <- forAll { (a: ConnectionInfo) in
			Law<ConnectionInfo>.isNeutralToEmpty(a)
		}

		property("ConnectionInfo composition is associative") <- forAll { (a: ConnectionInfo, b: ConnectionInfo, c: ConnectionInfo) in
			Law<ConnectionInfo>.isAssociative(a, b, c)
		}
	}
    
    func testConnectionInfoJSONObject() {
        property("Serialize a ConnectionInfo with `toJSON` always return a ClientResult.success") <- forAll { (ci: ConnectionInfo) in
            Serialize.toJSON(ci)
                .fold(
                    onSuccess: { _ in true },
                    onFailure: { _ in false })
        }
        
        property("Serialize a ConnectionInfo with `toJSON` always return a ClientResult.success") <- forAll { (ci: ConnectionInfo) in
            Serialize.fromJSONObject(ci.toJSONObject)
                .fold(
                    onSuccess: { _ in true },
                    onFailure: { _ in false })
        }
    }
}
