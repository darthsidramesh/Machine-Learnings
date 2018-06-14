

# Objective

The idea of this project is to show how to build models with categorical
data using Python's popular ML library **sklearn** and Microsoft's ML Server Library **revoscalepy**. 

# Prereqs

- Running the revoscalepy package requires an installation of [Microsoft ML Server](https://docs.microsoft.com/en-us/machine-learning-server/what-is-machine-learning-server)

# Key Takeaways

More can be found at my blogpost, but the key takeaways are:

1. One-hot encoding is an extra preprocessing step required by sklearn. The code in sklearn_tests will give people a basic example of one-hot encoding, and should be helpful for beginners.
2. Pandas and sklearn do not have the best integration when it comes to categorical variables
3. revoscalepy is amazing if you are coming from an R background (like me), but could be confusing for native Python users
4. revoscalepy allows for some nice transliteration between R and Python 

#For More Information

A detailed description and comparison of sklearn and revoscalepy can be found at my [blog post](http://blog.revolutionanalytics.com/2017/11/revoscalepy.html)
