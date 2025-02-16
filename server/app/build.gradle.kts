import com.jurnybuild.deploy.DockerBuild
import com.jurnybuild.deploy.DockerTask
import com.jurnybuild.deploy.GcloudTask
import java.time.LocalDateTime
import java.time.format.DateTimeFormatter

plugins {
    application
    kotlin("jvm") version "2.0.20"
    id("com.gradleup.shadow") version("8.3.6")
    id("jurnybuild.deploy")
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

val tag = LocalDateTime.now().format(DateTimeFormatter.ofPattern("uuuu-MM-dd-HH-mm-ss"))
val imageRepo = "jurny-server"
val imageReference = "$imageRepo:$tag"
val gcloudProjectName = "jurny-minus"
val gcrImageReference = "gcr.io/$gcloudProjectName/$imageReference"
val gcloudRunApp = imageRepo

val dockerBuild by tasks.registering(DockerBuild::class) {
    t.set(imageReference)
    resources.from(tasks.named("shadowJar"))
}

tasks.register<DockerTask>("dockerRun") {
    dependsOn(dockerBuild)
    args.addAll(listOf("run", "--name=$imageRepo", "--rm", "-p", "8080:8080", imageReference))
}

val dockerTagGcr by tasks.registering(DockerTask::class) {
    dependsOn(dockerBuild)
    args.addAll(listOf("tag", imageReference, gcrImageReference))
}

val dockerPushGcr by tasks.registering(DockerTask::class) {
    dependsOn(dockerTagGcr)
    args.addAll(listOf("push", gcrImageReference))
}

// View logs here: https://console.cloud.google.com/run/detail/asia-southeast1/jurny-server/logs?project=jurny-minus
tasks.register<GcloudTask>("gcloudRunDeploy") {
    dependsOn(dockerPushGcr)
    args.addAll(listOf("run", "deploy", gcloudRunApp, "--image", gcrImageReference, "--region", "asia-southeast1"))
}
