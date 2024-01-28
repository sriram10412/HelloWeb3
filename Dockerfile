FROM node:alpine3.17

WORKDIR /usr/src/app  #set wrk directory

COPY package*.json ./   # Copy package.json and package-lock.json to the wrk directory

RUN npm install  # Install dependencies

COPY . .   # Copy the app code to wrk directory 

EXPOSE 3000  # Expose the port to run app

CMD ["node", "app.js"]  #Kickstart the app.
