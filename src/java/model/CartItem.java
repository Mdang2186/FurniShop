package model;

/**
 * Lớp này đại diện cho một sản phẩm trong giỏ hàng.
 * Nó bao gồm đối tượng Product và số lượng tương ứng.
 */
public class CartItem {
    private Product product;
    private int quantity;

    public CartItem() {
    }

    public CartItem(Product product, int quantity) {
        this.product = product;
        this.quantity = quantity;
    }

    public Product getProduct() {
        return product;
    }

    public void setProduct(Product product) {
        this.product = product;
    }

    public int getQuantity() {
        return quantity;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }
    
    // Phương thức tiện ích để lấy tổng giá của mục này
    public double getTotalPrice() {
        return product.getPrice() * quantity;
    }
     
}