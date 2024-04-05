import SwiftUI

struct CustomTabView: View {
    var body: some View {
        TabView {
            BooksView()
                .tabItem {
                    Image(systemName: "books.vertical")
                    Text("Scripture")
                }

            SettingView()
                .tabItem {
                    Image(systemName: "gearshape")
                    Text("Setting")
                }
        }
    }
}

#Preview {
    CustomTabView()
}
