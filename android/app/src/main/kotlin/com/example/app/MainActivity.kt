import android.app.Activity
import android.content.Intent
import android.provider.MediaStore
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel

class MainActivity: FlutterActivity() {
    private val CHANNEL = "com.example.app/image_picker"
    private val PICK_IMAGE = 1
    private val TAKE_PHOTO = 2

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL).setMethodCallHandler { call, result ->
            when (call.method) {
                "pickImage" -> {
                    when (call.argument<String>("source")) {
                        "gallery" -> {
                            val intent = Intent(Intent.ACTION_PICK)
                            intent.type = "image/*"
                            startActivityForResult(intent, PICK_IMAGE)
                        }
                        "camera" -> {
                            val intent = Intent(MediaStore.ACTION_IMAGE_CAPTURE)
                            startActivityForResult(intent, TAKE_PHOTO)
                        }
                    }
                }
                else -> result.notImplemented()
            }
        }
    }

    override fun onActivityResult(requestCode: Int, resultCode: Int, data: Intent?) {
        super.onActivityResult(requestCode, resultCode, data)
        if (resultCode == Activity.RESULT_OK) {
            when (requestCode) {
                PICK_IMAGE -> {
                    val uri = data?.data
                    // Convert URI to file path and send back to Flutter
                    val path = getRealPathFromURI(uri)
                    MethodChannel(flutterEngine?.dartExecutor?.binaryMessenger!!, CHANNEL)
                        .invokeMethod("imageSelected", path)
                }
                TAKE_PHOTO -> {
                    val image = data?.extras?.get("data") as Bitmap
                    // Save bitmap to file and send path back to Flutter
                    val path = saveBitmapToFile(image)
                    MethodChannel(flutterEngine?.dartExecutor?.binaryMessenger!!, CHANNEL)
                        .invokeMethod("imageSelected", path)
                }
            }
        }
    }
} 