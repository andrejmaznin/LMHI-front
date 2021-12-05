import Foundation

class NetworkingService {
    struct ErrorResult: Decodable, Error {
        let ERROR: String
    }
    
    enum NetworkingError: Error {
        case badUrl
        case badResponse
        case badData
        case badEncoding
        case badDecoding
    }
    
    static func GETRequest<T>(endpoint: String, URLParameters: [String: Any] = [:], completion: @escaping (Result<T, Error>) -> Void) where T: Decodable {
        request(endpoint: endpoint, URLParameters: URLParameters, data: nil, method: "GET", contentType: "application/x-www-form-urlencoded", completion: completion)
    }
    
    static func POSTRequest<T, U>(endpoint: String, URLParameters: [String: Any] = [:], data: T, completion: @escaping (Result<U, Error>) -> Void) where T: Encodable, U: Decodable {
        guard let JSONData = try? JSONEncoder().encode(data) else {
            completion(.failure(NetworkingError.badEncoding))
            return
        }
        request(endpoint: endpoint, URLParameters: URLParameters, data: JSONData, method: "POST", contentType: "application/json", completion: completion)
    }
    
    private static let serverURL = "https://luscherian.herokuapp.com/"
    
    private static func request<T>(endpoint: String, URLParameters: [String: Any] = [:], data: Data?, method: String, contentType: String, completion: @escaping (Result<T, Error>) -> Void) where T: Decodable {
        guard let domainComponent = URLComponents(string: NetworkingService.serverURL + endpoint) else {
            completion(.failure(NetworkingError.badUrl))
            return
        }
        let queryItems = URLParameters.map { (key, value) in
            URLQueryItem(name: key, value: String(describing: value))
        }
        var components = domainComponent
        components.queryItems = queryItems
        guard let url = components.url else {
            completion(.failure(NetworkingError.badUrl))
            return
        }
        AppState.debugLog(url)
        var request = URLRequest(url: url)
        
        request.httpBody = data
        
        request.httpMethod = method
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let session = URLSession.shared
        let task = session.dataTask(with: request) { data, response, error in
            DispatchQueue.main.async {
                guard let unwrappedResponse = response as? HTTPURLResponse else {
                    completion(.failure(NetworkingError.badResponse))
                    return
                }
                AppState.debugLog(unwrappedResponse.statusCode)
                if let unwrappedError = error {
                    completion(.failure(unwrappedError))
                    return
                }
                guard let unwrappedData = data else {
                    completion(.failure(NetworkingError.badData))
                    return
                }
                AppState.debugLog(try! JSONSerialization.jsonObject(with: unwrappedData, options: []))
                if let object = try? JSONDecoder().decode(T.self, from: unwrappedData) {
                    completion(.success(object))
                } else if let errorResult = try? JSONDecoder().decode(ErrorResult.self, from: unwrappedData) {
                    completion(.failure(errorResult))
                } else {
                    completion(.failure(NetworkingError.badDecoding))
                }
            }
        }
        task.resume()
    }
}
