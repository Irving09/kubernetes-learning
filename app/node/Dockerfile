# The base image to build upon
FROM node:12

# Adds the app.js file into the container image
ADD app.js /app.js

EXPOSE 8080

# Specifies the command to execute when the image is ran
ENTRYPOINT ["node", "app.js"]

# Step 1/3 : FROM node:12
#  ---> 80066e418d2f       
# Step 2/3 : ADD app.js /app.js
#  ---> 7d3611c27b1e
# Step 3/3 : ENTRYPOINT ["node", "app.js"]
#  ---> Running in 4a89511e70e4
# Removing intermediate container 4a89511e70e4
#  ---> 8ec3dd4b6140
# Successfully built 8ec3dd4b6140
# Successfully tagged kubia:latest