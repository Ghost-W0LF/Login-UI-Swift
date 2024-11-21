import Foundation

struct UserModel:Hashable, Decodable {
   let userId: Int
   let id: Int
   let title: String
   let body: String
}
// Request Model (Optional, if you use Encodable)
struct PostRequest: Codable {
    let title: String
    let body: String
    let userId: Int
}

// Response Model (Decodable)
struct PostResponse: Decodable {
    let id: Int
    let title: String
    let body: String
    let userId: Int
}
