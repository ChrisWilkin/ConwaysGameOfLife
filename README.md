# ConwaysGameOfLife

ConwaysLife.forth is the main file containing all the primary executable words.
To run the code in a SwiftForth console, only import Visualisation.forth, as this will include all the necessary files automatically. 
Setting the grid size:
    To change the grid size, change the values of square_array_size in ConwaysLife and bmp-x-size, bmp-y-size in Visualisation, all to the same value. This value is one side length of the square array
    
Creating a starting array:
    For a random array, type 'random'. This will randomly generate 1s and 0s at a 3:7 ratio
    For a specific array, enter the file address of a txt file containing a 1s and 0s array (no spaces) in FileIO.forth, open-test-file.
    You can then call 'unpack-input', and this will load the array into the life simulation.
    If the array is smaller than square_array_size, the rest of the array will remain unchanged.
    
Running the Simulation
    To view in the console, call 'ascii-show'
    To view a simulation in graphical form, use 'life-we' for a wrapped edge simulation, and 'life-ae' for a hard edge simulation
    All simulations are stopped by a key press in the console.
    The speed of the simulation can be set by altering the time delay value in the 'life-we' or 'life-ae' words in Visualisation.
