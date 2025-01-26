package com.kuriakose.biju.topmovies.movie.data.network

import com.kuriakose.biju.topmovies.core.domain.DataError
import com.kuriakose.biju.topmovies.core.domain.Result
import com.kuriakose.biju.topmovies.core.data.safeCall
import com.kuriakose.biju.topmovies.movie.data.dataTransferObjects.TopMovieResponseDTO
import io.ktor.client.HttpClient
import io.ktor.client.request.get
import io.ktor.client.request.headers
import io.ktor.http.HttpHeaders

private const val BASE_URL = "https://api.themoviedb.org/3/movie"

class KtorRemoteMovieDataSource(
    private val httpClient: HttpClient
): RemoteMovieDataSource {
    override suspend fun getMovies(): Result<TopMovieResponseDTO, DataError.Remote> {
        return safeCall {
            httpClient.get(
                urlString = "$BASE_URL/top_rated?page=1"
            ) {
                headers {
                    append(HttpHeaders.Authorization, "Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJkODEwNWRiZTQwYmVhMTFjNWIwMjQxYTRiZTIxMDUxNSIsIm5iZiI6MTUwODg1ODE3NS41MTcsInN1YiI6IjU5ZWY1OTNmYzNhMzY4NDFjNzAwZWE5ZSIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.CcjVcHy5TnsyaUnZu4lrBcHQJU1s5cHoPAxdxEkyEQk")
                append(HttpHeaders.Accept,"application/json")
                }
            }
        }
    }
}