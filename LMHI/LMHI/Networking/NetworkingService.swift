import Foundation

class NetworkingService {
    
    public static func reuest<T>(
        requestType: Network.requestType,
        endpoint: String,
        data: T,
        completion: @escaping (Result<Network.RequestResult, Error>) -> Void
    ) -> Void where T : Encodable {
        
        guard let url = URL(string: Network.serverURL + endpoint) else {
            completion(.failure(NetworkingError.badUrl))
            return
        }
        
        let session = URLSession.shared
        var request = URLRequest(url: url)
        
        request.httpBody = Network.encode(data)
        
        if request.httpBody == nil {
            completion(.failure(NetworkingError.badEncoding))
            return
        }
        
        request.httpMethod = requestType.rawValue
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let task = session.dataTask(with: request) { (data, response, error) in
            guard let unwrappedResponse = response as? HTTPURLResponse else {
                Network.onMain(completion, .failure(NetworkingError.badResponse))
                return
            }
            
            if let unwrappedError = error {
                Network.onMain(completion, .failure(unwrappedError))
                return
            }
            
            if data != nil {
                guard let json = Network.decode(data!) else {
                    Network.onMain(completion, .failure(NetworkingError.badDecoding))
                    return
                }
                Network.onMain(completion, .success(Network.RequestResult(status: unwrappedResponse.statusCode, data: json)))
            }
        }
        
        task.resume()
    }
}
