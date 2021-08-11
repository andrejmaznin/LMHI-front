import Foundation

class APIService {
    static func createUser(model: SignUpModel, completion: @escaping (Result<Bool, Error>) -> Void) {
        NetworkingService.request(requestType: .post, endpoint: "users", data: model) { result in
            print(result)
        }
    }
}
