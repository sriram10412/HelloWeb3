FROM node:alpine3.17

# Set the working directory in the container
WORKDIR /usr/src/app

# Copy package.json and package-lock.json to the working directory
COPY package*.json ./

# Install app dependencies
RUN npm install

# Copy the rest of the application code to the working directory
COPY . .

# Expose the port on which your app will run
EXPOSE 3000

# Define the command to run your application
CMD ["node", "app.js"]
