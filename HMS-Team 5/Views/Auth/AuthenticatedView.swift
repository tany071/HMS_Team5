import SwiftUI
extension String {
    subscript (bounds: CountableClosedRange<Int>) -> String {
        let start = index(startIndex, offsetBy: bounds.lowerBound)
        let end = index(startIndex, offsetBy: bounds.upperBound)
        return String(self[start...end])
    }

    subscript (bounds: CountableRange<Int>) -> String {
        let start = index(startIndex, offsetBy: bounds.lowerBound)
        let end = index(startIndex, offsetBy: bounds.upperBound)
        return String(self[start..<end])
    }
}
// see
extension AuthenticatedView where Unauthenticated == EmptyView {
  init(@ViewBuilder content: @escaping () -> Content) {
    self.unauthenticated = nil
    self.content = content
  }
}

struct AuthenticatedView<Content, Unauthenticated>: View where Content: View, Unauthenticated: View {
  @StateObject private var viewModel = AuthenticationViewModel()
  @State private var presentingLoginScreen = false
  @State private var presentingProfileScreen = false

  var unauthenticated: Unauthenticated?
  @ViewBuilder var content: () -> Content

  public init(unauthenticated: Unauthenticated?, @ViewBuilder content: @escaping () -> Content) {
    self.unauthenticated = unauthenticated
    self.content = content
  }

  public init(@ViewBuilder unauthenticated: @escaping () -> Unauthenticated, @ViewBuilder content: @escaping () -> Content) {
    self.unauthenticated = unauthenticated()
    self.content = content
  }

    
    

  var body: some View {
    switch viewModel.authenticationState {
    case .unauthenticated, .authenticating:
      VStack {
        if let unauthenticated {
          unauthenticated
        }
        else {
          Text("You're not logged in.")
        }
        Button("Tap here to log in") {
          viewModel.reset()
          presentingLoginScreen.toggle()
        }
      }
      .sheet(isPresented: $presentingLoginScreen) {
        AuthenticationView()
          .environmentObject(viewModel)
      }
    case .authenticated:
      VStack {
        content()
        Text("You're logged in as \(viewModel.displayName).")
        Button("Tap here to view your profile") {
          presentingProfileScreen.toggle()
        }
      }
      .sheet(isPresented: $presentingProfileScreen) {
          if(viewModel.displayName[0..<6] == "doctor"){
              NavigationView {
                DoctorView()
                  .environmentObject(viewModel)
              }
              
          }
          if(viewModel.role == "Doctor"){
              NavigationView {
                DoctorView()
                  .environmentObject(viewModel)
              }
              
          }
          if(viewModel.role == "User"){
              NavigationView{
                UserProfileView()
                  .environmentObject(viewModel)
              }
              
          }
          if(viewModel.displayName == "admin@admin.com"){
              NavigationView{
                AdminView()
                  .environmentObject(viewModel)
              }
              
          }
      }
    }
  }
}

struct AuthenticatedView_Previews: PreviewProvider {
  static var previews: some View {
    AuthenticatedView {
      Text("You're signed in.")
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
        .background(.yellow)
    }
  }
}
