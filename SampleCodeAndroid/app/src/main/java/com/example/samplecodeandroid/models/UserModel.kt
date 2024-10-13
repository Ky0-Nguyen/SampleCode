package com.example.samplecodeandroid.models

/**
 * Represents a user with a name, email, and image URL.
 * 
 * This data class is used to model a user in the application. It contains three properties:
 * - name: The user's full name.
 * - email: The user's email address.
 * - imageUrl: The URL of the user's profile image.
 */
data class UserModel(
    val name: String,
    val email: String,
    val imageUrl: String
)