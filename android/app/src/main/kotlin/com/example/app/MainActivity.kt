import android.app.Activity
import android.content.Intent
import android.graphics.Bitmap
import android.net.Uri
import android.provider.MediaStore
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import java.io.File
import java.io.FileOutputStream

class MainActivity : FlutterActivity() {
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
                        else -> result.error("INVALID_SOURCE", "Invalid source provided", null)
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
                    val path = getRealPathFromURI(uri)
                    if (path != null) {
                        MethodChannel(flutterEngine?.dartExecutor?.binaryMessenger!!, CHANNEL)
                            .invokeMethod("imageSelected", path)
                    } else {
                        MethodChannel(flutterEngine?.dartExecutor?.binaryMessenger!!, CHANNEL)
                            .invokeMethod("imageSelectionFailed", "Unable to retrieve path")
                    }
                }
                TAKE_PHOTO -> {
                    val image = data?.extras?.get("data") as Bitmap
                    val path = saveBitmapToFile(image)
                    if (path != null) {
                        MethodChannel(flutterEngine?.dartExecutor?.binaryMessenger!!, CHANNEL)
                            .invokeMethod("imageSelected", path)
                    } else {
                        MethodChannel(flutterEngine?.dartExecutor?.binaryMessenger!!, CHANNEL)
                            .invokeMethod("imageSelectionFailed", "Unable to save image")
                    }
                }
            }
        }
    }

    private fun getRealPathFromURI(uri: Uri?): String? {
        var path: String? = null
        uri?.let {
            val projection = arrayOf(MediaStore.Images.Media.DATA)
            val cursor = contentResolver.query(it, projection, null, null, null)
            cursor?.use {
                if (it.moveToFirst()) {
                    val columnIndex = it.getColumnIndexOrThrow(MediaStore.Images.Media.DATA)
                    path = it.getString(columnIndex)
                }
            }
        }
        return path
    }

    private fun saveBitmapToFile(bitmap: Bitmap): String? {
        return try {
            val filesDir = applicationContext.filesDir
            val imageFile = File(filesDir, "captured_image_${System.currentTimeMillis()}.jpg")
            val outputStream = FileOutputStream(imageFile)
            bitmap.compress(Bitmap.CompressFormat.JPEG, 100, outputStream)
            outputStream.flush()
            outputStream.close()
            imageFile.absolutePath
        } catch (e: Exception) {
            e.printStackTrace()
            null
        }
    }
}
