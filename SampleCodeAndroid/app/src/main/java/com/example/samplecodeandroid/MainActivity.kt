package com.example.samplecodeandroid

import android.os.Bundle
import androidx.activity.ComponentActivity
import androidx.activity.compose.setContent
import androidx.activity.enableEdgeToEdge
import androidx.compose.foundation.Image
import androidx.compose.foundation.lazy.LazyColumn
import androidx.compose.foundation.lazy.items
import androidx.compose.foundation.layout.fillMaxSize
import androidx.compose.foundation.layout.fillMaxWidth
import androidx.compose.foundation.layout.height
import androidx.compose.foundation.layout.padding
import androidx.compose.material3.Scaffold
import androidx.compose.material3.Text
import androidx.compose.runtime.Composable
import androidx.compose.ui.Modifier
import androidx.compose.ui.layout.ContentScale
import androidx.compose.ui.tooling.preview.Preview
import androidx.compose.ui.unit.dp
import com.example.samplecodeandroid.ui.theme.SampleCodeAndroidTheme
import coil.compose.rememberAsyncImagePainter
import com.example.samplecodeandroid.models.UserModel
import com.github.javafaker.Faker

/**
 * Generates a list of fake users with random names, emails, and image URLs.
 * 
 * @param count The number of fake users to generate.
 * @return A list of UserModel objects representing the fake users.
 */
fun generateFakeUsers(count: Int): List<UserModel> {
    val faker = Faker()
    return List(count) {
        UserModel(
            name = faker.name().fullName(),
            email = faker.internet().emailAddress(),
            imageUrl = "https://picsum.photos/200/300?random=$it"
        )
    }
}

class MainActivity : ComponentActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        enableEdgeToEdge()
        setContent {
            SampleCodeAndroidTheme {
                Scaffold(modifier = Modifier.fillMaxSize()) { innerPadding ->
                    GifListScreen(modifier = Modifier.padding(innerPadding))
                }
            }
        }
    }
}

/**
 * Composable function to display a list of GIFs.
 * 
 * @param modifier The modifier to apply to the LazyColumn.
 */
@Composable
fun GifListScreen(modifier: Modifier = Modifier) {
    val users = generateFakeUsers(1000)
    LazyColumn(modifier = modifier) {
        items(users) { user ->
            GifRow(user = user)
        }
    }
}

/**
 * Composable function to display a single GIF row.
 * 
 * @param user The UserModel object representing the user.
 */
@Composable
fun GifRow(user: UserModel) {
    Image(
        painter = rememberAsyncImagePainter(user.imageUrl),
        contentDescription = "GIF",
        contentScale = ContentScale.Crop,
        modifier = Modifier
            .fillMaxWidth()
            .height(300.dp)
            .padding(16.dp)
    )
    Text(text = user.name)
    Text(text = user.email)
}

/**
 * Preview function for GifListScreen.
 */
@Preview(showBackground = true)
@Composable
fun GreetingPreview() {
    GifListScreen()
}