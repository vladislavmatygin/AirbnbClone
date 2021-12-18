import Foundation

class MainViewModel {
    var floorsArray = [
        Floor(
            id: "7b7fcc1c-5f92-11ec-bf63-0242ac130002",
            place: "Entire cabin • Norway",
            minimalizedName: "Elegant Cottage by Zachary",
            name: "Elegant Cottage",
            cost: "$141.00",
            imageName: "home",
            isLiked: false
        ),
        Floor(
            id: "7b7fd040-5f92-11ec-bf63-0242ac130002",
            place: "Entire Cabin • Norway",
            minimalizedName: "Candyblast by Agnes",
            name: "Candyblast",
            cost: "$141.00",
            imageName: "house",
            isLiked: false
        )
    ]    
}

struct Floor {
    let id: String
    let place: String
    let minimalizedName: String
    let name: String
    let cost: String
    let imageName: String
    var isLiked: Bool
}
