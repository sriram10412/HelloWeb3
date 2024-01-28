FROM node:alpine3.17

WORKDIR /usr/src/app   # Set the working directory in the container

COPY package*.json ./  # Copy package.json and package-lock.json to the working directory

RUN npm install  # Install app dependencies

COPY . .  # Copy the rest of the application code to the working directory

EXPOSE 3000  # Expose the port on which your app will run

CMD ["node", "app.js"]   # Define the command to run your application
