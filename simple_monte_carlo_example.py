import numpy as np
import matplotlib.pyplot as plt 

task_a = np.random.uniform(5, 10, size = 100)
task_b = np.random.uniform(2, 5, size = 100)

data = task_a + task_b


plt.hist(data, density=True)
plt.axvline(13, color = "red")
plt.show()

def prop_less_than_thresh(data: list, thresh: float):
    count = 0
    thresh = thresh
    for i in data:
        if i < thresh:
            count += 1
    return count / len(data)

print(prop_less_than_thresh(data, 12))