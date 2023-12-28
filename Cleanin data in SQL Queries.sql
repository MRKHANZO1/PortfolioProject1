

--Cleanin data in SQL Queries

-- CLeaning data in sql queries


 Select *
 From PortfolioProject..NashvilleHousing

 --Standadize Date Format

 Select  SaleDate2, CONVERT(Date,SaleDate)
 From PortfolioProject..NashvilleHousing

 Update NashvilleHousing
 Set SaleDate = CONVERT(Date,SaleDate)

 ALTER TABLE NashVilleHousing
 ADD SaleDate2 Date;

 Update NashvilleHousing
 Set SaleDate2 = CONVERT(Date,SaleDate)

 Select  SaleDate2, CONVERT(Date,SaleDate)
 From PortfolioProject..NashvilleHousing

 -- Populate Property address

  Select  PropertyAddress
 From PortfolioProject..NashvilleHousing
 Where PropertyAddress is null

 Select  *
 From PortfolioProject..NashvilleHousing
  Where PropertyAddress is null

  Select  *
 From PortfolioProject..NashvilleHousing

 Select  *
 From PortfolioProject..NashvilleHousing
 Order by ParcelID
 

 Select  a.parcelID, a.propertyAddress, b.parcelID, b.propertyAddress, ISNULL(a.propertyAddress,b.propertyAddress)
 From PortfolioProject..NashvilleHousing a
	JOIN PortfolioProject..NashvilleHousing b
	on a.ParcelID = b.ParcelID
	AND a.UniqueID <> b.UniqueID

	Where a.propertyAddress is Null





	Update a
	Set propertyAddress = ISNULL(a.propertyAddress,b.propertyAddress)
	From PortfolioProject..NashvilleHousing a
	JOIN PortfolioProject..NashvilleHousing b
	on a.ParcelID = b.ParcelID
	AND a.UniqueID <> b.UniqueID
	Where a.propertyAddress is Null

--Breaking out Address  into individual columns (Address, City, State)

Select  PropertyAddress
 From PortfolioProject..NashvilleHousing
 --Order by ParcelID
 
 Select
  SUBSTRING(PropertyAddress, 1, CHARINDEX(',', PropertyAddress)-1) as Address
  ,SUBSTRING(PropertyAddress, CHARINDEX(',', PropertyAddress)+1,LEN(PropertyAddress)) as Address
  From PortfolioProject..NashvilleHousing


  ALTER TABLE NashVilleHousing
 ADD PropertySplitAddress Nvarchar(255);

 Update NashvilleHousing
 Set PropertySplitAddress = SUBSTRING(PropertyAddress, 1, CHARINDEX(',', PropertyAddress)-1)

 ALTER TABLE NashVilleHousing
 ADD PropertySplitCity Nvarchar(255);

 Update NashvilleHousing
 Set PropertySplitCity =SUBSTRING(PropertyAddress, CHARINDEX(',', PropertyAddress)+1,LEN(PropertyAddress))

 select*
 From PortfolioProject..NashvilleHousing


 --splitting owner address
 Select OwnerAddress
  From PortfolioProject..NashvilleHousing

   Select 
   PARSENAME(REPLACE(OwnerAddress, ',', '.'),3)
   , PARSENAME(REPLACE(OwnerAddress, ',', '.'),2)
   , PARSENAME(REPLACE(OwnerAddress, ',', '.'),1)
  From PortfolioProject..NashvilleHousing

  ALTER TABLE NashVilleHousing
 ADD OwnerSplitAddress Nvarchar(255);

 Update NashvilleHousing
 Set OwnerSplitAddress = PARSENAME(REPLACE(OwnerAddress, ',', '.'),3)

 ALTER TABLE NashVilleHousing
 ADD OwnerSplitCity Nvarchar(255);

 Update NashvilleHousing
 Set OwnertySplitCity =PARSENAME(REPLACE(OwnerAddress, ',', '.'),2)

 
 ALTER TABLE NashVilleHousing
 ADD OwnerSplitState Nvarchar(255);

 Update NashvilleHousing
 Set OwnertySplitState =PARSENAME(REPLACE(OwnerAddress, ',', '.'),1)
 
 --splitting
 
 Select OwnerAddress
  From PortfolioProject..NashvilleHousing

   Select 
   PARSENAME(REPLACE(OwnerAddress, ',', '.'),3)
   , PARSENAME(REPLACE(OwnerAddress, ',', '.'),2)
   , PARSENAME(REPLACE(OwnerAddress, ',', '.'),1)
  From PortfolioProject..NashvilleHousing

  ALTER TABLE NashVilleHousing
 ADD OwnerSplitAddress Nvarchar(255);

 Update NashvilleHousing
 Set OwnerSplitAddress = PARSENAME(REPLACE(OwnerAddress, ',', '.'),3)

 ALTER TABLE NashVilleHousing
 ADD OwnerSplitCity Nvarchar(255);

 Update NashvilleHousing
 Set OwnerSplitCity =PARSENAME(REPLACE(OwnerAddress, ',', '.'),2)

 
 ALTER TABLE NashVilleHousing
 ADD OwnerSplitState Nvarchar(255);

 Update NashvilleHousing
 Set OwnerSplitState =PARSENAME(REPLACE(OwnerAddress, ',', '.'),1)

 Select *
  From PortfolioProject..NashvilleHousing

  --Change Y and N to Yes and No in 'Sold as Vacant' field

  Select Distinct(SoldAsVacant), COUNT(SoldAsVacant)
   From PortfolioProject..NashvilleHousing
   Group by SoldAsVacant
   order by 2

   
   Select SoldAsVacant
   , CASE When SoldAsVacant ='Y' THEN 'Yes'
			When SoldAsVacant ='N' THEN 'No'
			Else SoldAsVacant
			END
   From PortfolioProject..NashvilleHousing

   Update NashvilleHousing
   Set SoldAsVacant= CASE When SoldAsVacant ='Y' THEN 'Yes'
			When SoldAsVacant ='N' THEN 'No'
			Else SoldAsVacant
			END

-- Remove Duplicates

With RowNumCTE AS(
Select*,
ROW_NUMBER() OVER(
PARTITION BY ParcelID,
			 PropertyAddress,
			 SalePrice,
			 SaleDate,
			 LegalReference
			 ORDER BY
				UniqueID
				) row_num
From PortfolioProject..NashvilleHousing
--Order by ParcelID
)
Select*
From RowNumCTE
Where Row_num > 1
Order by PropertyAddress



 SELECT*
  From PortfolioProject..NashvilleHousing

  --Delete unused columns

  SELECT*
  From PortfolioProject..NashvilleHousing

  Alter Table PortfolioProject..NashvilleHousing
  Drop Column OwnerAddress, TaxDistrict, PropertyAddress, SaleDate