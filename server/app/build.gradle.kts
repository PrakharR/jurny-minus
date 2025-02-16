import com.github.jengelman.gradle.plugins.shadow.tasks.ShadowJar
import com.jurnybuild.docker.DockerBuild

plugins {
    application
    kotlin("jvm") version "2.0.20"
    id("com.gradleup.shadow") version("8.3.6")
    id("jurnybuild.docker")
}

kotlin {
    jvmToolchain(21)
}

repositories {
    mavenCentral()
}

application {
    mainClass = "com.jurny.server.Main"
}

dependencies {
    implementation(platform("org.http4k:http4k-bom:6.0.0.0"))

    implementation("org.http4k:http4k-core")
    implementation("org.http4k:http4k-server-undertow")
}

tasks.test {
    useJUnitPlatform()
}

tasks.register<DockerBuild>("dockerBuild") {
    t.set("jurny-server")
    resources.from(tasks.named("shadowJar"))
}
