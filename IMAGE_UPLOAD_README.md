# Image Upload Functionality for iDea Admin

## Overview
The image upload functionality has been successfully implemented for the product management system. This allows administrators to upload and manage product images through the admin interface.

## Features Implemented

### 1. Product Form (`product-form.jsp`)
- **Multipart Form**: Updated to support file uploads with `enctype="multipart/form-data"`
- **Multiple Image Upload**: Users can select up to 5 images at once
- **Image Preview**: Real-time preview of selected images before upload
- **File Type Validation**: Only accepts image files (JPG, PNG, GIF)
- **Existing Image Management**: Display and delete existing product images

### 2. AdminProductServlet (`AdminProductServlet.java`)
- **MultipartConfig Annotation**: Configured for file uploads (5MB max file size, 10MB max request size)
- **File Upload Handling**: Processes uploaded images in both add and update operations
- **Unique Filename Generation**: Uses UUID to prevent filename conflicts
- **Database Integration**: Saves image paths to the Images table
- **Error Handling**: Graceful handling of upload failures

### 3. File Storage
- **Upload Directory**: `/web/uploads/products/`
- **Automatic Directory Creation**: Creates upload directories if they don't exist
- **Relative Path Storage**: Stores relative paths in database for portability

### 4. Product Display (`products.jsp`)
- **Image Display**: Shows product images in the admin product table
- **Default Image**: Displays a default image when no product images are available
- **Responsive Design**: Images are properly sized and styled

## Technical Implementation

### Database Schema
The system uses the existing `Images` table:
```sql
CREATE TABLE Images (
    ImageID INT PRIMARY KEY AUTO_INCREMENT,
    ProductID INT,
    ImagePath VARCHAR(255),
    IsPrimary BOOLEAN DEFAULT FALSE,
    FOREIGN KEY (ProductID) REFERENCES Products(ProductID)
);
```

### File Upload Process
1. **Form Submission**: User selects images and submits the form
2. **File Processing**: Servlet processes multipart form data
3. **File Validation**: Checks file type and size
4. **File Storage**: Saves files to `/uploads/products/` with unique names
5. **Database Update**: Stores relative paths in the Images table
6. **Response**: Redirects with success message

### Image Management
- **Add Images**: Upload new images when creating or editing products
- **Delete Images**: Remove existing images using the delete button
- **Preview Images**: See image previews before upload
- **Multiple Images**: Support for multiple images per product

## Usage Instructions

### Adding a Product with Images
1. Navigate to Admin → Products
2. Click "Add New Product"
3. Fill in product details
4. Select one or more images (max 5)
5. Preview images if needed
6. Click "Add Product"

### Editing Product Images
1. Navigate to Admin → Products
2. Click "Edit" on any product
3. View existing images
4. Delete unwanted images using the X button
5. Upload new images if needed
6. Click "Update Product"

### Testing
A test file `test-upload.html` has been created for testing the upload functionality without going through the admin login process.

## Configuration

### File Size Limits
- **Max File Size**: 5MB per image
- **Max Request Size**: 10MB total
- **File Size Threshold**: 1MB (files larger than this are written to disk)

### Supported File Types
- JPEG (.jpg, .jpeg)
- PNG (.png)
- GIF (.gif)

### Upload Directory
- **Path**: `/web/uploads/products/`
- **Permissions**: Ensure the web server has write permissions

## Security Considerations
- **File Type Validation**: Only image files are accepted
- **Unique Filenames**: UUID prevents filename conflicts
- **Size Limits**: Prevents large file uploads
- **Path Validation**: Uses relative paths to prevent directory traversal

## Troubleshooting

### Common Issues
1. **Upload Directory Not Found**: Ensure `/web/uploads/products/` exists and is writable
2. **File Size Too Large**: Check file size limits in web.xml and MultipartConfig
3. **Images Not Displaying**: Verify image paths are correct and files exist
4. **Database Errors**: Check Images table structure and foreign key constraints

### Debugging
- Check server logs for upload errors
- Verify file permissions on upload directory
- Test with smaller images first
- Use the test-upload.html file for isolated testing

## Future Enhancements
- Image resizing and optimization
- Thumbnail generation
- Image cropping functionality
- Bulk image upload
- Image gallery management
- Cloud storage integration

## Files Modified
- `web/admin/product-form.jsp` - Updated form for file uploads
- `src/java/com/idea/controller/AdminProductServlet.java` - Added file upload handling
- `web/WEB-INF/web.xml` - Added multipart configuration
- `web/admin/products.jsp` - Enhanced image display
- `web/test-upload.html` - Test file for upload functionality

The image upload functionality is now fully operational and ready for use in the admin product management system. 