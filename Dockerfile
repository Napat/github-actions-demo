# Stage 1: Build the React application
FROM node:22-alpine AS build

WORKDIR /app

# Copy package.json and package-lock.json
COPY package*.json package-lock.json ./
RUN npm install
COPY . .
RUN npm run build

# Stage 2: Serve the application 
FROM joseluisq/static-web-server:2

COPY --from=build /app/dist /dist
CMD ["--port", "3000", "--root", "dist"]

