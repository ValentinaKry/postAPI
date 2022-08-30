
import Foundation

    // GET, POST, DELETE, etc.

func makePOSTRequest() {
    guard let  url  = URL(string: "https://jsonplaceholder.typicode.com/posts") else {
        return
    }

    print("Making api call...")

    var request = URLRequest(url: url)
        // method, body, headers
    request.httpMethod = "POST"
    request.setValue("application/json", forHTTPHeaderField: "Content-Type")
    let body: [String: AnyHashable] = [
        "userId": 1,
        "title": "Hello From IOS Academy",
        "body": "The quick brown fox jumped over the lazy dog. The quick brown fox jumped over the lazy dog. The quick brown fox jumped over the lazy dog."
    ]
    request.httpBody = try? JSONSerialization.data(withJSONObject: body, options: .fragmentsAllowed)

        // Make the request
    let task = URLSession.shared.dataTask(with: request) { data, _, error in
        guard let data = data, error == nil else {
            return
        }

        do {
            let response = try JSONDecoder().decode(Response.self, from: data)
            print("SUCCESS: \(response)")
        }
        catch {
            print(error)
        }
    }

    task.resume()


}

struct Response: Codable {
    let body: String
    let id: Int
    let userId: Int
    let title: String
}

let post = makePOSTRequest()
print(post)

