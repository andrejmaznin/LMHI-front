import SwiftUI

enum FormTextFieldType: Int {
    case username
    case password
    case personName
    case email
}

struct FormTextField: View {
    let type: FormTextFieldType
    
    @Binding var form: [String]
    @Binding var valid: [Bool]
    
    private var label: String
    
    @State private var validationError = ""
    @State private var fieldIsTouched = false
    
    init(type: FormTextFieldType, form: Binding<Array<String>>, valid: Binding<Array<Bool>>) {
        self.type = type
        self._form = form
        self._valid = valid
        
        switch type {
        case .username:
            label = "Username"
        case .password:
            label = "Password"
        case .personName:
            label = "Full name"
        case .email:
            label = "Email"
        }
    }
    
    var body: some View {
        VStack {
            if type == .password {
                SecureField(label, text: $form[type.rawValue], onCommit: validate)
                    .formTextField(type: type)
            } else {
                TextField(label, text: $form[type.rawValue], onCommit: validate)
                    .formTextField(type: type)
            }
            
            if fieldIsTouched && !valid[type.rawValue] {
                TextFieldError(text: validationError)
            }
        }
        .padding(.top, 10)
        .padding(.bottom, 10)
    }
    
    func validate() {
        fieldIsTouched = true
        let value = form[type.rawValue]
        valid[type.rawValue] = false
        switch type {
        case .username:
            if value.isEmpty {
                validationError = "Enter username"
                return
            }
            
            if !Util.evaluateRegEx(regEx: "[A-Z0-9a-z_]+", value: value) {
                validationError = "Username must contain only letters, numbers or underscores"
                return
            }
            
            if !Util.evaluateRegEx(regEx: "[0-9]*[A-Za-z][A-Z0-9a-z_]*", value: value) {
                validationError = "Username must contain at least one letter"
                return
            }
            
            if value.count < 4 {
                validationError = "Username is too short"
                return
            }
            
            if value.count > 30 {
                validationError = "Username is too long"
                return
            }
        case .password:
            if value.isEmpty {
                validationError = "Enter password"
                return
            }
            
            if value.count < 8 {
                validationError = "Password must contain at least 8 characters"
                return
            }
            
            if value.count > 64 {
                validationError = "Password is too long"
                return
            }
        case .personName:
            if value.isEmpty {
                validationError = "Enter your name"
                return
            }
            
            if !Util.evaluateRegEx(regEx: "[A-Za-z'-]+", value: value) || value.count < 3 || value.count > 32 {
                validationError = "Enter valid name"
                return
            }
        case .email:
            if value.isEmpty {
                validationError = "Enter email address"
                return
            }
            
            if !Util.evaluateRegEx(regEx: "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,32}", value: value) {
                validationError = "Enter valid email address"
                return
            }
        }
        validationError = ""
        valid[type.rawValue] = true
    }
}

struct FormTextField_Previews: PreviewProvider {
    static var previews: some View {
        FormTextField(type: .username, form: .constant(["", "", "", ""]), valid: .constant([false, false, false, false, false]))
    }
}
