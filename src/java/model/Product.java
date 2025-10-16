
// model/Product.java
package model;

import java.text.NumberFormat;
import java.util.Locale;
import java.util.Date;

public class Product {
    private int productID;
    private int categoryID;
    private String productName;
    private double price;
    private String description;
    private String material;
    private String features;
    private String imageURL;
    private String brand;
    private int stock;
    private Date createdAt;
    public int getProductID() {    
        return productID;
    }

    public void setProductID(int productID) {
        this.productID = productID;
    }

    public int getCategoryID() {
        return categoryID;
    }

    public void setCategoryID(int categoryID) {
        this.categoryID = categoryID;
    }

    public String getProductName() {
        return productName;
    }

    public void setProductName(String productName) {
        this.productName = productName;
    }

    public double getPrice() {
        return price;
    }

    public void setPrice(double price) {
        this.price = price;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public String getMaterial() {
        return material;
    }

    public void setMaterial(String material) {
        this.material = material;
    }

    public String getFeatures() {
        return features;
    }

    public void setFeatures(String features) {
        this.features = features;
    }

    public String getImageURL() {
        return imageURL;
    }

    public void setImageURL(String imageURL) {
        this.imageURL = imageURL;
    }

    public String getBrand() {
        return brand;
    }

    public void setBrand(String brand) {
        this.brand = brand;
    }

    public int getStock() {
        return stock;
    }

    public void setStock(int stock) {
        this.stock = stock;
    }

    public Date getCreatedAt() {
        return createdAt;
    }

    // Constructors, Getters, Setters cho tất cả các trường...
    public void setCreatedAt(Date createdAt) {
        this.createdAt = createdAt;
    }

    // Tiện ích định dạng giá tiền
    public String getFormattedPrice() {
        NumberFormat nf = NumberFormat.getCurrencyInstance(new Locale("vi", "VN"));
        return nf.format(this.price);
    }
}