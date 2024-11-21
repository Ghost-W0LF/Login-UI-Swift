
import Foundation
import Alamofire


extension Home {
    class ViewModel: ObservableObject {

        // Create the Alamofire session with the custom interceptor
        let session = Session(interceptor: CustomInterceptor())
        @Published var User: [UserModel] = []
        let baseUrl = "https://jsonplaceholder.typicode.com/posts"
        func loadData() {
            
            // using interceptor
            session.request(baseUrl)
                .responseDecodable(of: [UserModel].self) { response in
                    switch response.result {
                    case .success(let data):
                        DispatchQueue.main.async {
                            self.User = data // Assign response to the variable
                        }
                    case .failure(let error):
                        print("Error: \(error.localizedDescription)")
                    }
                }
            
            //            let interceptor = CustomInterceptor()
            //            let session = Session(interceptor: interceptor)
            //
            //            AF.request(baseUrl,method: .get)
            //                .responseDecodable(of:[UserModel].self){response in
            //                    switch response.result {
            //                    case .success(let fetchedPosts):
            //                        DispatchQueue.main.async {
            //                            self.User = fetchedPosts // Assign response to the variable
            //                        }
            //                    case .failure(let error):
            //                        print("Error: \(error.localizedDescription)")
            //                    }
            //                }
            //            Post request
            let postRequest = PostRequest(title: "Abhinav", body: "bar", userId: 1)
            
            AF.request(baseUrl,method: .post,parameters: postRequest, encoder: JSONParameterEncoder.default)
                .responseDecodable(of:PostResponse.self){response in
                    switch response.result {
                    case .success(let post):
                        print("Created Post: \(post)")
                    case .failure(let error):
                        print("Error: \(error.localizedDescription)")
                    }
                }
            
            
            // get method using URLSession
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
