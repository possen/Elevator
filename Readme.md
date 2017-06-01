Elevator
--------

* This project simulates the logic of a 4 elevator system.
* it tries to minimize wait time by distributing the requests to multiple cars.
* If you start multiple requests at the same time, it determins which is available and distributes it to the various elevators.
* it demonstrates the use of UIStackViews


Operation
---------
* The up and down buttons on the left side simulate the Up and Down buttons on the floor levels.
* The 4 following columns are the current state of the elevators. If you click on the floor it simulate the buttons inside the elevator.
* The arrows next to the columns show which way the elevator is going.
* Key: 
  - Blue: no elevator present on the floor.
  - Yellow: elevator on floor, door closed.
  - Black: door open
  - Green: indicates that the elevator was requested from the elevator panel.

Bugs
----
* the up and down buttons on the floor panels should renable if the elevator that servieced the request changed directions. 
