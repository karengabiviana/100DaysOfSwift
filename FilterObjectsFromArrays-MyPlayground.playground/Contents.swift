import UIKit
import CoreFoundation

struct User {
    let first: String
    let last: String
}

let users = [
    User(first: "Taylor", last: "Swift"),
    User(first: "Harry", last: "Styles"),
    User(first: "Olivia", last: "Rodrigo"),
    User(first: "Demi", last: "Lovato"),
    User(first: "Selena", last: "Gomes")

]

let answer = "S"

let result = users.filter {$0.last.contains(answer) || $0.first.contains(answer) }

print(result)

