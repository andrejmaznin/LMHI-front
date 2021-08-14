import Foundation

class APIService {
    static func createUser(model: SignUpModel, completion: @escaping (Result<Bool, Error>) -> Void) {
        NetworkingService.request(requestType: .post, endpoint: "users", data: model) { result in
            switch result {
            case .success:
                print(result)
            case .failure:
                print(result)
            }
        }
    }
}
