package com.kuriakose.biju.topmovies

interface Platform {
    val name: String
}

expect fun getPlatform(): Platform