package com.jurnybuild.deploy


import org.gradle.api.DefaultTask
import org.gradle.api.file.DirectoryProperty
import org.gradle.api.provider.ListProperty
import org.gradle.api.tasks.Input
import org.gradle.api.tasks.InputDirectory
import org.gradle.api.tasks.Optional
import org.gradle.api.tasks.TaskAction
import org.gradle.process.ExecOperations
import org.gradle.work.DisableCachingByDefault
import javax.inject.Inject

@DisableCachingByDefault
abstract class GcloudTask @Inject constructor(private val execOps: ExecOperations) : DefaultTask() {

    @get:Input
    abstract val args: ListProperty<String>

    @get:Optional
    @get:InputDirectory
    abstract val workingDir: DirectoryProperty

    @TaskAction
    fun run() {
        execOps.exec {
            if (this@GcloudTask.workingDir.isPresent) {
                workingDir(this@GcloudTask.workingDir.get())
            }
            commandLine(listOf("gcloud") + this@GcloudTask.args.get())
        }
    }
}
