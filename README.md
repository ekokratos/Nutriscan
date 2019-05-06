<p align="center">
  <img src="/assets/logoimage.png">
</p>
<p align="center">
  <img height="50" width="150" src="/assets/logotext.png">
</p>

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
![Build Status](https://travis-ci.org/anfederico/Clairvoyant.svg?branch=master)
![Dependencies](https://img.shields.io/badge/dependencies-up%20to%20date-brightgreen.svg)
[![License](https://img.shields.io/badge/license-MIT-blue.svg)](https://opensource.org/licenses/MIT)

An cross platform mobile application :iphone: developed in flutter to keep track of daily calorie needs. The calories required are calculated using BMI for which the inputs are taken from the user :bow: and stored in the database. The application is integrated with pedometer to keep count of number of steps taken by the user :walking: which helps to determine the calories burnt.

<ul>
  <li> The application uses <a href="https://cloud.google.com/vision/">Vision API</a> to determine the food item :pizza: from the picture which can be either taken from the phone camera or can be selected from the Gallery.

  <li> The JSON response recieved from the Vision API containing the name of the food item is cross referenced with the <a href="https://world.openfoodfacts.org/">openfoodfacts</a> database :page_facing_up: to get the nutritional facts.
  
  <li> For each 20 steps :paw_prints: counted by pedometer we deduct one calorie from the number of calories consumed by the user per day.
</ul>

# Screenshots

<p float="left">
  <img src="assets/info.jpg" width="200" height="350" />
  <img src="assets/calorie.jpg" width="200" height="350" /> 
  <img src="assets/picture.jpg" width="200" height="350" />
  <img src="assets/pedometer.jpg" width="200" height="350" />
</p>


