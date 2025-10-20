package model;

import java.text.NumberFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Locale;

public class Product {
    private int productID;
    private int categoryID;
    private String productName;
    private double price;
    private String description;
    private String material;
    private String dimensions; // Kích thước
    private String features;
    private String imageURL; // Ảnh đại diện
    private List<String> imageUrls; // Danh sách các ảnh chi tiết
    private String brand;
    private int stock;
    private Date createdAt;
    
    public Product() {
        this.imageUrls = new ArrayList<>(); // Luôn khởi tạo để tránh lỗi
    }

    public String getFormattedPrice() {
        return NumberFormat.getCurrencyInstance(new Locale("vi", "VN")).format(this.price);
    }
    
    // Getters and Setters for all fields...
    public int getProductID() { return productID; }
    public void setProductID(int productID) { this.productID = productID; }
    public int getCategoryID() { return categoryID; }
    public void setCategoryID(int categoryID) { this.categoryID = categoryID; }
    public String getProductName() { return productName; }
    public void setProductName(String productName) { this.productName = productName; }
    public double getPrice() { return price; }
    public void setPrice(double price) { this.price = price; }
    public String getDescription() { return description; }
    public void setDescription(String description) { this.description = description; }
    public String getMaterial() { return material; }
    public void setMaterial(String material) { this.material = material; }
    public String getDimensions() { return dimensions; }
    public void setDimensions(String dimensions) { this.dimensions = dimensions; }
    public String getFeatures() { return features; }
    public void setFeatures(String features) { this.features = features; }
    public String getImageURL() { return imageURL; }
    public void setImageURL(String imageURL) { this.imageURL = imageURL; }
    public List<String> getImageUrls() { return imageUrls; }
    public void setImageUrls(List<String> imageUrls) { this.imageUrls = imageUrls; }
    public String getBrand() { return brand; }
    public void setBrand(String brand) { this.brand = brand; }
    public int getStock() { return stock; }
    public void setStock(int stock) { this.stock = stock; }
    public Date getCreatedAt() { return createdAt; }
    public void setCreatedAt(Date createdAt) { this.createdAt = createdAt; }
}