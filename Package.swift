import PackageDescription

let package = Package(
    name: "Graphene",
    targets: [
        Target(name: "Graphene", dependencies: ["Intrinsics"]),
    ]
)
