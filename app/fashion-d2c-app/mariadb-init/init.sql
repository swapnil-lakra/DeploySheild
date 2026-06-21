CREATE DATABASE IF NOT EXISTS d2c_fashion;
USE d2c_fashion;


CREATE TABLE products (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(200) NOT NULL,
    slug VARCHAR(200) UNIQUE NOT NULL,
    description TEXT,
    price DECIMAL(10,2) NOT NULL,
    compare_at_price DECIMAL(10,2),   -- original price (for sale badge)
    category VARCHAR(100),
    image_url VARCHAR(500),
    additional_images JSON,            -- array of extra image URLs
    sizes JSON,                        -- e.g., ["S","M","L","XL"]
    colors JSON,                       -- e.g., ["Red","Blue","Black"]
    inventory_count INT DEFAULT 0,
    is_active BOOLEAN DEFAULT TRUE,
    is_featured BOOLEAN DEFAULT FALSE,
    badge VARCHAR(50),                 -- "Best Seller", "New", "Limited"
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

INSERT INTO products (name, slug, description, price, compare_at_price, category, image_url, sizes, colors, inventory_count, is_featured, badge) VALUES
('Cotton Oversized T-Shirt', 'cotton-oversized-tshirt', '100% combed cotton, relaxed fit.', 799, 1299, 'T-Shirts', 'https://picsum.photos/id/20/400/500', '["S","M","L","XL"]', '["White","Black","Navy"]', 150, TRUE, 'Best Seller'),
('Linen Blend Shirt', 'linen-blend-shirt', 'Breathable linen-cotton, regular fit.', 1499, 2499, 'Shirts', 'https://picsum.photos/id/26/400/500', '["M","L","XL"]', '["Beige","Blue"]', 80, FALSE, NULL),
('Banarasi Silk Saree', 'banarasi-silk-saree', 'Handwoven Banarasi silk with zari work.', 5999, 8999, 'Sarees', 'https://picsum.photos/id/30/400/500', NULL, '["Red","Maroon","Green"]', 25, TRUE, 'Limited'),
('Slim Fit Jeans', 'slim-fit-jeans', 'Stretch denim, mid-rise, dark wash.', 1899, 2999, 'Jeans', 'https://picsum.photos/id/28/400/500', '["28","30","32","34","36"]', '["Blue","Black"]', 200, TRUE, 'Best Seller'),
('Cotton Kurta Set', 'cotton-kurta-set', 'Hand-block printed kurta with churidar.', 2499, 3999, 'Kurtas', 'https://picsum.photos/id/34/400/500', '["S","M","L","XL"]', '["White","Sky Blue"]', 45, TRUE, 'Festival'),
('Leather Sneakers', 'leather-sneakers', 'Premium leather sneakers, cushioned sole.', 2999, 4999, 'Footwear', 'https://picsum.photos/id/0/400/500', '["6","7","8","9","10"]', '["White","Tan"]', 110, TRUE, 'New'),
('Cashmere Sweater', 'cashmere-sweater', 'Soft cashmere-merino wool blend.', 4499, 6999, 'Sweaters', 'https://picsum.photos/id/29/400/500', '["S","M","L","XL"]', '["Grey","Navy","Burgundy"]', 35, FALSE, 'Eco-Friendly'),
('Denim Jacket', 'denim-jacket', 'Classic denim jacket with button closure.', 3499, 4999, 'Outerwear', 'https://picsum.photos/id/31/400/500', '["S","M","L","XL"]', '["Blue","Black"]', 60, TRUE, 'Trending'),
('Handloom Ikat Dress', 'ikat-dress', 'Handwoven Ikat cotton dress with pockets.', 2899, 4299, 'Dresses', 'https://picsum.photos/id/36/400/500', '["XS","S","M","L"]', '["Multicolor","Blue"]', 28, TRUE, 'Artisan'),
('Jute Messenger Bag', 'jute-messenger-bag', 'Eco-friendly jute bag with leather trim.', 1299, 1999, 'Accessories', 'https://picsum.photos/id/33/400/500', NULL, '["Natural","Brown"]', 75, FALSE, NULL);