package com.jurny.server

import org.http4k.core.Request
import org.http4k.core.Response
import org.http4k.core.Status.Companion.OK
import org.http4k.server.Undertow
import org.http4k.server.asServer

class Main {
    companion object {
        @JvmStatic
        fun main(args: Array<String>) {
            val app = { request: Request -> Response(OK).body("Hello, ${request.query("name")}!!!") }
            val server = app.asServer(Undertow(8080)).start()
            println("Server started on port ${server.port()}")
        }
    }
}
