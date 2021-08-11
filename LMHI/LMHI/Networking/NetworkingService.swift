import Foundation

class NetworkingService {
    struct RequestResult {
        let status: Int
        let data: Any
    }
    
    enum RequestType: String {
        case get = "GET"
        case post = "POST"
    }
    
    enum NetworkingError: Error {
        case badUrl
        case badResponse
        case badData
        case badEncoding
        case badDecoding
    }
    
    private static var serverURL = "https://luscherian.herokuapp.com/"
    
    static func request<T>(requestType: RequestType, endpoint: String, data: T, completion: @escaping (Result<RequestResult, Error>) -> Void) where T: Encodable {
        guard let url = URL(string: NetworkingService.serverURL + endpoint) else {
            completion(.failure(NetworkingError.badUrl))
            return
        }
        var request = URLRequest(url: url)
        guard let body = encode(data) else {
            completion(.failure(NetworkingError.badEncoding))
            return
        }
        request.httpBody = body
        request.httpMethod = requestType.rawValue
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let session = URLSession.shared
        let task = session.dataTask(with: request) { data, response, error in
            DispatchQueue.main.async {
                guard let unwrappedResponse = response as? HTTPURLResponse else {
                    completion(.failure(NetworkingError.badResponse))
                    return
                }
                if let unwrappedError = error {
                    completion(.failure(unwrappedError))
                    return
                }
                guard let unwrappedData = data else {
                    completion(.failure(NetworkingError.badData))
                    return
                }
                if let json = decode(unwrappedData) {
                    completion(.success(RequestResult(status: unwrappedResponse.statusCode, data: json)))
                } else {
                    completion(.failure(NetworkingError.badDecoding))
                }
            }
        }
        task.resume()
    }
    
    private static func encode<T>(_ data: T) -> Data? where T: Encodable {
        return try? JSONEncoder().encode(data)
    }
    
    private static func decode(_ data: Data) -> Any? {
        return try? JSONSerialization.jsonObject(with: data, options: [])
    }
}
