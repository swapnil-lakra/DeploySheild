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
('Cotton Oversized T-Shirt', 'cotton-oversized-tshirt', '100% combed cotton, relaxed fit.', 799, 1299, 'T-Shirts', 'https://i.pinimg.com/736x/13/2e/aa/132eaa28ee8af8fb353222dfcc6d968c.jpg', '["S","M","L","XL"]', '["White","Black","Navy"]', 150, TRUE, 'Best Seller'),
('Linen Blend Shirt', 'linen-blend-shirt', 'Breathable linen-cotton, regular fit.', 1499, 2499, 'Shirts', 'https://i.pinimg.com/736x/d2/9c/49/d29c49cd0935c9a5f6528c5c2fef24b7.jpg', '["M","L","XL"]', '["Beige","Blue"]', 80, FALSE, NULL),
('Banarasi Silk Saree', 'banarasi-silk-saree', 'Handwoven Banarasi silk with zari work.', 5999, 8999, 'Sarees', 'https://i.pinimg.com/736x/c8/49/84/c849849555b81f8f088a487b31272ae2.jpg', NULL, '["Red","Maroon","Green"]', 25, TRUE, 'Limited'),
('Slim Fit Jeans', 'slim-fit-jeans', 'Stretch denim, mid-rise, dark wash.', 1899, 2999, 'Jeans', 'https://i.pinimg.com/1200x/15/b2/9d/15b29d9e457ad8bcbed10c80c0d4fe1d.jpg', '["28","30","32","34","36"]', '["Blue","Black"]', 200, TRUE, 'Best Seller'),
('Cotton Kurta Set', 'cotton-kurta-set', 'Hand-block printed kurta with churidar.', 2499, 3999, 'Kurtas', 'https://i.pinimg.com/1200x/e5/2f/63/e52f634da205f536c5bdeaeb5838f53d.jpg', '["S","M","L","XL"]', '["White","Sky Blue"]', 45, TRUE, 'Festival'),
('Leather Sneakers', 'leather-sneakers', 'Premium leather sneakers, cushioned sole.', 2999, 4999, 'Footwear', 'https://i.pinimg.com/736x/e6/6a/f9/e66af91ac4352cc119df5a727eb34e4d.jpg', '["6","7","8","9","10"]', '["White","Tan"]', 110, TRUE, 'New'),
('Cashmere Sweater', 'cashmere-sweater', 'Soft cashmere-merino wool blend.', 4499, 6999, 'Sweaters', 'https://i.pinimg.com/1200x/0a/f8/65/0af8651e4db5f8249a577749ae6ee5b8.jpg', '["S","M","L","XL"]', '["Grey","Navy","Burgundy"]', 35, FALSE, 'Eco-Friendly'),
('Denim Jacket', 'denim-jacket', 'Classic denim jacket with button closure.', 3499, 4999, 'Outerwear', 'https://i.pinimg.com/1200x/c9/f7/7d/c9f77d4174342a7b2d1a1145ecbe2cb0.jpg', '["S","M","L","XL"]', '["Blue","Black"]', 60, TRUE, 'Trending'),
('Handloom Ikat Dress', 'ikat-dress', 'Handwoven Ikat cotton dress with pockets.', 2899, 4299, 'Dresses', 'https://i.pinimg.com/736x/8e/04/7a/8e047aa948ae646125a13e7824171cc5.jpg', '["XS","S","M","L"]', '["Multicolor","Blue"]', 28, TRUE, 'Artisan'),
('Jute Messenger Bag', 'jute-messenger-bag', 'Eco-friendly jute bag with leather trim.', 1299, 1999, 'Accessories', 'https://i.pinimg.com/1200x/88/0d/19/880d19c6c0a21e85171450a084d00b0a.jpg', NULL, '["Natural","Brown"]', 75, FALSE, NULL);