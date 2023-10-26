const express = require('express');
const { PrismaClient } = require('@prisma/client');
const prisma = new PrismaClient();
const app = express();
app.use(express.json());


app.post('/users', async (req, res) => {
    const now = new Date(); 
    const birthDate = new Date(req.body.birth); 
  
    try {
      const user = await prisma.user.create({
        data: {
          name: req.body.name,
          address: req.body.address,
          birth: birthDate, 
          createAt: now, 
          deletedAt: now, 
          updateAt: now
        },
      });
      res.json(user);
    } catch (error) {
      console.error(error);
      res.status(500).json({ error: 'Gagal menambahkan pengguna.' });
    }
  });
  

  app.get('/users', async (req, res) => {
    try {
      const users = await prisma.user.findMany();
      res.json(users);
    } catch (error) {
      console.error(error);
      res.status(500).json({ error: 'Gagal mengambil data pengguna.' });
    }
  });

  app.put('/users/:id', async (req, res) => {
    const { id } = req.params;
    try {
      const user = await prisma.user.update({
        where: { id: parseInt(id) },
        data: {
          name: req.body.name, 
        },
      });
      res.json(user);
    } catch (error) {
      console.error(error);
      res.status(500).json({ error: 'Gagal memperbarui pengguna.' });
    }
  });
  

  app.delete('/users/:id', async (req, res) => {
    const { id } = req.params;
    try {
      await prisma.user.delete({
        where: { id: parseInt(id) },
      });
      res.json({ message: 'Pengguna berhasil dihapus.' });
    } catch (error) {
      console.error(error);
      res.status(500).json({ error: 'Gagal menghapus pengguna.' });
    }
  });
  
  const PORT = process.env.PORT || 8080;

app.listen(PORT, () => {
  console.log(`Server berjalan di port ${PORT}`);
});

