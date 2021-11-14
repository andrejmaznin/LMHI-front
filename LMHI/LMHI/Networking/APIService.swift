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
    
    struct ExitResult: Decodable {
        let success: String
    }
    
    struct TestSubmitionResult: Decodable {
        let results: [String]
        let success: String
    }
    
    static func createUser(model: SignUpModel, completion: @escaping (Result<Bool, APIError>) -> Void) {
        NetworkingService.request(requestType: .post, endpoint: "users", data: model) { (result: Result<CreateUserResult, Error>) in
            switch result {
            case .success:
                AppState.debugLog("Creation Success")
                completion(.success(true))
            case .failure(let error):
                AppState.debugLog("Creation Failure")
                if let handledError = error as? NetworkingService.ErrorResult {
                    if handledError.ERROR == "USER ALREADY EXISTS" {
                        completion(.failure(.userAlreadyExists))
                    } else {
                        print(handledError.ERROR)
                        completion(.failure(.unexpectedError))
                    }
                } else {
                    completion(.failure(.unexpectedError))
                }
            }
        }
    }
    
    static func authenticate(model: SignInModel, completion: @escaping(Result<Int, APIError>) -> Void) {
        NetworkingService.request(requestType: .post, endpoint: "auth", data: model) { (result: Result<AuthenticationResult, Error>) in
            switch result {
            case .success(let authResult):
                AppState.debugLog("Authentication Success")
                completion(.success(authResult.session_id))
            case .failure(let error):
                AppState.debugLog("Authentication Failure")
                if let handledError = error as? NetworkingService.ErrorResult {
                    switch handledError.ERROR {
                    case "NO USER":
                        completion(.failure(.wrongEmail))
                    case "WRONG USERNAME, LOGIN, PHONE OR PASSWORD":
                        completion(.failure(.wrongPassword))
                    default:
                        print(handledError.ERROR)
                        completion(.failure(.unexpectedError))
                    }
                } else {
                    completion(.failure(.unexpectedError))
                }
            }
        }
    }
    
    static func exit(model: SignOutModel, completion: @escaping(Result<Bool, APIError>) -> Void) {
        NetworkingService.request(requestType: .post, endpoint: "auth", data: model) { (result: Result<ExitResult, Error>) in
            switch result {
            case .success:
                AppState.debugLog("Exit Success")
                completion(.success(true))
            case .failure(let error):
                print("Exit Failure")
                if let handledError = error as? NetworkingService.ErrorResult {
                    print(handledError.ERROR)
                }
                completion(.failure(.unexpectedError))
            }
        }
    }
    
    static func submitTestResults(model: TestResultsModel, completion: @escaping(Result<[String], APIError>) -> Void) {
        NetworkingService.request(requestType: .post, endpoint: "result", data: model) { (result: Result<TestSubmitionResult, Error>) in
            switch result {
            case .success(let result):
                AppState.debugLog("Test Results Submition Success")
                completion(.success(result.results))
            case .failure(let error):
                print("Test Results Submition Failure")
                if let handledError = error as? NetworkingService.ErrorResult {
                    print(handledError.ERROR)
                }
                print(error)
                completion(.failure(.unexpectedError))
            }
        }
    }
}
