import Foundation

class MainViewModel {
    let floorsArray = [
        Floor(
            place: "Entire cabin • Norway",
            minimalizedName: "Elegant Cottage by Zachary",
            name: "Elegant Cottage",
            cost: "$141.00",
            imageName: "home"
        ),
        Floor(
            place: "Entire Cabin • Norway",
            minimalizedName: "Candyblast by Agnes",
            name: "Candyblast",
            cost: "$141.00",
            imageName: "house"
        )
    ]
}

struct Floor {
    let place: String
    let minimalizedName: String
    let name: String
    let cost: String
    let imageName: String
}
