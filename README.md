## Hospital-Quality-Of-Care

### This project gives you a strong set of R functions that can look at and rank more than 4,000 U.S. hospitals based on their 30-day mortality rates for three specific clinical outcomes: heart attack, heart failure, and pneumonia. The script takes raw Medicare data and finds the best hospitals at the state and national levels and cleans up messy data on its own and has a built-in referee to break ties if two hospitals have the exact same mortality rate.

### Functions

|  |  |
|------------------------------------|------------------------------------|
| **Function** | **Purpose** |
| `best()` | Identifies the single hospital with the lowest mortality rate in a given state. |
| `rankhospital()` | Returns the hospital name at a specific rank (e.g., 5th or "worst") for a chosen outcome. |
| `rankall()` | Compiles a state-by-state list of hospitals at a specific rank into a single, unified data frame. |

### Output

![](images/Screenshot%202026-04-10%20011427.png){width="175"}

![](images/Screenshot%202026-04-10%20012919.png){width="204"}
