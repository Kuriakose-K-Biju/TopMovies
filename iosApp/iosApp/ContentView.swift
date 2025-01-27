import UIKit
import SwiftUI
import ComposeApp

struct ComposeView: UIViewControllerRepresentable {
    @ObservedObject var sharedViewModelWrapper: SharedViewModelWrapper
    func makeUIViewController(context: Context) -> UIViewController {
        MainViewControllerKt.MainViewController(selectedMovieViewModel: sharedViewModelWrapper.viewModel)
    }

    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {}
}

struct ContentView: View {
    @ObservedObject var sharedViewModelWrapper: SharedViewModelWrapper = SharedViewModelWrapper()
    
    var body: some View {
        NavigationView {
            VStack {
                ComposeView(sharedViewModelWrapper: sharedViewModelWrapper)
                        .ignoresSafeArea(.keyboard) // Compose has own keyboard handler
                NavigationLink(
                    destination: MovieDetailsView(movieID: sharedViewModelWrapper.value),
                    isActive: Binding(get: { sharedViewModelWrapper.moveToDetails ?? false },
                                      set: { if !$0 {sharedViewModelWrapper.updateValue(newValue: "")} }
                                     )
                ) {
                    EmptyView()
                }
            }
        }
    }
}

class SharedViewModelWrapper: ObservableObject {
    let viewModel: SelectedMovieViewModel
    private var cancellables = [Any]() // Keep references to prevent deallocation
    @Published var value: String = ""
    @Published var moveToDetails: Bool?

    init() {
        self.viewModel = SelectedMovieViewModel()
        observeValue()
    }

    private func observeValue() {
        viewModel.valueAsCommonFlow().collect { [weak self] newValue in
            DispatchQueue.main.async {
                if let movieId = newValue as? String, movieId != "" {
                    self?.value = movieId
                    self?.moveToDetails = true
                } else {
                    self?.value = ""
                    self?.moveToDetails = false
                }
            }
        }
    }

    func updateValue(newValue: String) {
        viewModel.updateValue(newValue: newValue)
    }
}
