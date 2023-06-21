-- Drop tables if they exist
DROP TABLE IF EXISTS reviews CASCADE;
DROP TABLE IF EXISTS reservations CASCADE;
DROP TABLE IF EXISTS properties CASCADE;
DROP TABLE IF EXISTS addresses CASCADE;
DROP TABLE IF EXISTS users CASCADE;

-- Create the users table
CREATE TABLE users (
  id SERIAL PRIMARY KEY,
  name VARCHAR(255) NOT NULL,
  email VARCHAR(255) UNIQUE NOT NULL,
  password VARCHAR(255) NOT NULL
);

-- Create the properties table
CREATE TABLE properties (
  id SERIAL PRIMARY KEY,
  title VARCHAR(255) NOT NULL,
  description TEXT,
  cost_per_night NUMERIC(10, 2) NOT NULL,
  parking_spaces INTEGER NOT NULL,
  number_of_bathrooms INTEGER NOT NULL,
  number_of_bedrooms INTEGER NOT NULL,
  thumbnail_url VARCHAR(255),
  cover_photo_url VARCHAR(255),
  is_active BOOLEAN DEFAULT true,
  owner_id INTEGER REFERENCES users(id)
);

-- Create the addresses table
CREATE TABLE addresses (
  id SERIAL PRIMARY KEY,
  property_id INTEGER REFERENCES properties(id),
  country VARCHAR(255),
  street VARCHAR(255),
  city VARCHAR(255),
  province VARCHAR(255),
  post_code VARCHAR(10)
);

-- Create the reservations table
CREATE TABLE reservations (
  id SERIAL PRIMARY KEY,
  start_date DATE NOT NULL,
  end_date DATE NOT NULL,
  guest_id INTEGER REFERENCES users(id),
  property_id INTEGER REFERENCES properties(id)
);

-- Create the reviews table
CREATE TABLE reviews (
  id SERIAL PRIMARY KEY,
  message TEXT,
  rating INTEGER,
  guest_id INTEGER REFERENCES users(id),
  reservation_id INTEGER REFERENCES reservations(id)
);