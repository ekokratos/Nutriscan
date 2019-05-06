# NutriScan

An cross platform mobile application :iphone: developed in flutter to keep track of daily calorie needs. The calories required are calculated using BMI for which the inputs are taken from the user :bow: and stored in the database. The application is integrated with pedometer to keep count of number of steps taken by the user :walking: which helps to determine the calories burnt.

The application uses Vision API to determine the food item :pizza: from the picture which can be either taken from the phone camera or can be selected from the Gallery. You can find more about the Vision API [here](https://cloud.google.com/vision/).

Once we get the JSON response from the Vision API containing the name of the food item we cross reference with the **openfoodfacts** database to get the nutritional facts. You can find more about the openfoodfacts [here](https://world.openfoodfacts.org/).
