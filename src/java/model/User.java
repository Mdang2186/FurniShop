package model;

import java.util.Date;

public class User {
    private int userID;
    private String fullName;
    private String email;
    private String passwordHash;
    private String phone;
    private String address;
    private String role;
    private Date createdAt;

    // Constructor mặc định đã được sửa lỗi
    public User() {
    }

    // Getters and Setters for all fields...
    public int getUserID() { return userID; }
    public void setUserID(int userID) { this.userID = userID; }
    public String getFullName() { return fullName; }
    public void setFullName(String fullName) { this.fullName = fullName; }
    public String getEmail() { return email; }
    public void setEmail(String email) { this.email = email; }
    public String getPasswordHash() { return passwordHash; }
    public void setPasswordHash(String passwordHash) { this.passwordHash = passwordHash; }
    public String getPhone() { return phone; }
    public void setPhone(String phone) { this.phone = phone; }
    public String getAddress() { return address; }
    public void setAddress(String address) { this.address = address; }
    public String getRole() { return role; }
    public void setRole(String role) { this.role = role; }
    public Date getCreatedAt() { return createdAt; }
    public void setCreatedAt(Date createdAt) { this.createdAt = createdAt; }
}