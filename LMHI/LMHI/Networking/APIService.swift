import Foundation

class APIService {
    enum APIError: Error {
        case unexpectedError
        case userAlreadyExists
        case wrongEmail
        case wrongPassword
    }
    
    struct CreateUserResult: Decodable {
        let success: String
        let id: Int
    }
    
    struct AuthenticationResult: Decodable {
        let session_id: Int
        let success: String
    }
    
    static func createUser(model: SignUpModel, completion: @escaping (Result<Bool, APIError>) -> Void) {
        NetworkingService.request(requestType: .post, endpoint: "users", data: model) { (result: Result<CreateUserResult, Error>) in
            switch result {
            case .success:
                print("Creation Success")
                completion(.success(true))
            case .failure(let error):
                print("Creation Failure")
                if let handledError = error as? NetworkingService.ErrorResult {
                    if handledError.ERROR == "USER ALREADY EXISTS" {
                        completion(.failure(.userAlreadyExists))
                    } else {
                        completion(.failure(.unexpectedError))
                    }
                } else {
                    completion(.failure(.unexpectedError))
                }
            }
        }
    }
    
    static func authenticate(model: SignInModel, completion: @escaping(Result<Bool, APIError>) -> Void) {
        NetworkingService.request(requestType: .post, endpoint: "auth", data: model) { (result: Result<AuthenticationResult, Error>) in
            switch result {
            case .success:
                print("Authentication Success")
                completion(.success(true))
            case .failure(let error):
                print("Authentication Failure")
                if let handledError = error as? NetworkingService.ErrorResult {
                    switch handledError.ERROR {
                    case "NO USER":
                        completion(.failure(.wrongEmail))
                    case "WRONG USERNAME, LOGIN, PHONE OR PASSWORD":
                        completion(.failure(.wrongPassword))
                    default:
                        completion(.failure(.unexpectedError))
                    }
                } else {
                    completion(.failure(.unexpectedError))
                }
            }
        }
    }
}
