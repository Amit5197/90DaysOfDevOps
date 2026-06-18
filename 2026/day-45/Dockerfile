# Use the official Nginx Alpine image
FROM nginx:alpine

# Remove default Nginx website files
RUN rm -rf /usr/share/nginx/html/*

# Copy your custom index.html into Nginx html folder
COPY index.html /usr/share/nginx/html/index.html

# Expose port 80
EXPOSE 80

# Start Nginx in the foreground
CMD ["nginx", "-g", "daemon off;"]
