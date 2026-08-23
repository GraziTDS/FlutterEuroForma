allprojects {
    repositories {
        google()
        mavenCentral()
    }
}

// Build outputs são gerados fora da pasta sincronizada pelo OneDrive: o cliente do OneDrive
// mantém handles abertos em arquivos recém-criados, o que faz o Gradle falhar ao tentar
// limpar/recriar diretórios de build (ex.: "Unable to delete directory ... mergeDebugAssets").
val newBuildDir: File = File(System.getProperty("user.home"), "FlutterBuildCache/FlutterEuroForma")
rootProject.layout.buildDirectory.set(newBuildDir)

subprojects {
    val newSubprojectBuildDir = File(newBuildDir, project.name)
    project.layout.buildDirectory.set(newSubprojectBuildDir)
}
subprojects {
    project.evaluationDependsOn(":app")
}

tasks.register<Delete>("clean") {
    delete(rootProject.layout.buildDirectory)
}
