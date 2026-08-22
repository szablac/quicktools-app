const express = require('express');
const path = require('path');
const mysql = require('mysql2/promise');

const app = express();

app.use(express.static(path.join(__dirname, 'public')));

const pool = mysql.createPool({
  host: process.env.DB_HOST,
  user: process.env.DB_USER,
  password: process.env.DB_PASSWORD,
  database: process.env.DB_NAME,
  waitForConnections: true,
  connectionLimit: 5,
});

app.get('/api/tools', async (req, res) => {
  try {
    const [rows] = await pool.query(
      'SELECT slug, name_hu, name_en, category FROM tools WHERE is_active = 1 ORDER BY name_hu'
    );
    res.json(rows);
  } catch (err) {
    console.error(err);
    res.status(500).json({ error: 'Hiba történt az eszközlista lekérésekor.', debug_code: err.code, debug_message: err.message });
  }
});

app.listen();
