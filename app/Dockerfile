# Use a lightweight nginx base image
FROM nginx:alpine

# Remove the default nginx static content
RUN rm -rf /usr/share/nginx/html/*

# Copy your static HTML file into the nginx web root
COPY index.html /usr/share/nginx/html/

# Expose port 80 for the web server
EXPOSE 80

# Run nginx in the foreground
CMD ["nginx", "-g", "daemon off;"]
