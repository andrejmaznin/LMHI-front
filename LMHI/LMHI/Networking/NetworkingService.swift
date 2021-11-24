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
    
    private static var serverURL = "https://luscherian.herokuapp.com/"
    
    static func POSTRequest<T, U>(endpoint: String, data: T, completion: @escaping (Result<U, Error>) -> Void) where T: Encodable, U: Decodable {
        guard let url = URL(string: NetworkingService.serverURL + endpoint) else {
            completion(.failure(NetworkingError.badUrl))
            return
        }
        
        var request = URLRequest(url: url)
        guard let body = try? JSONEncoder().encode(data) else {
            completion(.failure(NetworkingError.badEncoding))
            return
        }
        request.httpBody = body
        request.httpMethod = "POST"
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
                if let object = try? JSONDecoder().decode(U.self, from: unwrappedData) {
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
