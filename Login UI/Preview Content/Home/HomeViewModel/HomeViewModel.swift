
import Foundation
import Alamofire


extension Home {
    class ViewModel: ObservableObject {
  
        @Published var User: [UserModel] = []
        let baseUrl = "https://jsonplaceholder.typicode.com/posts"
        func loadData() {
            AF.request(baseUrl,method: .get)
                .responseDecodable(of:[UserModel].self){response in
                    switch response.result {
                    case .success(let fetchedPosts):
 // Assign response to the variable
                        DispatchQueue.main.async {
                                               self.User = fetchedPosts
                                         }
                    case .failure(let error):
                        print("Error: \(error.localizedDescription)")
                    }
                }
            
            let request = PostRequest(title: "Abhinav", body: "bar", userId: 1)
            
            AF.request(baseUrl,method: .post,parameters: request,encoder: JSONParameterEncoder.default)
                .responseDecodable(of:PostResponse.self){response in
                    switch response.result {
                          case .success(let post):
                              print("Created Post: \(post)")
                          case .failure(let error):
                              print("Error: \(error.localizedDescription)")
                          }
                }
            
         
            //
            //            guard let url = URL(string: "https://jsonplaceholder.typicode.com/posts") else {
            //                print("Invalid URL")
            //                return
            //            }
            //
            //
            //            let task = URLSession.shared.dataTask(with: url) { data, _, error in
            //                guard let data = data, error == nil
            //                else {
            //                    print("Error: \(error?.localizedDescription ?? "Unknown error")")
            //                    return
            //                }
            //
            //                // Decode JSON
            //                do {
            //                    let users = try JSONDecoder().decode([UserModel].self, from: data)
            //                // Debug print
            //                    DispatchQueue.main.async {
            //                        self.User = users
            //                    }
            //                } catch {
            //                    print("Decoding Error: \(error)")
            //                }
            //            }
            //            task.resume()
            //        }
        }
    }
}
