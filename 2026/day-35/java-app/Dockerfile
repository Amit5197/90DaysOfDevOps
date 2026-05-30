# Use Java 17 JDK image
FROM eclipse-temurin:17-jdk

# Set working directory
WORKDIR /app

# Copy Java file into container
COPY src/Main.java .

# Compile Java file
RUN javac Main.java

#Showing all steps & verify that files are exactly where they should be during the image build process.

RUN ls -la
 
# Run the program
CMD ["java", "Main"]
