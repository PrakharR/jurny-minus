plugins {
    application
    kotlin("jvm") version "2.0.20"
}

kotlin {
    jvmToolchain(21)
}

repositories {
    mavenCentral()
}

dependencies {
    implementation(platform("org.http4k:http4k-bom:6.0.0.0"))

    implementation("org.http4k:http4k-core")
    implementation("org.http4k:http4k-server-undertow")
}

application {
    mainClass = "com.jurny.server.Main"
}

tasks.test {
    useJUnitPlatform()
}
