/*
  Warnings:

  - You are about to drop the `Post` table. If the table is not empty, all the data it contains will be lost.
  - A unique constraint covering the columns `[name]` on the table `User` will be added. If there are existing duplicate values, this will fail.
  - Added the required column `createAt` to the `User` table without a default value. This is not possible if the table is not empty.
  - Added the required column `updateAt` to the `User` table without a default value. This is not possible if the table is not empty.

*/
-- DropForeignKey
ALTER TABLE "Post" DROP CONSTRAINT "Post_authorId_fkey";

-- AlterTable
ALTER TABLE "User" ADD COLUMN     "address" TEXT,
ADD COLUMN     "birth" TIMESTAMP(3),
ADD COLUMN     "createAt" TIMESTAMP(3) NOT NULL,
ADD COLUMN     "deletedAt" TIMESTAMP(3),
ADD COLUMN     "updateAt" TIMESTAMP(3) NOT NULL;

-- DropTable
DROP TABLE "Post";

-- CreateTable
CREATE TABLE "Profile" (
    "id" SERIAL NOT NULL,
    "name" TEXT NOT NULL,
    "username" TEXT NOT NULL,
    "createAt" TIMESTAMP(3) NOT NULL,
    "deletedAt" TIMESTAMP(3),
    "updateAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "Profile_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "PhoneMerk" (
    "id" SERIAL NOT NULL,
    "phone_merk" TEXT NOT NULL,
    "createAt" TIMESTAMP(3) NOT NULL,
    "deletedAt" TIMESTAMP(3),
    "updateAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "PhoneMerk_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "PhoneStock" (
    "id" SERIAL NOT NULL,
    "phone_merk" TEXT NOT NULL,
    "phone_type" TEXT NOT NULL,
    "type_qty" INTEGER NOT NULL,
    "price" INTEGER NOT NULL,
    "createAt" TIMESTAMP(3) NOT NULL,
    "deletedAt" TIMESTAMP(3),
    "updateAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "PhoneStock_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Transaction" (
    "id" SERIAL NOT NULL,
    "name" TEXT NOT NULL,
    "phone_type" TEXT NOT NULL,
    "qty" INTEGER NOT NULL,
    "amount" INTEGER NOT NULL,
    "disc_amount" INTEGER NOT NULL,
    "is_paid" BOOLEAN NOT NULL,
    "createAt" TIMESTAMP(3) NOT NULL,
    "deletedAt" TIMESTAMP(3),
    "updateAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "Transaction_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Discount" (
    "id" SERIAL NOT NULL,
    "disc_code" TEXT NOT NULL,
    "disc_amount" INTEGER NOT NULL,
    "createAt" TIMESTAMP(3) NOT NULL,
    "deletedAt" TIMESTAMP(3),
    "updateAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "Discount_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE UNIQUE INDEX "Profile_name_key" ON "Profile"("name");

-- CreateIndex
CREATE UNIQUE INDEX "PhoneMerk_phone_merk_key" ON "PhoneMerk"("phone_merk");

-- CreateIndex
CREATE UNIQUE INDEX "PhoneStock_phone_type_key" ON "PhoneStock"("phone_type");

-- CreateIndex
CREATE UNIQUE INDEX "Transaction_disc_amount_key" ON "Transaction"("disc_amount");

-- CreateIndex
CREATE UNIQUE INDEX "Discount_disc_code_key" ON "Discount"("disc_code");

-- CreateIndex
CREATE UNIQUE INDEX "Discount_disc_amount_key" ON "Discount"("disc_amount");

-- CreateIndex
CREATE UNIQUE INDEX "User_name_key" ON "User"("name");

-- AddForeignKey
ALTER TABLE "User" ADD CONSTRAINT "User_name_fkey" FOREIGN KEY ("name") REFERENCES "Profile"("name") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "PhoneStock" ADD CONSTRAINT "PhoneStock_phone_merk_fkey" FOREIGN KEY ("phone_merk") REFERENCES "PhoneMerk"("phone_merk") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Transaction" ADD CONSTRAINT "Transaction_name_fkey" FOREIGN KEY ("name") REFERENCES "User"("name") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Transaction" ADD CONSTRAINT "Transaction_phone_type_fkey" FOREIGN KEY ("phone_type") REFERENCES "PhoneStock"("phone_type") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Transaction" ADD CONSTRAINT "Transaction_disc_amount_fkey" FOREIGN KEY ("disc_amount") REFERENCES "Discount"("disc_amount") ON DELETE RESTRICT ON UPDATE CASCADE;
