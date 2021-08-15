import Foundation

class APIService {
    enum APIError: Error {
        case unexpectedError
        case userAlreadyExists
    }
    
    struct CreateUserResult: Decodable {
        let success: String
        let id: Int
    }
    
    struct AuthenticationResult: Decodable {
        let session_id: Int
        let success: String
    }
    
    static func createUser(model: SignUpModel, completion: @escaping (Result<Int, APIError>) -> Void) {
        NetworkingService.request(requestType: .post, endpoint: "users", data: model) { (result: Result<CreateUserResult, Error>) in
            switch result {
            case .success(let result):
                print("Success")
                completion(.success(result.id))
            case .failure(let error):
                print("Failure")
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
        NetworkingService.request(requestType: .post, endpoint: "auth", data: model) { (result: Result<Bool, Error>) in
            switch result {
            case .success:
                print("Success")
            case .failure:
                print("Failure")
            }
        }
    }
}
