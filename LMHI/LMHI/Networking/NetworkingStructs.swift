import Foundation

struct SignUpObject: Encodable {
    let name: String
    let hashed_password: String
    let email: String
    let info: String
}

struct SignInOnject: Encodable {
    let action : String = "login"
    let email: String;
    let hashed_password: String;
}

enum NetworkingError: Error {
    case badUrl
    case badResponse
    case badEncoding
    case badDecoding
}

struct Network {
    public enum requestType : String {
        case get    = "GET"
        case post   = "POST"
        case delete = "DELETE"
    }
    
    public struct RequestResult {
        let status: Int;
        let data: Any;
    }
    
    static let serverURL = "https://luscherian.herokuapp.com"

    @inlinable
    static func onMain<T>(_ function: @escaping (T) -> Void, _ arg1: T) -> Void {
        DispatchQueue.main.async {
            function(arg1);
        }
    }
    
    @inlinable
    static func encode<T>(_ value: T) -> Data? where T : Encodable {
        return try? JSONEncoder().encode(value);
    }
    
    @inlinable
    static func decode(_ unwrappedData: Data, _ options: JSONSerialization.ReadingOptions = []) -> Any? {
        return try? JSONSerialization.jsonObject(with: unwrappedData, options: options);
    }
}
