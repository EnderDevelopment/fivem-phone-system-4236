CREATE TABLE IF NOT EXISTS phone_contacts (
    id INT AUTO_INCREMENT PRIMARY KEY,
    owner_id INT NOT NULL,
    name VARCHAR(255) NOT NULL,
    number VARCHAR(255) NOT NULL,
    FOREIGN KEY (owner_id) REFERENCES users(identifier)
);

CREATE TABLE IF NOT EXISTS phone_messages (
    id INT AUTO_INCREMENT PRIMARY KEY,
    sender_id INT NOT NULL,
    receiver_id INT NOT NULL,
    message TEXT NOT NULL,
    timestamp DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (sender_id) REFERENCES users(identifier),
    FOREIGN KEY (receiver_id) REFERENCES users(identifier)
);

CREATE TABLE IF NOT EXISTS phone_calls (
    id INT AUTO_INCREMENT PRIMARY KEY,
    caller_id INT NOT NULL,
    receiver_id INT NOT NULL,
    duration INT NOT NULL,
    timestamp DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (caller_id) REFERENCES users(identifier),
    FOREIGN KEY (receiver_id) REFERENCES users(identifier)
);