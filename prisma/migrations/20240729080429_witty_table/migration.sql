-- CreateTable
CREATE TABLE "Customer" (
    "CustomerID" SERIAL NOT NULL,
    "Name" TEXT NOT NULL,
    "PhoneNumber" TEXT NOT NULL,
    "Address" TEXT NOT NULL,
    "IsRegular" BOOLEAN NOT NULL,

    CONSTRAINT "Customer_pkey" PRIMARY KEY ("CustomerID")
);

-- CreateTable
CREATE TABLE "Employee" (
    "Username" TEXT NOT NULL,
    "Name" TEXT NOT NULL,
    "Email" TEXT NOT NULL,
    "Role" TEXT NOT NULL,
    "Password" TEXT NOT NULL,
    "PhoneNumber" TEXT NOT NULL,
    "CreatedAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "Employee_pkey" PRIMARY KEY ("Username")
);

-- CreateTable
CREATE TABLE "Branch" (
    "BranchID" SERIAL NOT NULL,
    "BranchName" TEXT NOT NULL,
    "Address" TEXT NOT NULL,
    "PhoneNumber" TEXT NOT NULL,
    "CreatedAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "Branch_pkey" PRIMARY KEY ("BranchID")
);

-- CreateTable
CREATE TABLE "Menu" (
    "MenuID" SERIAL NOT NULL,
    "Name" TEXT NOT NULL,
    "Description" TEXT NOT NULL,
    "CategoryID" INTEGER NOT NULL,
    "Price" DOUBLE PRECISION NOT NULL,
    "PreparationTime" INTEGER NOT NULL,
    "CreatedAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "Menu_pkey" PRIMARY KEY ("MenuID")
);

-- CreateTable
CREATE TABLE "Category" (
    "CategoryID" SERIAL NOT NULL,
    "Name" TEXT NOT NULL,
    "ParentCategoryID" INTEGER,

    CONSTRAINT "Category_pkey" PRIMARY KEY ("CategoryID")
);

-- CreateTable
CREATE TABLE "Ingredient" (
    "IngredientID" SERIAL NOT NULL,
    "Name" TEXT NOT NULL,
    "QuantityInStock" INTEGER NOT NULL,
    "Unit" TEXT NOT NULL,
    "ReorderLevel" INTEGER NOT NULL,

    CONSTRAINT "Ingredient_pkey" PRIMARY KEY ("IngredientID")
);

-- CreateTable
CREATE TABLE "Order" (
    "OrderID" SERIAL NOT NULL,
    "CustomerID" INTEGER NOT NULL,
    "BranchID" INTEGER NOT NULL,
    "OrderTime" TIMESTAMP(3) NOT NULL,
    "DeliveryTime" TIMESTAMP(3) NOT NULL,
    "TotalAmount" DOUBLE PRECISION NOT NULL,
    "Status" TEXT NOT NULL,
    "PaymentStatus" TEXT NOT NULL,
    "TableNumber" INTEGER,
    "SpecialInstructions" TEXT NOT NULL,

    CONSTRAINT "Order_pkey" PRIMARY KEY ("OrderID")
);

-- CreateTable
CREATE TABLE "OrderDetail" (
    "OrderDetailID" SERIAL NOT NULL,
    "OrderID" INTEGER NOT NULL,
    "MenuID" INTEGER NOT NULL,
    "Quantity" INTEGER NOT NULL,
    "SpecialRequest" TEXT NOT NULL,

    CONSTRAINT "OrderDetail_pkey" PRIMARY KEY ("OrderDetailID")
);

-- CreateTable
CREATE TABLE "Payment" (
    "PaymentID" SERIAL NOT NULL,
    "OrderID" INTEGER NOT NULL,
    "Amount" DOUBLE PRECISION NOT NULL,
    "PaymentMethod" TEXT NOT NULL,
    "PaymentDate" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "Payment_pkey" PRIMARY KEY ("PaymentID")
);

