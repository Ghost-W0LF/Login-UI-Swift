import Foundation

extension Home {
    class ViewModel: ObservableObject {
        @Published var User: [UserModel] = [] // Stores the decoded API data

        func loadData() {
            guard let url = URL(string: "https://jsonplaceholder.typicode.com/posts") else {
                print("Invalid URL")
                return
            }


            let task = URLSession.shared.dataTask(with: url) { data, _, error in
                guard let data = data, error == nil
                else {
                    print("Error: \(error?.localizedDescription ?? "Unknown error")")
                    return
                }

                // Decode JSON
                do {
                    let users = try JSONDecoder().decode([UserModel].self, from: data)
                // Debug print
                    DispatchQueue.main.async {
                        self.User = users
                    }
                } catch {
                    print("Decoding Error: \(error)")
                }
            }
            task.resume()
        }

    }
}
