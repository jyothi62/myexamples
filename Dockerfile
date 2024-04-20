#This is the Base image of node alpine
FROM node:alpine

#Copy the code 
COPY . .

#Installing necessary dependencies
RUN npm install 

#Expose port on which node.js app runs 
EXPOSE 8081

#Command to run nodejs appln
CMD ["npm","start"]