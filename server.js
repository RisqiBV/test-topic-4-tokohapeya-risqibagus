const express = require('express');
const { PrismaClient } = require('@prisma/client');
const prisma = new PrismaClient();
const app = express();
app.use(express.json());


app.post('/phoneMerks', async (req, res) => {
  try {
    const phoneMerk = await prisma.phoneMerk.create({
      data: req.body,
    });
    res.json(phoneMerk);
  } catch (error) {
    console.error(error);
    res.status(500).json({ error: 'Gagal menambahkan PhoneMerk.' });
  }
});


app.get('/phoneMerks', async (req, res) => {
  try {
    const phoneMerks = await prisma.phoneMerk.findMany();
    res.json(phoneMerks);
  } catch (error) {
    console.error(error);
    res.status(500).json({ error: 'Gagal mengambil data PhoneMerk.' });
  }
});


app.get('/phoneMerks/:id', async (req, res) => {
  const { id } = req.params;
  try {
    const phoneMerk = await prisma.phoneMerk.findUnique({
      where: { id: parseInt(id) },
    });
    res.json(phoneMerk);
  } catch (error) {
    console.error(error);
    res.status(500).json({ error: 'Gagal mengambil data PhoneMerk.' });
  }
});


app.put('/phoneMerks/:id', async (req, res) => {
  const { id } = req.params;
  try {
    const phoneMerk = await prisma.phoneMerk.update({
      where: { id: parseInt(id) },
      data: req.body,
    });
    res.json(phoneMerk);
  } catch (error) {
    console.error(error);
    res.status(500).json({ error: 'Gagal memperbarui PhoneMerk.' });
  }
});


app.delete('/phoneMerks/:id', async (req, res) => {
  const { id } = req.params;
  try {
    await prisma.phoneMerk.delete({
      where: { id: parseInt(id) },
    });
    res.json({ message: 'PhoneMerk berhasil dihapus.' });
  } catch (error) {
    console.error(error);
    res.status(500).json({ error: 'Gagal menghapus PhoneMerk.' });
  }
});

const PORT = process.env.PORT || 8080;

app.listen(PORT, () => {
  console.log(`Server berjalan di port ${PORT}`);
});
