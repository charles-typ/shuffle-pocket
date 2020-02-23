import pywren
import numpy as np

def my_function(x):
    return x + 7

wrenexec = pywren.default_executor()
#future = wrenexec.call_async(my_function, 3)
futures = wrenexec.map(my_function, range(10))
print(pywren.get_all_results(futures))


