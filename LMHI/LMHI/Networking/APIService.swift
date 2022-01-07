import Foundation

class APIService {
    enum APIError: Error {
        case unexpectedError
        case userAlreadyExists
        case wrongEmail
        case wrongPassword
    }
    
    struct CreateUserResult: Decodable {
        let token: String
    }
    
    struct AuthenticationResult: Decodable {
        let token: String
    }
    
    struct TestSubmitionResult: Decodable {
        struct Result: Decodable {
            let main: String
            let blue: String
            let green: String
            let red: String
            let yellow: String
        }
        
        let result: Result
    }
    
    struct TestResult: Decodable {
        let time: Int
        let main: String
        let blue: String
        let green: String
        let red: String
        let yellow: String
    }
    
    struct MoodCriteria: Decodable {
        let id: Int
        let name: String
    }
    
    static func createUser(model: SignUpModel, completion: @escaping (Result<Bool, APIError>) -> Void) {
        NetworkingService.POSTRequest(endpoint: "users", data: model) { (result: Result<CreateUserResult, Error>) in
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
    
    static func authenticate(model: SignInModel, completion: @escaping(Result<String, APIError>) -> Void) {
        NetworkingService.POSTRequest(endpoint: "auth", data: model) { (result: Result<AuthenticationResult, Error>) in
            switch result {
            case .success(let authResult):
                AppState.debugLog("Authentication Success")
                completion(.success(authResult.token))
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
    
    static func submitTestResults(model: TestResultsModel, completion: @escaping(Result<TestSubmitionResult.Result, APIError>) -> Void) {
        NetworkingService.GETRequest(endpoint: "result", URLParameters: model.data) { (result: Result<TestSubmitionResult, Error>) in
            switch result {
            case .success(let result):
                AppState.debugLog("Test Results Submition Success")
                completion(.success(result.result))
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
    
    static func getAllTestResults(model: AllTestsResultsModel, completion: @escaping(Result<[TestResult], APIError>) -> Void) {
        NetworkingService.GETRequest(endpoint: "test_result", headers: model.data) { (result: Result<[TestResult], Error>) in
            switch result {
            case .success(let result):
                AppState.debugLog("Successfully Received All Tests Results")
                completion(.success(result))
            case .failure(let error):
                print("Failed to Receive All Tests Results")
                if let handledError = error as? NetworkingService.ErrorResult {
                    print(handledError.ERROR)
                }
                print(error)
                completion(.failure(.unexpectedError))
            }
        }
    }
    
    static func getMoodCriterias(completion: @escaping(Result<[String], APIError>) -> Void) {
        NetworkingService.GETRequest(endpoint: "mood_criteria") { (result: Result<[MoodCriteria], Error>) in
            switch result {
            case .success(let result):
                AppState.debugLog("Successfully Received Mood Criterias")
                var res: [String] = []
                for criteria in result {
                    res.append(criteria.name)
                }
                completion(.success(res))
            case .failure(let error):
                print("Failed to Receive Mood Criterias")
                if let handledError = error as? NetworkingService.ErrorResult {
                    print(handledError.ERROR)
                }
                print(error)
                completion(.failure(.unexpectedError))
            }
        }
    }
}