-- CreateTable
CREATE TABLE "Review" (
    "ReviewID" SERIAL NOT NULL,
    "CustomerID" INTEGER NOT NULL,
    "MenuID" INTEGER NOT NULL,
    "Rating" INTEGER NOT NULL,
    "Comment" TEXT NOT NULL,

    CONSTRAINT "Review_pkey" PRIMARY KEY ("ReviewID")
);

-- CreateTable
CREATE TABLE "Role" (
    "RoleID" SERIAL NOT NULL,
    "RoleName" TEXT NOT NULL,
    "Permissions" TEXT NOT NULL,

    CONSTRAINT "Role_pkey" PRIMARY KEY ("RoleID")
);

-- CreateTable
CREATE TABLE "EmployeeRole" (
    "EmployeeRoleID" SERIAL NOT NULL,
    "Username" TEXT NOT NULL,
    "RoleID" INTEGER NOT NULL,

    CONSTRAINT "EmployeeRole_pkey" PRIMARY KEY ("EmployeeRoleID")
);

-- CreateTable
CREATE TABLE "Log" (
    "LogID" SERIAL NOT NULL,
    "Username" TEXT NOT NULL,
    "Action" TEXT NOT NULL,
    "Timestamp" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "Log_pkey" PRIMARY KEY ("LogID")
);

-- CreateTable
CREATE TABLE "_EmployeeBranches" (
    "A" INTEGER NOT NULL,
    "B" TEXT NOT NULL
);

-- CreateIndex
CREATE UNIQUE INDEX "Employee_Email_key" ON "Employee"("Email");

-- CreateIndex
CREATE UNIQUE INDEX "_EmployeeBranches_AB_unique" ON "_EmployeeBranches"("A", "B");

-- CreateIndex
CREATE INDEX "_EmployeeBranches_B_index" ON "_EmployeeBranches"("B");

-- AddForeignKey
ALTER TABLE "Menu" ADD CONSTRAINT "Menu_CategoryID_fkey" FOREIGN KEY ("CategoryID") REFERENCES "Category"("CategoryID") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Category" ADD CONSTRAINT "Category_ParentCategoryID_fkey" FOREIGN KEY ("ParentCategoryID") REFERENCES "Category"("CategoryID") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Order" ADD CONSTRAINT "Order_CustomerID_fkey" FOREIGN KEY ("CustomerID") REFERENCES "Customer"("CustomerID") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Order" ADD CONSTRAINT "Order_BranchID_fkey" FOREIGN KEY ("BranchID") REFERENCES "Branch"("BranchID") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "OrderDetail" ADD CONSTRAINT "OrderDetail_OrderID_fkey" FOREIGN KEY ("OrderID") REFERENCES "Order"("OrderID") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "OrderDetail" ADD CONSTRAINT "OrderDetail_MenuID_fkey" FOREIGN KEY ("MenuID") REFERENCES "Menu"("MenuID") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Payment" ADD CONSTRAINT "Payment_OrderID_fkey" FOREIGN KEY ("OrderID") REFERENCES "Order"("OrderID") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Review" ADD CONSTRAINT "Review_CustomerID_fkey" FOREIGN KEY ("CustomerID") REFERENCES "Customer"("CustomerID") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Review" ADD CONSTRAINT "Review_MenuID_fkey" FOREIGN KEY ("MenuID") REFERENCES "Menu"("MenuID") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "EmployeeRole" ADD CONSTRAINT "EmployeeRole_Username_fkey" FOREIGN KEY ("Username") REFERENCES "Employee"("Username") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "EmployeeRole" ADD CONSTRAINT "EmployeeRole_RoleID_fkey" FOREIGN KEY ("RoleID") REFERENCES "Role"("RoleID") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Log" ADD CONSTRAINT "Log_Username_fkey" FOREIGN KEY ("Username") REFERENCES "Employee"("Username") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "_EmployeeBranches" ADD CONSTRAINT "_EmployeeBranches_A_fkey" FOREIGN KEY ("A") REFERENCES "Branch"("BranchID") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "_EmployeeBranches" ADD CONSTRAINT "_EmployeeBranches_B_fkey" FOREIGN KEY ("B") REFERENCES "Employee"("Username") ON DELETE CASCADE ON UPDATE CASCADE;
