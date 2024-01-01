
import Foundation

enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case delete = "DELETE"
}

enum NetworkError: Error {
    case invalidURL
    case requestFailed(Error)
    case invalidResponse
    case decodingFailed(Error)
}

struct Model: Codable {}

struct NetworkManager {
    
    static func request<T: Decodable, D: Codable>(
        urlString: String,
        method: HTTPMethod = .post,
        parameters: [String: Any]? = nil,
        systemBody: Data? = nil,
        body: D? = Model(),
        headers: [String: String]? = nil,
        completion: @escaping (Result<T, NetworkError>) -> Void
    ) {
        guard let url = URL(string: urlString) else {
            completion(.failure(.invalidURL))
            return
        }
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        
        headers?.forEach { key, value in
            request.addValue(value, forHTTPHeaderField: key)
        }
        
        do {
            if let systemBody = systemBody {
                request.httpBody = systemBody
            } else if method == .post, let parameters = parameters {
                request.httpBody = try JSONSerialization.data(withJSONObject: parameters)
            } else if (method == .post || method == .put), let body = body, D.self != Model.self {
                request.httpBody = try JSONEncoder().encode(body)
            }
        } catch {
            completion(.failure(.requestFailed(error)))
        }
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print(error.localizedDescription)
                completion(.failure(.requestFailed(error)))
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse else {
                completion(.failure(.invalidResponse))
                return
            }
            
            guard (200...299).contains(httpResponse.statusCode) else {
                print("StatusCode: \(httpResponse.statusCode)")
                completion(.failure(.invalidResponse))
                return
            }
            
            guard let data = data else {
                completion(.failure(.invalidResponse))
                return
            }
            if T.self == String.self {
                if let responseString = String(data: data, encoding: .utf8) {
                    completion(.success(responseString as! T))
                } else {
                    completion(.failure(.decodingFailed(NSError(domain: "YourDomain", code: 100, userInfo: nil))))
                }
            } else {
                do {
                    let decodedData = try JSONDecoder().decode(T.self, from: data)
                    completion(.success(decodedData))
                } catch {
                    print(data)
                    completion(.failure(.decodingFailed(error)))
                }
            }
        }
        task.resume()
    }
}
