//
//  SampleCodeIosApp.swift
//  SampleCodeIos
//
//  Created by Hổ's Macbook on 11/10/2024.
//

import SwiftUI
import Fakery

struct User: Identifiable {
    let id = UUID()
    let name: String
    let email: String
    let avatarUrl: String
}

func generateFakeUsers(count: Int) -> [User] {
    let faker = Faker()  // Create an instance of Faker
    return (0..<count).map { _ in
        User(
            name: faker.name.name(),
            email: faker.internet.email(),
            avatarUrl: "https://picsum.photos/200/200?random=\(Int.random(in: 1...1000))"
        )
    }
}

struct GifRow: View {
    let user: User

    var body: some View {
        AsyncImage(url: URL(string: user.avatarUrl)) { phase in
            switch phase {
            case .empty:
                ProgressView()
            case .success(let image):
                image
                    .resizable()
                    .scaledToFit()
            case .failure:
                Image(systemName: "photo")
                    .resizable()
                    .scaledToFit()
            @unknown default:
                EmptyView()
            }
        }
        .frame(height: 200)
        VStack(alignment: .leading) {
            Text(user.name).font(.headline)
            Text(user.email).font(.subheadline).foregroundColor(.gray)
        }
    }
}

struct GifListView: View {
    let users = generateFakeUsers(count: 1000)

    var body: some View {
        List(users) { user in
            GifRow(user: user)
        }
    }
}

@main
struct SampleCodeIosApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            GifListView()
        }
    }
}
